package com.mibogear.domain;

import java.util.Date;

public class MachineSpare {
	
	//생성 날짜
	private Date insert_date;
	
	//스페어 번호
	private Integer no;//int -> Integer
	
	//설비
	private String mch_name;
	
	//부품명
	private String mch_parts;
	
	//사용처
	private String a_usage;
	
	//규격
	private String standard;
	
	//제작업체
	private String producer;
	
	//교체
	private String replacement;
	
	// 구매주기
    private String buy_cycle;

    // 현재고
    private Integer now_stock;

    // 안전재고
    private Integer safe_stock;

    // 부족재고
    private Integer shortage_stock;

    // 단위
    private String unit;

    // 보관위치
    private String storage_location;

    // 랙번호
    private String rack_no;

    // 구매신청
    private String purchase_request;

    // 비고
    private String remark;
    
    

	public Date getInsert_date() {
		return insert_date;
	}

	public void setInsert_date(Date insert_date) {
		this.insert_date = insert_date;
	}

	public Integer getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getMch_name() {
		return mch_name;
	}

	public void setMch_name(String mch_name) {
		this.mch_name = mch_name;
	}

	public String getMch_parts() {
		return mch_parts;
	}

	public void setMch_parts(String mch_parts) {
		this.mch_parts = mch_parts;
	}

	public String getA_usage() {
		return a_usage;
	}

	public void setA_usage(String a_usage) {
		this.a_usage = a_usage;
	}

	public String getStandard() {
		return standard;
	}

	public void setStandard(String standard) {
		this.standard = standard;
	}

	public String getProducer() {
		return producer;
	}

	public void setProducer(String producer) {
		this.producer = producer;
	}

	public String getReplacement() {
		return replacement;
	}

	public void setReplacement(String replacement) {
		this.replacement = replacement;
	}

	public String getBuy_cycle() {
		return buy_cycle;
	}

	public void setBuy_cycle(String buy_cycle) {
		this.buy_cycle = buy_cycle;
	}

	public Integer getNow_stock() {
		return now_stock;
	}

	public void setNow_stock(int now_stock) {
		this.now_stock = now_stock;
	}

	public Integer getSafe_stock() {
		return safe_stock;
	}

	public void setSafe_stock(int safe_stock) {
		this.safe_stock = safe_stock;
	}

	public Integer getShortage_stock() {
		return shortage_stock;
	}

	public void setShortage_stock(int shortage_stock) {
		this.shortage_stock = shortage_stock;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getStorage_location() {
		return storage_location;
	}

	public void setStorage_location(String storage_location) {
		this.storage_location = storage_location;
	}

	public String getRack_no() {
		return rack_no;
	}

	public void setRack_no(String rack_no) {
		this.rack_no = rack_no;
	}

	public String getPurchase_request() {
		return purchase_request;
	}

	public void setPurchase_request(String purchase_request) {
		this.purchase_request = purchase_request;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Override
	public String toString() {
		return "MachineSpare [insert_date=" + insert_date + ", no=" + no + ", mch_name=" + mch_name + ", mch_parts="
				+ mch_parts + ", a_usage=" + a_usage + ", standard=" + standard + ", producer=" + producer
				+ ", replacement=" + replacement + ", buy_cycle=" + buy_cycle + ", now_stock=" + now_stock
				+ ", safe_stock=" + safe_stock + ", shortage_stock=" + shortage_stock + ", unit=" + unit
				+ ", storage_location=" + storage_location + ", rack_no=" + rack_no + ", purchase_request="
				+ purchase_request + ", remark=" + remark + "]";
	}
    
    
    

}
