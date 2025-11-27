package com.mibogear.domain;

public class Measure {
	
	private String sdate;
	private String edate;
	
	
	private String ter_code;	//PK
	private String ter_name;		//측정기기명
	private String ter_no;			//측정기기번호
	private String ter_model;		//모델명
	private String ter_sn;			//시리얼번호(S/N)
	private String ter_yong;		//용도
	private String ter_kind;		//측정기기종류
	private String ter_man1;		//관리자(정)
	private String ter_man2;		//관리자(부)
	private String ter_place;		//설치장소
	private String ter_use;			//상태[사용/폐기/매각]
	private String ter_ubigo;		//상태비고
	private String ter_bigo;		//비고
	private String ter_maker;		//제조회사
	private String ter_mdate;		//제조일자
	private String ter_buy;			//구입회사
	private String ter_bdate;		//구입일자
	private String ter_bmon;		//구입금액
	private String ter_gum;			//검교정주기[분기/반기/년간/2년간]
	private String ter_v;			//사용전압
	private String ter_a;			//사용전류
	private String ter_kw;			//사용전력
	private String ter_next_gum;	//차기검교정일
	private String ter_end_gum;		//최종검교정일
	private String ter_file;		//첨부파일(이미지)
	private String ter_man;
	
	
	//측정기기고장 및 점검
	private Integer terr_code;
	private String terr_name;
	private String terr_chkman; //확인자
	private String terr_date; //고장일시
	private String terr_condi; //상태
	private String terr_cost; //소요비용
	private String terr_reward; //고장현상
	private String terr_bigo; //비고
	private String terr_bphoto; //수리전사진
	private String terr_aphoto; //수리후사진
	private String terr_strt; //수리시작시간
	private String terr_strt_h; //시작 시
	private String terr_strt_mm; //시작 분
	private String terr_strt_ss; //시작 초
	private String terr_end; //수리종료시간
	private String terr_end_h; //종료 시
	private String terr_end_mm; //종료 분
	private String terr_end_ss; //종료 초
	private String terr_time; //수리시간
	private String terr_man; //수리자
	private String terr_suri; //수리
	private String terr_content; //수리내용
	
	
	private String terr_strt_m;
	private String terr_strt_s;
	private String terr_end_m;
	private String terr_end_s;
	
	
	
	//측정기기점검관리
	private Integer mcd_cd;
	private String mcd_inspection_date; //점검일
	private String mcd_no; //장비번호
	private String mcd_man_no;
	private String mcd_correction_cycle; //교정주기명
	private String mcd_next_date; //차기교정일
	private String repair_comp;
	private int mcd_manager_user_cd;
	private String mcd_available_term;
	private String repair_history;
	private String mcd_file;
	private String mcd_reg_dt; //최초등록일시
	private String mcd_reg_cd; //최초등록자명
	private String mcd_mod_dt; //최종수정일시
	private String mcd_mod_cd; //최종수정자명
	private int site_seq;
	private String device_location_cd;
	private String file_name;	//측정기기 사진 이름
	private String file_name1;	//수리 전 이름
	private String file_name2;	//수리 후 이름
	private String file_name3; //측정기기점검관리 사진 이름
	
	
	
	public String getFile_name3() {
		return file_name3;
	}
	public void setFile_name3(String file_name3) {
		this.file_name3 = file_name3;
	}
	public String getFile_name1() {
		return file_name1;
	}
	public void setFile_name1(String file_name1) {
		this.file_name1 = file_name1;
	}
	public String getFile_name2() {
		return file_name2;
	}
	public void setFile_name2(String file_name2) {
		this.file_name2 = file_name2;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getTer_code() {
		return ter_code;
	}
	public void setTer_code(String ter_code) {
		this.ter_code = ter_code;
	}
	public String getTer_name() {
		return ter_name;
	}
	public void setTer_name(String ter_name) {
		this.ter_name = ter_name;
	}
	public String getTer_no() {
		return ter_no;
	}
	public void setTer_no(String ter_no) {
		this.ter_no = ter_no;
	}
	public String getTer_model() {
		return ter_model;
	}
	public void setTer_model(String ter_model) {
		this.ter_model = ter_model;
	}
	public String getTer_sn() {
		return ter_sn;
	}
	public void setTer_sn(String ter_sn) {
		this.ter_sn = ter_sn;
	}
	public String getTer_yong() {
		return ter_yong;
	}
	public void setTer_yong(String ter_yong) {
		this.ter_yong = ter_yong;
	}
	public String getTer_kind() {
		return ter_kind;
	}
	public void setTer_kind(String ter_kind) {
		this.ter_kind = ter_kind;
	}
	public String getTer_man1() {
		return ter_man1;
	}
	public void setTer_man1(String ter_man1) {
		this.ter_man1 = ter_man1;
	}
	public String getTer_man2() {
		return ter_man2;
	}
	public void setTer_man2(String ter_man2) {
		this.ter_man2 = ter_man2;
	}
	public String getTer_place() {
		return ter_place;
	}
	public void setTer_place(String ter_place) {
		this.ter_place = ter_place;
	}
	public String getTer_use() {
		return ter_use;
	}
	public void setTer_use(String ter_use) {
		this.ter_use = ter_use;
	}
	public String getTer_ubigo() {
		return ter_ubigo;
	}
	public void setTer_ubigo(String ter_ubigo) {
		this.ter_ubigo = ter_ubigo;
	}
	public String getTer_bigo() {
		return ter_bigo;
	}
	public void setTer_bigo(String ter_bigo) {
		this.ter_bigo = ter_bigo;
	}
	public String getTer_maker() {
		return ter_maker;
	}
	public void setTer_maker(String ter_maker) {
		this.ter_maker = ter_maker;
	}
	public String getTer_mdate() {
		return ter_mdate;
	}
	public void setTer_mdate(String ter_mdate) {
		this.ter_mdate = ter_mdate;
	}
	public String getTer_buy() {
		return ter_buy;
	}
	public void setTer_buy(String ter_buy) {
		this.ter_buy = ter_buy;
	}
	public String getTer_bdate() {
		return ter_bdate;
	}
	public void setTer_bdate(String ter_bdate) {
		this.ter_bdate = ter_bdate;
	}
	public String getTer_bmon() {
		return ter_bmon;
	}
	public void setTer_bmon(String ter_bmon) {
		this.ter_bmon = ter_bmon;
	}
	public String getTer_gum() {
		return ter_gum;
	}
	public void setTer_gum(String ter_gum) {
		this.ter_gum = ter_gum;
	}
	public String getTer_v() {
		return ter_v;
	}
	public void setTer_v(String ter_v) {
		this.ter_v = ter_v;
	}
	public String getTer_a() {
		return ter_a;
	}
	public void setTer_a(String ter_a) {
		this.ter_a = ter_a;
	}
	public String getTer_kw() {
		return ter_kw;
	}
	public void setTer_kw(String ter_kw) {
		this.ter_kw = ter_kw;
	}
	public String getTer_next_gum() {
		return ter_next_gum;
	}
	public void setTer_next_gum(String ter_next_gum) {
		this.ter_next_gum = ter_next_gum;
	}
	public String getTer_end_gum() {
		return ter_end_gum;
	}
	public void setTer_end_gum(String ter_end_gum) {
		this.ter_end_gum = ter_end_gum;
	}
	public String getTer_file() {
		return ter_file;
	}
	public void setTer_file(String ter_file) {
		this.ter_file = ter_file;
	}
	public String getTerr_chkman() {
		return terr_chkman;
	}
	public void setTerr_chkman(String terr_chkman) {
		this.terr_chkman = terr_chkman;
	}
	public String getTerr_date() {
		return terr_date;
	}
	public void setTerr_date(String terr_date) {
		this.terr_date = terr_date;
	}
	public String getTerr_condi() {
		return terr_condi;
	}
	public void setTerr_condi(String terr_condi) {
		this.terr_condi = terr_condi;
	}
	public String getTerr_cost() {
		return terr_cost;
	}
	public void setTerr_cost(String terr_cost) {
		this.terr_cost = terr_cost;
	}
	public String getTerr_reward() {
		return terr_reward;
	}
	public void setTerr_reward(String terr_reward) {
		this.terr_reward = terr_reward;
	}
	public String getTerr_bigo() {
		return terr_bigo;
	}
	public void setTerr_bigo(String terr_bigo) {
		this.terr_bigo = terr_bigo;
	}
	public String getTerr_bphoto() {
		return terr_bphoto;
	}
	public void setTerr_bphoto(String terr_bphoto) {
		this.terr_bphoto = terr_bphoto;
	}
	public String getTerr_aphoto() {
		return terr_aphoto;
	}
	public void setTerr_aphoto(String terr_aphoto) {
		this.terr_aphoto = terr_aphoto;
	}
	public String getTerr_strt() {
		return terr_strt;
	}
	public void setTerr_strt(String terr_strt) {
		this.terr_strt = terr_strt;
	}
	public String getTerr_strt_h() {
		return terr_strt_h;
	}
	public void setTerr_strt_h(String terr_strt_h) {
		this.terr_strt_h = terr_strt_h;
	}
	public String getTerr_strt_mm() {
		return terr_strt_mm;
	}
	public void setTerr_strt_mm(String terr_strt_mm) {
		this.terr_strt_mm = terr_strt_mm;
	}
	public String getTerr_strt_ss() {
		return terr_strt_ss;
	}
	public void setTerr_strt_ss(String terr_strt_ss) {
		this.terr_strt_ss = terr_strt_ss;
	}
	public String getTerr_end() {
		return terr_end;
	}
	public void setTerr_end(String terr_end) {
		this.terr_end = terr_end;
	}
	public String getTerr_end_h() {
		return terr_end_h;
	}
	public void setTerr_end_h(String terr_end_h) {
		this.terr_end_h = terr_end_h;
	}
	public String getTerr_end_mm() {
		return terr_end_mm;
	}
	public void setTerr_end_mm(String terr_end_mm) {
		this.terr_end_mm = terr_end_mm;
	}
	public String getTerr_end_ss() {
		return terr_end_ss;
	}
	public void setTerr_end_ss(String terr_end_ss) {
		this.terr_end_ss = terr_end_ss;
	}
	public String getTerr_time() {
		return terr_time;
	}
	public void setTerr_time(String terr_time) {
		this.terr_time = terr_time;
	}
	public String getTerr_man() {
		return terr_man;
	}
	public void setTerr_man(String terr_man) {
		this.terr_man = terr_man;
	}
	public String getTerr_suri() {
		return terr_suri;
	}
	public void setTerr_suri(String terr_suri) {
		this.terr_suri = terr_suri;
	}
	public String getTerr_content() {
		return terr_content;
	}
	public void setTerr_content(String terr_content) {
		this.terr_content = terr_content;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public String getEdate() {
		return edate;
	}
	public void setEdate(String edate) {
		this.edate = edate;
	}
	public String getTerr_name() {
		return terr_name;
	}
	public void setTerr_name(String terr_name) {
		this.terr_name = terr_name;
	}
	public String getMcd_inspection_date() {
		return mcd_inspection_date;
	}
	public void setMcd_inspection_date(String mcd_inspection_date) {
		this.mcd_inspection_date = mcd_inspection_date;
	}
	public String getMcd_no() {
		return mcd_no;
	}
	public void setMcd_no(String mcd_no) {
		this.mcd_no = mcd_no;
	}

	public String getMcd_next_date() {
		return mcd_next_date;
	}
	public void setMcd_next_date(String mcd_next_date) {
		this.mcd_next_date = mcd_next_date;
	}

	public String getMcd_reg_dt() {
		return mcd_reg_dt;
	}
	public void setMcd_reg_dt(String mcd_reg_dt) {
		this.mcd_reg_dt = mcd_reg_dt;
	}

	public String getMcd_mod_dt() {
		return mcd_mod_dt;
	}
	public void setMcd_mod_dt(String mcd_mod_dt) {
		this.mcd_mod_dt = mcd_mod_dt;
	}

	public Integer getMcd_cd() {
		return mcd_cd;
	}
	public void setMcd_cd(Integer mcd_cd) {
		this.mcd_cd = mcd_cd;
	}
	public String getMcd_man_no() {
		return mcd_man_no;
	}
	public void setMcd_man_no(String mcd_man_no) {
		this.mcd_man_no = mcd_man_no;
	}
	public String getMcd_correction_cycle() {
		return mcd_correction_cycle;
	}
	public void setMcd_correction_cycle(String mcd_correction_cycle) {
		this.mcd_correction_cycle = mcd_correction_cycle;
	}
	public String getRepair_comp() {
		return repair_comp;
	}
	public void setRepair_comp(String repair_comp) {
		this.repair_comp = repair_comp;
	}
	public int getMcd_manager_user_cd() {
		return mcd_manager_user_cd;
	}
	public void setMcd_manager_user_cd(int mcd_manager_user_cd) {
		this.mcd_manager_user_cd = mcd_manager_user_cd;
	}
	public String getMcd_available_term() {
		return mcd_available_term;
	}
	public void setMcd_available_term(String mcd_available_term) {
		this.mcd_available_term = mcd_available_term;
	}
	public String getRepair_history() {
		return repair_history;
	}
	public void setRepair_history(String repair_history) {
		this.repair_history = repair_history;
	}
	public String getMcd_file() {
		return mcd_file;
	}
	public void setMcd_file(String mcd_file) {
		this.mcd_file = mcd_file;
	}
	public String getMcd_reg_cd() {
		return mcd_reg_cd;
	}
	public void setMcd_reg_cd(String mcd_reg_cd) {
		this.mcd_reg_cd = mcd_reg_cd;
	}
	public String getMcd_mod_cd() {
		return mcd_mod_cd;
	}
	public void setMcd_mod_cd(String mcd_mod_cd) {
		this.mcd_mod_cd = mcd_mod_cd;
	}
	public int getSite_seq() {
		return site_seq;
	}
	public void setSite_seq(int site_seq) {
		this.site_seq = site_seq;
	}
	public String getDevice_location_cd() {
		return device_location_cd;
	}
	public void setDevice_location_cd(String device_location_cd) {
		this.device_location_cd = device_location_cd;
	}
	public Integer getTerr_code() {
		return terr_code;
	}
	public void setTerr_code(Integer terr_code) {
		this.terr_code = terr_code;
	}
	@Override
	public String toString() {
		return "Measure [sdate=" + sdate + ", edate=" + edate + ", ter_code=" + ter_code + ", ter_name=" + ter_name
				+ ", ter_no=" + ter_no + ", ter_model=" + ter_model + ", ter_sn=" + ter_sn + ", ter_yong=" + ter_yong
				+ ", ter_kind=" + ter_kind + ", ter_man1=" + ter_man1 + ", ter_man2=" + ter_man2 + ", ter_place="
				+ ter_place + ", ter_use=" + ter_use + ", ter_ubigo=" + ter_ubigo + ", ter_bigo=" + ter_bigo
				+ ", ter_maker=" + ter_maker + ", ter_mdate=" + ter_mdate + ", ter_buy=" + ter_buy + ", ter_bdate="
				+ ter_bdate + ", ter_bmon=" + ter_bmon + ", ter_gum=" + ter_gum + ", ter_v=" + ter_v + ", ter_a="
				+ ter_a + ", ter_kw=" + ter_kw + ", ter_next_gum=" + ter_next_gum + ", ter_end_gum=" + ter_end_gum
				+ ", ter_file=" + ter_file + ", terr_code=" + terr_code + ", terr_name=" + terr_name + ", terr_chkman="
				+ terr_chkman + ", terr_date=" + terr_date + ", terr_condi=" + terr_condi + ", terr_cost=" + terr_cost
				+ ", terr_reward=" + terr_reward + ", terr_bigo=" + terr_bigo + ", terr_bphoto=" + terr_bphoto
				+ ", terr_aphoto=" + terr_aphoto + ", terr_strt=" + terr_strt + ", terr_strt_h=" + terr_strt_h
				+ ", terr_strt_mm=" + terr_strt_mm + ", terr_strt_ss=" + terr_strt_ss + ", terr_end=" + terr_end
				+ ", terr_end_h=" + terr_end_h + ", terr_end_mm=" + terr_end_mm + ", terr_end_ss=" + terr_end_ss
				+ ", terr_time=" + terr_time + ", terr_man=" + terr_man + ", terr_suri=" + terr_suri + ", terr_content="
				+ terr_content + ", mcd_cd=" + mcd_cd + ", mcd_inspection_date=" + mcd_inspection_date + ", mcd_no="
				+ mcd_no + ", mcd_man_no=" + mcd_man_no + ", mcd_correction_cycle=" + mcd_correction_cycle
				+ ", mcd_next_date=" + mcd_next_date + ", repair_comp=" + repair_comp + ", mcd_manager_user_cd="
				+ mcd_manager_user_cd + ", mcd_available_term=" + mcd_available_term + ", repair_history="
				+ repair_history + ", mcd_file=" + mcd_file + ", mcd_reg_dt=" + mcd_reg_dt + ", mcd_reg_cd="
				+ mcd_reg_cd + ", mcd_mod_dt=" + mcd_mod_dt + ", mcd_mod_cd=" + mcd_mod_cd + ", site_seq=" + site_seq
				+ ", device_location_cd=" + device_location_cd + ", file_name=" + file_name + "]";
	}
	public String getTerr_strt_m() {
		return terr_strt_m;
	}
	public void setTerr_strt_m(String terr_strt_m) {
		this.terr_strt_m = terr_strt_m;
	}
	public String getTerr_strt_s() {
		return terr_strt_s;
	}
	public void setTerr_strt_s(String terr_strt_s) {
		this.terr_strt_s = terr_strt_s;
	}
	public String getTerr_end_m() {
		return terr_end_m;
	}
	public void setTerr_end_m(String terr_end_m) {
		this.terr_end_m = terr_end_m;
	}
	public String getTerr_end_s() {
		return terr_end_s;
	}
	public void setTerr_end_s(String terr_end_s) {
		this.terr_end_s = terr_end_s;
	}
	public String getTer_man() {
		return ter_man;
	}
	public void setTer_man(String ter_man) {
		this.ter_man = ter_man;
	}

	
}
