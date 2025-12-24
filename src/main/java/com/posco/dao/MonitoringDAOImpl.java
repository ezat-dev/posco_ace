package com.posco.dao;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import com.posco.domain.Monitoring;
import com.posco.domain.Pattern;

@Repository
public class MonitoringDAOImpl implements MonitoringDAO{
	
	@Resource(name="session")
	private SqlSession sqlSession;
	
	@Resource(name="sessionSQLite")
	private SqlSession sessionSQLite;
	
	@Override
	public List<Monitoring> gettrend(Monitoring monitoring) {
		return sqlSession.selectList("monitoring.gettrend", monitoring);
	}
	
	@Override
	public List<Pattern> getPatternList(Pattern pattern) {
		return sqlSession.selectList("monitoring.getPatternList", pattern);
	}
	
	@Override
	public List<Monitoring> alarmRecordListAll(Monitoring monitoring) {
		return sessionSQLite.selectList("alarm.alarmRecordListAll", monitoring);
	}
	
	@Override
	public List<Monitoring> alarmRecordListOver() {
		return sessionSQLite.selectList("alarm.alarmRecordListOver");
	}
	
	@Override
	public void patternInputList(Map<String, Object> rtnMap) {
		sqlSession.update("monitoring.patternInputList", rtnMap);
	}
	
	@Override
	public Map<String, Object> getPatternInfo(int patternNo) {
		return sqlSession.selectOne("monitoring.getPatternInfo", patternNo);
	}
}