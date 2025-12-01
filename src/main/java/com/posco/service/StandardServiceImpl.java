package com.posco.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.posco.dao.StandardDAO;
import com.posco.domain.Corp;
import com.posco.domain.Fac;
import com.posco.domain.Measure;
import com.posco.domain.Product;
import com.posco.domain.Standard;
import com.posco.domain.Users;

@Service
public class StandardServiceImpl implements StandardService {
	
	@Autowired
	private StandardDAO standardDAO;
	
	
	@Override
	public List<Users> getUserList(Users user){
		return standardDAO.getUserList(user);
	}
	@Override
	public List<Users> getBigPageList(){
		return standardDAO.getBigPageList();
	}
	
	@Override
	public List<Users> getSmallPageList(String page_big) {  
		return standardDAO.getSmallPageList(page_big);  
	}
	
	
	//제품 리스트 조회
	@Override
	public List<Product> getProductList(Product product){
		return standardDAO.getProductList(product);
	}
	
	//제품 더블 클릭
	@Override
	public Product productInsertDetail(Product product) {
		return standardDAO.productInsertDetail(product);
	}
	
	//제품 저장
	@Override
	public void productInsertSave(Product product) {
		standardDAO.productInsertSave(product);
	}
	
	//제품 업데이트
	@Override
	public void productUpdateSave(Product product) {
		standardDAO.productUpdateSave(product);
	}
	
	//제품 삭제
	@Override
	public void productDelete(String prod_code) {
		standardDAO.productDelete(prod_code);
	}
	
	
	
	
	//거래처 리스트 조회
	@Override
	public List<Corp> getCorpList(Corp corp){
		return standardDAO.getCorpList(corp);
	}
	
	//거래처 더블클릭 조회
	@Override
	public Corp cutumInsertDetail(Corp corp) {
		return standardDAO.cutumInsertDetail(corp);
	}
	
	//거래처 저장
	@Override
	public void cutumInsertSave(Corp corp) {
		standardDAO.cutumInsertSave(corp);
	}
	
	//거래처 수정
	@Override
	public void cutumUpdateSave(Corp corp) {
		standardDAO.cutumUpdateSave(corp);
	}
	
	//거래처 삭제
	@Override
	public void cutumDelete(String corp_code) {
		standardDAO.cutumDelete(corp_code);
	}
	
	
	
	
	
	@Override
	public List<Fac> getFacList(Fac fac){
		return standardDAO.getFacList(fac);
	}
	
	@Override
	public Fac facInsertDetail(Fac fac) {
		return standardDAO.facInsertDetail(fac);
	}
	
	@Override
	public void facInsertSave(Fac fac) {
		standardDAO.facInsertSave(fac);
	}
	
	@Override
	public void facUpdateSave(Fac fac) {
		standardDAO.facUpdateSave(fac);
	}
	
	@Override
	public void facDelete(String fac_code) {
		standardDAO.facDelete(fac_code);
	}
	
	
	
	//제품 리스트 조회
	@Override
	public List<Standard> getStandardList(Standard stadnard){
		return standardDAO.getStandardList(stadnard);
	}

	//제품 더블 클릭
	@Override
	public Standard standardDetail(Standard stadnard) {
		return standardDAO.standardDetail(stadnard);
	}

	//제품 저장
	@Override
	public void standardInsertSave(Standard stadnard) {
		standardDAO.standardInsertSave(stadnard);
	}

	//제품 업데이트
	@Override
	public void standardUpdateSave(Standard stadnard) {
		standardDAO.standardUpdateSave(stadnard);
	}

	//제품 삭제
	@Override
	public void standardDelete(String wstd_code) {
		standardDAO.standardDelete(wstd_code);
	}
		
		
		
	
	
	
	@Override
	public List<Measure> getMeasureList(){
		return standardDAO.getMeasureList();
	}
	
	@Override
	public void measureInsertSave(Measure measure) {
		standardDAO.measureInsertSave(measure);
	}
	
	@Override
	public void measureUpdateSave(Measure measure) {
		standardDAO.measureUpdateSave(measure);
	}
	
	@Override
	public void measureDelete(String ter_code) {
		standardDAO.measureDelete(ter_code);
	}
	
	@Override
	public Measure getMeasurmentDetail(Measure measure) {
		return standardDAO.getMeasurmentDetail(measure);
	}
	

}
