package com.posco.dao;

import java.util.List;
import java.util.Map;
import com.posco.domain.Monitoring;
import com.posco.domain.Pattern;

public interface MonitoringDAO {
	
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
	
	
	
	
	// 패턴 이름 조회 (단건)
    Pattern getPatternName(int pattern_no);
    
    // 전체 패턴 이름 조회
    List<Pattern> getAllPatternNames();
    
    // 패턴 이름 수정
    int updatePatternName(Pattern pattern);
    
    // 패턴 이름 초기화
    int resetPatternName(int pattern_no);
    
    // 패턴 이름 존재 여부 확인
    int checkPatternNameExists(int pattern_no);
    
    // 패턴 이름 초기 데이터 삽입
    int insertPatternName(Pattern pattern);
    
    
    
}