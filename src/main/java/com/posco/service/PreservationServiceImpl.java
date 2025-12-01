package com.posco.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.posco.dao.PreservationDAO;
import com.posco.dao.StandardDAO;
import com.posco.domain.Bega;
import com.posco.domain.Corp;
import com.posco.domain.Fac;
import com.posco.domain.Product;
import com.posco.domain.SparePart;
import com.posco.domain.Suri;
import com.posco.domain.Users;

@Service
public class PreservationServiceImpl implements PreservationService {
	
	@Autowired
	private PreservationDAO preservationdDAO;
	
	
	@Override
	public List<SparePart> getSparePartList(SparePart sparePart){
		return preservationdDAO.getSparePartList(sparePart);
	}
	
	@Override
	public SparePart sparePartDetail(SparePart sparePart) {
		return preservationdDAO.sparePartDetail(sparePart);
	}
	
	@Override
	public void sparePartInsertSave(SparePart sparePart) {
		preservationdDAO.sparePartInsertSave(sparePart);
	}
	
	@Override
	public void sparePartUpdateSave(SparePart sparePart) {
		preservationdDAO.sparePartUpdateSave(sparePart);
	}
	
	@Override
	public void sparePartDelete(String spp_idx) {
		preservationdDAO.sparePartDelete(spp_idx);
	}
	
	
	
	
	
	
	
	
	
	@Override
	public List<Bega> getBegaInsertList(Bega bega){
		return preservationdDAO.getBegaInsertList(bega);
	}
	
	@Override
	public Bega begaInsertDetail(Bega bega) {
		return preservationdDAO.begaInsertDetail(bega);
	}
	
	@Override
	public void begaInsertSave(Bega bega) {
		preservationdDAO.begaInsertSave(bega);
	}
	
	@Override
	public void begaUpdateSave(Bega bega) {
		preservationdDAO.begaUpdateSave(bega);
	}
	
	@Override
	public void begaDelete(String fstp_code) {
		preservationdDAO.begaDelete(fstp_code);
	}
	
	
	@Override
	public List<Suri> getSuriHistoryList(Suri suri){
		return preservationdDAO.getSuriHistoryList(suri);
	}
	
	@Override
	public Suri suriHistoryDetail(Suri suri) {
		return preservationdDAO.suriHistoryDetail(suri);
	}
	
	@Override
	public void suriHistoryInsertSave(Suri suri) {
		preservationdDAO.suriHistoryInsertSave(suri);
	}
	
	@Override
	public void suriHistoryUpdateSave(Suri suri) {
		preservationdDAO.suriHistoryUpdateSave(suri);
	}
	
	@Override
	public void suriHistoryDelete(String ffx_no) {
		preservationdDAO.suriHistoryDelete(ffx_no);
	}

}
