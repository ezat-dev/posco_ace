package com.posco.domain;

public class Work {

    private String drug_name;
	private String startDate;
    private String id;
    private String date;
    private String unit;
    private String next_month;
    private String stock_cnt;
    private String geomet_g1;
    private String geomet_g2;
    private String geomet_adding;
    private String pluse;
    private String ml_h;
    private String ml_g;
    private String k_black;
    private String naoh_99;
    private String sc_300a;
    private String sc330b_3x;
    private String sc330_liquid;
    private String geomet_sus;
    private String ed2800_a_black;
    private String ed2800_b;
    private String geomet_005;
    private String geomet_069;
    private String geomet_p_210;
    private String geomet_sq_70;
    private String created_at;
    private String status;
    private String nextMonth;
    private String filed_name;
    
    
    //설비효율 관리
    private String facility_name;
    private String a;
    private String b;
    private String c;
    private String d;
    private String weight;
    private String weight_wr;
    
    
    //작업일보
    private String r_num;
    private String start_time;
    private String end_time;
    private String tong_day;
    private String weight_day;
    private String item_nm;
    private String item_cd;
    private String next_facility;
    private String e;
    private String f;
    private String s_time;
    private String e_time;
    private String m_code;
    //작업일보 합계
    private String mach_code;
	/*
	 * private String tong_day; private String weight_day;
	 */
    private String tong_sum;
    private String weight_sum;
    private String work_time;
    private String work_percent;
    private String sum_time;
    private String sum_percent;
    private String avg_day;
    private String avg_sum;
    private String uph;
    private String uph_sum;
    
    //작업일보 인풋
    private String idx;
    private String mch_code;
    private String mch_name;
    private String gb;
    private String visc;
    private String pre_temp;
    private String heat_temp;
    private String liq_temp;
    private String sg;
    private String input_date;
    
    
    private String no;
    
    
    
    
    
    //생산모니터링
	/*
	 * public String facility_name; public String mach_code;
	 */
    public String std_weight;
    public String c_t;
    public String aa;
    public String bb;
    public String work_day;
    public String set_hr;
    public String mok_hr;
    public String capa_day;
    public String day_ton;
    public String percent_day;
    public String bujok_day;
    public String capa_month;
    public String capa_sum;
    public String cc;
    public String dd;
    public String ee;
    public String tong;
    public String tong_night;
 
    public String a1;
    public String a2;
    public String a3;
    public String a4;
    public String a5;
    public String a6;
    public String a7;
    public String a8;
    public String a9;
    public String a10;
    public String a11;
    public String a12;
    public String a13;
    
    
    
    
	public String getTong() {
		return tong;
	}
	public void setTong(String tong) {
		this.tong = tong;
	}
	public String getTong_night() {
		return tong_night;
	}
	public void setTong_night(String tong_night) {
		this.tong_night = tong_night;
	}
	public String getA1() {
		return a1;
	}
	public void setA1(String a1) {
		this.a1 = a1;
	}
	public String getA2() {
		return a2;
	}
	public void setA2(String a2) {
		this.a2 = a2;
	}
	public String getA3() {
		return a3;
	}
	public void setA3(String a3) {
		this.a3 = a3;
	}
	public String getA4() {
		return a4;
	}
	public void setA4(String a4) {
		this.a4 = a4;
	}
	public String getA5() {
		return a5;
	}
	public void setA5(String a5) {
		this.a5 = a5;
	}
	public String getA6() {
		return a6;
	}
	public void setA6(String a6) {
		this.a6 = a6;
	}
	public String getA7() {
		return a7;
	}
	public void setA7(String a7) {
		this.a7 = a7;
	}
	public String getA8() {
		return a8;
	}
	public void setA8(String a8) {
		this.a8 = a8;
	}
	public String getA9() {
		return a9;
	}
	public void setA9(String a9) {
		this.a9 = a9;
	}
	public String getA10() {
		return a10;
	}
	public void setA10(String a10) {
		this.a10 = a10;
	}
	public String getA11() {
		return a11;
	}
	public void setA11(String a11) {
		this.a11 = a11;
	}
	public String getA12() {
		return a12;
	}
	public void setA12(String a12) {
		this.a12 = a12;
	}
	public String getA13() {
		return a13;
	}
	public void setA13(String a13) {
		this.a13 = a13;
	}
	public String getStd_weight() {
		return std_weight;
	}
	public void setStd_weight(String std_weight) {
		this.std_weight = std_weight;
	}
	public String getC_t() {
		return c_t;
	}
	public void setC_t(String c_t) {
		this.c_t = c_t;
	}
	public String getAa() {
		return aa;
	}
	public void setAa(String aa) {
		this.aa = aa;
	}
	public String getBb() {
		return bb;
	}
	public void setBb(String bb) {
		this.bb = bb;
	}
	public String getWork_day() {
		return work_day;
	}
	public void setWork_day(String work_day) {
		this.work_day = work_day;
	}
	public String getSet_hr() {
		return set_hr;
	}
	public void setSet_hr(String set_hr) {
		this.set_hr = set_hr;
	}
	public String getMok_hr() {
		return mok_hr;
	}
	public void setMok_hr(String mok_hr) {
		this.mok_hr = mok_hr;
	}
	public String getCapa_day() {
		return capa_day;
	}
	public void setCapa_day(String capa_day) {
		this.capa_day = capa_day;
	}
	public String getDay_ton() {
		return day_ton;
	}
	public void setDay_ton(String day_ton) {
		this.day_ton = day_ton;
	}
	public String getPercent_day() {
		return percent_day;
	}
	public void setPercent_day(String percent_day) {
		this.percent_day = percent_day;
	}
	public String getBujok_day() {
		return bujok_day;
	}
	public void setBujok_day(String bujok_day) {
		this.bujok_day = bujok_day;
	}
	public String getCapa_month() {
		return capa_month;
	}
	public void setCapa_month(String capa_month) {
		this.capa_month = capa_month;
	}
	public String getCapa_sum() {
		return capa_sum;
	}
	public void setCapa_sum(String capa_sum) {
		this.capa_sum = capa_sum;
	}
	public String getCc() {
		return cc;
	}
	public void setCc(String cc) {
		this.cc = cc;
	}
	public String getDd() {
		return dd;
	}
	public void setDd(String dd) {
		this.dd = dd;
	}
	public String getEe() {
		return ee;
	}
	public void setEe(String ee) {
		this.ee = ee;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getR_num() {
		return r_num;
	}
	public void setR_num(String r_num) {
		this.r_num = r_num;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public String getTong_day() {
		return tong_day;
	}
	public void setTong_day(String tong_day) {
		this.tong_day = tong_day;
	}
	public String getWeight_day() {
		return weight_day;
	}
	public void setWeight_day(String weight_day) {
		this.weight_day = weight_day;
	}
	public String getItem_nm() {
		return item_nm;
	}
	public void setItem_nm(String item_nm) {
		this.item_nm = item_nm;
	}
	public String getItem_cd() {
		return item_cd;
	}
	public void setItem_cd(String item_cd) {
		this.item_cd = item_cd;
	}
	public String getNext_facility() {
		return next_facility;
	}
	public void setNext_facility(String next_facility) {
		this.next_facility = next_facility;
	}
	public String getE() {
		return e;
	}
	public void setE(String e) {
		this.e = e;
	}
	public String getF() {
		return f;
	}
	public void setF(String f) {
		this.f = f;
	}
	public String getS_time() {
		return s_time;
	}
	public void setS_time(String s_time) {
		this.s_time = s_time;
	}
	public String getE_time() {
		return e_time;
	}
	public void setE_time(String e_time) {
		this.e_time = e_time;
	}
	public String getM_code() {
		return m_code;
	}
	public void setM_code(String m_code) {
		this.m_code = m_code;
	}
	public String getMach_code() {
		return mach_code;
	}
	public void setMach_code(String mach_code) {
		this.mach_code = mach_code;
	}
	public String getTong_sum() {
		return tong_sum;
	}
	public void setTong_sum(String tong_sum) {
		this.tong_sum = tong_sum;
	}
	public String getWeight_sum() {
		return weight_sum;
	}
	public void setWeight_sum(String weight_sum) {
		this.weight_sum = weight_sum;
	}
	public String getWork_time() {
		return work_time;
	}
	public void setWork_time(String work_time) {
		this.work_time = work_time;
	}
	public String getWork_percent() {
		return work_percent;
	}
	public void setWork_percent(String work_percent) {
		this.work_percent = work_percent;
	}
	public String getSum_time() {
		return sum_time;
	}
	public void setSum_time(String sum_time) {
		this.sum_time = sum_time;
	}
	public String getSum_percent() {
		return sum_percent;
	}
	public void setSum_percent(String sum_percent) {
		this.sum_percent = sum_percent;
	}
	public String getAvg_day() {
		return avg_day;
	}
	public void setAvg_day(String avg_day) {
		this.avg_day = avg_day;
	}
	public String getAvg_sum() {
		return avg_sum;
	}
	public void setAvg_sum(String avg_sum) {
		this.avg_sum = avg_sum;
	}
	public String getUph() {
		return uph;
	}
	public void setUph(String uph) {
		this.uph = uph;
	}
	public String getUph_sum() {
		return uph_sum;
	}
	public void setUph_sum(String uph_sum) {
		this.uph_sum = uph_sum;
	}
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getMch_code() {
		return mch_code;
	}
	public void setMch_code(String mch_code) {
		this.mch_code = mch_code;
	}
	public String getMch_name() {
		return mch_name;
	}
	public void setMch_name(String mch_name) {
		this.mch_name = mch_name;
	}
	public String getGb() {
		return gb;
	}
	public void setGb(String gb) {
		this.gb = gb;
	}
	public String getVisc() {
		return visc;
	}
	public void setVisc(String visc) {
		this.visc = visc;
	}
	public String getPre_temp() {
		return pre_temp;
	}
	public void setPre_temp(String pre_temp) {
		this.pre_temp = pre_temp;
	}
	public String getHeat_temp() {
		return heat_temp;
	}
	public void setHeat_temp(String heat_temp) {
		this.heat_temp = heat_temp;
	}
	public String getLiq_temp() {
		return liq_temp;
	}
	public void setLiq_temp(String liq_temp) {
		this.liq_temp = liq_temp;
	}
	public String getSg() {
		return sg;
	}
	public void setSg(String sg) {
		this.sg = sg;
	}
	public String getInput_date() {
		return input_date;
	}
	public void setInput_date(String input_date) {
		this.input_date = input_date;
	}
	public String getFacility_name() {
		return facility_name;
	}
	public void setFacility_name(String facility_name) {
		this.facility_name = facility_name;
	}
	public String getA() {
		return a;
	}
	public void setA(String a) {
		this.a = a;
	}
	public String getB() {
		return b;
	}
	public void setB(String b) {
		this.b = b;
	}
	public String getC() {
		return c;
	}
	public void setC(String c) {
		this.c = c;
	}
	public String getD() {
		return d;
	}
	public void setD(String d) {
		this.d = d;
	}
	public String getWeight() {
		return weight;
	}
	public void setWeight(String weight) {
		this.weight = weight;
	}
	public String getWeight_wr() {
		return weight_wr;
	}
	public void setWeight_wr(String weight_wr) {
		this.weight_wr = weight_wr;
	}
	public String getFiled_name() {
		return filed_name;
	}
	public void setFiled_name(String filed_name) {
		this.filed_name = filed_name;
	}
	public String getNextMonth() {
		return nextMonth;
	}
	public void setNextMonth(String nextMonth) {
		this.nextMonth = nextMonth;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDrug_name() {
		return drug_name;
	}
	public void setDrug_name(String drug_name) {
		this.drug_name = drug_name;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getNext_month() {
		return next_month;
	}
	public void setNext_month(String next_month) {
		this.next_month = next_month;
	}
	public String getStock_cnt() {
		return stock_cnt;
	}
	public void setStock_cnt(String stock_cnt) {
		this.stock_cnt = stock_cnt;
	}
	public String getGeomet_g1() {
		return geomet_g1;
	}
	public void setGeomet_g1(String geomet_g1) {
		this.geomet_g1 = geomet_g1;
	}
	public String getGeomet_g2() {
		return geomet_g2;
	}
	public void setGeomet_g2(String geomet_g2) {
		this.geomet_g2 = geomet_g2;
	}
	public String getGeomet_adding() {
		return geomet_adding;
	}
	public void setGeomet_adding(String geomet_adding) {
		this.geomet_adding = geomet_adding;
	}
	public String getPluse() {
		return pluse;
	}
	public void setPluse(String pluse) {
		this.pluse = pluse;
	}
	public String getMl_h() {
		return ml_h;
	}
	public void setMl_h(String ml_h) {
		this.ml_h = ml_h;
	}
	public String getMl_g() {
		return ml_g;
	}
	public void setMl_g(String ml_g) {
		this.ml_g = ml_g;
	}
	public String getK_black() {
		return k_black;
	}
	public void setK_black(String k_black) {
		this.k_black = k_black;
	}
	public String getNaoh_99() {
		return naoh_99;
	}
	public void setNaoh_99(String naoh_99) {
		this.naoh_99 = naoh_99;
	}
	public String getSc_300a() {
		return sc_300a;
	}
	public void setSc_300a(String sc_300a) {
		this.sc_300a = sc_300a;
	}
	public String getSc330b_3x() {
		return sc330b_3x;
	}
	public void setSc330b_3x(String sc330b_3x) {
		this.sc330b_3x = sc330b_3x;
	}
	public String getSc330_liquid() {
		return sc330_liquid;
	}
	public void setSc330_liquid(String sc330_liquid) {
		this.sc330_liquid = sc330_liquid;
	}
	public String getGeomet_sus() {
		return geomet_sus;
	}
	public void setGeomet_sus(String geomet_sus) {
		this.geomet_sus = geomet_sus;
	}
	public String getEd2800_a_black() {
		return ed2800_a_black;
	}
	public void setEd2800_a_black(String ed2800_a_black) {
		this.ed2800_a_black = ed2800_a_black;
	}
	public String getEd2800_b() {
		return ed2800_b;
	}
	public void setEd2800_b(String ed2800_b) {
		this.ed2800_b = ed2800_b;
	}
	public String getGeomet_005() {
		return geomet_005;
	}
	public void setGeomet_005(String geomet_005) {
		this.geomet_005 = geomet_005;
	}
	public String getGeomet_069() {
		return geomet_069;
	}
	public void setGeomet_069(String geomet_069) {
		this.geomet_069 = geomet_069;
	}
	public String getGeomet_p_210() {
		return geomet_p_210;
	}
	public void setGeomet_p_210(String geomet_p_210) {
		this.geomet_p_210 = geomet_p_210;
	}
	public String getGeomet_sq_70() {
		return geomet_sq_70;
	}
	public void setGeomet_sq_70(String geomet_sq_70) {
		this.geomet_sq_70 = geomet_sq_70;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}

}
