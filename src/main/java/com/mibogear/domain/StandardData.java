package com.mibogear.domain;

public class StandardData {
	
	// 설비명
    private String equipment_name;  
    
    // 품번
    private String item_no;      
    
    // 품명
    private String item_name;     
    
    // 강종
    private String steel_grade; 
    
    // T급
    private String t_grade;  
    
    // 진합로트
    private String batch;         

    // 참고기준정보 소입온도
    private Integer ref_soak_temp;  
    
    // 참고기준정보 소려온도
    private Integer ref_cool_temp;     
    
    // 참고기준정보 CP
    private float ref_cp;       

    
    // 적용기준정보 소입온도
    private Integer apply_soak_temp; 
    
    // 적용기준정보 소려온도
    private Integer apply_cool_temp; 
    
    // 적용기준정보 CP
    private float apply_cp;   

    // 장입량1
    private Integer load1;       
    
    // 장입량2
    private Integer load2;       
    
    // 장입량3
    private Integer load3;       
    
    // 기준 장입량
    private Integer std_load;     
    
    // 요구경도
    private String hardness_req;
    
    

	public String getEquipment_name() {
		return equipment_name;
	}



	public void setEquipment_name(String equipment_name) {
		this.equipment_name = equipment_name;
	}



	public String getItem_no() {
		return item_no;
	}



	public void setItem_no(String item_no) {
		this.item_no = item_no;
	}



	public String getItem_name() {
		return item_name;
	}



	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}



	public String getSteel_grade() {
		return steel_grade;
	}



	public void setSteel_grade(String steel_grade) {
		this.steel_grade = steel_grade;
	}



	public String getT_grade() {
		return t_grade;
	}



	public void setT_grade(String t_grade) {
		this.t_grade = t_grade;
	}



	public String getBatch() {
		return batch;
	}



	public void setBatch(String batch) {
		this.batch = batch;
	}



	public Integer getRef_soak_temp() {
		return ref_soak_temp;
	}



	public void setRef_soak_temp(Integer ref_soak_temp) {
		this.ref_soak_temp = ref_soak_temp;
	}



	public Integer getRef_cool_temp() {
		return ref_cool_temp;
	}



	public void setRef_cool_temp(Integer ref_cool_temp) {
		this.ref_cool_temp = ref_cool_temp;
	}



	public float getRef_cp() {
		return ref_cp;
	}



	public void setRef_cp(float ref_cp) {
		this.ref_cp = ref_cp;
	}



	public Integer getApply_soak_temp() {
		return apply_soak_temp;
	}



	public void setApply_soak_temp(Integer apply_soak_temp) {
		this.apply_soak_temp = apply_soak_temp;
	}



	public Integer getApply_cool_temp() {
		return apply_cool_temp;
	}



	public void setApply_cool_temp(Integer apply_cool_temp) {
		this.apply_cool_temp = apply_cool_temp;
	}



	public float getApply_cp() {
		return apply_cp;
	}



	public void setApply_cp(float apply_cp) {
		this.apply_cp = apply_cp;
	}



	public Integer getLoad1() {
		return load1;
	}



	public void setLoad1(Integer load1) {
		this.load1 = load1;
	}



	public Integer getLoad2() {
		return load2;
	}



	public void setLoad2(Integer load2) {
		this.load2 = load2;
	}



	public Integer getLoad3() {
		return load3;
	}



	public void setLoad3(Integer load3) {
		this.load3 = load3;
	}



	public Integer getStd_load() {
		return std_load;
	}



	public void setStd_load(Integer std_load) {
		this.std_load = std_load;
	}



	public String getHardness_req() {
		return hardness_req;
	}



	public void setHardness_req(String hardness_req) {
		this.hardness_req = hardness_req;
	}



	@Override
	public String toString() {
		return "StandardDataController [equipment_name=" + equipment_name + ", item_no=" + item_no + ", item_name="
				+ item_name + ", steel_grade=" + steel_grade + ", t_grade=" + t_grade + ", batch=" + batch
				+ ", ref_soak_temp=" + ref_soak_temp + ", ref_cool_temp=" + ref_cool_temp + ", ref_cp=" + ref_cp
				+ ", apply_soak_temp=" + apply_soak_temp + ", apply_cool_temp=" + apply_cool_temp + ", apply_cp="
				+ apply_cp + ", load1=" + load1 + ", load2=" + load2 + ", load3=" + load3 + ", std_load=" + std_load
				+ ", hardness_req=" + hardness_req + "]";
	}

}
