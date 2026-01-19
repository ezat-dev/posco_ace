package com.posco.service;

import java.util.List;
import java.util.Map;
import com.posco.domain.Monitoring;
import com.posco.domain.Pattern;
import com.posco.domain.Product;

public interface MonitoringService {
	
	List<Monitoring> alarmRecordListAll(Monitoring monitoring);
	
	List<Monitoring> getBatchReportAlarms(Monitoring monitoring);
	
	List<Monitoring> alarmRecordListOver();
	
	List<Monitoring> gettrend(Monitoring monitoring);
	
	List<Monitoring> getPatternTrend(Monitoring monitoring);

	List<Monitoring> getRealtimeTrend();
	
	Pattern getCurrentRunningPattern();


	void patternInputList(Map<String, Object> rtnMap);
	
	List<Pattern> getPatternList(Pattern pattern);
	
	Map<String, Object> getPatternInfo(int patternNo);
	
	
	List<Monitoring> getPatternName(Monitoring monitoring);
	
	void updatePatternName(Product product);
	
	
	
	
	// 패턴 이름 조회 (단건)
    Pattern getPatternName(int pattern_no);
    
    // 전체 패턴 이름 조회
    List<Pattern> getAllPatternNames();
    
    // 패턴 이름 수정
    boolean updatePatternName(int pattern_no, String pattern_name);
    
    // 패턴 이름 초기화
    boolean resetPatternName(int pattern_no);
    
    // 패턴 이름 초기 데이터 생성 (1~14)
    void initializePatternNames();
	
	
}