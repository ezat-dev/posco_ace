package com.posco.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.posco.dao.PatternDao;
import com.posco.domain.Pattern;
import com.posco.util.OpcDataMap;

@Service
public class PatternServiceImpl implements PatternService {

	@Autowired
	private PatternDao patternDao;
	
	private final Logger logger = LoggerFactory.getLogger(PatternServiceImpl.class);
	
	@Override
	public void patternProcStart() {
		//패턴시작신호 1인지 체크
		
		OpcDataMap opc = new OpcDataMap();
		short setValue = 1;
		short resetValue = 0;
		
		try {
			//오토닉스 태그 지정 후 변경
			Map<String, Object> patternStartMap = opc.getOpcData("ace_posco.OVERVIEW.pattern-start");			
			short patternStart = Short.parseShort(patternStartMap.get("value").toString());
			
//			short patternStart = 0;
			
			if(patternStart != 1) {
				return;
			}else {
				//패턴시작신호 확인 완료
				
				//진행중인 패턴번호
				Map<String, Object> patternNumberMap = opc.getOpcData("ace_posco.OVERVIEW.analog-pattern-status");
				int patternNumber = Integer.parseInt(patternNumberMap.get("value").toString());
				
				if(patternNumber != 0) {
					//DB 패턴진행정보 저장 확인 (패턴번호 있으면서 시작시간 있으면서 종료시간 null)
					List<Pattern> patternDataList = patternDao.patternDataList();
					logger.info("패턴운전-패턴시작 : {}","[패턴운전시작-1] - 패턴시작신호 : "+patternStart+"// 진행 패턴번호 : "+patternNumber);
					int listSize = patternDataList.size();
					Pattern p = new Pattern();
					p.setProc_ptrn_no(patternNumber);
					
					if(listSize == 0) {
						//DB에 패턴번호로 데이터 추가						
						patternDao.patternStartDataSave(p);
						logger.info("패턴운전-패턴시작 : {}","[패턴DB추가-2] - 패턴시작신호 : "+patternStart+"// 진행 패턴번호 : "+patternNumber+"// 패턴리스트 수 : "+listSize);
						
						
						while(patternStart == 1) {
							patternStartMap = opc.getOpcData("ace_posco.OVERVIEW.pattern-start");
							patternStart = Short.parseShort(patternStartMap.get("value").toString());
							
							opc.setOpcData("ace_posco.OVERVIEW.pattern-start", resetValue);
							logger.info("패턴운전-패턴시작 : {}","[패턴시작신호리셋-3] - 패턴시작신호 : "+patternStart+"// 진행 패턴번호 : "+patternNumber+"// 패턴리스트 수 : "+listSize);
							Thread.sleep(200);
						}

					}else if(listSize == 1) {
						//DB 패턴진행정보의 카운트가 1보다 크다면 (이전에 정상적으로 종료되지 않은게 남아있음)
						//로그처리 후 강제 업데이트(비고 추가)
						for(int i=0; i<listSize; i++) {
							p.setProc_comment("패턴 미종료 - 강제 업데이트");
							p.setProc_ptrn_start(patternDataList.get(i).getProc_ptrn_start());
							patternDao.patternStartDataForceUpdate(p);
							logger.info("패턴운전-패턴시작 : {}","[패턴미종료(강제업데이트)-4] - 패턴시작신호 : "+patternStart+"// 진행 패턴번호 : "+patternNumber+"// 패턴리스트 수 : "+listSize);
						}						
					}else {
						logger.info("패턴운전-패턴시작 : {}","[패턴리스트오류-99] - 패턴시작신호 : "+patternStart+"// 패턴리스트 수 : "+listSize);
					}
					
					
				}else {
					//패턴시작신호는 있지만 패턴번호가 0일경우
					logger.info("패턴운전-패턴시작 : {}","[패턴번호오류-99] - 패턴시작신호 : "+patternStart+"// 진행 패턴번호 : "+patternNumber);
					return;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void patternProcEnd() {
		OpcDataMap opc = new OpcDataMap();
		short setValue = 1;
		short resetValue = 0;
		
		try {
			
			Map<String, Object> patternEndMap = opc.getOpcData("ace_posco.OVERVIEW.pattern-end");			
			short patternEnd = Short.parseShort(patternEndMap.get("value").toString());
			
			if(patternEnd != 1) {
				return;
			}else {
				//진행중인 패턴번호
				Map<String, Object> patternNumberMap = opc.getOpcData("ace_posco.OVERVIEW.analog-pattern-status");
				int patternNumber = Integer.parseInt(patternNumberMap.get("value").toString());

				Pattern p = new Pattern();
				p.setProc_ptrn_no(patternNumber);
				//시작은 NOT NULL, 종료는 NULL
				List<Pattern> patternEndDataList = patternDao.patternEndDataList(p);
				
				int listSize = patternEndDataList.size();
				logger.info("패턴운전-패턴종료 : {}","[패턴DB조회-1] - 패턴종료신호 : "+patternEnd+"// 진행 패턴번호 : "+patternNumber+"// 패턴리스트 수 : "+listSize);
				
				if(listSize == 0) {
					while(patternEnd == 1) {
						patternEndMap = opc.getOpcData("ace_posco.OVERVIEW.pattern-end");
						patternEnd = Short.parseShort(patternEndMap.get("value").toString());
						
						logger.info("패턴운전-패턴종료 : {}","[패턴종료신호리셋-3] - 패턴종료신호 : "+patternEnd+"// 진행 패턴번호 : "+patternNumber+"// 패턴리스트 수 : "+listSize);
						
						opc.setOpcData("ace_posco.OVERVIEW.pattern-end", resetValue);
						Thread.sleep(200);
					}
				}else {
					for(int i=0; i<listSize; i++) {
						int log_ptrn_no = patternEndDataList.get(i).getProc_ptrn_no();
						String log_ptrn_start = patternEndDataList.get(i).getProc_ptrn_start();
						p.setProc_ptrn_start(patternEndDataList.get(i).getProc_ptrn_start());
						
						logger.info("패턴운전-패턴종료 : {}","[패턴DB조회-2] - 패턴종료신호 : "+patternEnd+"// 진행 패턴번호 : "+log_ptrn_no+"// 패턴진행시간 : "+log_ptrn_start+"// 패턴리스트 수 : "+listSize);
						patternDao.patternEndDataUpdate(p);
					}
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	

}
