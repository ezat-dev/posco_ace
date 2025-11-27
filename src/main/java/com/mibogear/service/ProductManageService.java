package com.mibogear.service;

import java.util.List;
import java.util.Map;

import com.mibogear.domain.DroppedGoods;

public interface ProductManageService {
	
	List<DroppedGoods> getDroppedGoodsList();
	
	void updateDroppedGoods(Map<String, Object> param);
	

}
