package com.mibogear.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.mibogear.domain.Condition;
import com.mibogear.domain.StandardData;
import com.mibogear.domain.TempCorrectionQue;
import com.mibogear.domain.Thermocouple;

@Repository 
public class ConditionDaoImpl implements ConditionDao {

	@Resource(name="session")
	private SqlSession sqlSession;


	//기준정보 조회
	@Override
	public List<Condition> getStandardDataList(Condition condition) {
		return sqlSession.selectList("condition.getStandardDataList", condition);
	}

	//기준정보 생성
	@Override
	public boolean insertStandardData(Condition condition) {
		int result =  sqlSession.insert("condition.insertStandardData", condition);
		if(result <= 0) {
			return false;
		}
		return true;
	}

	//기준정보 수정
	@Override
	public boolean updateStandardData(Condition condition) {
		int result =  sqlSession.update("condition.updateStandardData", condition);
		if(result <= 0) {
			return false;
		}
		return true;
	}

	//기준정보 삭제
	@Override
	public boolean deleteStandardData(Condition condition) {
		int result =  sqlSession.delete("condition.deleteStandardData", condition);
		if(result <= 0) {
			return false;
		}
		return true;
	}


	//-----------------------------------------------------------------

	//기준정보
	@Override
	public List<Condition> getStandardInfoList(Condition params) {

		return sqlSession.selectList("condition.getStandardInfoList", params);
	}

	@Override
	public void saveDivisionWeight(Condition condition) {
		sqlSession.insert("condition.saveDivisionWeight",condition);
	}

	@Override
	public void delDivisionWeight(Condition condition) {
		sqlSession.delete("condition.delDivisionWeight",condition);
	}

	//TC조절
	@Override
	public List<Condition> getCorrStatusList(Condition params) {

		return sqlSession.selectList("condition.getCorrStatusList", params);
	}

	@Override
	public void delCorrStatus(Condition condition) {
		sqlSession.delete("condition.delCorrStatus",condition);
	}

	@Override
	public void saveCorrStatus(Condition condition) {
		sqlSession.update("condition.saveCorrStatus",condition);
	}

	//조건관리
	@Override
	public List<Condition> getconditionList(Condition condition) {
		return sqlSession.selectList("condition.getconditionList",condition);
	}
	@Override
	public void machinePartTempUpdate(Condition condition) {
		sqlSession.update("condition.machinePartTempUpdate",condition);
	}


	//액교반
	@Override
	public List<Condition> getMachineliquidmanage(Condition condition) {
		return sqlSession.selectList("condition.getMachineliquidmanage",condition);
	}
	@Override
	public void insertMachineliquidmanage(Condition condition) {
		sqlSession.update("condition.insertMachineliquidmanage",condition);
	}
	//액교반
	@Override
	public List<Condition> getMachineliquidmanage2(Condition condition) {
		return sqlSession.selectList("condition.getMachineliquidmanage2",condition);
	}
	@Override
	public void insertMachineliquidmanage2(Condition condition) {
		sqlSession.update("condition.insertMachineliquidmanage2",condition);
	}

	@Override
	public void deleteMachineliquidmanage(Condition condition) {
		sqlSession.update("condition.deleteMachineliquidmanage",condition);
	}
	@Override
	public void deleteMachineliquidmanage2(Condition condition) {
		sqlSession.update("condition.deleteMachineliquidmanage2",condition);
	}
	

	@Override
    public List<Condition> standardDocList(Condition condition) {

        return sqlSession.selectList("condition.standardDocList", condition);
    }
    @Override
    public void standardDocSaves(Condition condition) {
    	sqlSession.insert("condition.standardDocSaves",condition);
    }

    @Override
    public void standardDocDel(Condition condition) {
    	sqlSession.delete("condition.standardDocDel",condition);
    }
    
    
    
  //열전대교체이력
  	@Override
  	public List<Thermocouple> getThermocoupleList(String year) {
  		return sqlSession.selectList("condition.getThermocoupleList", year);
  	}
  	
  	@Override
	public void thermocoupleSave(Thermocouple thermocouple) {
		sqlSession.update("condition.thermocoupleSave",thermocouple);
	}
  	
  	
  	
  	
  	
  	@Override
  	public List<TempCorrectionQue> getTempCorrectionQueList(String year) {
  		return sqlSession.selectList("condition.getTempCorrectionQueList", year);
  	}
  	
  	public void updateTempCorrectionField(Map<String, Object> param) {
  		sqlSession.update("condition.updateTempCorrectionField",param);
  	}

}
