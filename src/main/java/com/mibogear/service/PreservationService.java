package com.mibogear.service;

import java.util.List;

import com.mibogear.domain.Bega;
import com.mibogear.domain.Product;
import com.mibogear.domain.SparePart;
import com.mibogear.domain.Suri;

public interface PreservationService {
	
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
