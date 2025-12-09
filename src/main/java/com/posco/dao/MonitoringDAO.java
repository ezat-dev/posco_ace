package com.posco.dao;

import java.util.List;

import com.posco.domain.Monitoring;

public interface MonitoringDAO {
	
	List<Monitoring> alarmRecordListAll(Monitoring monitoring);
	
	List<Monitoring> alarmRecordListOver();
	
	List<Monitoring> gettrend(Monitoring monitoring); 
	
}
