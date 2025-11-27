package com.mibogear.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.mibogear.domain.MachineSpare;



@Repository
public class MachineSpareDAOImpl implements MachineSpareDAO{
	
	@Resource(name="session")
    private SqlSession sqlSession;

	//스페어 조회
	@Override
	public List<MachineSpare> getMachineSpareList(MachineSpare machineSpare) {
		  return sqlSession.selectList("machineSpare.getMachineSpareList", machineSpare);
	}

	//스페어 생성
	@Override
	public boolean insertMachineSpare(MachineSpare machineSpare) {
		int result =  sqlSession.insert("machineSpare.insertMachineSpare", machineSpare);
		if(result <= 0) {
			return false;
		}
		return true;
	}
	
	//스페어 수정
	@Override
	public boolean updateMachineSpare(MachineSpare machineSpare) {
		int result =  sqlSession.update("machineSpare.updateMachineSpare", machineSpare);
		if(result <= 0) {
			return false;
		}
		return true;
	}

	//스페어 삭제
	@Override
	public boolean deleteMachineSpare(MachineSpare machineSpare) {
		int result =  sqlSession.delete("machineSpare.deleteMachineSpare", machineSpare);
		if(result <= 0) {
			return false;
		}
		return true;
	}



}
