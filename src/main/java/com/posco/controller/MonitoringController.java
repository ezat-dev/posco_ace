package com.posco.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import org.eclipse.milo.opcua.stack.core.UaException;
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
	
	
	@RequestMapping(value= "/monitoring/view/string", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> manualOperationViewString() throws UaException, InterruptedException, ExecutionException {
		Map<String, Object> returnMap = new HashMap<String, Object>();

		OpcDataMap opcDataMap = new OpcDataMap();

		returnMap = opcDataMap.getOpcDataListMap("ace_posco.OVERVIEW");

		// System.out으로 찍기
		System.out.println("manualOperationView 호출됨");
		System.out.println("returnMap 내용: " + returnMap);

		return returnMap;       
	}

	
	@RequestMapping(value= "/monitoring/view", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> manualOperationView() throws UaException, InterruptedException, ExecutionException {
		Map<String, Object> returnMap = new HashMap<String, Object>();

		OpcDataMap opcDataMap = new OpcDataMap();

		returnMap = opcDataMap.getOpcDataListMap("ace_posco.OVERVIEW");

		//  System.out으로 찍기
		System.out.println("monitoring view 호출됨");
		System.out.println("returnMap 내용: " + returnMap);

		return returnMap;       
	}
	
	
	@RequestMapping(value= "/monitoring/alarmView", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> alarmView() throws UaException, InterruptedException, ExecutionException {
		Map<String, Object> returnMap = new HashMap<String, Object>();

		OpcDataMap opcDataMap = new OpcDataMap();

		returnMap = opcDataMap.getOpcDataListMap("ace_posco.ALARM_LAMP");

		// System.out으로 찍기
		System.out.println("alarmView 호출됨");
		System.out.println("returnMap 내용: " + returnMap);

		return returnMap;       
	}

	
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
	
	@RequestMapping(value = "/monitoring/alarmRanking", method = RequestMethod.GET)
	public String alarmRanking(Users users) {

		return "/monitoring/alarmRanking.jsp";
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
	
	//고진공밸브
	@RequestMapping(value = "/popup/gasValve", method = RequestMethod.GET)
	public String gasValve(Users users) {
		return "/popup/gasValve.jsp"; 
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

		System.out.println("검색된 행 수: " + alarmList.size());

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
