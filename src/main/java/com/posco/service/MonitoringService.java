package com.posco.service;

import java.util.List;
import java.util.Map;
import com.posco.domain.Monitoring;
import com.posco.domain.Pattern;

public interface MonitoringService {
	
	List<Monitoring> alarmRecordListAll(Monitoring monitoring);
	
	List<Monitoring> alarmRecordListOver();
	
	List<Monitoring> gettrend(Monitoring monitoring);
	
	void patternInputList(Map<String, Object> rtnMap);
	
	List<Pattern> getPatternList(Pattern pattern);
	
	Map<String, Object> getPatternInfo(int patternNo);
}