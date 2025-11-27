package com.mibogear.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mibogear.domain.StandardData;
import com.mibogear.service.StandardDataService;

@Controller
public class StandardDataController {
	
	@Autowired
	private StandardDataService standardDataService;
	
//    // 기준정보 조회
//    @RequestMapping(value= "/condition/standardData/list", method = RequestMethod.GET)
//    @ResponseBody
//    public List<StandardData> getstandardDataList(Model model, StandardData standardData) {
//    	System.out.println("getstandardDataList 컨트롤러 도착");
//    	List<StandardData> datas = standardDataService.getStandardDataList(standardData);
//    	System.out.println("machineSpare: "+datas);
//        return datas;  
//    }
	


    
}
