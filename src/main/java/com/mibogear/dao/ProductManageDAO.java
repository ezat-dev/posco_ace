package com.mibogear.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mibogear.domain.DroppedGoods;

@Repository
public interface ProductManageDAO {
	
	List<DroppedGoods> getDroppedGoodsList();
	
	void updateDroppedGoods(Map<String, Object> param);

}
