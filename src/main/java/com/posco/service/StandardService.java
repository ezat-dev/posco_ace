package com.posco.service;

import java.util.List;

import com.posco.domain.Corp;
import com.posco.domain.Fac;
import com.posco.domain.Measure;
import com.posco.domain.Product;
import com.posco.domain.Standard;
import com.posco.domain.Users;

public interface StandardService {
	
	List<Users> getUserList(Users user); 
	
	List<Users> getBigPageList(); 
	
	List<Users> getSmallPageList(String page_big);
	
	
	
	
	List<Product> getProductList(Product product);
	
	Product productInsertDetail(Product product);
	
	void productInsertSave(Product product);
	
	void productUpdateSave(Product product);
	
	void productDelete(String prod_code);
	
	
	
	
	
	
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
