package com.mibogear.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.mibogear.domain.StandardData;

@Repository
public interface StandardDataDAO {
	
	//기준정보 조회
	List<StandardData> getStandardDataList(StandardData standardData);
	
	//기준정보 생성
	boolean insertStandardData(StandardData standardData);
	
	//기준정보 수정
	boolean updateStandardData(StandardData standardData);
	
	//기준정보 삭제
	boolean deleteStandardData(StandardData standardData);

}
