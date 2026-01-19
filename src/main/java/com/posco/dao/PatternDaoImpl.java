package com.posco.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.posco.domain.Pattern;

@Repository
public class PatternDaoImpl implements PatternDao {
	
	@Resource(name="session")
    private SqlSession sqlSession;

	@Override
	public List<Pattern> patternDataList() {
		return sqlSession.selectList("pattern.patternDataList");
	}

	@Override
	public void patternStartDataSave(Pattern p) {
		sqlSession.insert("pattern.patternStartDataSave",p);
	}

	@Override
	public void patternStartDataForceUpdate(Pattern p) {
		sqlSession.update("pattern.patternStartDataForceUpdate",p);
	}

	@Override
	public List<Pattern> patternEndDataList(Pattern p) {
		return sqlSession.selectList("pattern.patternEndDataList",p);
	}

	@Override
	public void patternEndDataUpdate(Pattern p) {
		sqlSession.update("pattern.patternEndDataUpdate",p);
	}
	
	
	
	

}
