package com.posco.service;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.posco.dao.MonitoringDAO;
import com.posco.domain.Monitoring;
import com.posco.domain.Pattern;

@Service
public class MonitoringServiceImpl implements MonitoringService{
	
	@Autowired
	private MonitoringDAO monitoringDAO;
	
	@Override
	public List<Monitoring> alarmRecordListAll(Monitoring monitoring) {
		return monitoringDAO.alarmRecordListAll(monitoring);
	}
	
	@Override
	public List<Monitoring> getBatchReportAlarms(Monitoring monitoring) {
		return monitoringDAO.getBatchReportAlarms(monitoring);
	}
	
	@Override
	public List<Monitoring> alarmRecordListOver() {
		return monitoringDAO.alarmRecordListOver();
	}
	
	@Override
	public List<Monitoring> gettrend(Monitoring monitoring) {
		return monitoringDAO.gettrend(monitoring);
	}
	
	@Override
	public List<Monitoring> getPatternTrend(Monitoring monitoring) {
	    return monitoringDAO.getPatternTrend(monitoring);
	}
	
	@Override
	public List<Monitoring> getRealtimeTrend() {
	    return monitoringDAO.getRealtimeTrend();
	}
	
	@Override
	public Pattern getCurrentRunningPattern() {
	    return monitoringDAO.getCurrentRunningPattern();
	}

	
	@Override
	public void patternInputList(Map<String, Object> rtnMap) {
		monitoringDAO.patternInputList(rtnMap);
	}
	
	@Override
	public List<Pattern> getPatternList(Pattern pattern) {
		return monitoringDAO.getPatternList(pattern);
	}
	
	@Override
	public Map<String, Object> getPatternInfo(int patternNo) {
		return monitoringDAO.getPatternInfo(patternNo);
	}
	
	
	
	
	
	
	
	
	
	@Override
    public Pattern getPatternName(int pattern_no) {
        return monitoringDAO.getPatternName(pattern_no);
    }
    
    @Override
    public List<Pattern> getAllPatternNames() {
        return monitoringDAO.getAllPatternNames();
    }
    
    @Override
    public boolean updatePatternName(int pattern_no, String pattern_name) {
        Pattern pattern = new Pattern();
        pattern.setPattern_no(pattern_no);
        pattern.setPattern_name(pattern_name);
        
        int result = monitoringDAO.updatePatternName(pattern);
        return result > 0;
    }
    
    @Override
    public boolean resetPatternName(int pattern_no) {
        int result = monitoringDAO.resetPatternName(pattern_no);
        return result > 0;
    }
    
    @Override
    public void initializePatternNames() {
        // 패턴 1~14까지 초기 데이터 생성
        for (int i = 1; i <= 14; i++) {
            int exists = monitoringDAO.checkPatternNameExists(i);
            
            if (exists == 0) {
                Pattern pattern = new Pattern();
                pattern.setPattern_no(i);
                pattern.setPattern_name("패턴 " + i);
                monitoringDAO.insertPatternName(pattern);
            }
        }
    }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}