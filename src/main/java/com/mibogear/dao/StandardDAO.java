package com.mibogear.dao;

import java.util.List;

import com.mibogear.domain.Corp;
import com.mibogear.domain.Fac;
import com.mibogear.domain.Measure;
import com.mibogear.domain.Product;
import com.mibogear.domain.Standard;
import com.mibogear.domain.Users;

public interface StandardDAO {
	
	List<Users> getUserList(Users user); 
	
	List<Users> getBigPageList(); 
	
	List<Users> getSmallPageList(String page_big);
	
	
	//제품 리스트 조회
	List<Product> getProductList(Product product);
	
	//제품 더블클릭
	Product productInsertDetail(Product product);
	
	//제품 저장
	void productInsertSave(Product product);
	
	//제품 업데이트
	void productUpdateSave(Product product);
	
	//제품 삭제
	void productDelete(String prod_code);
	
	
	
	//거래처 리스트 조회
	List<Corp> getCorpList(Corp corp);
	
	Corp cutumInsertDetail(Corp corp);
	
	void cutumInsertSave(Corp corp);
	
	void cutumUpdateSave(Corp corp);
	
	void cutumDelete(String corp_code);
	
	
	
	
	List<Fac> getFacList(Fac fac);
	
	Fac facInsertDetail(Fac fac);
	
	void facInsertSave(Fac fac);
	
	void facUpdateSave(Fac fac);
	
	void facDelete(String fac_code);
	
	
	
	List<Standard> getStandardList(Standard stadnard);
	
	Standard standardDetail(Standard stadnard);
	
	void standardInsertSave(Standard stadnard);
	
	void standardUpdateSave(Standard stadnard);
	
	void standardDelete(String wstd_code);
	
	
	
	
	List<Measure> getMeasureList();
	
	void measureInsertSave(Measure measure);
	
	void measureUpdateSave(Measure measure);
	
	Measure getMeasurmentDetail(Measure measure);
	
	void measureDelete(String ter_code);
	
	
}
