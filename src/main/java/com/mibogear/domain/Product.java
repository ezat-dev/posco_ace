package com.mibogear.domain;

public class Product {
	
	//PRODUCT 테이블
	private String prod_code;
	private String corp_code;
	private String corp_name;           //거래처명
	private String prod_name;			//품명
	private String prod_no;				//품번
	private String prod_gyu;			//규격
	private String prod_jai;			//재질
	private String prod_fac1;
	private String prod_fac2;
	private String prod_fac3;
	private String prod_fac4;
	private String prod_fac5;
	private String prod_fac6;
	private String prod_cno;
	private String prod_model;
	private String prod_gubn;
	

	//TECH 테이블
	private String tech_no;					//공정
	private String tech_pattern;			//공정패턴
	private String tech_seq;				//공정순서
	private String tech_te;

	
	
	
	
	public String getProd_code() {
		return prod_code;
	}
	public void setProd_code(String prod_code) {
		this.prod_code = prod_code;
	}
	public String getCorp_code() {
		return corp_code;
	}
	public void setCorp_code(String corp_code) {
		this.corp_code = corp_code;
	}
	public String getProd_name() {
		return prod_name;
	}
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}
	public String getProd_no() {
		return prod_no;
	}
	public void setProd_no(String prod_no) {
		this.prod_no = prod_no;
	}
	public String getProd_gyu() {
		return prod_gyu;
	}
	public void setProd_gyu(String prod_gyu) {
		this.prod_gyu = prod_gyu;
	}
	public String getProd_jai() {
		return prod_jai;
	}
	public void setProd_jai(String prod_jai) {
		this.prod_jai = prod_jai;
	}
	
	public String getTech_no() {
		return tech_no;
	}
	public void setTech_no(String tech_no) {
		this.tech_no = tech_no;
	}
	
	public String getTech_pattern() {
		return tech_pattern;
	}
	public void setTech_pattern(String tech_pattern) {
		this.tech_pattern = tech_pattern;
	}
	public String getTech_seq() {
		return tech_seq;
	}
	public void setTech_seq(String tech_seq) {
		this.tech_seq = tech_seq;
	}
	
	public String getCorp_name() {
		return corp_name;
	}
	public void setCorp_name(String corp_name) {
		this.corp_name = corp_name;
	}
	public String getTech_te() {
		return tech_te;
	}
	public void setTech_te(String tech_te) {
		this.tech_te = tech_te;
	}
	public String getProd_fac1() {
		return prod_fac1;
	}
	public void setProd_fac1(String prod_fac1) {
		this.prod_fac1 = prod_fac1;
	}
	public String getProd_fac2() {
		return prod_fac2;
	}
	public void setProd_fac2(String prod_fac2) {
		this.prod_fac2 = prod_fac2;
	}
	public String getProd_fac3() {
		return prod_fac3;
	}
	public void setProd_fac3(String prod_fac3) {
		this.prod_fac3 = prod_fac3;
	}
	public String getProd_fac4() {
		return prod_fac4;
	}
	public void setProd_fac4(String prod_fac4) {
		this.prod_fac4 = prod_fac4;
	}
	public String getProd_fac5() {
		return prod_fac5;
	}
	public void setProd_fac5(String prod_fac5) {
		this.prod_fac5 = prod_fac5;
	}
	public String getProd_fac6() {
		return prod_fac6;
	}
	public void setProd_fac6(String prod_fac6) {
		this.prod_fac6 = prod_fac6;
	}
	public String getProd_cno() {
		return prod_cno;
	}
	public void setProd_cno(String prod_cno) {
		this.prod_cno = prod_cno;
	}
	public String getProd_model() {
		return prod_model;
	}
	public void setProd_model(String prod_model) {
		this.prod_model = prod_model;
	}
	public String getProd_gubn() {
		return prod_gubn;
	}
	public void setProd_gubn(String prod_gubn) {
		this.prod_gubn = prod_gubn;
	}
	
	
}
