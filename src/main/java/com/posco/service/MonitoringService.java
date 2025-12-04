package com.posco.service;

import java.util.List;

import com.posco.domain.Monitoring;

public interface MonitoringService {
	
	List<Monitoring> alarmRecordListAll(Monitoring monitoring);
	
	List<Monitoring> gettrend(Monitoring monitoring);

}
