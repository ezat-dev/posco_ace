package com.mibogear.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mibogear.domain.Condition;
import com.mibogear.domain.StandardData;
import com.mibogear.domain.TempCorrectionQue;
import com.mibogear.domain.Thermocouple;


@Repository
public interface ConditionDao {
	
	//기준정보 조회
	List<Condition> getStandardDataList(Condition condition);
	
	//기준정보 생성
	boolean insertStandardData(Condition condition);
	
	//기준정보 수정
	boolean updateStandardData(Condition condition);
	
	//기준정보 삭제
	boolean deleteStandardData(Condition condition);
	  //-----------------------------------------------------
	  //기준정보
	  List<Condition> getStandardInfoList(Condition params); 
	
	  void saveDivisionWeight(Condition condition);
	  
	  void delDivisionWeight(Condition condition);
	  
	  //TC조절
	  List<Condition> getCorrStatusList(Condition params);
	  
	  void delCorrStatus(Condition condition);
	  
	  void saveCorrStatus(Condition condition);
	  
	  //조건관리
	  
	  List<Condition> getconditionList(Condition condition);
	  void machinePartTempUpdate(Condition condition);
	 
	  
	  
	  //액교반일지
	  
	    List<Condition> getMachineliquidmanage(Condition condition); 
	    void insertMachineliquidmanage(Condition condition); 
	    
	    List<Condition> getMachineliquidmanage2(Condition condition); 
	    void insertMachineliquidmanage2(Condition condition); 
	   
	    void deleteMachineliquidmanage(Condition condition); 
	    void deleteMachineliquidmanage2(Condition condition); 
	    
	    //관리계획서 및 작업 표준서
	    List<Condition> standardDocList(Condition condition); 
	    
	    void standardDocSaves(Condition condition);
	    
	    void standardDocDel(Condition condition);
	    
	    
	    List<Thermocouple> getThermocoupleList(String year);
	    
	    void thermocoupleSave(Thermocouple thermocouple);
	    
	    
	    List<TempCorrectionQue> getTempCorrectionQueList(String year);
	    
	    void updateTempCorrectionField(Map<String, Object> param);
}
