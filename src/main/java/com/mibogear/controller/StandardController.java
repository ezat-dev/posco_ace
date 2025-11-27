package com.mibogear.controller;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mibogear.domain.Corp;
import com.mibogear.domain.Fac;
import com.mibogear.domain.Measure;
import com.mibogear.domain.Product;
import com.mibogear.domain.Standard;
import com.mibogear.domain.Users;
import com.mibogear.service.StandardService;


@Controller
public class StandardController {

	@Autowired
	private StandardService standardService;
	
	@RequestMapping(value = "/standardManagement/login", method = RequestMethod.GET)
	public String login(Users users) {
		return "/management/login.jsp";

	}

	@RequestMapping(value = "/standardManagement/sideBar", method = RequestMethod.GET)
	public String sideBar(Users users) {
		return "/include/sideBar.jsp";

	}
	
	//제품등록
	@RequestMapping(value = "/standardManagement/productInsert", method = RequestMethod.GET)
	public String productInsert(Users users) {

		return "/standardManagement/productInsert.jsp";
	}	
	
	//제품 리스트 조회
	@RequestMapping(value = "/standardManagement/productInsert/productList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getProductList(
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Product product = new Product();

		List<Product> productList = standardService.getProductList(product);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<productList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("prod_code", productList.get(i).getProd_code());
			rowMap.put("corp_name", productList.get(i).getCorp_name());
			rowMap.put("corp_code", productList.get(i).getCorp_code());
			rowMap.put("prod_name", productList.get(i).getProd_name());
			rowMap.put("prod_no", productList.get(i).getProd_no());
			rowMap.put("prod_gyu", productList.get(i).getProd_gyu());
			rowMap.put("prod_jai", productList.get(i).getProd_jai());
			rowMap.put("prod_fac1", productList.get(i).getProd_fac1());
			rowMap.put("prod_fac2", productList.get(i).getProd_fac2());
			rowMap.put("prod_fac3", productList.get(i).getProd_fac3());
			rowMap.put("prod_fac4", productList.get(i).getProd_fac4());
			rowMap.put("prod_fac5", productList.get(i).getProd_fac5());
			rowMap.put("prod_fac6", productList.get(i).getProd_fac6());
			rowMap.put("prod_cno", productList.get(i).getProd_cno());
			rowMap.put("prod_gubn", productList.get(i).getProd_gubn());
			rowMap.put("prod_model", productList.get(i).getProd_model());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}	 
	
	
	//제품등록, 수정 - insert,update
	@RequestMapping(value = "/standardManagement/productInsert/productInsertSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> productInsertSave(
			@ModelAttribute Product product,
			@RequestParam("mode") String mode) { 

		System.out.println("저장 컨트롤러 도착");

		Map<String, Object> result = new HashMap<>();

		System.out.println(product.getProd_code());

		try {
			if ("insert".equalsIgnoreCase(mode)) {
				standardService.productInsertSave(product);
			} else if ("update".equalsIgnoreCase(mode)) {
				standardService.productUpdateSave(product);  
			} else {
				throw new IllegalArgumentException("Invalid mode: " + mode);
			}

			result.put("status", "success");
			result.put("message", "OK");

		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
			e.printStackTrace();
		}

		System.out.println(result.get("status"));
		System.out.println(result.get("message"));

		return result;

	}

	
	//제품 삭제 - delete
	@RequestMapping(value = "/standardManagement/productInsert/productDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> productDelete(@RequestParam("prod_code") String prod_code) {
		Map<String, Object> result = new HashMap<>();

		try {
			standardService.productDelete(prod_code);
			result.put("status", "success");
			result.put("message", "삭제 완료");
		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		System.out.println(result.get("status"));
		System.out.println(result.get("message"));

		return result;
	}


	//제품 더블클릭조회
	@RequestMapping(value = "/standardManagement/productInsert/productInsertDetail", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> productInsertDetail(
			@RequestParam String prod_code) {
		System.out.println("더블클릭 로그");
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Product product = new Product();
		product.setProd_code(prod_code);
		Product prodList = standardService.productInsertDetail(product);

		rtnMap.put("data",prodList);

		return rtnMap; 
	}
	
	
	
	
	//설비등록
	@RequestMapping(value = "/standardManagement/facInsert", method = RequestMethod.GET)
	public String facInsert(Users users) {

		return "/standardManagement/facInsert.jsp";
	}	
	
	//전체 설비목록 조회
	@RequestMapping(value = "/standardManagement/facInsert/getFacList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getFacList(
			@RequestParam String fac_no,
			@RequestParam String fac_name
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Fac fac = new Fac();
		fac.setFac_no(fac_no);
		fac.setFac_name(fac_name);

		List<Fac> facList = standardService.getFacList(fac);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<facList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("fac_no", facList.get(i).getFac_no());
			rowMap.put("fac_name", facList.get(i).getFac_name());
			rowMap.put("fac_gyu", facList.get(i).getFac_gyu());
			rowMap.put("fac_hyun", facList.get(i).getFac_hyun());
			rowMap.put("fac_yong", facList.get(i).getFac_yong());
			rowMap.put("fac_plc", facList.get(i).getFac_plc());
			rowMap.put("fac_able", facList.get(i).getFac_able());
			rowMap.put("fac_make", facList.get(i).getFac_make());
			rowMap.put("fac_cbuy", facList.get(i).getFac_cbuy());
			rowMap.put("fac_code", facList.get(i).getFac_code());
			rowMap.put("fac_file_name", facList.get(i).getFac_file_name());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	//설비 더블클릭조회
	@RequestMapping(value = "/standardManagement/facInsert/facInsertDetail", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> facInsertDetail(
			@RequestParam String fac_code) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Fac fac = new Fac();
		fac.setFac_code(fac_code);

		Fac facList = standardService.facInsertDetail(fac);

		rtnMap.put("data",facList);

		return rtnMap; 
	}

	//설비 등록 and 수정
	@RequestMapping(value = "/standardManagement/facInsert/facInsertSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> facInsertSave(
			@ModelAttribute Fac fac,
			@RequestParam("mode") String mode) { 
		Map<String, Object> result = new HashMap<>();

		try {

			if ("insert".equalsIgnoreCase(mode)) {
				standardService.facInsertSave(fac);
			} else if ("update".equalsIgnoreCase(mode)) {
				standardService.facUpdateSave(fac);  
			} else {
				throw new IllegalArgumentException("Invalid mode: " + mode);
			}

			result.put("status", "success");
			result.put("message", "OK");

		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		System.out.println(result.get("status"));
		System.out.println(result.get("message"));

		return result;
	}


	//설비 삭제 - delete
	@RequestMapping(value = "/standardManagement/facInsert/facDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> facDelete(@RequestParam("fac_code") String fac_code) {
		Map<String, Object> result = new HashMap<>();

		try {
			standardService.facDelete(fac_code);
			result.put("status", "success");
			result.put("message", "삭제 완료");
		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		System.out.println(result.get("status"));
		System.out.println(result.get("message"));

		return result;
	}
	
	
	
	
	//거래처등록
	@RequestMapping(value = "/standardManagement/cutumInsert", method = RequestMethod.GET)
	public String cutumInsert(Users users) {

		return "/standardManagement/cutumInsert.jsp";
	}	
	
	
	//전체 거래처목록 조회
	@RequestMapping(value = "/standardManagement/cutumInsert/cutumInsertList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getCutumList(
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Corp corp = new Corp();


		List<Corp> corpList = standardService.getCorpList(corp);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<corpList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("corp_code", corpList.get(i).getCorp_code());
			rowMap.put("corp_name", corpList.get(i).getCorp_name());
			rowMap.put("corp_no", corpList.get(i).getCorp_no());
			rowMap.put("corp_tel", corpList.get(i).getCorp_tel());
			rowMap.put("corp_fax", corpList.get(i).getCorp_fax());
			rowMap.put("corp_boss", corpList.get(i).getCorp_boss());
			rowMap.put("corp_mast", corpList.get(i).getCorp_mast());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	
	//거래처등록 더블클릭조회
	@RequestMapping(value = "/standardManagement/cutumInsert/cutumInsertDetail", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> cutumInsertDetail(
			@RequestParam String corp_code) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Corp corp = new Corp();
		corp.setCorp_code(corp_code);

		Corp corpList = standardService.cutumInsertDetail(corp);

		rtnMap.put("data",corpList);

		return rtnMap; 
	}
	
	//거래처 등록 and 수정
	@RequestMapping(value = "/standardManagement/cutumInsert/cutumInsertSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> cutumInsertSave(
			@ModelAttribute Corp corp,
			@RequestParam("mode") String mode) { 
		Map<String, Object> result = new HashMap<>();

		try {
			if ("insert".equalsIgnoreCase(mode)) {
				standardService.cutumInsertSave(corp);
			} else if ("update".equalsIgnoreCase(mode)) {
				standardService.cutumUpdateSave(corp);  
			} else {
				throw new IllegalArgumentException("Invalid mode: " + mode);
			}

			result.put("status", "success");
			result.put("message", "OK");

		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		System.out.println(result.get("status"));
		System.out.println(result.get("message"));

		return result;
	}

	//거래처 삭제 - delete
	@RequestMapping(value = "/standardManagement/cutumInsert/cutumDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> cutumDelete(@RequestParam("corp_code") String corp_code) {
		Map<String, Object> result = new HashMap<>();

		try {
			standardService.cutumDelete(corp_code);
			result.put("status", "success");
			result.put("message", "삭제 완료");
		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		System.out.println(result.get("status"));
		System.out.println(result.get("message"));

		return result;
	}

	
	
	
	
	
	
	//침탄로작업표준
	@RequestMapping(value = "/standardManagement/standard", method = RequestMethod.GET)
	public String standard(Users users) {

		return "/standardManagement/standard.jsp";
	}	 
	
	
	//작업표준 리스트 조회
	@RequestMapping(value = "/standardManagement/standard/standardList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getStandardList(
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Standard standard = new Standard();

		List<Standard> standardList = standardService.getStandardList(standard);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<standardList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("wstd_code", standardList.get(i).getWstd_code());
			rowMap.put("fac_name", standardList.get(i).getFac_name());
			rowMap.put("fac_code", standardList.get(i).getFac_code());
			rowMap.put("pattern", standardList.get(i).getPattern());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}	 


	//작업표준 등록, 수정 - insert,update
	@RequestMapping(value = "/standardManagement/standard/standardSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> standardSave(
			@ModelAttribute Standard standard,
			@RequestParam("mode") String mode) { 

		System.out.println("저장 컨트롤러 도착");

		Map<String, Object> result = new HashMap<>();

		System.out.println(standard.getWstd_code());

		try {
			if ("insert".equalsIgnoreCase(mode)) {
				standardService.standardInsertSave(standard);
			} else if ("update".equalsIgnoreCase(mode)) {
				standardService.standardUpdateSave(standard);  
			} else {
				throw new IllegalArgumentException("Invalid mode: " + mode);
			}

			result.put("status", "success");
			result.put("message", "OK");

		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
			e.printStackTrace();
		}

		System.out.println(result.get("status"));
		System.out.println(result.get("message"));

		return result;

	}


	//제품 삭제 - delete
	@RequestMapping(value = "/standardManagement/standard/standardDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> standardDelete(@RequestParam("wstd_code") String wstd_code) {
		Map<String, Object> result = new HashMap<>();

		try {
			standardService.standardDelete(wstd_code);
			result.put("status", "success");
			result.put("message", "삭제 완료");
		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		System.out.println(result.get("status"));
		System.out.println(result.get("message"));

		return result;
	}


	//작업표준 더블클릭조회
	@RequestMapping(value = "/standardManagement/standard/standardDetail", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> standardDetail(
			@RequestParam String wstd_code) {
		System.out.println("더블클릭 로그");
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Standard standard = new Standard();
		standard.setWstd_code(wstd_code);
		Standard standardList = standardService.standardDetail(standard);

		rtnMap.put("data",standardList);

		return rtnMap; 
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//측정기기관리
	@RequestMapping(value = "/standardManagement/measurement", method = RequestMethod.GET)
	public String measurement(Users users) {

		return "/standardManagement/measurement.jsp";
	}	
	
	
	//측정기기 목록 조회
	@RequestMapping(value = "/standardManagement/measurement/measureList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getMeasureList() {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		List<Measure> measureList = standardService.getMeasureList();

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<measureList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("ter_no", measureList.get(i).getTer_no());
			rowMap.put("ter_kind", measureList.get(i).getTer_kind());
			rowMap.put("ter_name", measureList.get(i).getTer_name());
			rowMap.put("ter_code", measureList.get(i).getTer_code());
			rowMap.put("ter_end_gum", measureList.get(i).getTer_end_gum());
			rowMap.put("ter_next_gum", measureList.get(i).getTer_next_gum());
			rowMap.put("ter_gum", measureList.get(i).getTer_gum());
			rowMap.put("ter_model", measureList.get(i).getTer_model());
			rowMap.put("ter_buy", measureList.get(i).getTer_buy());
			rowMap.put("ter_bdate", measureList.get(i).getTer_bdate());
			rowMap.put("ter_bmon", measureList.get(i).getTer_bmon());
			rowMap.put("file_name", measureList.get(i).getFile_name());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}	


	//측정기기 등록 and 수정
	@RequestMapping(value = "/standardManagement/measurement/measureInsertSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> measureInsertSave(
			@ModelAttribute Measure measure,
			@RequestParam("mode") String mode) { 
		Map<String, Object> result = new HashMap<>();

		try {

			
			if ("insert".equalsIgnoreCase(mode)) {
				standardService.measureInsertSave(measure);
			} else if ("update".equalsIgnoreCase(mode)) {
				standardService.measureUpdateSave(measure);  
			} else {
				throw new IllegalArgumentException("Invalid mode: " + mode);
			}

			result.put("status", "success");
			result.put("message", "OK");

		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		System.out.println(result.get("status"));
		System.out.println(result.get("message"));

		return result;
	}



	//측정기기 삭제 - delete
	@RequestMapping(value = "/standardManagement/measurement/measureDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> measureDelete(@RequestParam("ter_code") String ter_code) {
		Map<String, Object> result = new HashMap<>();

		try {
			standardService.measureDelete(ter_code);
			result.put("status", "success");
			result.put("message", "삭제 완료");
		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", e.getMessage());
		}

		System.out.println(result.get("status"));
		System.out.println(result.get("message"));

		return result;
	}

	//측정기기관리 더블클릭조회
	@RequestMapping(value = "/standardManagement/getMeasurmentDetail", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getMeasureDetail(
			@RequestParam String ter_code) {
		System.out.println("측정기기관리 더블클릭조회");
		System.out.println("ter_code: "+ter_code);
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Measure measure = new Measure();
		measure.setTer_code(ter_code);
		System.out.println("measure.getTer_code(): "+measure.getTer_code());

		measure = standardService.getMeasurmentDetail(measure);
		System.out.println(measure);

		rtnMap.put("data",measure);

		return rtnMap; 
	}




}

