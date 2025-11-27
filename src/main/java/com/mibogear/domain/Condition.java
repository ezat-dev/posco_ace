package com.mibogear.domain;

public class Condition {
	
	    private Integer idx;
	    private String cr_date;
	   // private String mch_name;
	    private String box1;
	    private String box2;
	    private String box3;
	    private String box4;
	    private String memo;
	
	 	private String plating_no;      // 도금품번 (기준값)
	    private String material_no;     // 자재품번
	    private String pum_name;        // 품명
	    private String surface_spec;    // 표면처리사양
	    private String max_weight;      // 최대중량
	    private String min_weight;      // 최소중량
	    private String avg_weight;      // 평균중량
	    private String equip_1;         // 설비명1
	    private String load_1;          // 장입기준1
	
	    private String equip_2;         // 설비명2
	    private String load_2;          // 장입기준2
	    private String split_cnt;       // 분할횟수
	    private String avg_load;        // 평균 장입량
	    private String g800;           // G-800(kg)
	    private String g600;           // G600(kg)
	    private String common_equip;    // 공용설비(kg)
	    private String k_black;         // K-BLACK(kg)
	    
	    //TC조절
	    private String tdatetime; 
	    private String equipment_name;
	    private String location;
	    private String serial_number;
	    private String replacement_date;
	    private String next_date;
	    private String replacement_cycle;
	    private String remarks;
	    private String startDate;
	    private String endDate;
	    private String no;
	    private String equipmentName;
	    
	    private Integer id;

	    private String date;
	    private String mch_code;
	    private String mch_nname;
	    private String tank_temp;
	    private String visocosity;
	    private String specific_gravity;
	    private String chiller_temp;
	    private String filed;
	    private String title;
	    private String value;
	    private String field;

	    
	    
	   
	    private String in_date;

	    private String m68_mixer_no;
	    private String m68_g1_temp;
	    private String m68_g2_temp;
	    private String m68_g1_lot_no;
	    private String m68_g2_lot_no;
	    private String m68_thickener_time;
	    private String m68_thickener_g;
	    private String m68_thickener_lot;
	    private String m68_post_rpm;
	    private String m68_mixing_start_time;
	    private String m68_mixing_time;
	    private String m68_checker;
	    private String m68_mch_temp;
	    private String m68_humidity;
	    private String m68_viscosity;
	    private String m68_out_time;

	    private String kmp_humidity;
	    private String kmp_mixing_temp;
	    private String kmp_mch_temp;
	    private String kmp_liquid_lot_no;
	    private String kmp_mixing_start_time;
	    private String kmp_mixing_time;
	    private String kmp_mch_visc;
	    private String kmp_out_time;
	    private String kmp_checker;
	    private String mch_name;

	    
	    
	    private String coating_nm;
	    private String tank_no;
	    private String ck_time;
	    private String liquid_lot_no;
	    private String liquid_in;
	    private String distilles_in;
	    private String liquid_viscosity;

	    private String viscosity_after;
	    private String ck_time2;
	    private String operator;
	    
	    
	    private String plac_cd;
	    private String plnt_cd;
	    private String group_id;
	    private String item_cd;
	    private String item_nm;
	    private String mach_main;
	    private String mach_main_weight;
	    private String mach_sub;
	    private String mach_sub_weight;
	    private String kblack_weight;
	    private String mlpl_weight;
	    
	    
	    
	    // 품번, PK
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
	    


		@Override
		public String toString() {
			return "Condition [equipment_name=" + equipment_name + ", item_no=" + item_no + ", item_name=" + item_name
					+ ", steel_grade=" + steel_grade + ", t_grade=" + t_grade + ", batch=" + batch + ", ref_soak_temp="
					+ ref_soak_temp + ", ref_cool_temp=" + ref_cool_temp + ", ref_cp=" + ref_cp + ", apply_soak_temp="
					+ apply_soak_temp + ", apply_cool_temp=" + apply_cool_temp + ", apply_cp=" + apply_cp + ", load1="
					+ load1 + ", load2=" + load2 + ", load3=" + load3 + ", std_load=" + std_load + ", hardness_req="
					+ hardness_req + "]";
		}
		
		
		public Integer getIdx() {
		    return idx;
		}
		public void setIdx(Integer idx) {
		    this.idx = idx;
		}
		public String getCr_date() {
		    return cr_date;
		}
		public void setCr_date(String cr_date) {
		    this.cr_date = cr_date;
		}
		public String getBox1() {
		    return box1;
		}
		public void setBox1(String box1) {
		    this.box1 = box1;
		}
		public String getBox2() {
		    return box2;
		}
		public void setBox2(String box2) {
		    this.box2 = box2;
		}
		public String getBox3() {
		    return box3;
		}
		public void setBox3(String box3) {
		    this.box3 = box3;
		}
		public String getBox4() {
		    return box4;
		}
		public void setBox4(String box4) {
		    this.box4 = box4;
		}
		public String getMemo() {
		    return memo;
		}
		public void setMemo(String memo) {
		    this.memo = memo;
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
		public String getCoating_nm() {
			return coating_nm;
		}
		public void setCoating_nm(String coating_nm) {
			this.coating_nm = coating_nm;
		}
		public String getTank_no() {
			return tank_no;
		}
		public void setTank_no(String tank_no) {
			this.tank_no = tank_no;
		}
		public String getCk_time() {
			return ck_time;
		}
		public void setCk_time(String ck_time) {
			this.ck_time = ck_time;
		}
		public String getLiquid_lot_no() {
			return liquid_lot_no;
		}
		public void setLiquid_lot_no(String liquid_lot_no) {
			this.liquid_lot_no = liquid_lot_no;
		}
		public String getLiquid_in() {
			return liquid_in;
		}
		public void setLiquid_in(String liquid_in) {
			this.liquid_in = liquid_in;
		}
		public String getDistilles_in() {
			return distilles_in;
		}
		public void setDistilles_in(String distilles_in) {
			this.distilles_in = distilles_in;
		}
		public String getLiquid_viscosity() {
			return liquid_viscosity;
		}
		public void setLiquid_viscosity(String liquid_viscosity) {
			this.liquid_viscosity = liquid_viscosity;
		}
		public String getViscosity_after() {
			return viscosity_after;
		}
		public void setViscosity_after(String viscosity_after) {
			this.viscosity_after = viscosity_after;
		}
		public String getCk_time2() {
			return ck_time2;
		}
		public void setCk_time2(String ck_time2) {
			this.ck_time2 = ck_time2;
		}
		public String getOperator() {
			return operator;
		}
		public void setOperator(String operator) {
			this.operator = operator;
		}
		public String getIn_date() {
			return in_date;
		}
		public void setIn_date(String in_date) {
			this.in_date = in_date;
		}
		public String getM68_mixer_no() {
			return m68_mixer_no;
		}
		public void setM68_mixer_no(String m68_mixer_no) {
			this.m68_mixer_no = m68_mixer_no;
		}
		public String getM68_g1_temp() {
			return m68_g1_temp;
		}
		
		public String getMch_name() {
			return mch_name;
		}
		public void setMch_name(String mch_name) {
			this.mch_name = mch_name;
		}
		public void setM68_g1_temp(String m68_g1_temp) {
			this.m68_g1_temp = m68_g1_temp;
		}
		public String getM68_g2_temp() {
			return m68_g2_temp;
		}
		public void setM68_g2_temp(String m68_g2_temp) {
			this.m68_g2_temp = m68_g2_temp;
		}
		public String getM68_g1_lot_no() {
			return m68_g1_lot_no;
		}
		public void setM68_g1_lot_no(String m68_g1_lot_no) {
			this.m68_g1_lot_no = m68_g1_lot_no;
		}
		public String getM68_g2_lot_no() {
			return m68_g2_lot_no;
		}
		public void setM68_g2_lot_no(String m68_g2_lot_no) {
			this.m68_g2_lot_no = m68_g2_lot_no;
		}
		public String getM68_thickener_time() {
			return m68_thickener_time;
		}
		public void setM68_thickener_time(String m68_thickener_time) {
			this.m68_thickener_time = m68_thickener_time;
		}
		public String getM68_thickener_g() {
			return m68_thickener_g;
		}
		public void setM68_thickener_g(String m68_thickener_g) {
			this.m68_thickener_g = m68_thickener_g;
		}
		public String getM68_thickener_lot() {
			return m68_thickener_lot;
		}
		public void setM68_thickener_lot(String m68_thickener_lot) {
			this.m68_thickener_lot = m68_thickener_lot;
		}
		public String getM68_post_rpm() {
			return m68_post_rpm;
		}
		public void setM68_post_rpm(String m68_post_rpm) {
			this.m68_post_rpm = m68_post_rpm;
		}
		public String getM68_mixing_start_time() {
			return m68_mixing_start_time;
		}
		public void setM68_mixing_start_time(String m68_mixing_start_time) {
			this.m68_mixing_start_time = m68_mixing_start_time;
		}
		public String getM68_mixing_time() {
			return m68_mixing_time;
		}
		public void setM68_mixing_time(String m68_mixing_time) {
			this.m68_mixing_time = m68_mixing_time;
		}
		public String getM68_checker() {
			return m68_checker;
		}
		public void setM68_checker(String m68_checker) {
			this.m68_checker = m68_checker;
		}
		public String getM68_mch_temp() {
			return m68_mch_temp;
		}
		public void setM68_mch_temp(String m68_mch_temp) {
			this.m68_mch_temp = m68_mch_temp;
		}
		public String getM68_humidity() {
			return m68_humidity;
		}
		public void setM68_humidity(String m68_humidity) {
			this.m68_humidity = m68_humidity;
		}
		public String getM68_viscosity() {
			return m68_viscosity;
		}
		public void setM68_viscosity(String m68_viscosity) {
			this.m68_viscosity = m68_viscosity;
		}
		public String getM68_out_time() {
			return m68_out_time;
		}
		public void setM68_out_time(String m68_out_time) {
			this.m68_out_time = m68_out_time;
		}
		public String getKmp_humidity() {
			return kmp_humidity;
		}
		public void setKmp_humidity(String kmp_humidity) {
			this.kmp_humidity = kmp_humidity;
		}
		public String getKmp_mixing_temp() {
			return kmp_mixing_temp;
		}
		public void setKmp_mixing_temp(String kmp_mixing_temp) {
			this.kmp_mixing_temp = kmp_mixing_temp;
		}
		public String getKmp_mch_temp() {
			return kmp_mch_temp;
		}
		public void setKmp_mch_temp(String kmp_mch_temp) {
			this.kmp_mch_temp = kmp_mch_temp;
		}
		public String getKmp_liquid_lot_no() {
			return kmp_liquid_lot_no;
		}
		public void setKmp_liquid_lot_no(String kmp_liquid_lot_no) {
			this.kmp_liquid_lot_no = kmp_liquid_lot_no;
		}
		public String getKmp_mixing_start_time() {
			return kmp_mixing_start_time;
		}
		public void setKmp_mixing_start_time(String kmp_mixing_start_time) {
			this.kmp_mixing_start_time = kmp_mixing_start_time;
		}
		public String getKmp_mixing_time() {
			return kmp_mixing_time;
		}
		public void setKmp_mixing_time(String kmp_mixing_time) {
			this.kmp_mixing_time = kmp_mixing_time;
		}
		public String getKmp_mch_visc() {
			return kmp_mch_visc;
		}
		public void setKmp_mch_visc(String kmp_mch_visc) {
			this.kmp_mch_visc = kmp_mch_visc;
		}
		public String getKmp_out_time() {
			return kmp_out_time;
		}
		public void setKmp_out_time(String kmp_out_time) {
			this.kmp_out_time = kmp_out_time;
		}
		public String getKmp_checker() {
			return kmp_checker;
		}
		public void setKmp_checker(String kmp_checker) {
			this.kmp_checker = kmp_checker;
		}
		public String getField() {
			return field;
		}
		public void setField(String field) {
			this.field = field;
		}
		public String getFiled() {
			return filed;
		}
		public void setFiled(String filed) {
			this.filed = filed;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public String getValue() {
			return value;
		}
		public void setValue(String value) {
			this.value = value;
		}
		public String getMch_nname() {
			return mch_nname;
		}
		public void setMch_nname(String mch_nname) {
			this.mch_nname = mch_nname;
		}

		public Integer getId() {
			return id;
		}
		public void setId(Integer id) {
			this.id = id;
		}
		public String getDate() {
			return date;
		}
		public void setDate(String date) {
			this.date = date;
		}
		public String getMch_code() {
			return mch_code;
		}
		public void setMch_code(String mch_code) {
			this.mch_code = mch_code;
		}
		public String getTank_temp() {
			return tank_temp;
		}
		public void setTank_temp(String tank_temp) {
			this.tank_temp = tank_temp;
		}
		public String getVisocosity() {
			return visocosity;
		}
		public void setVisocosity(String visocosity) {
			this.visocosity = visocosity;
		}
		public String getSpecific_gravity() {
			return specific_gravity;
		}
		public void setSpecific_gravity(String specific_gravity) {
			this.specific_gravity = specific_gravity;
		}
		public String getChiller_temp() {
			return chiller_temp;
		}
		public void setChiller_temp(String chiller_temp) {
			this.chiller_temp = chiller_temp;
		}
		public String getEquipmentName() {
			return equipmentName;
		}
		public void setEquipmentName(String equipmentName) {
			this.equipmentName = equipmentName;
		}
		public String getNo() {
			return no;
		}
		public void setNo(String no) {
			this.no = no;
		}
		public String getStartDate() {
			return startDate;
		}
		public void setStartDate(String startDate) {
			this.startDate = startDate;
		}
		public String getEndDate() {
			return endDate;
		}
		public void setEndDate(String endDate) {
			this.endDate = endDate;
		}
		public String getTdatetime() {
			return tdatetime;
		}
		public void setTdatetime(String tdatetime) {
			this.tdatetime = tdatetime;
		}
		public String getEquipment_name() {
			return equipment_name;
		}
		public void setEquipment_name(String equipment_name) {
			this.equipment_name = equipment_name;
		}
		public String getLocation() {
			return location;
		}
		public void setLocation(String location) {
			this.location = location;
		}
		public String getSerial_number() {
			return serial_number;
		}
		public void setSerial_number(String serial_number) {
			this.serial_number = serial_number;
		}
		public String getReplacement_date() {
			return replacement_date;
		}
		public void setReplacement_date(String replacement_date) {
			this.replacement_date = replacement_date;
		}
		public String getNext_date() {
			return next_date;
		}
		public void setNext_date(String next_date) {
			this.next_date = next_date;
		}
		public String getReplacement_cycle() {
			return replacement_cycle;
		}
		public void setReplacement_cycle(String replacement_cycle) {
			this.replacement_cycle = replacement_cycle;
		}
		public String getRemarks() {
			return remarks;
		}
		public void setRemarks(String remarks) {
			this.remarks = remarks;
		}
		public String getPlating_no() {
			return plating_no;
		}
		public void setPlating_no(String plating_no) {
			this.plating_no = plating_no;
		}
		public String getMaterial_no() {
			return material_no;
		}
		public void setMaterial_no(String material_no) {
			this.material_no = material_no;
		}
		public String getPum_name() {
			return pum_name;
		}
		public void setPum_name(String pum_name) {
			this.pum_name = pum_name;
		}
		public String getSurface_spec() {
			return surface_spec;
		}
		public void setSurface_spec(String surface_spec) {
			this.surface_spec = surface_spec;
		}
		public String getMax_weight() {
			return max_weight;
		}
		public void setMax_weight(String max_weight) {
			this.max_weight = max_weight;
		}
		public String getMin_weight() {
			return min_weight;
		}
		public void setMin_weight(String min_weight) {
			this.min_weight = min_weight;
		}
		public String getAvg_weight() {
			return avg_weight;
		}
		public void setAvg_weight(String avg_weight) {
			this.avg_weight = avg_weight;
		}
		public String getEquip_1() {
			return equip_1;
		}
		public void setEquip_1(String equip_1) {
			this.equip_1 = equip_1;
		}
		public String getLoad_1() {
			return load_1;
		}
		public void setLoad_1(String load_1) {
			this.load_1 = load_1;
		}
		public String getEquip_2() {
			return equip_2;
		}
		public void setEquip_2(String equip_2) {
			this.equip_2 = equip_2;
		}
		public String getLoad_2() {
			return load_2;
		}
		public void setLoad_2(String load_2) {
			this.load_2 = load_2;
		}
		public String getSplit_cnt() {
			return split_cnt;
		}
		public void setSplit_cnt(String split_cnt) {
			this.split_cnt = split_cnt;
		}
		public String getAvg_load() {
			return avg_load;
		}
		public void setAvg_load(String avg_load) {
			this.avg_load = avg_load;
		}
		public String getG800() {
			return g800;
		}
		public void setG800(String g800) {
			this.g800 = g800;
		}
		public String getG600() {
			return g600;
		}
		public void setG600(String g600) {
			this.g600 = g600;
		}
		public String getCommon_equip() {
			return common_equip;
		}
		public void setCommon_equip(String common_equip) {
			this.common_equip = common_equip;
		}
		public String getK_black() {
			return k_black;
		}
		public void setK_black(String k_black) {
			this.k_black = k_black;
		}
		public String getPlac_cd() {
			return plac_cd;
		}
		public void setPlac_cd(String plac_cd) {
			this.plac_cd = plac_cd;
		}
		public String getPlnt_cd() {
			return plnt_cd;
		}
		public void setPlnt_cd(String plnt_cd) {
			this.plnt_cd = plnt_cd;
		}
		public String getGroup_id() {
			return group_id;
		}
		public void setGroup_id(String group_id) {
			this.group_id = group_id;
		}
		public String getItem_cd() {
			return item_cd;
		}
		public void setItem_cd(String item_cd) {
			this.item_cd = item_cd;
		}
		public String getItem_nm() {
			return item_nm;
		}
		public void setItem_nm(String item_nm) {
			this.item_nm = item_nm;
		}
		public String getMach_main() {
			return mach_main;
		}
		public void setMach_main(String mach_main) {
			this.mach_main = mach_main;
		}
		public String getMach_main_weight() {
			return mach_main_weight;
		}
		public void setMach_main_weight(String mach_main_weight) {
			this.mach_main_weight = mach_main_weight;
		}
		public String getMach_sub() {
			return mach_sub;
		}
		public void setMach_sub(String mach_sub) {
			this.mach_sub = mach_sub;
		}
		public String getMach_sub_weight() {
			return mach_sub_weight;
		}
		public void setMach_sub_weight(String mach_sub_weight) {
			this.mach_sub_weight = mach_sub_weight;
		}
		public String getKblack_weight() {
			return kblack_weight;
		}
		public void setKblack_weight(String kblack_weight) {
			this.kblack_weight = kblack_weight;
		}
		public String getMlpl_weight() {
			return mlpl_weight;
		}
		public void setMlpl_weight(String mlpl_weight) {
			this.mlpl_weight = mlpl_weight;
		}
	}
