package com.mibogear.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mibogear.dao.MachineSpareDAO;
import com.mibogear.domain.MachineSpare;

@Service
public class MachineSpareServiceImpl implements MachineSpareService{

	@Autowired
	private MachineSpareDAO machineSpareDAO;

	//스페어 조회
	@Override
	public List<MachineSpare> getMachineSpareList(MachineSpare machineSpare) {
		  return machineSpareDAO.getMachineSpareList(machineSpare);
	}

	//스페어 생성
	@Override
	public boolean insertMachineSpare(MachineSpare machineSpare) {
		return machineSpareDAO.insertMachineSpare(machineSpare);
	}
	
	//스페어 수정
	@Override
	public boolean updateMachineSpare(MachineSpare machineSpare) {
		return machineSpareDAO.updateMachineSpare(machineSpare);
	}
	
	//스페어 삭제
	@Override
	public boolean deleteMachineSpare(MachineSpare machineSpare) {
		return machineSpareDAO.deleteMachineSpare(machineSpare);
	}

	
}
