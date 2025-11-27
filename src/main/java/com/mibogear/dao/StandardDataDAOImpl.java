package com.mibogear.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.mibogear.domain.StandardData;

@Repository
public class StandardDataDAOImpl implements StandardDataDAO{
	
	@Resource(name="session")
    private SqlSession sqlSession;

	//기준정보 조회
	@Override
	public List<StandardData> getStandardDataList(StandardData standardData) {
		return sqlSession.selectList("standardData.getStandardDataList", standardData);
	}

	//기준정보 생성
	@Override
	public boolean insertStandardData(StandardData standardData) {
		int result =  sqlSession.insert("standardData.insertStandardData", standardData);
		if(result <= 0) {
			return false;
		}
		return true;
	}

	//기준정보 수정
	@Override
	public boolean updateStandardData(StandardData standardData) {
		int result =  sqlSession.update("standardData.updateStandardData", standardData);
		if(result <= 0) {
			return false;
		}
		return true;
	}

	//기준정보 삭제
	@Override
	public boolean deleteStandardData(StandardData standardData) {
		int result =  sqlSession.delete("standardData.deleteMachineSpare", standardData);
		if(result <= 0) {
			return false;
		}
		return true;
	}

}
