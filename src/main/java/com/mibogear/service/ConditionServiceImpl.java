package com.mibogear.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mibogear.dao.ConditionDao;
import com.mibogear.domain.Condition;
import com.mibogear.domain.CorrStatus;
import com.mibogear.domain.StandardData;
import com.mibogear.domain.TempCorrectionQue;
import com.mibogear.domain.Thermocouple;
import com.mibogear.domain.Work;



@Service 
public class ConditionServiceImpl implements ConditionService {

	@Autowired  
	private ConditionDao conditionDao;


	//기준정보 조회
	@Override
	public List<Condition> getStandardDataList(Condition condition) {
		return conditionDao.getStandardDataList(condition);
	}

	//기준정보 생성
	@Override
	public boolean insertStandardData(Condition condition) {
		return conditionDao.insertStandardData(condition);
	}

	//기준정보 수정
	@Override
	public boolean updateStandardData(Condition condition) {
		return conditionDao.updateStandardData(condition);
	}

	//기준정보 삭제
	@Override
	public boolean deleteStandardData(Condition condition) {
		return conditionDao.deleteStandardData(condition);
	}

	//--------------------------------------------------
	//기준정보
	@Override
	public List<Condition> getStandardInfoList(Condition params) {
		return conditionDao.getStandardInfoList(params); 	   
	}

	@Override
	public void saveDivisionWeight(Condition condition) {
		conditionDao.saveDivisionWeight(condition);
	}

	@Override
	public void delDivisionWeight(Condition condition) {
		conditionDao.delDivisionWeight(condition);
	}

	//TC조절
	@Override
	public List<Condition> getCorrStatusList(Condition params) {
		return conditionDao.getCorrStatusList(params); 	   
	}
	@Override
	public void delCorrStatus(Condition condition) {
		conditionDao.delCorrStatus(condition);
	}

	@Override
	public void saveCorrStatus(Condition condition) {
		conditionDao.saveCorrStatus(condition);
	}


	//조건관리

	@Override
	public List<Condition> getconditionList(Condition condition){
		return conditionDao.getconditionList(condition);
	}

	@Override
	public void machinePartTempUpdate(Condition condition) {
		conditionDao.machinePartTempUpdate(condition);
	}


	@Override
	public List<Condition> getMachineliquidmanage(Condition condition){
		return conditionDao.getMachineliquidmanage(condition);
	}

	@Override
	public void insertMachineliquidmanage(Condition condition) {
		conditionDao.insertMachineliquidmanage(condition);
	}


	@Override
	public List<Condition> getMachineliquidmanage2(Condition condition){
		return conditionDao.getMachineliquidmanage2(condition);
	}

	@Override
	public void insertMachineliquidmanage2(Condition condition) {
		conditionDao.insertMachineliquidmanage2(condition);
	}

	@Override
	public void deleteMachineliquidmanage(Condition condition) {
		conditionDao.deleteMachineliquidmanage(condition);
	}

	@Override
	public void deleteMachineliquidmanage2(Condition condition) {
		conditionDao.deleteMachineliquidmanage2(condition);
	}
	
	
    @Override
    public List<Condition> standardDocList(Condition condition) {
        return conditionDao.standardDocList(condition);
    }

    @Override
    public void standardDocSaves(Condition condition) {
    	conditionDao.standardDocSaves(condition);
    }

    @Override
    public void standardDocDel(Condition condition) {
    	conditionDao.standardDocDel(condition);
    }
    
    
  //열전대교체이력

  	@Override
  	public List<Thermocouple> getThermocoupleList(String year){
  		return conditionDao.getThermocoupleList(year);
  	}
  	
  	@Override
	public void thermocoupleSave(Thermocouple thermocouple) {
		conditionDao.thermocoupleSave(thermocouple);
	}

  	
  	@Override
  	public List<TempCorrectionQue> getTempCorrectionQueList(String year) {
  	    return conditionDao.getTempCorrectionQueList(year);
  	}
  	
  	public void updateTempCorrectionField(Map<String, Object> param) {
  		conditionDao.updateTempCorrectionField(param);
  	}
}
