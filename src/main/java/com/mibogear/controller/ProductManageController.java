package com.mibogear.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mibogear.domain.DroppedGoods;
import com.mibogear.service.ProductManageService;


@Controller
public class ProductManageController {
	
	@Autowired
	private ProductManageService productManageService; 
	
	
	
	//낙하품관리 로드
    @RequestMapping(value= "/productionManagement/droppedGoods", method = RequestMethod.GET)
    public String droppedGoods(Model model) {
        return "/productionManagement/droppedGoods.jsp";  
    }
    
    
  //낙하품관리 조회
    @RequestMapping(value = "/productionManagement/droppedGoods/getDroppedGoodsList", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getDroppedGoodsList() {

        Map<String, Object> rtnMap = new HashMap<>();

        
        List<DroppedGoods> droppedGoodsList = productManageService.getDroppedGoodsList();

        List<Map<String, Object>> rtnList = new ArrayList<>();
        for (int i = 0; i < droppedGoodsList.size(); i++) {
        	DroppedGoods dg = droppedGoodsList.get(i);

            Map<String, Object> row = new HashMap<>();
            row.put("d_lot", dg.getD_lot());
            row.put("w_pnum", dg.getW_pnum());
            row.put("item_name", dg.getItem_name());
            row.put("w_sdatetime", dg.getW_sdatetime());
            row.put("w_in_edatetime", dg.getW_in_edatetime());
            row.put("w_edatetime", dg.getW_edatetime());
            row.put("d_in", dg.getD_in());
            row.put("d_qf", dg.getD_qf());
            row.put("d_tf",dg.getD_tf());
            row.put("d_out",dg.getD_out());
            row.put("d_bigo",dg.getD_bigo());

            rtnList.add(row);
        }

        rtnMap.put("last_page", 1); 
        rtnMap.put("data", rtnList);

        return rtnMap;
    }
    
    
    @RequestMapping(value = "/productionManagement/droppedGoods/updateDroppedGoods", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateDroppedGoods(@RequestBody Map<String, Object> param) {
        Map<String, Object> result = new HashMap<>();
        try {
            productManageService.updateDroppedGoods(param); 
            result.put("result", "success");
        } catch (Exception e) {
            result.put("result", "fail");
            result.put("message", e.getMessage());
            e.printStackTrace();
        }
        return result;
    }
    
    
    
    
  //생산모니터링현황 로드
    @RequestMapping(value= "/productionManagement/integrationProduction", method = RequestMethod.GET)
    public String integrationProduction(Model model) {
        return "/productionManagement/integrationProduction.jsp";  
    }
    
    
    
  //생산모니터링현황 로드
    @RequestMapping(value= "/productionManagement/lotReport", method = RequestMethod.GET)
    public String lotReport(Model model) {
        return "/productionManagement/lotReport.jsp";  
    } 

}
