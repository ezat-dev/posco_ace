package com.mibogear.domain;

public class DroppedGoods {
	
		private String d_lot;//천일lot
		private String w_pnum;//품번
		private String item_name;//품명
		private String w_sdatetime; //투입시작시간
		private String w_in_edatetime;//투입완료시간
		private String w_edatetime;//작업완료시간
		private String d_in; //투입 낙하품유무
		private String d_qf; //참턴 낙하품유무
		private String d_tf; //템퍼링 낙하품유무
		private String d_out; //퇴출품 낙하유무
		private String d_bigo;//비고
		private String w_date;//작업날짜
		
		
		
		
		
		
		public String getD_lot() {
			return d_lot;
		}
		public void setD_lot(String d_lot) {
			this.d_lot = d_lot;
		}
		public String getW_pnum() {
			return w_pnum;
		}
		public void setW_pnum(String w_pnum) {
			this.w_pnum = w_pnum;
		}
		public String getItem_name() {
			return item_name;
		}
		public void setItem_name(String item_name) {
			this.item_name = item_name;
		}
		public String getW_sdatetime() {
			return w_sdatetime;
		}
		public void setW_sdatetime(String w_sdatetime) {
			this.w_sdatetime = w_sdatetime;
		}
		public String getW_in_edatetime() {
			return w_in_edatetime;
		}
		public void setW_in_edatetime(String w_in_edatetime) {
			this.w_in_edatetime = w_in_edatetime;
		}
		public String getW_edatetime() {
			return w_edatetime;
		}
		public void setW_edatetime(String w_edatetime) {
			this.w_edatetime = w_edatetime;
		}
		public String getD_in() {
			return d_in;
		}
		public void setD_in(String d_in) {
			this.d_in = d_in;
		}
		public String getD_qf() {
			return d_qf;
		}
		public void setD_qf(String d_qf) {
			this.d_qf = d_qf;
		}
		public String getD_tf() {
			return d_tf;
		}
		public void setD_tf(String d_tf) {
			this.d_tf = d_tf;
		}
		public String getD_out() {
			return d_out;
		}
		public void setD_out(String d_out) {
			this.d_out = d_out;
		}
		public String getD_bigo() {
			return d_bigo;
		}
		public void setD_bigo(String d_bigo) {
			this.d_bigo = d_bigo;
		}
		public String getW_date() {
			return w_date;
		}
		public void setW_date(String w_date) {
			this.w_date = w_date;
		}
}
