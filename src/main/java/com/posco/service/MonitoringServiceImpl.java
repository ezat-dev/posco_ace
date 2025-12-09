package com.posco.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.posco.dao.MonitoringDAO;
import com.posco.domain.Monitoring;
@Service
public class MonitoringServiceImpl implements MonitoringService{
	
	@Autowired
	private MonitoringDAO monitoringDAO;
	
	
	 @Override public List<Monitoring> alarmRecordListAll(Monitoring monitoring) {
	 
	 return monitoringDAO.alarmRecordListAll(monitoring); }
	 
	 @Override public List<Monitoring> alarmRecordListOver() {
		 
		 return monitoringDAO.alarmRecordListOver(); }
	 
	
	@Override
	public List<Monitoring > gettrend(Monitoring monitoring) {
	    
		return monitoringDAO.gettrend(monitoring); 	   
	}

}
