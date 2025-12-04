package com.posco.domain;

public class Monitoring {
	
	
	private String hogi;
    private String cutum;
    private String pum;
    private String lot;
    private String heat;
    private String bon;
    private String gangon;
    private String cool;
    private String gonglo;
    private String gong;
    private String gb;
    
    private String startDate;
    private String endDate;
    private String tdatetime;
    
    
    
    private Integer vac1_pv;
    private Integer vac2_pv;
    private Integer vac3_pv;
    private Integer protec_pv;
    private Integer tem_sp;
    private Integer tem_1;
    private Integer tem_2;
    private Integer tem_3;
    private Integer tem_4;
    private Integer tem_5;
    private Integer tem_6;
    private Integer tem_7;
    private Integer tem_8;
    private Integer tem_9;
    private Integer tem_10;
    private Integer tem_11;
    private Integer tem_12;
    
    private String tagname;
	private String alarmdesc;
	private String alarmnmae;
	private String start_time;
	private String end_time;
	
	//알람이력
	private String a_stime;			//알람 발생시간
	private String a_etime;			//알람 해제시간
	private String a_hogi;			//알람 호기
	private String a_addr;			//알람 주소
	private String a_desc;			//알람 코멘트
	private int a_value;			//알람 현재 값
	private int a_cnt;				//알람 발생 수
	private String a_sdate;			//알람 조회시작일자
	private String a_edate;			//알람 조회종료일자
	private String s_sdate;
    private String s_edate;
	 private String s_date;
	    private String e_date;
	    private String cnt;
    
	public String getHogi() {
		return hogi;
	}
	public void setHogi(String hogi) {
		this.hogi = hogi;
	}
	public String getCutum() {
		return cutum;
	}
	public void setCutum(String cutum) {
		this.cutum = cutum;
	}
	public String getPum() {
		return pum;
	}
	public void setPum(String pum) {
		this.pum = pum;
	}
	public String getHeat() {
		return heat;
	}
	public void setHeat(String heat) {
		this.heat = heat;
	}
	public String getLot() {
		return lot;
	}
	public void setLot(String lot) {
		this.lot = lot;
	}
	public String getBon() {
		return bon;
	}
	public void setBon(String bon) {
		this.bon = bon;
	}
	public String getGangon() {
		return gangon;
	}
	public void setGangon(String gangon) {
		this.gangon = gangon;
	}
	public String getCool() {
		return cool;
	}
	public void setCool(String cool) {
		this.cool = cool;
	}
	public String getGonglo() {
		return gonglo;
	}
	public void setGonglo(String gonglo) {
		this.gonglo = gonglo;
	}
	public String getGong() {
		return gong;
	}
	public void setGong(String gong) {
		this.gong = gong;
	}
	public String getGb() {
		return gb;
	}
	public void setGb(String gb) {
		this.gb = gb;
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
	public Integer getTem_1() {
		return tem_1;
	}
	public void setTem_1(Integer tem_1) {
		this.tem_1 = tem_1;
	}
	public Integer getTem_2() {
		return tem_2;
	}
	public void setTem_2(Integer tem_2) {
		this.tem_2 = tem_2;
	}
	public Integer getTem_3() {
		return tem_3;
	}
	public void setTem_3(Integer tem_3) {
		this.tem_3 = tem_3;
	}
	public Integer getTem_4() {
		return tem_4;
	}
	public void setTem_4(Integer tem_4) {
		this.tem_4 = tem_4;
	}
	public Integer getTem_5() {
		return tem_5;
	}
	public void setTem_5(Integer tem_5) {
		this.tem_5 = tem_5;
	}
	public Integer getTem_6() {
		return tem_6;
	}
	public void setTem_6(Integer tem_6) {
		this.tem_6 = tem_6;
	}
	public Integer getTem_7() {
		return tem_7;
	}
	public void setTem_7(Integer tem_7) {
		this.tem_7 = tem_7;
	}
	public Integer getTem_8() {
		return tem_8;
	}
	public void setTem_8(Integer tem_8) {
		this.tem_8 = tem_8;
	}
	public Integer getTem_9() {
		return tem_9;
	}
	public void setTem_9(Integer tem_9) {
		this.tem_9 = tem_9;
	}
	public Integer getTem_10() {
		return tem_10;
	}
	public void setTem_10(Integer tem_10) {
		this.tem_10 = tem_10;
	}
	public Integer getTem_11() {
		return tem_11;
	}
	public void setTem_11(Integer tem_11) {
		this.tem_11 = tem_11;
	}
	public Integer getTem_12() {
		return tem_12;
	}
	public void setTem_12(Integer tem_12) {
		this.tem_12 = tem_12;
	}
	public String getTagname() {
		return tagname;
	}
	public void setTagname(String tagname) {
		this.tagname = tagname;
	}
	public String getAlarmdesc() {
		return alarmdesc;
	}
	public void setAlarmdesc(String alarmdesc) {
		this.alarmdesc = alarmdesc;
	}
	public String getAlarmnmae() {
		return alarmnmae;
	}
	public void setAlarmnmae(String alarmnmae) {
		this.alarmnmae = alarmnmae;
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
	public String getA_stime() {
		return a_stime;
	}
	public void setA_stime(String a_stime) {
		this.a_stime = a_stime;
	}
	public String getA_etime() {
		return a_etime;
	}
	public void setA_etime(String a_etime) {
		this.a_etime = a_etime;
	}
	public String getA_hogi() {
		return a_hogi;
	}
	public void setA_hogi(String a_hogi) {
		this.a_hogi = a_hogi;
	}
	public String getA_addr() {
		return a_addr;
	}
	public void setA_addr(String a_addr) {
		this.a_addr = a_addr;
	}
	public String getA_desc() {
		return a_desc;
	}
	public void setA_desc(String a_desc) {
		this.a_desc = a_desc;
	}
	public int getA_value() {
		return a_value;
	}
	public void setA_value(int a_value) {
		this.a_value = a_value;
	}
	public int getA_cnt() {
		return a_cnt;
	}
	public void setA_cnt(int a_cnt) {
		this.a_cnt = a_cnt;
	}
	public String getA_sdate() {
		return a_sdate;
	}
	public void setA_sdate(String a_sdate) {
		this.a_sdate = a_sdate;
	}
	public String getA_edate() {
		return a_edate;
	}
	public void setA_edate(String a_edate) {
		this.a_edate = a_edate;
	}
	public String getS_date() {
		return s_date;
	}
	public void setS_date(String s_date) {
		this.s_date = s_date;
	}
	public String getE_date() {
		return e_date;
	}
	public void setE_date(String e_date) {
		this.e_date = e_date;
	}
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public String getS_sdate() {
		return s_sdate;
	}
	public void setS_sdate(String s_sdate) {
		this.s_sdate = s_sdate;
	}
	public String getS_edate() {
		return s_edate;
	}
	public void setS_edate(String s_edate) {
		this.s_edate = s_edate;
	}
	public Integer getVac1_pv() {
		return vac1_pv;
	}
	public void setVac1_pv(Integer vac1_pv) {
		this.vac1_pv = vac1_pv;
	}
	public Integer getVac2_pv() {
		return vac2_pv;
	}
	public void setVac2_pv(Integer vac2_pv) {
		this.vac2_pv = vac2_pv;
	}
	public Integer getVac3_pv() {
		return vac3_pv;
	}
	public void setVac3_pv(Integer vac3_pv) {
		this.vac3_pv = vac3_pv;
	}
	public Integer getProtec_pv() {
		return protec_pv;
	}
	public void setProtec_pv(Integer protec_pv) {
		this.protec_pv = protec_pv;
	}
	public Integer getTem_sp() {
		return tem_sp;
	}
	public void setTem_sp(Integer tem_sp) {
		this.tem_sp = tem_sp;
	}
	
	
	
	
	
	
	
	
	

}
