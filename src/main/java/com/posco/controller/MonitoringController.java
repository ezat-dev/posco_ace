package com.posco.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

import org.eclipse.milo.opcua.stack.core.UaException;
import org.eclipse.milo.opcua.stack.core.types.builtin.DataValue;
import org.eclipse.milo.opcua.stack.core.types.builtin.NodeId;
import org.eclipse.milo.opcua.stack.core.types.builtin.StatusCode;
import org.eclipse.milo.opcua.stack.core.types.builtin.Variant;
import org.eclipse.milo.opcua.stack.core.types.builtin.unsigned.UShort;
import org.eclipse.milo.opcua.stack.core.types.builtin.unsigned.Unsigned;
import org.eclipse.milo.opcua.stack.core.types.enumerated.TimestampsToReturn;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.posco.domain.Monitoring;
import com.posco.domain.Pattern;
import com.posco.domain.Users;
import com.posco.service.MonitoringService;
import com.posco.service.PatternService;
import com.posco.util.OpcDataMap;

@Controller
public class MonitoringController {
	
	@Autowired
	private MonitoringService monitoringService;
	
	private PatternService patternService;
	
	private final Logger logger = LoggerFactory.getLogger(MonitoringController.class);
	
	
	
	
	@RequestMapping(value = "/pattern/getPatternList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getPatternList(
	        @RequestParam String sdate,
	        @RequestParam String edate) {
	    Map<String, Object> rtnMap = new HashMap<String, Object>();
	    
	    Pattern pattern = new Pattern();
	    pattern.setSdate(sdate);
	    pattern.setEdate(edate);
	    
	    List<Pattern> patternList = monitoringService.getPatternList(pattern);
	    
	    List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
	    for(int i=0; i<patternList.size(); i++) {
	        HashMap<String, Object> rowMap = new HashMap<String, Object>();
	        rowMap.put("idx", (i+1));
	        rowMap.put("proc_date", patternList.get(i).getProc_date());
	        rowMap.put("proc_ptrn_no", patternList.get(i).getProc_ptrn_no());
	        rowMap.put("proc_ptrn_start", patternList.get(i).getProc_ptrn_start());
	        rowMap.put("proc_ptrn_end", patternList.get(i).getProc_ptrn_end());
	        
	        // ✅ 패턴 이름 추가
	        rowMap.put("pattern_name", patternList.get(i).getPattern_name());
	        
	        rtnList.add(rowMap);
	    }
	    
	    rtnMap.put("last_page",1);
	    rtnMap.put("data",rtnList);
	    
	    return rtnMap; 
	}
	
	
	@RequestMapping(value = "/pattern/getPatternInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getPatternInfo(@RequestParam int patternNo) {
	    return monitoringService.getPatternInfo(patternNo);
	}
	
	
	
	
	
	
	@RequestMapping(value= "/monitoring/view/string", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> manualOperationViewString() throws UaException, InterruptedException, ExecutionException {
		Map<String, Object> returnMap = new HashMap<String, Object>();

		OpcDataMap opcDataMap = new OpcDataMap();

		returnMap = opcDataMap.getOpcDataListMap("ace_posco.OVERVIEW");

		// System.out으로 찍기
		/*
		 * System.out.println("manualOperationView 호출됨");
		 * System.out.println("returnMap 내용: " + returnMap);
		 */

		return returnMap;       
	}

	
	@RequestMapping(value= "/monitoring/view", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> manualOperationView() throws UaException, InterruptedException, ExecutionException {
		Map<String, Object> returnMap = new HashMap<String, Object>();

		OpcDataMap opcDataMap = new OpcDataMap();

		returnMap = opcDataMap.getOpcDataListMap("ace_posco.OVERVIEW");

		//  System.out으로 찍기
		/*
		 * System.out.println("monitoring view 호출됨");
		 * System.out.println("returnMap 내용: " + returnMap);
		 */

		return returnMap;       
	}
	
	
	@RequestMapping(value= "/monitoring/alarmView", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> alarmView() throws UaException, InterruptedException, ExecutionException {
		Map<String, Object> returnMap = new HashMap<String, Object>();

		OpcDataMap opcDataMap = new OpcDataMap();

		returnMap = opcDataMap.getOpcDataListMap("ace_posco.ALARM_LAMP");

		// System.out으로 찍기
		/*
		 * System.out.println("alarmView 호출됨"); System.out.println("returnMap 내용: " +
		 * returnMap);
		 */

		return returnMap;       
	}
	
	//오버뷰 경보 표시
	@RequestMapping(value = "/monitoring/writeOverview", method = RequestMethod.POST)
	@ResponseBody
	public boolean writeOpcValueOverview(String tagName, int value) {
		try {
			String fullNodeId = "ace_posco.OVERVIEW." + tagName;
			System.out.println("Write NodeId = ns=2;s=" + fullNodeId);

			UShort namespaceIndex = Unsigned.ushort(2);
			NodeId nodeId = new NodeId(namespaceIndex, fullNodeId);

			boolean boolVal = (value == 1);
			DataValue dataValue = new DataValue(new Variant(boolVal));

			StatusCode statusCode = MainController.client.writeValue(nodeId, dataValue).get();
			if (!statusCode.isGood()) return false;

			// ▼ 2초 후 자동 리셋
			if (boolVal) {
				new Thread(() -> {
					try {
						Thread.sleep(2000);
						System.out.println("### Auto Reset: " + fullNodeId);

						DataValue resetValue = new DataValue(new Variant(false));
						MainController.client.writeValue(nodeId, resetValue).get();

					} catch (Exception e) {
						e.printStackTrace();
					}
				}).start();
			}

			return true;

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	
	
	//PLC 오버뷰 램프 비트 읽기
	@RequestMapping(value = "/monitoring/read/overviewLamp", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> overviewLamp(@RequestParam String tagName) {
		Map<String, Object> result = new HashMap<>();
		try {
			String fullNodeId = "ace_posco.COMM." + tagName;
			UShort namespaceIndex = Unsigned.ushort(2);
			NodeId nodeId = new NodeId(namespaceIndex, fullNodeId);

			DataValue dataValue = MainController.client.readValue(0, TimestampsToReturn.Neither, nodeId).get();
			boolean value = (boolean) dataValue.getValue().getValue();

			result.put("status", "OK");
			result.put("value", value);
		} catch (Exception e) {
			result.put("status", "ERR");
			result.put("value", false);
		}
		return result;
	}
	
	
	//PLC 오버뷰 양압계 빨간 글씨 표시
	@RequestMapping(value = "/monitoring/read/pgLamp", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> pgLamp(@RequestParam String tagName) {
		Map<String, Object> result = new HashMap<>();
		try {
			String fullNodeId = "ace_posco.OVERVIEW." + tagName;
			UShort namespaceIndex = Unsigned.ushort(2);
			NodeId nodeId = new NodeId(namespaceIndex, fullNodeId);

			DataValue dataValue = MainController.client.readValue(0, TimestampsToReturn.Neither, nodeId).get();
			boolean value = (boolean) dataValue.getValue().getValue();

			result.put("status", "OK");
			result.put("value", value);
		} catch (Exception e) {
			result.put("status", "ERR");
			result.put("value", false);
		}
		return result;
	}
	
	//온도계 통신 전환 램프 비트 읽기
	@RequestMapping(value = "/monitoring/read/patternLamp", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> patternLamp(@RequestParam String tagName) {
		Map<String, Object> result = new HashMap<>();
		try {
			String fullNodeId = "ace_posco.OVERVIEW." + tagName;
			UShort namespaceIndex = Unsigned.ushort(2);
			NodeId nodeId = new NodeId(namespaceIndex, fullNodeId);

			DataValue dataValue = MainController.client.readValue(0, TimestampsToReturn.Neither, nodeId).get();
			boolean value = (boolean) dataValue.getValue().getValue();

			result.put("status", "OK");
			result.put("value", value);
		} catch (Exception e) {
			result.put("status", "ERR");
			result.put("value", false);
		}
		return result;
	}
	
	//seg별 램프 비트 읽기
	@RequestMapping(value = "/monitoring/read/segLamp", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> segLamp(@RequestParam String tagName) {
		Map<String, Object> result = new HashMap<>();
		try {
			String fullNodeId = "ace_posco.INFO." + tagName;
			UShort namespaceIndex = Unsigned.ushort(2);
			NodeId nodeId = new NodeId(namespaceIndex, fullNodeId);

			DataValue dataValue = MainController.client.readValue(0, TimestampsToReturn.Neither, nodeId).get();
			boolean value = (boolean) dataValue.getValue().getValue();

			result.put("status", "OK");
			result.put("value", value);
		} catch (Exception e) {
			result.put("status", "ERR");
			result.put("value", false);
		}
		return result;
	}
	
	//PLC 팝업 비트 읽기
	@RequestMapping(value = "/monitoring/read/bit", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> readBitValue(@RequestParam String tagName) {
	    Map<String, Object> result = new HashMap<>();
	    try {
	        String fullNodeId = "ace_posco.POPUP." + tagName;
	        UShort namespaceIndex = Unsigned.ushort(2);
	        NodeId nodeId = new NodeId(namespaceIndex, fullNodeId);

	        DataValue dataValue = MainController.client.readValue(0, TimestampsToReturn.Neither, nodeId).get();
	        boolean value = (boolean) dataValue.getValue().getValue();

	        result.put("status", "OK");
	        result.put("value", value);
	    } catch (Exception e) {
	        result.put("status", "ERR");
	        result.put("value", false);
	    }
	    return result;
	}

	
	


	//PLC 값써주기 비트
	@RequestMapping(value = "/monitoring/write", method = RequestMethod.POST)
	@ResponseBody
	public boolean writeOpcValue(String tagName, int value) {
	    try {
	        String fullNodeId = "ace_posco.POPUP." + tagName;
	        System.out.println("Write NodeId = ns=2;s=" + fullNodeId);

	        UShort namespaceIndex = Unsigned.ushort(2);
	        NodeId nodeId = new NodeId(namespaceIndex, fullNodeId);

	        boolean boolVal = (value == 1);
	        DataValue dataValue = new DataValue(new Variant(boolVal));

	        System.out.println("Write Value = " + boolVal);	      
	        StatusCode statusCode = MainController.client.writeValue(nodeId, dataValue).get();
	        System.out.println("Write Status = " + statusCode);

	        if (!statusCode.isGood()) return false;

	       
	        if (boolVal) {
	            new Thread(() -> {
	                try {
	                    Thread.sleep(2000); // 2초 슬립

	                    System.out.println("### Auto Reset → tag=" + fullNodeId + ", value=0");

	                    DataValue resetValue = new DataValue(new Variant(false));
	                    StatusCode resetStatus =
	                        MainController.client.writeValue(nodeId, resetValue).get();

	                    System.out.println("Auto Reset Status = " + resetStatus);

	                } catch (Exception e) {
	                    e.printStackTrace();
	                }
	            }).start();
	        }

	        return true;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	
	
	// PLC 아날로그값 READ
	@RequestMapping(value = "/monitoring/read/analog", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> readOpcAnalog(@RequestParam String tagName) {

	    Map<String, Object> result = new HashMap<>();

	    try {
	        UShort namespaceIndex = Unsigned.ushort(2);
	        String fullNodeId = "ace_posco.OVERVIEW." + tagName;

	        System.out.println("Analog Read NodeId = ns=2;s=" + fullNodeId);

	        NodeId nodeId = new NodeId(namespaceIndex, fullNodeId);

	        DataValue dataValue = MainController.client
	                .readValue(0, TimestampsToReturn.Neither, nodeId)
	                .get();

	        Object value = dataValue.getValue().getValue();

	        System.out.println("Analog Read Value = " + value);

	        result.put("status", "OK");
	        result.put("value", value);

	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("status", "NG");
	    }

	    return result;
	}

	
	//PLC 아날로그값 WRITE
	@RequestMapping(value = "/monitoring/write/popInput", method = RequestMethod.POST)
	@ResponseBody
	public boolean writePopupValue(@RequestParam String tagName, @RequestParam String value) {

	    try {
	        UShort namespaceIndex = Unsigned.ushort(2);
	        String fullNodeId = "ace_posco.POPUP." + tagName;

	        System.out.println("Popup Write NodeId = ns=2;s=" + fullNodeId);

	        NodeId nodeId = new NodeId(namespaceIndex, fullNodeId);

	        Variant writeValue;

	        // =======================
	        // ★ Int16 처리해야 하는 태그
	        // =======================
	        if (tagName.equals("input-heat-2") ||
	            tagName.equals("input-hivacuum-2") ||
	            tagName.equals("input-lowvacuum-2") ||
	            tagName.equals("analog-pattern-number") ||
	            tagName.equals("input-cool-sv")) 
	        {
	            try {
	                short v = Short.parseShort(value);
	                writeValue = new Variant(v);
	            } catch(Exception e) {
	                System.out.println("Int16 변환 실패");
	                return false;
	            }
	        }

	        // =======================
	        // ★ Float (소수점 1자리 반올림)
	        // =======================
	        else {
	            try {
	                float v = Float.parseFloat(value);

	                // ★ 소수점 1자리 반올림 처리
	                v = Math.round(v * 10) / 10.0f;

	                writeValue = new Variant(v);
	            } catch(Exception e) {
	                writeValue = new Variant(value);
	            }
	        }

	        System.out.println("Popup Write Value = " + writeValue);

	        StatusCode status = MainController.client
	                .writeValue(nodeId, new DataValue(writeValue))
	                .get();

	        System.out.println("Write Status = " + status);

	        return status.isGood();

	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	
	
	
	
	
	//////////////////////////////////////////패턴//////////////////////////////////////////////////

	// PLC 패턴 아날로그값 READ
	@RequestMapping(value = "/monitoring/read/patternAnalog", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> patternAnalog() {

		Map<String, Object> result = new HashMap<>();

		OpcDataMap opc = new OpcDataMap();
		
		try {			
			
			result = opc.getOpcDataListMap("ace_posco.OVERVIEW");

		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "NG");
		}

		return result;
	}
	
//////////////////////////////////////패턴관리(팝업)////////////////////////////////////////////////

	//PLC 패턴 관리(팝업) 아날로그값 READ
	@RequestMapping(value = "/monitoring/read/patternInfoAnalog", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> patternInfoAnalog() {
		Map<String, Object> result = new HashMap<>();
		OpcDataMap opc = new OpcDataMap();
		try {            
			result = opc.getOpcDataListMap("ace_posco.INFO");
			result.put("status", "OK");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "NG");
			result.put("error", "PLC 연결 끊김");
		}
		return result;
	}


	//PLC 패턴 관리(팝업) 개별 읽기버튼
	@RequestMapping(value = "/monitoring/write/patternInfoRead", method = RequestMethod.POST)
	@ResponseBody
	public boolean patternInfoRead(
			@RequestParam int patternNo,
			@RequestParam String tagName) {  // 👈 tagName 파라미터 추가
		try {
			OpcDataMap opc = new OpcDataMap();

			// ① 패턴번호 설정
			opc.setOpcData(
					"ace_posco.INFO.analog-pattern-number",
					(short) patternNo
					);
			Thread.sleep(300);

			// ② 패턴별 읽기 비트 ON (pattern-read-1 ~ pattern-read-14)
			opc.setOpcData("ace_posco.INFO." + tagName, true);
			Thread.sleep(1000);

			// ③ 패턴별 읽기 비트 OFF
			opc.setOpcData("ace_posco.INFO." + tagName, false);

			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}


	//PLC 패턴 관리(팝업) 개별 수정버튼 (패턴 쓰기)
	@RequestMapping(value = "/monitoring/write/patternInfoWrite", method = RequestMethod.POST)
	@ResponseBody
	public boolean patternInfoWrite(
			@RequestParam int patternNo,
			@RequestParam String tagName) {  // 👈 pattern-write-1 ~ pattern-write-14
		try {
			OpcDataMap opc = new OpcDataMap();

			// ① 패턴번호 설정
			opc.setOpcData(
					"ace_posco.INFO.analog-pattern-number",
					(short) patternNo
					);
			Thread.sleep(300);

			// ② 패턴별 쓰기 비트 ON (pattern-write-1 ~ pattern-write-14)
			opc.setOpcData("ace_posco.INFO." + tagName, true);
			Thread.sleep(2000);

			// ③ 패턴별 쓰기 비트 OFF
			opc.setOpcData("ace_posco.INFO." + tagName, false);

			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}


	//PLC 패턴 관리(팝업) 개별 적용버튼
	@RequestMapping(value = "/monitoring/write/patternInfoApplyBit", method = RequestMethod.POST)
	@ResponseBody
	public boolean patternInfoApplyBit(
			@RequestParam String tagName,
			@RequestParam int value) {
		try {
			String node = "ace_posco.INFO." + tagName;
			NodeId nodeId = new NodeId(
					Unsigned.ushort(2),
					node
					);

			MainController.client.writeValue(
					nodeId,
					new DataValue(new Variant(value == 1))
					).get();

			// 5초 후 자동 OFF
			new Thread(() -> {
				try {
					Thread.sleep(5000);
					MainController.client.writeValue(
							nodeId,
							new DataValue(new Variant(false))
							).get();
				} catch (Exception ignored) {}
			}).start();

			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}


	//PLC 패턴 관리(팝업) 아날로그 값만 쓰기 (운전 패턴번호 설정용)
	@RequestMapping(value = "/monitoring/write/patternInfoAnalogOnly", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> patternInfoAnalogOnly(
			@RequestParam String tagName,
			@RequestParam int value) {
		Map<String, Object> rMap = new HashMap<>();
		OpcDataMap opc = new OpcDataMap();
		try {
			if (value < -32768 || value > 32767) {
				rMap.put("alert", "범위초과");
				return rMap;
			}

			// INFO 그룹으로 아날로그 값 설정
			opc.setOpcData(
					"ace_posco.INFO." + tagName,
					(short) value
					);

			rMap.put("status", "OK");
			return rMap;
		} catch (Exception e) {
			rMap.put("alert", e.getMessage());
			return rMap;
		}
	}


	//PLC 패턴 관리(팝업) 패턴 데이터 일괄 쓰기
		@RequestMapping(value = "/monitoring/write/patternInfoInputList", method = RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> patternInfoInputList(@RequestParam(required = false) String listParam) {
			Map<String, Object> rtnMap = new HashMap<>();
			JSONParser listParser = new JSONParser();
			Object listObj = new Object();
			JSONArray listJsonArray = new JSONArray();
			OpcDataMap opc = new OpcDataMap();

			try {
				// 현재 조회중인 패턴 값 읽기
				Map<String, Object> ptrnNumberMap = opc.getOpcData("ace_posco.INFO.analog-pattern-number");
				short ptrn_no = Short.parseShort(ptrnNumberMap.get("value").toString());

				listObj = listParser.parse(listParam);

				if(listObj instanceof JSONArray) {
					listJsonArray = (JSONArray)listObj;
					rtnMap.put("ptrn_no", ptrn_no);

					for(int i=0; i<listJsonArray.size(); i++) {
						JSONArray aa = (JSONArray)listJsonArray.get(i);

						String tagName = "";
						String columnName = "";
						short tagValue = 0;

						for(int j=0; j<aa.size(); j++) {
							tagName = "ace_posco.INFO." + aa.get(0).toString();  // 👈 INFO 그룹

							if(aa.get(0).toString().length() > 0) {
								String[] aaArray = aa.get(0).toString().split("-");
								if(aa.get(0).toString().contains("-time-")) {
									columnName = "ptrn_seg" + aaArray[3] + "_time";
								} else {
									columnName = "ptrn_seg" + aaArray[3] + "_temp";
								}
							}

							tagValue = Short.parseShort(aa.get(1).toString());
						}

						rtnMap.put(columnName, tagValue);
						opc.setOpcData(tagName, tagValue);
					}

					logger.info("패턴관리(팝업)-패턴수정 : {}", "패턴 데이터적용 : " + rtnMap.toString());
				}

				monitoringService.patternInputList(rtnMap);

			} catch (Exception e) {
				e.printStackTrace();
			}
			return rtnMap;
		}
////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//패턴 읽기버튼 쓰기
	@RequestMapping(value = "/monitoring/write/patternBit", method = RequestMethod.POST)
	@ResponseBody
	public boolean patternBit(
	        @RequestParam String tagName,
	        @RequestParam int value) {

	    try {
	        String fullNodeId = "ace_posco.OVERVIEW." + tagName;
	        System.out.println("Write NodeId = ns=2;s=" + fullNodeId);

	        UShort namespaceIndex = Unsigned.ushort(2);
	        NodeId nodeId = new NodeId(namespaceIndex, fullNodeId);

	        boolean boolVal = (value == 1);
	        DataValue dataValue = new DataValue(new Variant(boolVal));

	        StatusCode status =
	                MainController.client.writeValue(nodeId, dataValue).get();

	        System.out.println("Write Status = " + status);
	        if (!status.isGood()) return false;

	        // 자동 리셋
	        if (boolVal) {
	            new Thread(() -> {
	                try {
	                    Thread.sleep(2000);
	                    MainController.client.writeValue(
	                            nodeId,
	                            new DataValue(new Variant(false))
	                    ).get();
	                } catch (Exception e) {
	                    e.printStackTrace();
	                }
	            }).start();
	        }

	        return true;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	
	
	
	//패턴 쓰기버튼 쓰기
	@RequestMapping(value = "/monitoring/write/patternWriteBit", method = RequestMethod.POST)
	@ResponseBody
	public boolean patternWriteBit(
			@RequestParam String tagName,
			@RequestParam int value) {

		try {
			String fullNodeId = "ace_posco.POPUP." + tagName;
			System.out.println("Write NodeId = ns=2;s=" + fullNodeId);

			UShort namespaceIndex = Unsigned.ushort(2);
			NodeId nodeId = new NodeId(namespaceIndex, fullNodeId);

			boolean boolVal = (value == 1);
			DataValue dataValue = new DataValue(new Variant(boolVal));

			StatusCode status =
					MainController.client.writeValue(nodeId, dataValue).get();

			System.out.println("Write Status = " + status);
			if (!status.isGood()) return false;

			// 2초
			if (boolVal) {
				new Thread(() -> {
					try {
						Thread.sleep(2000);
						MainController.client.writeValue(
								nodeId,
								new DataValue(new Variant(false))
								).get();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}).start();
			}

			return true;

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	
	@RequestMapping(value = "/monitoring/write/patternInputList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> patternInputList(
	        @RequestParam(required = false) String listParam,
	        @RequestParam(required = false) Integer patternNo) {

	    Map<String, Object> rtnMap = new HashMap<String, Object>();
	    
	    JSONParser listParser = new JSONParser();
	    JSONArray listJsonArray = new JSONArray();
	    OpcDataMap opc = new OpcDataMap();
	    
	    try {
	        // ✅ 패턴 번호 결정
	        short ptrn_no;
	        if (patternNo != null && patternNo >= 1 && patternNo <= 14) {
	            ptrn_no = patternNo.shortValue();
	        } else {
	            Map<String, Object> ptrnNumberMap = opc.getOpcData("ace_posco.OVERVIEW.analog-pattern-number");
	            ptrn_no = Short.parseShort(ptrnNumberMap.get("value").toString());
	        }
	        
	        rtnMap.put("ptrn_no", ptrn_no);
	        logger.info("========================================");
	        logger.info("패턴 수정 시작: 패턴번호 = {}", ptrn_no);
	        
	        Object listObj = listParser.parse(listParam);
	        
	        if(listObj instanceof JSONArray) {
	            listJsonArray = (JSONArray)listObj;
	            
	            int successCount = 0;
	            int failCount = 0;
	            
	            for(int i=0; i<listJsonArray.size(); i++) {
	                JSONArray aa = (JSONArray)listJsonArray.get(i);
	                
	                String tagStr = aa.get(0).toString();
	                String valueStr = aa.get(1).toString();
	                
	                String tagName = "ace_posco.POPUP." + tagStr;
	                
	                // DB 컬럼명 추출
	                String columnName = "";
	                if(tagStr.length() > 0) {
	                    String[] aaArray = tagStr.split("-");
	                    if(tagStr.contains("-time-")) {
	                        columnName = "ptrn_seg" + aaArray[3] + "_time";
	                    } else {
	                        columnName = "ptrn_seg" + aaArray[3] + "_temp";
	                    }
	                }
	                
	                try {
	                    int intValue = Integer.parseInt(valueStr);
	                    
	                    if (intValue < Short.MIN_VALUE || intValue > Short.MAX_VALUE) {
	                        logger.error("❌ 값 범위 초과: {} = {}", tagStr, intValue);
	                        failCount++;
	                        continue;
	                    }
	                    
	                    short tagValue = (short) intValue;
	                    
	                    // ✅ PLC에 쓰기
	                    opc.setOpcData(tagName, tagValue);
	                    
	                    // ✅ DB용 Map에 저장
	                    if (!columnName.isEmpty()) {
	                        rtnMap.put(columnName, tagValue);
	                    }
	                    
	                    successCount++;
	                    logger.info("  ✅ {} = {}", tagName, tagValue);
	                    
	                    // ✅ 10개마다 10ms 대기 (PLC 부하 방지)
	                    if (i % 10 == 9) {
	                        Thread.sleep(10);
	                    }
	                    
	                } catch (NumberFormatException e) {
	                    logger.error("❌ 숫자 변환 실패: {} = {}", tagStr, valueStr);
	                    failCount++;
	                }
	            }
	            
	            logger.info("========================================");
	            logger.info("PLC 쓰기 완료: 성공 {}, 실패 {}", successCount, failCount);
	            logger.info("DB 저장 데이터: {}", rtnMap);
	            logger.info("========================================");
	        }

	        // DB 저장
	        monitoringService.patternInputList(rtnMap);
	        
	        logger.info("✅ 패턴 {} DB 저장 완료", ptrn_no);
	        
	        rtnMap.put("status", "OK");
	        rtnMap.put("message", "패턴 저장 완료");

	    } catch (Exception e) {
	        logger.error("❌ 패턴 수정 실패", e);
	        e.printStackTrace();
	        rtnMap.put("status", "ERROR");
	        rtnMap.put("message", e.getMessage());
	    }
	    
	    return rtnMap;
	}
	
	//PLC 패턴 아날로그값 WRITE
	@RequestMapping(value = "/monitoring/write/patternInput", method = RequestMethod.POST)
	@ResponseBody
	public boolean patternInput(@RequestParam String tagName, @RequestParam String value) {

		try {
			UShort namespaceIndex = Unsigned.ushort(2);
			String fullNodeId = "ace_posco.POPUP." + tagName;

			System.out.println("Popup Write NodeId = ns=2;s=" + fullNodeId);

			NodeId nodeId = new NodeId(namespaceIndex, fullNodeId);

			Variant writeValue;

			if (tagName.equals("input-pattern-time-1") ||
					tagName.equals("input-pattern-time-2") ||
					tagName.equals("input-pattern-time-3") ||
					tagName.equals("input-pattern-time-4") ||
					tagName.equals("input-pattern-time-5") ||
					tagName.equals("input-pattern-time-6") ||
					tagName.equals("input-pattern-time-7") ||
					tagName.equals("input-pattern-time-8") ||
					tagName.equals("input-pattern-time-9") ||
					tagName.equals("input-pattern-time-10") ||
					tagName.equals("input-pattern-time-11") ||
					tagName.equals("input-pattern-time-12") ||
					tagName.equals("input-pattern-time-13") ||
					tagName.equals("input-pattern-time-14") ||
					tagName.equals("input-pattern-time-15") ||
					tagName.equals("input-pattern-time-16") ||
					tagName.equals("input-pattern-time-17") ||
					tagName.equals("input-pattern-time-18") ||
					tagName.equals("input-pattern-time-19") ||
					tagName.equals("input-pattern-time-20") ||
					tagName.equals("input-pattern-temp-1") ||
					tagName.equals("input-pattern-temp-2") ||
					tagName.equals("input-pattern-temp-3") ||
					tagName.equals("input-pattern-temp-4") ||
					tagName.equals("input-pattern-temp-5") ||
					tagName.equals("input-pattern-temp-6") ||
					tagName.equals("input-pattern-temp-7") ||
					tagName.equals("input-pattern-temp-8") ||
					tagName.equals("input-pattern-temp-9") ||
					tagName.equals("input-pattern-temp-10") ||
					tagName.equals("input-pattern-temp-11") ||
					tagName.equals("input-pattern-temp-12") ||
					tagName.equals("input-pattern-temp-13") ||
					tagName.equals("input-pattern-temp-14") ||
					tagName.equals("input-pattern-temp-15") ||
					tagName.equals("input-pattern-temp-16") ||
					tagName.equals("input-pattern-temp-17") ||
					tagName.equals("input-pattern-temp-18") ||
					tagName.equals("input-pattern-temp-19") ||
					tagName.equals("input-pattern-temp-20")) 
			{
				try {
					short v = Short.parseShort(value);
					writeValue = new Variant(v);

					logger.info("패천관리-패턴수정 : {}","패턴 데이터 조회 : "+v);
				} catch(Exception e) {
					System.out.println("Int16 변환 실패");
					return false;
				}
			}

			//float
			else {
				try {
					float v = Float.parseFloat(value);


					v = Math.round(v * 10) / 10.0f;

					writeValue = new Variant(v);
				} catch(Exception e) {
					writeValue = new Variant(value);
				}
			}

			System.out.println("Popup Write Value = " + writeValue);

			StatusCode status = MainController.client
					.writeValue(nodeId, new DataValue(writeValue))
					.get();

			System.out.println("Write Status = " + status);

			return status.isGood();

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	
	//패턴읽기 버튼
	@RequestMapping(value = "/monitoring/write/patternRead", method = RequestMethod.POST)
	@ResponseBody
	public boolean writePatternRead(@RequestParam int patternNo) {

	    try {
	        OpcDataMap opc = new OpcDataMap();

	        opc.setOpcData(
	            "ace_posco.OVERVIEW.analog-pattern-number",
	            (short) patternNo
	        );

	        Thread.sleep(300);

	        opc.setOpcData("ace_posco.OVERVIEW.pattern-read", true);
	        Thread.sleep(1000);
	        opc.setOpcData("ace_posco.OVERVIEW.pattern-read", false);

	        return true;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	//패턴 아날로그값 쓰기
	@RequestMapping(value = "/monitoring/write/patternAnalogOnly", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> writePatternAnalogOnly(
	        @RequestParam String tagName,
	        @RequestParam int value) {

	    Map<String, Object> rMap = new HashMap<>();
	    OpcDataMap opc = new OpcDataMap();

	    try {
	        if (value < -32768 || value > 32767) {
	            rMap.put("alert", "범위초과");
	            return rMap;
	        }

	        opc.setOpcData(
	            "ace_posco.OVERVIEW." + tagName,
	            (short) value
	        );

	        return rMap;

	    } catch (Exception e) {
	        rMap.put("alert", e.getMessage());
	        return rMap;
	    }
	}
	
	
	@RequestMapping(value = "/monitoring/write/patternApplyBit", method = RequestMethod.POST)
	@ResponseBody
	public boolean patternApplyBit(
	        @RequestParam String tagName,
	        @RequestParam int value) {

	    try {
	        String node = "ace_posco.OVERVIEW." + tagName;

	        NodeId nodeId = new NodeId(
	            Unsigned.ushort(2),
	            node
	        );

	        MainController.client.writeValue(
	            nodeId,
	            new DataValue(new Variant(value == 1))
	        ).get();

	        new Thread(() -> {
	            try {
	                Thread.sleep(5000);
	                MainController.client.writeValue(
	                    nodeId,
	                    new DataValue(new Variant(false))
	                ).get();
	            } catch (Exception ignored) {}
	        }).start();

	        return true;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	
	
	
	
	// PLC 패턴 아날로그값 WRITE (INT16)
	@RequestMapping(value = "/monitoring/write/patternAnalog", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> writePatternAnalog(
	        @RequestParam String tagName,
	        @RequestParam int value) {

		Map<String, Object> rMap = new HashMap<String, Object>();
		OpcDataMap opc = new OpcDataMap();
		
	    try {
	    	//패턴읽기 비트 ON 태그
	        String ptrnRead = "ace_posco.OVERVIEW.pattern-read";
	        
	        boolean setValue = true;
	        boolean resetValue = false;
	        
	        //체크용
	        if (value < -32768 || value > 32767) {
	        	System.err.println("범위 초과");
	        	
	        	rMap.put("alert","범위초과");
	        	return rMap;
	        }
	        
	        //패턴번호 아날로그값 전송	        
	        short shortValue = Short.parseShort(value+"");
	        
	        opc.setOpcData("ace_posco.OVERVIEW."+tagName, shortValue);
	        Thread.sleep(300);
	        
	        //패턴읽기비트 ON
	        opc.setOpcData(ptrnRead, setValue);
	        Thread.sleep(1000);
	        opc.setOpcData(ptrnRead, resetValue);
	        
	        return rMap;

	    } catch (Exception e) {
	        rMap.put("alert", e.getMessage());
	        return rMap;
	    }
	}
	
	
	// 패턴 대기신호(읽기중, 쓰기중, 읽기완료, 쓰기완료)
	@RequestMapping(value = "/monitoring/read/waitbit", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> waitbit(@RequestParam String tagName) {
	    Map<String, Object> result = new HashMap<>();
	    try {
	        String fullNodeId = "ace_posco.OVERVIEW." + tagName;
	        UShort namespaceIndex = Unsigned.ushort(2);
	        NodeId nodeId = new NodeId(namespaceIndex, fullNodeId);

	        DataValue dataValue = MainController.client.readValue(0, TimestampsToReturn.Neither, nodeId).get();
	        boolean value = (boolean) dataValue.getValue().getValue();

	        result.put("status", "OK");
	        result.put("value", value);
	    } catch (Exception e) {
	        result.put("status", "ERR");
	        result.put("value", false);
	    }
	    return result;
	}


	@RequestMapping(value = "/monitoring/read/infoanalog", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> inforeadAnalog(@RequestParam String tagName) {
	    Map<String, Object> result = new HashMap<>();
	    OpcDataMap opc = new OpcDataMap();
	    
	    try {
	        // INFO 그룹에서 읽기
	        Map<String, Object> data = opc.getOpcData("ace_posco.INFO." + tagName);
	        result.put("status", "OK");
	        result.put("value", data.get("value"));
	    } catch (Exception e) {
	        result.put("status", "NG");
	    }
	    
	    return result;
	}
	
	
////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// PLC 오버뷰 아날로그 값 바로 쓰기
	/*
	 * @RequestMapping(value = "/monitoring/write/analog", method =
	 * RequestMethod.POST)
	 * 
	 * @ResponseBody public boolean writeOpcAnalog(String tagName, String value) {
	 * 
	 * try { String fullNodeId = "ace_posco.OVERVIEW." + tagName;
	 * System.out.println("Analog Write NodeId = ns=2;s=" + fullNodeId);
	 * 
	 * UShort namespaceIndex = Unsigned.ushort(2); NodeId nodeId = new
	 * NodeId(namespaceIndex, fullNodeId);
	 * 
	 * // PLC 태그 타입 설정 (태그별 타입 매핑) Variant writeValue;
	 * 
	 * switch (tagName) {
	 * 
	 * // FLOAT case "analog-hivacuum-pv-1": case "analog-heat-pv-1": writeValue =
	 * new Variant(Float.parseFloat(value)); break;
	 * 
	 * // INT16 case "analog-hivacuum-pv-2": case "analog-heat-pv-2": case
	 * "analog-timer-sv": writeValue = new Variant(Short.valueOf((short)
	 * Integer.parseInt(value))); break;
	 * 
	 * default: throw new RuntimeException("지원하지 않는 태그: " + tagName); }
	 * 
	 * System.out.println("Analog Write Value = " + writeValue);
	 * 
	 * StatusCode status = MainController.client.writeValue(nodeId, new
	 * DataValue(writeValue)).get(); System.out.println("Write Status = " + status);
	 * 
	 * return status.isGood();
	 * 
	 * } catch (Exception e) { e.printStackTrace(); return false; } }
	 */




	
	
	
	/*
	 * //램프값 읽어오기
	 * 
	 * @RequestMapping(value = "/monitoring/read", method = RequestMethod.POST)
	 * 
	 * @ResponseBody public Map<String, Object> readOpcValue(@RequestParam String
	 * tagName) {
	 * 
	 * Map<String, Object> result = new HashMap<>();
	 * 
	 * try { String fullNodeId = "ace_posco.POPUP." + tagName; UShort ns =
	 * Unsigned.ushort(2); NodeId nodeId = new NodeId(ns, fullNodeId);
	 * 
	 * DataValue dv = MainController.client.readValue(0, null, nodeId).get();
	 * 
	 * boolean value = false;
	 * 
	 * if (!dv.getStatusCode().isGood()) { result.put("success", false); return
	 * result; }
	 * 
	 * if (dv.getValue() != null && dv.getValue().getValue() instanceof Boolean) {
	 * value = (boolean) dv.getValue().getValue(); }
	 * 
	 * result.put("success", true); result.put("value", value); return result;
	 * 
	 * } catch (Exception e) { e.printStackTrace(); result.put("success", false);
	 * return result; } }
	 */







	
	@RequestMapping(value = "/monitoring/overView", method = RequestMethod.GET)
	public String overView(Users users) {

		return "/monitoring/overView.jsp";
	}	 
	
	@RequestMapping(value = "/monitoring/alarm", method = RequestMethod.GET)
	public String alarm(Users users) {

		return "/monitoring/alarm.jsp";
	}
	
	@RequestMapping(value = "/monitoring/alarmHistory", method = RequestMethod.GET)
	public String alarmHistory(Users users) {

		return "/monitoring/alarmHistory.jsp";
	}
	
	@RequestMapping(value = "/monitoring/pattern", method = RequestMethod.GET)
	public String pattern(Users users) {

		return "/monitoring/pattern.jsp";
	}
	
	@RequestMapping(value = "/monitoring/batchReport", method = RequestMethod.GET)
	public String batchReport(Users users) {

		return "/monitoring/batchReport.jsp";
	}
	
	@RequestMapping(value = "/monitoring/historyTrend", method = RequestMethod.GET)
	public String historyTrend(Users users) {

		return "/monitoring/historyTrend.jsp";
	}
	
	@RequestMapping(value = "/monitoring/realTrend", method = RequestMethod.GET)
	public String realTrend(Users users) {

		return "/monitoring/realTrend.jsp";
	}
	
	@RequestMapping(value = "/monitoring/patternTrend", method = RequestMethod.GET)
	public String patternTrend(Users users) {

		return "/monitoring/patternTrend.jsp";
	}
	
	
	
	//////////////////팝업////////////////////
	
	//진공로 히터 버튼(오버뷰)
	@RequestMapping(value = "/popup/vacuumHeat", method = RequestMethod.GET)
	public String vacuumHeat(Users users) {
	    return "/popup/vacuumHeat.jsp"; 
	}
	
	//자동운전선택
	@RequestMapping(value = "/popup/autoRun", method = RequestMethod.GET)
	public String autoRun(Users users) {
	    return "/popup/autoRun.jsp"; 
	}
	
	//러핑펌프
	@RequestMapping(value = "/popup/luffingPump", method = RequestMethod.GET)
	public String luffingPump(Users users) {
		return "/popup/luffingPump.jsp"; 
	}
	
	//부스터펌프
	@RequestMapping(value = "/popup/boosterPump", method = RequestMethod.GET)
	public String boosterPump(Users users) {
		return "/popup/boosterPump.jsp"; 
	}

	//확산펌프
	@RequestMapping(value = "/popup/diffPump", method = RequestMethod.GET)
	public String diffPump(Users users) {
		return "/popup/diffPump.jsp"; 
	}
	
	//냉각팬
	@RequestMapping(value = "/popup/coldPen", method = RequestMethod.GET)
	public String coldPen(Users users) {
		return "/popup/coldPen.jsp"; 
	}
	
	//냉각팬
	@RequestMapping(value = "/popup/vantilPen", method = RequestMethod.GET)
	public String vantilPen(Users users) {
		return "/popup/vantilPen.jsp"; 
	}

	//러핑밸브
	@RequestMapping(value = "/popup/luffingValve", method = RequestMethod.GET)
	public String luffingValve(Users users) {
		return "/popup/luffingValve.jsp"; 
	}

	//포라인밸브
	@RequestMapping(value = "/popup/fourlineValve", method = RequestMethod.GET)
	public String fourlineValve(Users users) {
		return "/popup/fourlineValve.jsp"; 
	}
	
	//고진공밸브
	@RequestMapping(value = "/popup/vacuumValve", method = RequestMethod.GET)
	public String vacuumValve(Users users) {
		return "/popup/vacuumValve.jsp"; 
	}
	
	//가스밸브
	@RequestMapping(value = "/popup/gasValve", method = RequestMethod.GET)
	public String gasValve(Users users) {
		return "/popup/gasValve.jsp"; 
	}
	
	//히팅SET
	@RequestMapping(value = "/popup/heatingSet", method = RequestMethod.GET)
	public String heatingSet(Users users) {
		return "/popup/heatingSet.jsp"; 
	}
	
	//고진공SET
	@RequestMapping(value = "/popup/vacuumSet", method = RequestMethod.GET)
	public String vacuumSet(Users users) {
		return "/popup/vacuumSet.jsp"; 
	}
	
	//저진공SET
	@RequestMapping(value = "/popup/lowVacuumSet", method = RequestMethod.GET)
	public String lowVacuumSet(Users users) {
		return "/popup/lowVacuumSet.jsp"; 
	}
	
	//냉각타이머 설정치
	@RequestMapping(value = "/popup/coolTimerSet", method = RequestMethod.GET)
	public String coolTimerSet(Users users) {
		return "/popup/coolTimerSet.jsp"; 
	}
	
	//자동운전 시작
	@RequestMapping(value = "/popup/autoStart", method = RequestMethod.GET)
	public String autoStart(Users users) {
		return "/popup/autoStart.jsp"; 
	}
	
	//자동운전 정지
	@RequestMapping(value = "/popup/autoStop", method = RequestMethod.GET)
	public String autoStop(Users users) {
		return "/popup/autoStop.jsp"; 
	}
	
	//패턴넘버 선택
	@RequestMapping(value = "/popup/patternNumber", method = RequestMethod.GET)
	public String patternNumber(Users users) {
		return "/popup/patternNumber.jsp"; 
	}
	
	//패턴쓰기
	@RequestMapping(value = "/popup/patternWrite", method = RequestMethod.GET)
	public String patternWrite(Users users) {
		return "/popup/patternWrite.jsp"; 
	}
	
	//패턴스킵
	@RequestMapping(value = "/popup/patternSkip", method = RequestMethod.GET)
	public String patternSjip(Users users) {
		return "/popup/patternSkip.jsp"; 
	}
	
	//패턴관리
	@RequestMapping(value = "/popup/patternInfo", method = RequestMethod.GET)
	public String patternInfo(Users users) {
		return "/popup/patternInfo.jsp"; 
	}
	///////////////////////////////////////////////
	
	
	
	//알람 내역,랭킹,트렌드//////////////////////////////
	@RequestMapping(value = "/monitoring/alarmRecordListAll/list", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> alarmRecordListAll(
    		@RequestParam String s_sdate,
    		@RequestParam String s_edate) {

		System.out.println("s_sdate: " + s_sdate+"// length : "+s_sdate.length());
		System.out.println("s_edate: " + s_edate+"// length : "+s_sdate.length());

		Map<String, Object> rtnMap = new HashMap<>();

		Monitoring monitoring = new Monitoring();
		monitoring.setS_sdate(s_sdate); // 2025-10-12
		monitoring.setS_edate(s_edate); // 2025-10-13

		List<Monitoring> alarmList = monitoringService.alarmRecordListAll(monitoring);

		

		List<HashMap<String, Object>> rtnList = new ArrayList<>();
		for (int i = 0; i < alarmList.size(); i++) {
			Monitoring a = alarmList.get(i);
			HashMap<String, Object> rowMap = new HashMap<>();
			rowMap.put("idx", (i + 1));
			rowMap.put("a_addr", a.getTagname());
			rowMap.put("a_desc", a.getAlarmdesc());
			rowMap.put("a_stime", a.getStart_time());
			rowMap.put("a_etime", a.getEnd_time());
			rtnList.add(rowMap);
		}

		rtnMap.put("data", rtnList);
		rtnMap.put("last_page", 1);
		rtnMap.put("total_count", alarmList.size());

		return rtnMap;
	}
	
	
	@RequestMapping(value = "/monitoring/alarmRecordListOver/list", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> alarmRecordListOver() {
	    Map<String, Object> rtnMap = new HashMap<>();
	    List<Monitoring> alarmList = monitoringService.alarmRecordListOver();
	    
	    List<HashMap<String, Object>> rtnList = new ArrayList<>();
	    for (int i = 0; i < alarmList.size(); i++) {
	        Monitoring a = alarmList.get(i);
	        
	        // ✅ 실시간 PLC 상태 확인
	        boolean isActiveInPLC = checkAlarmStatusInPLC(a.getTagname());
	        
	        HashMap<String, Object> rowMap = new HashMap<>();
	        rowMap.put("idx", (i + 1));
	        rowMap.put("a_addr", a.getTagname());
	        rowMap.put("a_desc", a.getAlarmdesc());
	        rowMap.put("a_stime", a.getStart_time());
	        
	        // ✅ PLC에서 꺼져있으면 해제시간 표시 (또는 제외)
	        if (!isActiveInPLC && a.getEnd_time() == null) {
	            rowMap.put("a_etime", "자동해제");  // 또는 현재시간
	            rowMap.put("is_real_active", false);
	        } else {
	            rowMap.put("a_etime", a.getEnd_time());
	            rowMap.put("is_real_active", isActiveInPLC);
	        }
	        
	        rtnList.add(rowMap);
	    }
	    rtnMap.put("data", rtnList);
	    rtnMap.put("last_page", 1);
	    rtnMap.put("total_count", alarmList.size());
	    return rtnMap;
	}
	
	
	@RequestMapping(value = "/monitoring/batchReport/alarms", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getBatchReportAlarms(
	        @RequestParam String startTime,
	        @RequestParam String endTime) {
	    
	    System.out.println("배치리포트 알람 조회");
	    System.out.println("시작시간: " + startTime);
	    System.out.println("종료시간: " + endTime);
	    
	    Map<String, Object> rtnMap = new HashMap<>();
	    
	    try {
	        Monitoring monitoring = new Monitoring();
	        monitoring.setS_sdate(startTime);  // 2025-01-19 10:30:00
	        monitoring.setS_edate(endTime);    // 2025-01-19 15:45:00
	        
	        List<Monitoring> alarmList = monitoringService.getBatchReportAlarms(monitoring);
	        
	        System.out.println("조회된 알람 개수: " + alarmList.size());
	        
	        List<HashMap<String, Object>> rtnList = new ArrayList<>();
	        for (int i = 0; i < alarmList.size(); i++) {
	            Monitoring a = alarmList.get(i);
	            HashMap<String, Object> rowMap = new HashMap<>();
	            rowMap.put("idx", (i + 1));
	            rowMap.put("a_addr", a.getTagname());
	            rowMap.put("a_desc", a.getAlarmdesc());
	            rowMap.put("a_stime", a.getStart_time());
	            rowMap.put("a_etime", a.getEnd_time() != null ? a.getEnd_time() : "");
	            
	            // 해제되지 않은 알람 체크
	            if(a.getEnd_time() == null || a.getEnd_time().isEmpty()) {
	                rowMap.put("is_active", true);
	            } else {
	                rowMap.put("is_active", false);
	            }
	            
	            rtnList.add(rowMap);
	        }
	        
	        rtnMap.put("success", true);
	        rtnMap.put("data", rtnList);
	        rtnMap.put("total_count", alarmList.size());
	        
	    } catch (Exception e) {
	        System.err.println("배치리포트 알람 조회 오류: " + e.getMessage());
	        e.printStackTrace();
	        
	        rtnMap.put("success", false);
	        rtnMap.put("error", e.getMessage());
	        rtnMap.put("data", new ArrayList<>());
	        rtnMap.put("total_count", 0);
	    }
	    
	    return rtnMap;
	}
	

	// ✅ PLC 알람 상태 확인 메서드
	private boolean checkAlarmStatusInPLC(String tagName) {
	    try {
	        String fullNodeId = "ace_posco.ALARM." + tagName;
	        UShort namespaceIndex = Unsigned.ushort(2);
	        NodeId nodeId = new NodeId(namespaceIndex, fullNodeId);
	        
	        DataValue dataValue = MainController.client.readValue(
	            0, TimestampsToReturn.Neither, nodeId
	        ).get();
	        
	        return (boolean) dataValue.getValue().getValue();
	    } catch (Exception e) {
	        // PLC 읽기 실패 시 DB 기준으로 판단
	        return true;
	    }
	}
	
	
	
	
	
	
	
	@RequestMapping(value = "/monitoring/trend/list", method = RequestMethod.POST)
	@ResponseBody
	public List<Monitoring> gettrend(Monitoring monitoring) {

	    DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
	    DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

	    LocalDateTime startDateTime = LocalDateTime.parse(monitoring.getStartDate(), inputFormatter);
	    LocalDateTime endDateTime = LocalDateTime.parse(monitoring.getEndDate(), inputFormatter);

	    monitoring.setStartDate(startDateTime.format(outputFormatter)); 
	    monitoring.setEndDate(endDateTime.format(outputFormatter));

	    return monitoringService.gettrend(monitoring);
	}
	
	
	// CSV 저장
	@RequestMapping(value = "/monitoring/trend/saveCSV", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveCSV(@RequestParam String csvData, @RequestParam String filename) {
	    Map<String, Object> result = new HashMap<>();
	    
	    try {
	        // 저장 경로 설정
	        String directoryPath = "D:\\온도파일저장";
	        String fullPath = directoryPath + "\\" + filename;
	        
	        // 디렉토리 생성 (없으면)
	        File directory = new File(directoryPath);
	        if (!directory.exists()) {
	            boolean created = directory.mkdirs();
	            if (!created) {
	                result.put("status", "ERR");
	                result.put("error", "디렉토리 생성 실패: " + directoryPath);
	                return result;
	            }
	        }
	        
	        // CSV 파일 저장 (UTF-8 BOM 추가 - 엑셀 한글 깨짐 방지)
	        Path path = Paths.get(fullPath);
	        byte[] bom = new byte[] { (byte) 0xEF, (byte) 0xBB, (byte) 0xBF };
	        byte[] csvBytes = csvData.getBytes(StandardCharsets.UTF_8);
	        
	        // BOM + CSV 데이터 결합
	        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
	        outputStream.write(bom);
	        outputStream.write(csvBytes);
	        
	        Files.write(path, outputStream.toByteArray());
	        
	        result.put("status", "OK");
	        result.put("path", fullPath);
	        result.put("filename", filename);
	        
	        System.out.println("✅ CSV 파일 저장 완료: " + fullPath);
	        
	    } catch (IOException e) {
	        result.put("status", "ERR");
	        result.put("error", "파일 저장 실패: " + e.getMessage());
	        
	        System.err.println("❌ CSV 파일 저장 실패: " + e.getMessage());
	        e.printStackTrace();
	    }
	    
	    return result;
	}
	
	
	
		
	@RequestMapping(value = "/monitoring/trend/pattern", method = RequestMethod.POST)
	@ResponseBody
	public List<Monitoring> getPatternTrend(Monitoring monitoring) {

	  
	    return monitoringService.getPatternTrend(monitoring);
	}

	@RequestMapping(value = "/monitoring/trend/realtime", method = RequestMethod.POST)
	@ResponseBody
	public List<Monitoring> getRealtimeTrend() {
	    return monitoringService.getRealtimeTrend();
	}
	
	
	@RequestMapping(value = "/monitoring/trend/pattern/current", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getCurrentPattern() {

	    Pattern current = monitoringService.getCurrentRunningPattern();

	    Map<String, Object> map = new HashMap<>();
	    if(current == null){
	        map.put("running", false);
	    } else {
	        map.put("running", true);
	        map.put("patternNo", current.getProc_ptrn_no());
	        map.put("startTime", current.getProc_ptrn_start());
	        map.put("endTime", current.getProc_ptrn_end());
	    }

	    return map;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	///////////////패턴 네이밍//////////////////
	@RequestMapping(value = "/monitoring/pattern/name", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getPatternName(@RequestParam int pattern_no) {
	    Map<String, Object> result = new HashMap<>();
	    
	    try {
	        Pattern pattern = monitoringService.getPatternName(pattern_no);
	        
	        if (pattern != null) {
	            result.put("status", "OK");
	            result.put("pattern_no", pattern.getPattern_no());
	            result.put("pattern_name", pattern.getPattern_name());
	        } else {
	            result.put("status", "ERR");
	            result.put("message", "패턴을 찾을 수 없습니다.");
	        }
	        
	    } catch (Exception e) {
	        result.put("status", "ERR");
	        result.put("message", e.getMessage());
	        e.printStackTrace();
	    }
	    
	    return result;
	}

	//패턴 좌측 이름 한꺼번에 조회 메서드
	@RequestMapping(value = "/monitoring/pattern/names", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getAllPatternNames() {
	    Map<String, Object> result = new HashMap<>();
	    
	    try {
	        List<Pattern> patternNames = monitoringService.getAllPatternNames();
	        
	        result.put("status", "OK");
	        result.put("patternNames", patternNames);
	        
	    } catch (Exception e) {
	        result.put("status", "ERR");
	        result.put("message", e.getMessage());
	        e.printStackTrace();
	    }
	    
	    return result;
	}

	//패턴이름수정
	@RequestMapping(value = "/monitoring/pattern/name/update", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updatePatternName(
	        @RequestParam int pattern_no, 
	        @RequestParam String pattern_name) {
	    
	    Map<String, Object> result = new HashMap<>();
	    
	    try {
	        
	        if (pattern_no < 1 || pattern_no > 14) {
	            result.put("status", "ERR");
	            result.put("message", "패턴 번호는 1~14 범위여야 합니다.");
	            return result;
	        }
	        
	        
	        if (pattern_name == null || pattern_name.trim().isEmpty()) {
	            result.put("status", "ERR");
	            result.put("message", "패턴 이름을 입력해주세요.");
	            return result;
	        }
	        
	        if (pattern_name.length() > 200) {
	            result.put("status", "ERR");
	            result.put("message", "패턴 이름은 200자 이내로 입력해주세요.");
	            return result;
	        }
	        
	        
	        boolean success = monitoringService.updatePatternName(pattern_no, pattern_name.trim());
	        
	        if (success) {
	            result.put("status", "OK");
	            result.put("message", "패턴 이름이 수정되었습니다.");
	        } else {
	            result.put("status", "ERR");
	            result.put("message", "패턴 이름 수정 실패");
	        }
	        
	    } catch (Exception e) {
	        result.put("status", "ERR");
	        result.put("message", e.getMessage());
	        e.printStackTrace();
	    }
	    
	    return result;
	}

	//초기화
	@RequestMapping(value = "/monitoring/pattern/name/reset", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> resetPatternName(@RequestParam int pattern_no) {
	    Map<String, Object> result = new HashMap<>();
	    
	    try {
	        
	        if (pattern_no < 1 || pattern_no > 14) {
	            result.put("status", "ERR");
	            result.put("message", "패턴 번호는 1~14 범위여야 합니다.");
	            return result;
	        }
	        
	        
	        boolean success = monitoringService.resetPatternName(pattern_no);
	        
	        if (success) {
	            result.put("status", "OK");
	            result.put("message", "패턴 이름이 초기화되었습니다.");
	        } else {
	            result.put("status", "ERR");
	            result.put("message", "패턴 이름 초기화 실패");
	        }
	        
	    } catch (Exception e) {
	        result.put("status", "ERR");
	        result.put("message", e.getMessage());
	        e.printStackTrace();
	    }
	    
	    return result;
	}

	//초기세팅
	@RequestMapping(value = "/monitoring/pattern/initialize", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> initializePatternNames() {
	    Map<String, Object> result = new HashMap<>();
	    
	    try {
	    	monitoringService.initializePatternNames();
	        
	        result.put("status", "OK");
	        result.put("message", "패턴 이름 초기화 완료");
	        
	    } catch (Exception e) {
	        result.put("status", "ERR");
	        result.put("message", e.getMessage());
	        e.printStackTrace();
	    }
	    
	    return result;
	}
	
	

	

}
