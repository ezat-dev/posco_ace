package com.mibogear.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.mibogear.domain.MachineSpare;

@Repository
public interface MachineSpareDAO {
	
	//스페어 정보 조회
	List<MachineSpare> getMachineSpareList(MachineSpare machineSpare);
	
	//스페어 생성
	boolean insertMachineSpare(MachineSpare machineSpare);
	
	//스페어 수정
	boolean updateMachineSpare(MachineSpare machineSpare);
	
	//스페어 삭제
	boolean deleteMachineSpare(MachineSpare machineSpare);

}
