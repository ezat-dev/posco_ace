package com.posco.async;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import com.posco.service.PatternService;


public class PatternProcessor {

	@Autowired
	private PatternService patternService;
   
   //1초주기로 OPC UA 커넥션이 null일경우 연결
   @Scheduled(fixedRate = 5000)
   public void handle() {
	   //패턴시작
	   patternService.patternProcStart();
	   
	   //패턴종료
	   patternService.patternProcEnd();
   }
}