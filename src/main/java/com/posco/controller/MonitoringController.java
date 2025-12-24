package com.posco.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import org.eclipse.milo.opcua.stack.core.UaException;
import org.eclipse.milo.opcua.stack.core.types.builtin.DataValue;
import org.eclipse.milo.opcua.stack.core.types.builtin.NodeId;
import org.eclipse.milo.opcua.stack.core.types.builtin.StatusCode;
import org.eclipse.milo.opcua.stack.core.types.builtin.Variant;
import org.eclipse.milo.opcua.stack.core.types.builtin.unsigned.UShort;
import org.eclipse.milo.opcua.stack.core.types.builtin.unsigned.Unsigned;
import org.eclipse.milo.opcua.stack.core.types.enumerated.TimestampsToReturn;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.posco.domain.Monitoring;
import com.posco.domain.Users;
import com.posco.service.MonitoringService;
import com.posco.util.OpcDataMap;

@Controller
public class MonitoringController {
	
	@Autowired
	private MonitoringService monitoringService;
	
	private final Logger logger = LoggerFactory.getLogger(MonitoringController.class);
	
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
	
	@RequestMapping(value = "/monitoring/trend", method = RequestMethod.GET)
	public String trend(Users users) {

		return "/monitoring/trend.jsp";
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

		
	
	
	

}
