package com.posco.dao;

import java.util.List;

import com.posco.domain.Bega;
import com.posco.domain.SparePart;
import com.posco.domain.Suri;

public interface PreservationDAO {
	
	List<SparePart> getSparePartList(SparePart sparePart);
	
	SparePart sparePartDetail(SparePart sparePart);
	
	void sparePartInsertSave(SparePart sparePart);
	
	void sparePartUpdateSave(SparePart sparePart);
	
	void sparePartDelete(String spp_code);
	
	
	
	
	List<Bega> getBegaInsertList(Bega bega);
	
	Bega begaInsertDetail(Bega bega);
	
	void begaInsertSave(Bega bega);
	
	void begaUpdateSave(Bega bega);
	
	void begaDelete(String fstp_code);
	
	
	List<Suri> getSuriHistoryList(Suri srui);
	
	Suri suriHistoryDetail(Suri srui);
	
	void suriHistoryInsertSave(Suri srui);
	
	void suriHistoryUpdateSave(Suri srui);
	
	void suriHistoryDelete(String ffx_no);
	
}
