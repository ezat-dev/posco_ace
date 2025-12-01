package com.posco.domain;

public class Fac {

	private String fac_code;		
	private String fac_no;			//설비번호
	private String fac_name;		//설비명
	private String fac_gyu;			//설비규격[가스질화/이온질화/침탄/VC/PQ/TEMPERING/진공/세척기/후처리/기타]
	private String fac_hyun;		//설비형식
	private String fac_yong;		//설비용도
	private String fac_make;		//제조회사
	private String fac_lot;			//사용부서
	private String fac_test;		//점검주기
	private String fac_bigo;		//비고
	private String fac_cau;			//설비점검 주의사항
	
	
	private String fac_man1;		//관리자(정)
	private String fac_man2;		//관리자(부)
	private String fac_plc;			//설치장소
	
	private String fac_cbuy;		//구입처
	private String fac_buy;			//도입시기
	private String fac_mday;		//제조일자
	private String fac_mon;			//구입가격
	private String fac_able;		//처리용량
	private String fac_time;		//기동시간 기준
	
	
	private String fac_tech_no;
	private String fac_gubn;
	private String fac_e1;			//제조번호
	private String fac_e2;			//제조사 국적
	private String fac_e3;			//유지보수업체
	private String fac_e4;			//주변설비 및 관련사항
	
	private String fac_dan;			//실적현황 출력
	private String fac_unus;		//특이사항
	
	private String fac_pda_use;
	private String fac_state;
	
	private String tech_no;			//설비종료
	private String fac_file_name;	//설비 이미지 이름
	
	
	public String getFac_file_name() {
		return fac_file_name;
	}
	public void setFac_file_name(String fac_file_name) {
		this.fac_file_name = fac_file_name;
	}
	public String getFac_code() {
		return fac_code;
	}
	public void setFac_code(String fac_code) {
		this.fac_code = fac_code;
	}
	public String getFac_no() {
		return fac_no;
	}
	public void setFac_no(String fac_no) {
		this.fac_no = fac_no;
	}
	public String getFac_name() {
		return fac_name;
	}
	public void setFac_name(String fac_name) {
		this.fac_name = fac_name;
	}
	public String getFac_gyu() {
		return fac_gyu;
	}
	public void setFac_gyu(String fac_gyu) {
		this.fac_gyu = fac_gyu;
	}
	public String getFac_hyun() {
		return fac_hyun;
	}
	public void setFac_hyun(String fac_hyun) {
		this.fac_hyun = fac_hyun;
	}
	public String getFac_yong() {
		return fac_yong;
	}
	public void setFac_yong(String fac_yong) {
		this.fac_yong = fac_yong;
	}
	public String getFac_man1() {
		return fac_man1;
	}
	public void setFac_man1(String fac_man1) {
		this.fac_man1 = fac_man1;
	}
	public String getFac_man2() {
		return fac_man2;
	}
	public void setFac_man2(String fac_man2) {
		this.fac_man2 = fac_man2;
	}
	public String getFac_plc() {
		return fac_plc;
	}
	public void setFac_plc(String fac_plc) {
		this.fac_plc = fac_plc;
	}
	public String getFac_make() {
		return fac_make;
	}
	public void setFac_make(String fac_make) {
		this.fac_make = fac_make;
	}
	public String getFac_cbuy() {
		return fac_cbuy;
	}
	public void setFac_cbuy(String fac_cbuy) {
		this.fac_cbuy = fac_cbuy;
	}
	public String getFac_buy() {
		return fac_buy;
	}
	public void setFac_buy(String fac_buy) {
		this.fac_buy = fac_buy;
	}
	public String getFac_mday() {
		return fac_mday;
	}
	public void setFac_mday(String fac_mday) {
		this.fac_mday = fac_mday;
	}
	public String getFac_mon() {
		return fac_mon;
	}
	public void setFac_mon(String fac_mon) {
		this.fac_mon = fac_mon;
	}
	public String getFac_able() {
		return fac_able;
	}
	public void setFac_able(String fac_able) {
		this.fac_able = fac_able;
	}
	public String getFac_time() {
		return fac_time;
	}
	public void setFac_time(String fac_time) {
		this.fac_time = fac_time;
	}
	public String getFac_bigo() {
		return fac_bigo;
	}
	public void setFac_bigo(String fac_bigo) {
		this.fac_bigo = fac_bigo;
	}
	public String getFac_tech_no() {
		return fac_tech_no;
	}
	public void setFac_tech_no(String fac_tech_no) {
		this.fac_tech_no = fac_tech_no;
	}
	public String getFac_gubn() {
		return fac_gubn;
	}
	public void setFac_gubn(String fac_gubn) {
		this.fac_gubn = fac_gubn;
	}
	public String getFac_e1() {
		return fac_e1;
	}
	public void setFac_e1(String fac_e1) {
		this.fac_e1 = fac_e1;
	}
	public String getFac_e2() {
		return fac_e2;
	}
	public void setFac_e2(String fac_e2) {
		this.fac_e2 = fac_e2;
	}
	public String getFac_e3() {
		return fac_e3;
	}
	public void setFac_e3(String fac_e3) {
		this.fac_e3 = fac_e3;
	}
	public String getFac_e4() {
		return fac_e4;
	}
	public void setFac_e4(String fac_e4) {
		this.fac_e4 = fac_e4;
	}
	public String getFac_lot() {
		return fac_lot;
	}
	public void setFac_lot(String fac_lot) {
		this.fac_lot = fac_lot;
	}
	public String getFac_dan() {
		return fac_dan;
	}
	public void setFac_dan(String fac_dan) {
		this.fac_dan = fac_dan;
	}
	public String getFac_unus() {
		return fac_unus;
	}
	public void setFac_unus(String fac_unus) {
		this.fac_unus = fac_unus;
	}
	public String getFac_cau() {
		return fac_cau;
	}
	public void setFac_cau(String fac_cau) {
		this.fac_cau = fac_cau;
	}
	public String getFac_pda_use() {
		return fac_pda_use;
	}
	public void setFac_pda_use(String fac_pda_use) {
		this.fac_pda_use = fac_pda_use;
	}
	public String getFac_state() {
		return fac_state;
	}
	public void setFac_state(String fac_state) {
		this.fac_state = fac_state;
	}
	public String getFac_test() {
		return fac_test;
	}
	public void setFac_test(String fac_test) {
		this.fac_test = fac_test;
	}
	public String getTech_no() {
		return tech_no;
	}
	public void setTech_no(String tech_no) {
		this.tech_no = tech_no;
	}
	
}
