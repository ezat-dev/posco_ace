<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>오버뷰</title>
    <link rel="stylesheet" href="/posco/css/login/style.css">
     <link rel="stylesheet" href="/posco/css/tabBar/tabBar.css">
     <link rel="stylesheet" href="/posco/css/overview/style.css">
    
<%@include file="../include/pluginpage.jsp" %>     
    
    <style>
    
    
    	 body {overflow:hidden}
			/* 📑 탭 스타일 */
	
.box14,.auto-run-off-box,.auto-run-on-box,.auto-value,
.set-vacuum,.set-heat,.set-cool-switch-1,.set-cool-switch-2,.set-cool-switch-3,.set-cool-switch-4
,.analog-vacuum-pv-1,.analog-hivacuum-pv-1,.analog-heat-pv-1,.analog-vacuum-pv-2,.analog-hivacuum-pv-2
,.analog-heat-pv-2,.analog-timer-sv,.analog-timer-pv,.box12,.box10,.box13,.box17,.ok-auto,.box20,.set-lowVacuum,.box22,
.analog-lowvacuum-pv-1,.analog-lowvacuum-pv-2,.analog-pg{
	 display: flex;
    justify-content: center;
    align-items: center;
    font-weight: bold;
    text-align: center;
}
.vacuum-heat,.luffing-pump,
 .booster-pump,
 .diff-pump,
 .cold-pen,
 .luffing-valve,
 .vacuum-valve,
 .fourline-valve,
 .gas-valve,
 .vantil-pen,
 .water-cool-switch-1,
 .water-cool-switch-2,
 .water-cool-switch-3,
 .water-cool-switch-4{
	 display: flex;
    justify-content: center;
    align-items: center;
    font-weight: bold;
    text-align: center;
    color: white;
}
	
	/* 모든 클릭 가능한 오버뷰 요소 기본 스타일 */
.vacuum-heat,
 .box14,.box13,.box12,.box17,.auto-run-off-box,.auto-run-on-box,
 .luffing-pump,
 .booster-pump,
 .diff-pump,
 .cold-pen,
 .luffing-valve,
 .vacuum-valve,
 .fourline-valve,
 .gas-valve,
 .vantil-pen{
    cursor: pointer;      /* 마우스 포인터 손가락 모양 */
    transition: transform 0.1s, filter 0.1s; /* 부드러운 효과 */
}

/* 마우스 오버 시 */
.vacuum-heat:hover, 
.luffing-pump:hover,
.booster-pump:hover,
 .diff-pump:hover,
 .cold-pen:hover,
 .luffing-valve:hover,
 .vacuum-valve:hover,
 .fourline-valve:hover,
 .gas-valve:hover,
 .vantil-pen:hover {
    filter: brightness(1.2);   /* 밝게 */
    transform: scale(1.05);    /* 살짝 확대 */
}
.box14:hover,
.box13:hover,
.box12:hover,
.box17:hover,
.box22:hover,
.auto-run-off-box:hover,.auto-run-on-box:hover,
.bell-alarm-reset:hover,
 .bell-alarm-stop:hover,
 .bell-alarm-test:hover{
	filter: brightness(1.2);
	border: 1px solid red;
}
}

/* 클릭 시 (마우스 다운) */
.vacuum-heat:active, 
.box14:active, 
.luffing-pump:active,
.booster-pump:active,
 .diff-pump:active,
 .cold-pen:active,
 .luffing-valve:active,
 .vacuum-valve:active,
 .fourline-valve:active,
 .gas-valve:active,
 .auto-run-off-box:active,.auto-run-on-box:active,
 .bell-alarm-reset:active,
 .bell-alarm-stop:active,
 .bell-alarm-test:active,
 .vantil-pen:active {
    filter: brightness(0.8);   /* 어둡게 */
    transform: scale(0.95);    /* 살짝 줄어듦 */
}

h1{
	margin-left: 300px;
    margin-top: 1px;
}



	
.pen-rotate {
    animation: rotate 2s linear infinite;
}

@keyframes rotate {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
}



	
.hidden {
    display: none !important;
}	
	
	
	
	
.area-alarm {
    width: 379px;
    height: 87px;
    position: absolute;
    left: 1299px;
    top: 749px;

    background: #ffffff;
    border: 1px solid #d0d3d8;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.07);

    display: flex;
    flex-direction: column;
    overflow: hidden;
}

.alarm-title {
    background: #0b63ce;
    color: white;
    font-size: 15px;
    font-weight: bold;
    padding: 10px;
    text-align: center;
}

.alarm-list-wrapper {
    flex: 1;
    overflow-y: auto;
    padding: 4px 6px;
}

#overviewAlarmTable {
    width: 100%;
    border-collapse: collapse;
    font-size: 12px;
}

#overviewAlarmTable thead {
    background: #f3f6fb;
    position: sticky;
    top: 0;
}

#overviewAlarmTable th {
    padding: 6px 4px;
    border-bottom: 1px solid #e0e6ef;
    text-align: center;
    font-size: 12px;
    font-weight: bold;
}

#overviewAlarmTable td {
    padding: 6px 4px;
    border-bottom: 1px solid #f1f1f1;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

#overviewAlarmTable tbody tr:hover {
    background: #f0f8ff;
}

#overviewAlarmTable .active-alarm {
    background: rgba(255, 0, 0, 0.08);
    color: #d30000;
    font-weight: bold;
}






.area-trend {
    width: 720px;
    height: 330px;
    position: absolute;
    left: 950px;
    top: 10px;
    background: #ffffff;
    border-radius: 10px;
    border: 1px solid #d0d3d8;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.07);

    display: flex;
    flex-direction: column;
    overflow: hidden;
}
.trend-title {
    background: #0b63ce;
    color: white;
    font-size: 15px;
    font-weight: bold;
    padding: 10px;
    text-align: center;
}




/* 안전한 별도 네임스페이스 */
.st-table-wrap {
    position: absolute;
    left: 30px;
    top: 10px;
}

.st-table {
    border-collapse: collapse;
    width: 820px;
}

.st-table th {
    background: #f3f6fb;
    border: 1px solid #d0d3d8;
    text-align: center;
    font-size: 13px;
    font-weight: bold;
    color: #0b63ce;
    height: 25px;
}

.st-table td {
    border: 1px solid #d0d3d8;
    height: 35px;
    text-align: center;
    font-size: 15px;
    font-weight: bold;
    color: #333;
    height: 28px;
}



.seg-table-wrap {
    position: absolute;
    left: 30px;
    top: 73px;
}

.seg-table {
    border-collapse: collapse;
    width: 820px;
}

.seg-table th {
    background: #f3f6fb;
    border: 1px solid #d0d3d8;
    text-align: center;
    font-size: 13px;
    font-weight: bold;
    color: #0b63ce;
    height: 25px;
}

.seg-table td {
    border: 1px solid #d0d3d8;
    height: 35px;
    text-align: center;
    font-size: 15px;
    font-weight: bold;
    color: #333;
    height: 28px;
}


	
	
	
	
.arrow-pipe {
  width: 25px;
  height: 75px;
  position: absolute;
  left: 614px;
  top: 508px;
  clip-path: polygon(
    50% 0%,
    100% 35%,
    70% 35%,
    70% 100%,
    30% 100%,
    30% 35%,
    0% 35%
  );
  background: #00ff00;
}

.arrow-pipe span {
  position: absolute;
  left: 50%;
  width: 4px;
  height: 8px;
  background: #01B3FF;
  border-radius: 2px;
  transform: translateX(-50%);
  animation: particleDown 1s linear infinite;
}

.arrow-pipe span:nth-child(1) { animation-delay: 0s; }
.arrow-pipe span:nth-child(2) { animation-delay: .3s; }
.arrow-pipe span:nth-child(3) { animation-delay: .6s; }

@keyframes particleDown {
  from { top: -10px; opacity: 0; }
  10%  { opacity: 1; }
  to   { top: 80px; opacity: 0; }
}





/* 테두리 점멸 효과 */
.btn.active-on {
    border: 5px solid #00ff00;
    animation: blink-border-green 1s infinite;
}

@keyframes blink-border-green {
    0%, 100% {
        border-color: rgba(0, 255, 0, 1);
    }
    50% {
        border-color: rgba(0, 255, 0, 0.2);
    }
}

.pg-on {
    color: #ff0000;
    
}

    </style>
    
    
    <body>
    
  <!-- <div class="arrow-pipe">
  <span></span>
  <span></span>
  <span></span>
</div> -->
 <div class="st-table-wrap">
    <table class="st-table">
        <tr>
        	<th>운전 패턴번호</th>
            <th>진행 세그먼트</th>
            <th>세그먼트 남은시간(분)</th>
            <th>1존온도 PV</th>
            <th>2존온도 PV</th>
            <th>3존온도 PV</th>
            <th>온도SP</th>
            <th>온도TSP</th>
        </tr>
        <tr>
        	<td class="analog-pattern-status"></td>
            <td class="analog-seg-status"></td>
            <td class="analog-seg-time"></td>
            <td class="analog-vac1_pv"></td>
            <td class="analog-vac2_pv"></td>
            <td class="analog-vac3_pv"></td>   
            <td class="analog-tem_sp"></td>  
            <td class="analog-tem_sp"></td>       
        </tr>        
    </table>
</div>

  
   <div class="seg-table-wrap">
    <table class="seg-table">
        <tr>
            <th>온도분포 1</th>
            <th>온도분포 2</th>
            <th>온도분포 3</th>
            <th>온도분포 4</th>
            <th>온도분포 5</th>
            <th>온도분포 6</th>
            <th>온도분포 7</th>
            <th>온도분포 8</th>
            <th>온도분포 9</th>
        </tr>
        <tr>
            <td class="analog-tem_1"></td>
            <td class="analog-tem_2"></td>
            <td class="analog-tem_3"></td>
            <td class="analog-tem_4"></td>
            <td class="analog-tem_5"></td>
            <td class="analog-tem_6"></td>
            <td class="analog-tem_7"></td>
            <td class="analog-tem_8"></td>
            <td class="analog-tem_9"></td>
        </tr>      
    </table>
</div>
  
  
  
  
  
  <!-- 운전모드 확인 -->
  <div id="runStatus" style="position:absolute; left:35px; top:150px; font-size:18px; font-weight:bold; color:#003366;"> 운전 모드:</div>
  <div class="lamp-bit1-auto-run" style="position:absolute; left:120px; top:150px; font-size:18px; font-weight:bold; color:#003366;"></div>
  <div class="lamp-bit2-manual-run" style="position:absolute; left:120px; top:150px; font-size:18px; font-weight:bold; color:#003366;"></div>
  
  <!-- 운전상태 확인 -->
  <div id="onStatus" style="position:absolute; left:35px; top:180px; font-size:18px; font-weight:bold; color:#003366;"> 운전 상태:</div>
  <div class="lamp-bit3-wait-ok" style="position:absolute; left:120px; top:180px; font-size:18px; font-weight:bold; color:#003366;"></div>
  <div class="lamp-bit4-wait-no" style="position:absolute; left:120px; top:180px; font-size:18px; font-weight:bold; color:#003366;"></div>
  <div class="lamp-bit5-vacuum" style="position:absolute; left:120px; top:180px; font-size:18px; font-weight:bold; color:#003366;"></div>
  <div class="lamp-bit6-heat" style="position:absolute; left:120px; top:180px; font-size:18px; font-weight:bold; color:#003366;"></div>
  <div class="lamp-bit7-cool" style="position:absolute; left:120px; top:180px; font-size:18px; font-weight:bold; color:#003366;"></div>
  <div class="lamp-bit8-end" style="position:absolute; left:120px; top:180px; font-size:18px; font-weight:bold; color:#003366;"></div>
  <div class="lamp-bit9-done" style="position:absolute; left:120px; top:180px; font-size:18px; font-weight:bold; color:#003366;"></div>
  
  
  
  
  <div class="line-1"></div>
  <div class="line-2"></div>
  <div class="line-3"></div>
  <div class="line-4"></div>
  <div class="line-5"></div>
  <div class="water-cool-switch-1">냉각수 유량 1</div>
  <div class="water-cool-switch-2">냉각수 유량 2</div>
  <div class="water-cool-switch-3">냉각수 유량 3</div>
  <div class="water-cool-switch-4">냉각수 유량 4</div>
  
  
  <img class="btn vantil" src="/posco/image/overview/vantil1.png" />
  <div class="btn vantil-pen" data-tag="vantil-pen">배기 펜</div>  
  <div class="btn vacuum-heat" data-tag="vacuum-heat">진공로 히터</div>
  <div class="btn vacuum-valve" data-tag="vacuum-valve">고진공 밸브</div>
  <div class="btn cold-pen" data-tag="cold-pen">냉각 펜</div>
  <div class="btn luffing-pump" data-tag="luffing-pump">저진공 펌프</div>
  <div class="diff-pump" data-tag="diff-pump">고진공 펌프</div>
  <div class="btn booster-pump" data-tag="booster-pump">저진공 보조 펌프</div>
  <div class="btn fourline-valve" data-tag="fourline-valve">포라인 밸브</div>
  <div class="btn luffing-valve" data-tag="luffing-valve">저진공 밸브</div>
  <div class="btn gas-valve" data-tag="gas-valve">질소 가스 밸브</div>
  
  <img class="mainIMG" src="/posco/image/overview/poscoMain.png" />
  
  <div class="nomal-heat">HEATPOWER<br>OFF</div>
  <div class="heatpower-red">HEATPOWER<br>ON</div>

  
  
  
  <!-- <div class="footer"></div>
  <div class="rectangle-91"></div>
  <div class="rectangle-92"></div>
  <div class="rectangle-93"></div>
  <div class="rectangle-94"></div>
  <div class="rectangle-95"></div>
  <div class="rectangle-96"></div>
  <div class="rectangle-97"></div>
  <div class="rectangle-98"></div>
  <div class="rectangle-99"></div>
  <div class="rectangle-100"></div>
  <div class="rectangle-101"></div>
  <div class="rectangle-102"></div>
  <div class="rectangle-103"></div> -->
  <!-- <img class="object" src="/posco/image/overview/object0.png" />
  <img class="object2" src="/posco/image/overview/object1.png" />
  <img class="object3" src="/posco/image/overview/object2.png" />
  <img class="object4" src="/posco/image/overview/object3.png" />
  <img class="object5" src="/posco/image/overview/object4.png" />
  <img class="object6" src="/posco/image/overview/object5.png" />
  <img class="object7" src="/posco/image/overview/object6.png" />
  <img class="object8" src="/posco/image/overview/object7.png" />
  <img class="object9" src="/posco/image/overview/object8.png" />
  <img class="object10" src="/posco/image/overview/object9.png" />
  <img class="object11" src="/posco/image/overview/object10.png" /> -->
  
  <!-- <img class="object12" src="/posco/image/overview/object11.png" />
  <img class="object13" src="/posco/image/overview/object12.png" />
  <img class="object14" src="/posco/image/overview/object13.png" />
  <img class="object15" src="/posco/image/overview/object14.png" />
  <img class="object16" src="/posco/image/overview/object15.png" />
  <img class="object17" src="/posco/image/overview/object16.png" />
  <img class="object18" src="/posco/image/overview/object17.png" />
  <img class="object19" src="/posco/image/overview/object18.png" />
  <img class="object20" src="/posco/image/overview/object19.png" /> -->
  <img class="object21" src="/posco/image/overview/object20.png" />
  <img class="object22" src="/posco/image/overview/object21.png" />
  <!-- <img class="object23" src="/posco/image/overview/object22.png" /> -->
  <img class="object24" src="/posco/image/overview/object23.png" />
  <img class="object25" src="/posco/image/overview/object24.png" />
  <!-- <img class="object26" src="/posco/image/overview/object25.png" /> -->
  <!-- <img class="object27" src="/posco/image/overview/object26.png" />
  <img class="object28" src="/posco/image/overview/object27.png" />
  <img class="object29" src="/posco/image/overview/object28.png" />
  <img class="object30" src="/posco/image/overview/object29.png" />
  <img class="object31" src="/posco/image/overview/object30.png" />
  <img class="object32" src="/posco/image/overview/object31.png" />
  <img class="object33" src="/posco/image/overview/object32.png" />
  <img class="object34" src="/posco/image/overview/object33.png" /> -->
  
  <div class="lamp-text-diff-pump-on">OFF</div>
  <!-- <div class="diff-pump-off">OFF</div> -->
  
  <!-- <div class="lamp-text-luffing-valve-off">닫힘</div> -->
  <div class="lamp-text-luffing-valve-on">닫힘</div>
  <div class="green-luffing-valve"></div>
  <!-- <div class="lamp-text-vacuum-valve-off">닫힘</div> -->
  <div class="lamp-text-vacuum-valve-on">닫힘</div>
  <div class="green-vacuum-valve"></div>
  <!-- <div class="lamp-text-fourline-valve-off">닫힘</div> -->
  <div class="lamp-text-fourline-valve-on">닫힘</div>
  <div class="green-fourline-valve"></div>
  <!-- <div class="lamp-text-gas-valve-off">닫힘</div> -->
  <div class="lamp-text-gas-valve-on">닫힘</div>
 	
  <div class="green-gas-valve"></div>
  <!-- <div class="ellipse-1"></div> -->
  <img class="pen-4" src="/posco/image/overview/pen-40.png" />
  <!-- <div class="ellipse-2"></div> -->
  <img class="pen-3" src="/posco/image/overview/pen-30.png" />
  <div class="ellipse-3"></div>
  <img class="pen-2" src="/posco/image/overview/pen-20.png" />
  <div class="ellipse-4"></div>
  <img class="pen-1" src="/posco/image/overview/pen-10.png" />
  <div class="ellipse-5"></div>
  <img class="pen-5" src="/posco/image/overview/pen-10.png" />
  <div class="box"></div>
  <div class="box2"></div>
  <div class="box3"></div>
  <div class="box4"></div>
  <div class="box5"></div>
  <div class="box6"></div>
  <div class="box7"></div>
  
  <div class="time-zone-2"></div>
  <div class="bell-box"></div>
  <div class="bell-alarm-stop">
  <img class="icon-stop" src="/posco/image/overview/alarm_stop.png" /><div class="alarm-stop-text">알람정지</div></div>
  <div class="bell-alarm-reset">
  <img class="icon-reset" src="/posco/image/overview/alarm_reset.png" /><div class="alarm-stop-text">알람리셋</div></div>
  <div class="bell-alarm-test">
  <img class="icon-test" src="/posco/image/overview/alarm_test.png" /><div class="alarm-stop-text">알람테스트</div></div>
  <div class="logo-zone"></div>
  
  <div class="box8"></div>
  <div class="box9"></div>
  <div class="box10"></div>
  <div class="box11"></div>
  <div class="box12">히팅 SP</div>
  <div class="box13">고진공 SP</div>
  <div class="box14">운전 선택</div>
  <div class="auto-run-off-box">자동운전 정지</div>
  <div class="auto-run-on-box">자동운전 시작</div>
  <div class="set-vacuum">OFF</div>
  <div class="set-heat">OFF</div>
  <!-- <div class="set-low-vacuum"></div> -->
  
  <div class="box20">저진공 도달</div>
  <div class="box21"></div>
  <div class="set-lowVacuum">OFF</div>
  
  <div class="box22">저진공 SP</div>
  <div class="box23"></div>
  <!-- <div class="box24"></div> -->
  
  
  <!-- <div class="bx"></div> -->
  <div class="box15"></div>
  
  <div class="box17">설정치</div>
 <!--  <div class="box16"></div>
  <div class="box18"></div> -->
  <div class="box19"></div>
  <div class="analog-vacuum-pv-1"></div>
  <div class="analog-hivacuum-pv-1"></div>
  <div class="analog-heat-pv-1"></div>
  <div class="analog-vacuum-pv-2"></div>
  <div class="analog-hivacuum-pv-2"></div>
  <div class="analog-heat-pv-2"></div>
  <div class="analog-timer-sv"></div>
  <div class="analog-pg" data-tag="analog-pg"></div>
  <div class="text-pg">kPa</div>
  <!-- <div class="analog-timer-pv"></div> -->
  <!-- <div class="ok-auto"></div> -->
  <div class="analog-lowvacuum-pv-1"></div>
  <div class="analog-lowvacuum-pv-2"></div>
  
  <!-- <div class="text">냉각수 유량스위치-1</div>
  <div class="text2">냉각수 유량스위치-2</div>
  <div class="text3">냉각수 유량스위치-3</div>
  <div class="text4">냉각수 유량스위치-4</div> -->
  <div class="text5">Torr</div>
  <div class="text6">Torr</div>
  <div class="text7">Torr</div>
  <div class="text19">Torr</div>
  <div class="text8">고진공 도달</div>
  <div class="text9">히팅 도달</div>
  <div class="text10">양압계</div>
  <div class="text11">진공도</div>
  <!-- <div class="text12">고진공-SET</div>
  <div class="text13">히팅-SET</div> -->
  <div class="text14">냉각완료온도</div>
  <div class="text16">℃</div>
  <!-- <div class="text17">분</div>
  <div class="text18">현재치</div> -->
  <div class="div">E</div>
  <div class="div2">E</div>
  <div class="div3">E</div>
  <div class="div4">E</div>






	<!-- 알람  영역 -->
	<div class="area-alarm">
    <!-- <div class="alarm-title">알람 내역</div> -->

    <div class="alarm-list-wrapper">
        <table id="overviewAlarmTable">
            <!-- <thead>
                <tr>
                    <th>No</th>
                    <th>내용</th>
                    <th>발생</th>
                    <th>해제</th>
                </tr>
            </thead> -->
            <tbody></tbody>
        </table>
    </div>
</div>
	
	
  


	    
	    
<script>


$(document).ready(function () {

	//진공로히터
    $(".vacuum-heat").on("click", function () {
        openPopup("/posco/popup/vacuumHeat", 350, 140);
    });

	//자동운전선택
    $(".box14").on("click", function () {
        openPopup("/posco/popup/autoRun", 420, 220);
    });

	//러핑펌프
    $(".luffing-pump").on("click", function () {
        openPopup("/posco/popup/luffingPump", 350, 140);
    });

    //부스터펌프
    $(".booster-pump").on("click", function () {
        openPopup("/posco/popup/boosterPump", 350, 140);
    });
    
    //부스터펌프
    $(".diff-pump").on("click", function () {
        openPopup("/posco/popup/diffPump", 350, 140);
    });

  	//냉각팬
    $(".cold-pen").on("click", function () {
        openPopup("/posco/popup/coldPen", 350, 140);
    });

  	//냉각팬
    $(".vantil-pen").on("click", function () {
        openPopup("/posco/popup/vantilPen", 350, 140);
    });

  	//러핑밸브
    $(".luffing-valve").on("click", function () {
        openPopup("/posco/popup/luffingValve", 350, 140);
    });

  	//고진공밸브
    $(".vacuum-valve").on("click", function () {
        openPopup("/posco/popup/vacuumValve", 350, 140);
    });

  	//포라인밸브
    $(".fourline-valve").on("click", function () {
        openPopup("/posco/popup/fourlineValve", 350, 140);
    });

    //가스밸브
    $(".gas-valve").on("click", function () {
        openPopup("/posco/popup/gasValve", 350, 140);
    });

 	 //히팅SET
    $(".box12").on("click", function () {
        openPopup("/posco/popup/heatingSet", 460, 190);
    });

  	//고진공SET
    $(".box13").on("click", function () {
        openPopup("/posco/popup/vacuumSet", 460, 190);
    });

  	//저진공SET
    $(".box22").on("click", function () {
        openPopup("/posco/popup/lowVacuumSet", 460, 190);
    });

  	//냉각타이머 설정치
    $(".box17").on("click", function () {
        openPopup("/posco/popup/coolTimerSet", 460, 190);
    });

 	 //자동운전 정지
    $(".auto-run-off-box").on("click", function () {
        openPopup("/posco/popup/autoStop", 350, 140);
    });

    //자동운전 시작
    $(".auto-run-on-box").on("click", function () {
        openPopup("/posco/popup/autoStart", 350, 140);
    });
});



function openPopup(url, w, h) {
    // 화면 중앙 계산
    const left = (window.screen.width - w) / 2;
    const top = (window.screen.height - h) / 2;

    const options =
        "width=" + w +
        ",height=" + h +
        ",left=" + left +
        ",top=" + top +
        ",resizable=yes,scrollbars=yes";

    window.open(url, "_blank", options);
}







//OPC///////////////////////////////////////////////////////////////////////

function v(key, value){
    const els = document.getElementsByClassName(key);
    if(!els || els.length === 0){
        return;
    }

    Array.from(els).forEach(el => {
        if(value == true || value == 1){
            el.classList.remove("hidden");     // 보이기
        } else {
            el.classList.add("hidden");        // 숨기기
        }
    });
}


function c(key, value){
    const els = document.getElementsByClassName(key);
    if(!els || els.length === 0){
        //console.warn(`c: DOM element not found for key "${key}"`);
        return;
    }
    Array.from(els).forEach(el => el.classList.toggle("active-green", !!value));
}


//팬 애니메이션
function pen(key, value){
    const els = document.getElementsByClassName(key);
    if(!els || els.length === 0) return;

    Array.from(els).forEach(el => {
        if (value == 1) {
            el.classList.add("pen-rotate");
        } else {
            el.classList.remove("pen-rotate");
        }
    });
}


function setText(key, value){
    const els = document.getElementsByClassName(key);
    if(!els || els.length === 0) return;

    Array.from(els).forEach(el => {
        el.innerText = (value == 1 ? "ON" : "OFF");
    });
}



function ok(key, value){
    const els = document.getElementsByClassName(key);
    if(!els || els.length === 0) return;

    Array.from(els).forEach(el => {
        el.innerText = (value == 1 ? "자동운전 완료" : "자동운전 미완료");
    });
}


//초록램프
function green(key, value){
    const els = document.getElementsByClassName(key);
    if(!els || els.length === 0) return;

    Array.from(els).forEach(el => {
        if(value == 1){
            el.style.backgroundColor = "#00FF00"; // 초록
        } else {
            el.style.backgroundColor = "#ff0000"; // 기본 회색
        }
    });
}

function water(key, value){
    const els = document.getElementsByClassName(key);
    if(!els || els.length === 0) return;

    Array.from(els).forEach(el => {
        if(value == 1){
            el.style.backgroundColor = "#00FF00"; // 초록
        } else {
            el.style.backgroundColor = "#ff0000"; // 기본 회색
        }
    });
}


function vs(key, value){
    const els = document.getElementsByClassName(key);
    if(!els || els.length === 0){
        //console.warn(`vs: DOM element not found for key "${key}"`);
        return;
    }
    Array.from(els).forEach(el => el.classList.toggle("blinking", !!value));
}


function valueDisplay(key, val) {
    const els = document.getElementsByClassName(key);
    if (!els || els.length === 0) return;

    let displayValue = val;

    
    const decimalKeys = [
        "analog-vacuum-pv-1",
        "analog-heat-pv-1",
        "analog-hivacuum-pv-1",
        "analog-lowvacuum-pv-1"
    ];

    if (decimalKeys.includes(key) && !isNaN(val)) {
        displayValue = parseFloat(val).toFixed(1);
    }

    Array.from(els).forEach(el => {
        el.innerText = displayValue;
    });
}






function lamp(key, value){
    const els = document.getElementsByClassName(key);
    if(!els || els.length === 0) return;

    Array.from(els).forEach(el => {

        // 1) lamp-on-* 처리 (초록 / 회색 전환)
        if(key.includes("lamp-on")){
            // hidden 제거 (항상 표시)
            el.classList.remove("hidden");

            if(value){
                el.classList.add("active-lamp");   // 초록색
            } else {
                el.classList.remove("active-lamp"); // 회색(기본)
            }
        }

        // 2) lamp-text-* 처리 (열림/닫힘 텍스트 변경)
        else if(key.includes("lamp-text")){
            if(value){
                el.innerText = "열림";
            } else {
                el.innerText = "닫힘";
            }
        }
        else if(key.includes("lamp-bit1")){
            if(value){
                el.innerText = "자동운전 모드";
            } else {
                el.innerText = "";
            }
        }
        else if(key.includes("lamp-bit2")){
            if(value){
                el.innerText = "수동운전 모드";
            } else {
                el.innerText = "";
            }
        }
        else if(key.includes("lamp-bit3")){
            if(value){
                el.innerText = "운전대기-자동운전가능";
            } else {
                el.innerText = "";
            }
        }
        else if(key.includes("lamp-bit4")){
            if(value){
                el.innerText = "운전대기-자동운전불가";
            } else {
                el.innerText = "";
            }
        }
        else if(key.includes("lamp-bit5")){
            if(value){
                el.innerText = "진공 중";
            } else {
                el.innerText = "";
            }
        }
        else if(key.includes("lamp-bit6")){
            if(value){
                el.innerText = "히팅 중";
            } else {
                el.innerText = "";
            }
        }
        else if(key.includes("lamp-bit7")){
            if(value){
                el.innerText = "냉각 중";
            } else {
                el.innerText = "";
            }
        }
        else if(key.includes("lamp-bit8")){
            if(value){
                el.innerText = "종료 중";
            } else {
                el.innerText = "";
            }
        }
        else if(key.includes("lamp-bit9")){
            if(value){
                el.innerText = "운전완료";
            } else {
                el.innerText = "";
            }
        }
    });
}


// =====================
// OPC 값 조회
// =====================
function overviewListView() {
    $.ajax({
        url: "/posco/monitoring/view",
        type: "post",
        dataType: "json",
        success: function(result) {
            /* console.log("✅ Ajax 응답 전체:", result);  */

            const data = result.multiValues;
           /*  console.log("▶ multiValues:", data);  */

            for(const item of data){
                /* console.log("item:", item);  */
                for(const [tagName, tagData] of Object.entries(item)){
                    /* console.log("tagName:", tagName, "tagData:", tagData);  */
                    if(!tagName) continue;
                    const { action, value } = tagData;

                    switch(action){
	                    case "v":     v(tagName, value); break;
	                    case "c":     c(tagName, value); break;
	                    case "pen":   pen(tagName, value); break;
	                    case "lamp":  lamp(tagName, value); break;
	                    case "vs":    vs(tagName, value); break;
	                    case "value": valueDisplay(tagName, value); break;
	                    case "green": green(tagName, value); break;
	                    case "water": water(tagName, value); break;
	                    case "ok": ok(tagName, value); break;
	                    case "settext": setText(tagName, value); break;
                    }
                }
            }
        },
        error: function(err) {
            //console.error("❌ Ajax 요청 실패:", err);
        }
    });
}




function overviewListViewString() {
    $.ajax({
        url: "/posco/monitoring/view/string",
        type: "post",
        dataType: "json",
        success: function(result) {
            /* console.log("✅ Ajax 응답 전체:", result); */

            const data = result.multiValues;
            /* console.log("▶ 스트링:", data); */

            for (const item of data) {
                /* console.log("item:", item); */
                for (const [tagName, tagData] of Object.entries(item)) {
                    /* console.log("tagName:", tagName, "tagData:", tagData); */
                    if (!tagName) continue;

                    let { action, value } = tagData;

    

                    switch (action) {
                        case "value":
                            valueDisplay(tagName, value);
                            break;
                    }
                }
            }
        },
        error: function(err) {
            //console.error("❌ Ajax 요청 실패:", err);
        }
    });
}

$(function(){
    overviewListView();        // 첫 실행
    overviewListViewString();  // 첫 실행

    overviewInterval = setInterval(() => {
        overviewListView();
        overviewListViewString();
     
    }, 1000); // 1초마다 갱신

});
////////////////////////////////////////////////////////

function shortTime(t) {
    if (!t) return "";
    return t.substring(11, 19); // HH:mm:ss 부분만 추출
}

function loadOverviewAlarm() {
    $.ajax({
        url: "/posco/monitoring/alarmRecordListOver/list",
        type: "POST",
        data: {
            s_sdate: new Date().toISOString().slice(0, 10),
            s_edate: new Date().toISOString().slice(0, 10)
        },
        success: function(resp) {

            var arr = Array.isArray(resp) ? resp : (resp.data || []);

            
            var activeList = arr.filter(a => !a.a_etime);

            var $tbody = $("#overviewAlarmTable tbody").empty();

            if (activeList.length === 0) {
                $tbody.append("<tr><td colspan='4'>현재 알람 없음</td></tr>");
                return;
            }

            activeList.forEach(function(r, i){
                var tr = $("<tr></tr>");

                tr.append("<td>" + (i + 1) + "</td>");
                tr.append("<td style='text-align:left;'>" + (r.a_desc || "") + "</td>");
                tr.append("<td>" + shortTime(r.a_stime) + "</td>");
                /* tr.append("<td class='active-alarm'>진행중</td>"); */

                tr.addClass("active-alarm");

                $tbody.append(tr);
            });
        }
    });
}


setInterval(loadOverviewAlarm, 5000);
loadOverviewAlarm();


//=======================================
//OVERVIEW STOP/RESET (즉시 1 → 2초 후 0)
//=======================================

document
    .querySelectorAll('.icon-stop, .icon-reset, .icon-test')
    .forEach(icon => {

        icon.addEventListener('click', function () {

            let tagName = "";
            let alertMsg = "";

            if (this.classList.contains('icon-stop')) {
                tagName = "icon-stop";
                alertMsg = "알람 정지 완료";
            } else if (this.classList.contains('icon-reset')) {
                tagName = "icon-reset";
                alertMsg = "알람 리셋 완료";
            } else if (this.classList.contains('icon-test')) {
                tagName = "icon-test";
                alertMsg = "알람 테스트 완료";
            }

            if (!tagName) return;

            console.log("### OVERVIEW 버튼 클릭됨:", tagName);

            $.ajax({
                url: "/posco/monitoring/writeOverview",
                type: "post",
                data: {
                    tagName: tagName,
                    value: 1
                },
                success: function (res) {
                    console.log("### OVERVIEW write 성공:", res);
                    alert(alertMsg);   // 🔥 여기
                },
                error: function (err) {
                    console.error("### OVERVIEW write 실패:", err);
                    alert("PLC 통신 실패");
                }
            });
        });
    });





//==============================
//PLC Lamp 상태 폴링
//==============================
function pollLampStatus() {

//ON Lamp
//부스터펌프 오버뷰 램프 on
$.ajax({
 url: "/posco/monitoring/read/overviewLamp",
 type: "get",
 data: { tagName: "booster-pump-lamp-on" },
 success: function(res) {
     if (res.status === "OK") {
         const isOn = res.value === true;

         const onBtn = document.querySelector("[data-tag='booster-pump']");
         if (isOn) {
             onBtn.classList.add("active-on");
         } else {
             onBtn.classList.remove("active-on");
         }
     }
 }
});

//러핑펌프 오버뷰 램프 on
$.ajax({
	 url: "/posco/monitoring/read/overviewLamp",
	 type: "get",
	 data: { tagName: "luffing-pump-lamp-on" },
	 success: function(res) {
	     if (res.status === "OK") {
	         const isOn = res.value === true;

	         const onBtn = document.querySelector("[data-tag='luffing-pump']");
	         if (isOn) {
	             onBtn.classList.add("active-on");
	         } else {
	             onBtn.classList.remove("active-on");
	         }
	     }
	 }
	});

//확산펌프 오버뷰 램프 on
$.ajax({
	 url: "/posco/monitoring/read/overviewLamp",
	 type: "get",
	 data: { tagName: "diff-pump-lamp-on" },
	 success: function(res) {
	     if (res.status === "OK") {
	         const isOn = res.value === true;

	         const onBtn = document.querySelector("[data-tag='diff-pump']");
	         if (isOn) {
	             onBtn.classList.add("active-on");
	         } else {
	             onBtn.classList.remove("active-on");
	         }
	     }
	 }
	});

//진공메인 오버뷰 램프 on
$.ajax({
	 url: "/posco/monitoring/read/overviewLamp",
	 type: "get",
	 data: { tagName: "vacuum-heat-lamp-on" },
	 success: function(res) {
	     if (res.status === "OK") {
	         const isOn = res.value === true;

	         const onBtn = document.querySelector("[data-tag='vacuum-heat']");
	         if (isOn) {
	             onBtn.classList.add("active-on");
	         } else {
	             onBtn.classList.remove("active-on");
	         }
	     }
	 }
	});

//냉각펜 오버뷰 램프 on
$.ajax({
	 url: "/posco/monitoring/read/overviewLamp",
	 type: "get",
	 data: { tagName: "cool-pen-lamp-on" },
	 success: function(res) {
	     if (res.status === "OK") {
	         const isOn = res.value === true;

	         const onBtn = document.querySelector("[data-tag='cold-pen']");
	         if (isOn) {
	             onBtn.classList.add("active-on");
	         } else {
	             onBtn.classList.remove("active-on");
	         }
	     }
	 }
	});

//배기펜 오버뷰 램프 on
$.ajax({
	 url: "/posco/monitoring/read/overviewLamp",
	 type: "get",
	 data: { tagName: "vantil-pen-lamp-on" },
	 success: function(res) {
	     if (res.status === "OK") {
	         const isOn = res.value === true;

	         const onBtn = document.querySelector("[data-tag='vantil-pen']");
	         if (isOn) {
	             onBtn.classList.add("active-on");
	         } else {
	             onBtn.classList.remove("active-on");
	         }
	     }
	 }
	});

//러핑밸브 오버뷰 램프 on
$.ajax({
	 url: "/posco/monitoring/read/overviewLamp",
	 type: "get",
	 data: { tagName: "luffing-valve-lamp-on" },
	 success: function(res) {
	     if (res.status === "OK") {
	         const isOn = res.value === true;

	         const onBtn = document.querySelector("[data-tag='luffing-valve']");
	         if (isOn) {
	             onBtn.classList.add("active-on");
	         } else {
	             onBtn.classList.remove("active-on");
	         }
	     }
	 }
	});

//포라인밸브 오버뷰 램프 on
$.ajax({
	 url: "/posco/monitoring/read/overviewLamp",
	 type: "get",
	 data: { tagName: "fourline-valve-lamp-on" },
	 success: function(res) {
	     if (res.status === "OK") {
	         const isOn = res.value === true;

	         const onBtn = document.querySelector("[data-tag='fourline-valve']");
	         if (isOn) {
	             onBtn.classList.add("active-on");
	         } else {
	             onBtn.classList.remove("active-on");
	         }
	     }
	 }
	});

//고진공밸브 오버뷰 램프 on
$.ajax({
	 url: "/posco/monitoring/read/overviewLamp",
	 type: "get",
	 data: { tagName: "vacuum-valve-lamp-on" },
	 success: function(res) {
	     if (res.status === "OK") {
	         const isOn = res.value === true;

	         const onBtn = document.querySelector("[data-tag='vacuum-valve']");
	         if (isOn) {
	             onBtn.classList.add("active-on");
	         } else {
	             onBtn.classList.remove("active-on");
	         }
	     }
	 }
	});

//가스밸브 오버뷰 램프 on
$.ajax({
	 url: "/posco/monitoring/read/overviewLamp",
	 type: "get",
	 data: { tagName: "gas-valve-lamp-on" },
	 success: function(res) {
	     if (res.status === "OK") {
	         const isOn = res.value === true;

	         const onBtn = document.querySelector("[data-tag='gas-valve']");
	         if (isOn) {
	             onBtn.classList.add("active-on");
	         } else {
	             onBtn.classList.remove("active-on");
	         }
	     }
	 }
	});

//양압계 글자표시
$.ajax({
	 url: "/posco/monitoring/read/pgLamp",
	 type: "get",
	 data: { tagName: "lamp-pg" },
	 success: function(res) {
	     if (res.status === "OK") {
	         const isOn = res.value === true;

	         const onBtn = document.querySelector("[data-tag='analog-pg']");
	         if (isOn) {
	             onBtn.classList.add("pg-on");
	         } else {
	             onBtn.classList.remove("pg-on");
	         }
	     }
	 }
	});

}

//1초마다 PLC 상태 갱신
setInterval(pollLampStatus, 1000);

//첫 실행
pollLampStatus();

</script>

	</body>
</html>
