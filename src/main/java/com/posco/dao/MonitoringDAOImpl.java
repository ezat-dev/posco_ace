package com.posco.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.posco.domain.Monitoring;
@Repository
public class MonitoringDAOImpl implements MonitoringDAO{

	
	@Resource(name="session")
    private SqlSession sqlSession;
	
	
	@Override
    public List<Monitoring> gettrend(Monitoring monitoring) { 
      
        return sqlSession.selectList("monitoring.gettrend", monitoring);
    }
	
	
	
	
	 @Resource(name="sessionSQLite") private SqlSession sessionSQLite;
	 
	 
	 @Override public List<Monitoring> alarmRecordListAll(Monitoring monitoring) {
	 return sessionSQLite.selectList("alarm.alarmRecordListAll", monitoring);
	 }
	 
	 @Override public List<Monitoring> alarmRecordListOver( ) {
		 return sessionSQLite.selectList("alarm.alarmRecordListOver");
		 }

}
