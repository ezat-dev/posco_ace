package com.mibogear.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mibogear.domain.Users;

@Controller
public class MonitoringController {

	
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

}
