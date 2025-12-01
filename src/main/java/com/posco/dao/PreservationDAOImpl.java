package com.posco.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.posco.domain.Bega;
import com.posco.domain.SparePart;
import com.posco.domain.Suri;


@Repository
public class PreservationDAOImpl implements PreservationDAO{
	
	@Resource(name="session")
    private SqlSession sqlSession;
	
	@Override
	 public List<SparePart> getSparePartList(SparePart sparePart) {
		 return sqlSession.selectList("sparePart.getSparePartList",sparePart);
	 }
	
	@Override
	public SparePart sparePartDetail(SparePart sparePart) {
		return sqlSession.selectOne("sparePart.sparePartDetail",sparePart);
	}
	
	@Override
	 public void sparePartInsertSave(SparePart sparePart) {
		 sqlSession.insert("sparePart.sparePartInsertSave", sparePart);
	 }
	
	@Override
	 public void sparePartUpdateSave(SparePart sparePart) {
		 sqlSession.update("sparePart.sparePartUpdateSave", sparePart);
	 }
	
	@Override
	 public void sparePartDelete(String spp_idx) {
		 sqlSession.delete("sparePart.sparePartDelete", spp_idx);
	 }
	
	
	
	
	
	@Override
	 public List<Bega> getBegaInsertList(Bega bega) {
		 return sqlSession.selectList("bega.getBegaInsertList", bega);
	 }
	
	//비가동등록 더블클릭 조회
	@Override
	public Bega begaInsertDetail(Bega bega) {
		return sqlSession.selectOne("bega.begaInsertDetail",bega);
	}
	
	@Override
	 public void begaInsertSave(Bega bega) {
		 sqlSession.insert("bega.begaInsertSave", bega);
	 }
	
	@Override
	 public void begaUpdateSave(Bega bega) {
		 sqlSession.update("bega.begaUpdateSave", bega);
	 }
	
	@Override
	 public void begaDelete(String fstp_code) {
		 sqlSession.delete("bega.begaDelete", fstp_code);
	 }
	
	
	
	
	@Override
	 public List<Suri> getSuriHistoryList(Suri suri) {
		 return sqlSession.selectList("suri.getSuriHistoryList", suri);
	 }
	
	@Override
	public Suri suriHistoryDetail(Suri suri) {
		return sqlSession.selectOne("suri.suriHistoryDetail",suri);
	}
	
	@Override
	 public void suriHistoryInsertSave(Suri suri) {
		 sqlSession.insert("suri.suriHistoryInsertSave", suri);
	 }
	
	@Override
	 public void suriHistoryUpdateSave(Suri suri) {
		 sqlSession.update("suri.suriHistoryUpdateSave", suri);
	 }
	
	@Override
	 public void suriHistoryDelete(String ffx_no) {
		 sqlSession.delete("suri.suriHistoryDelete", ffx_no);
	 }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
