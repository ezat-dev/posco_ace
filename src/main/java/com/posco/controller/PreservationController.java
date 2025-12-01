package com.posco.controller;
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

import com.posco.domain.Bega;
import com.posco.domain.Product;
import com.posco.domain.SparePart;
import com.posco.domain.Suri;
import com.posco.service.PreservationService;


@Controller
public class PreservationController {

	@Autowired
	private PreservationService preservationService;
	
	
	//SparePart관리 - 화면로드
	@RequestMapping(value = "/preservation/sparePart", method = RequestMethod.GET)
	public String sparePart() {
		return "/preservation/sparePart.jsp";
	}

	
	//SparePart 리스트 조회
	@RequestMapping(value = "/preservation/sparePart/getSparePartList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getSparePartList(
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		SparePart sparePart = new SparePart();

		List<SparePart> sparePartList = preservationService.getSparePartList(sparePart);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<sparePartList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("spp_code", sparePartList.get(i).getSpp_code());
			rowMap.put("corp_name", sparePartList.get(i).getCorp_name());
			rowMap.put("corp_code", sparePartList.get(i).getCorp_code());
			rowMap.put("spp_name", sparePartList.get(i).getSpp_name());
			rowMap.put("spp_no", sparePartList.get(i).getSpp_no());
			rowMap.put("spp_gyu", sparePartList.get(i).getSpp_gyu());
			rowMap.put("spp_yong", sparePartList.get(i).getSpp_yong());
			rowMap.put("spp_proper", sparePartList.get(i).getSpp_proper());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}	 


	//SparePart 등록, 수정 - insert,update
	@RequestMapping(value = "/preservation/sparePart/sparePartSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> sparePartSave(
			@ModelAttribute SparePart sparePart,
			@RequestParam("mode") String mode) { 

		System.out.println("저장 컨트롤러 도착");

		Map<String, Object> result = new HashMap<>();

		System.out.println(sparePart.getSpp_code());

		try {
			if ("insert".equalsIgnoreCase(mode)) {
				preservationService.sparePartInsertSave(sparePart);
			} else if ("update".equalsIgnoreCase(mode)) {
				preservationService.sparePartUpdateSave(sparePart);  
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


	//SparePart 삭제 - delete
	@RequestMapping(value = "/preservation/sparePart/sparePartDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> sparePartDelete(@RequestParam("spp_code") String spp_code) {
		Map<String, Object> result = new HashMap<>();

		try {
			preservationService.sparePartDelete(spp_code);
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


	//SparePart 더블클릭조회
	@RequestMapping(value = "/preservation/sparePart/sparePartDetail", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> sparePartDetail(
			@RequestParam String spp_code) {
		System.out.println("더블클릭 로그");
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		SparePart sparePart = new SparePart();
		sparePart.setSpp_code(spp_code);
		SparePart sparePartList = preservationService.sparePartDetail(sparePart);

		rtnMap.put("data",sparePartList);

		return rtnMap; 
	}

	
	
	
	
	
	
	
	
	//설비비가동등록 - 화면로드
	@RequestMapping(value = "/preservation/begaInsert", method = RequestMethod.GET)
	public String begaInsert() {
		return "/preservation/begaInsert.jsp";
	}

	//설비비가동등록 조회
	@RequestMapping(value = "/preservation/begaInsert/getBegaInsertList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getBegaInsertList(
			@RequestParam String sdate,
			@RequestParam String edate
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Bega bega = new Bega();

		bega.setSdate(sdate);
		bega.setEdate(edate);

		List<Bega> begaInsertList = preservationService.getBegaInsertList(bega);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<begaInsertList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("fstp_date", begaInsertList.get(i).getFstp_date());
			rowMap.put("fac_name", begaInsertList.get(i).getFac_name());
			rowMap.put("fstp_plan", begaInsertList.get(i).getFstp_plan());
			rowMap.put("fstp_tu", begaInsertList.get(i).getFstp_tu());
			rowMap.put("fstp_stby", begaInsertList.get(i).getFstp_stby());
			rowMap.put("fstp_01", begaInsertList.get(i).getFstp_01());
			rowMap.put("fstp_02", begaInsertList.get(i).getFstp_02());
			rowMap.put("fstp_03", begaInsertList.get(i).getFstp_03());
			rowMap.put("fstp_04", begaInsertList.get(i).getFstp_04());
			rowMap.put("fstp_05", begaInsertList.get(i).getFstp_05());
			rowMap.put("fstp_06", begaInsertList.get(i).getFstp_06());
			rowMap.put("fstp_07", begaInsertList.get(i).getFstp_07());
			rowMap.put("fstp_08", begaInsertList.get(i).getFstp_08());
			rowMap.put("fstp_09", begaInsertList.get(i).getFstp_09());
			rowMap.put("fstp_10", begaInsertList.get(i).getFstp_10());
			rowMap.put("fstp_bigo", begaInsertList.get(i).getFstp_bigo());
			rowMap.put("fac_code", begaInsertList.get(i).getFac_code());
			rowMap.put("fstp_code", begaInsertList.get(i).getFstp_code());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("rtnData",begaInsertList);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	//비가동등록 더블클릭조회
	@RequestMapping(value = "/preservation/begaInsert/begaInsertDetail", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> begaInsertDetail(
			@RequestParam String fstp_code) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Bega bega = new Bega();
		bega.setFstp_code(fstp_code);
		Bega begaList = preservationService.begaInsertDetail(bega);

		rtnMap.put("data",begaList);

		return rtnMap; 
	}

	//설비 비가동등록 - insert,update
	@RequestMapping(value = "/preservation/begaInsert/begaInsertSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> begaInsertSave(
			@ModelAttribute Bega bega,
			@RequestParam("mode") String mode) { 

		System.out.println("mode = " + mode);
		System.out.println("fstp_code = " + bega.getFstp_code());
		System.out.println("fac_code = " + bega.getFac_code());
		Map<String, Object> result = new HashMap<>();

		try {
			if ("insert".equalsIgnoreCase(mode)) {
				preservationService.begaInsertSave(bega);
			} else if ("update".equalsIgnoreCase(mode)) {
				preservationService.begaUpdateSave(bega);  
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

	//설비비가동등록 삭제 - delete
	@RequestMapping(value = "/preservation/begaInsert/begaDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> begaDelete(@RequestParam("fstp_code") String fstp_code) {
		Map<String, Object> result = new HashMap<>();

		try {
			preservationService.begaDelete(fstp_code);
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
	
	
	
	
	
	//설비수리이력관리 - 화면로드
	@RequestMapping(value = "/preservation/suriHistory", method = RequestMethod.GET)
	public String suriHistory() {
		return "/preservation/suriHistory.jsp";
	}
	
	//설비수리이력관리 조회
	@RequestMapping(value = "/preservation/suriHistory/getSuriHistoryList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getSuriHistoryList(
			@RequestParam String sdate,
			@RequestParam String edate
			) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Suri suri = new Suri();

		suri.setSdate(sdate);
		suri.setEdate(edate);


		List<Suri> suriHistoryList = preservationService.getSuriHistoryList(suri);

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<suriHistoryList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("fac_no", suriHistoryList.get(i).getFac_no());
			rowMap.put("fac_code", suriHistoryList.get(i).getFac_code());
			rowMap.put("fac_name", suriHistoryList.get(i).getFac_name());
			rowMap.put("ffx_date", suriHistoryList.get(i).getFfx_date());
			rowMap.put("ffx_wrk", suriHistoryList.get(i).getFfx_wrk());
			rowMap.put("ffx_cost", suriHistoryList.get(i).getFfx_cost());
			rowMap.put("ffx_note", suriHistoryList.get(i).getFfx_note());
			rowMap.put("ffx_no", suriHistoryList.get(i).getFfx_no());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	//설비 수리이력 더블클릭조회
	@RequestMapping(value = "/preservation/suriHistory/suriHistoryDetail", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> suriHistoryDetail(
			@RequestParam String ffx_no) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Suri suri = new Suri();
		suri.setFfx_no(ffx_no);
		Suri SuriList = preservationService.suriHistoryDetail(suri);

		rtnMap.put("data",SuriList);

		return rtnMap; 
	}

	//설비 수리이력 - insert, update
	@RequestMapping(value = "/preservation/suriHistory/suriHistorySave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> suriHistorySave(
			@ModelAttribute Suri suri,
			@RequestParam("mode") String mode) { 

		System.out.println("mode = " + mode);
		System.out.println("Ffx_note = " + suri.getFfx_note());
		System.out.println("Ffx_no = " + suri.getFfx_no());
		Map<String, Object> result = new HashMap<>();

		try {

			if ("insert".equalsIgnoreCase(mode)) {
				preservationService.suriHistoryInsertSave(suri);
			} else if ("update".equalsIgnoreCase(mode)) {
				preservationService.suriHistoryUpdateSave(suri);  
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


	//설비 수리이력 삭제 - delete
	@RequestMapping(value = "/preservation/suriHistory/suriHistoryDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> suriHistoryDelete(@RequestParam("ffx_no") String ffx_no) {
		Map<String, Object> result = new HashMap<>();

		try {
			preservationService.suriHistoryDelete(ffx_no);
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

}

