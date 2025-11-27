package com.mibogear.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mibogear.dao.StandardDataDAO;
import com.mibogear.domain.StandardData;

@Service
public class StandardDataServiceImpl implements StandardDataService{
	
	@Autowired
	private StandardDataDAO standardDataDAO;

	@Override
	public List<StandardData> getStandardDataList(StandardData standardData) {
		return standardDataDAO.getStandardDataList(standardData);
	}

	@Override
	public boolean insertStandardData(StandardData standardData) {
		return standardDataDAO.insertStandardData(standardData);
	}

	@Override
	public boolean updateStandardData(StandardData standardData) {
		return standardDataDAO.updateStandardData(standardData);
	}

	@Override
	public boolean deleteStandardData(StandardData standardData) {
		return standardDataDAO.deleteStandardData(standardData);
	}

}
