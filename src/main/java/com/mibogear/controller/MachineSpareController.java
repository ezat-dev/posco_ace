package com.mibogear.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mibogear.domain.MachineSpare;
import com.mibogear.service.ExcelService;
import com.mibogear.service.MachineSpareService;


@Controller
public class MachineSpareController {

	 @Autowired
	 private MachineSpareService machineSpareService; 
	 
	 @Autowired
	 private ExcelService excelService;

    
	 @RequestMapping(value= "/machine/spareStatus", method = RequestMethod.GET)
	    public String spareStatus(Model model) {
	        return "/machine/spareStatus.jsp"; 
	    }
	 
	 
	 
	 
    //스페어 전체조회
    @RequestMapping(value= "/machine/spareStatus/list", method = RequestMethod.GET)
    @ResponseBody
    public List<MachineSpare> getMachineSpareList(Model model, MachineSpare machineSpare) {
    	System.out.println("getMachineSpareList 컨트롤러 도착");
    	List<MachineSpare> datas = machineSpareService.getMachineSpareList(machineSpare);
    	System.out.println("machineSpare: "+datas);
        return datas;  
    }
    
    //스페어 생성, 수정
    @RequestMapping(value= "/machine/spareStatus/insert", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> insertMachineSpare(Model model, MachineSpare machineSpare) {
    	Map<String, Object> result = new HashMap<>();
    	System.out.println("insertMachineSpare 컨트롤러 도착");
    	boolean flag;
    	if(machineSpare.getNo() == null || machineSpare.getNo() == 0) {
    	flag = machineSpareService.insertMachineSpare(machineSpare);
    	}
    	else {
    		flag = machineSpareService.updateMachineSpare(machineSpare);
    	}
    	result.put("result", flag);
    	return result;
    }
    
    //스페어 삭제
    @RequestMapping(value= "/machine/spareStatus/delete", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteMachineSpare(Model model, @RequestBody MachineSpare machineSpare) {
    	Map<String, Object> result = new HashMap<>();
    	System.out.println("deleteMachineSpare 컨트롤러 도착");
    	System.out.println("machineSpare: "+machineSpare);
    	boolean flag = machineSpareService.deleteMachineSpare(machineSpare);
    	result.put("result", flag);
    	return result;
    }
    
    //스페어 엑셀파일 업로드(수정, 생성)
    @RequestMapping(value= "/machine/spare/uploadFile", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> uploadExcel(@RequestParam("file") MultipartFile file) {
    	System.out.println("uploadExcel 컨트롤러 도착");
        Map<String, Object> result = new HashMap<>();

        try {
        	//엑셀 행 도메인에 넣기
            List<MachineSpare> spareList = excelService.parseSpareExcelFile(file);
            System.out.println("spareList: "+spareList);

            boolean flag = false;
            //DB 업데이트 
            for(MachineSpare v : spareList){
            	//스페어 번호 0이면 새로 생성
            	if(v.getNo() == null || v.getNo() == 0) {
            		flag = machineSpareService.insertMachineSpare(v);
            	}
            	//아니면 수정
            	else {
            		flag = machineSpareService.updateMachineSpare(v);
            	}
            }
            //machineSpareService.updateOrInsert(spareList);

            result.put("result", flag);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("error", e.getMessage());
        }

        return result;
    }
    
    
/*    @RequestMapping(value = "/machine/spareStatus/list", method = RequestMethod.POST)
    @ResponseBody
    public List<Machine> getspareStatusList(Machine machine) {
       
        return machineService.getspareStatusList(machine);
    }

    @RequestMapping(value = "/machine/spareStatus/insert", method = RequestMethod.POST)
    @ResponseBody
    public String insertspareStatus(@ModelAttribute Machine machine) {


        machineService.insertspareStatus(machine); 

        return "success";
    }
    @RequestMapping(value = "/machine/spareStatus/delete", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> delspareStatus(@RequestBody Machine machine) {
        Map<String, Object> rtnMap = new HashMap<>();
        System.out.println("삭제 요청 받은 데이터: " + machine);

        if (machine.getNo() == null) {
            rtnMap.put("data", "행 선택하세요");
            return rtnMap;
        }

        machineService.delspareStatus(machine);

        rtnMap.put("data", "success");
        return rtnMap;
    }*/
    
    
   
    
}