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
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
<%@include file="../include/pluginpage.jsp" %>     
    
    <style>
    	 body {overflow:hidden}
			/* 📑 탭 스타일 */
	
.box14,.auto-run-off-box,.auto-run-on-box,.auto-value,
.set-vacuum,.set-heat,.set-cool-switch-1,.set-cool-switch-2,.set-cool-switch-3,.set-cool-switch-4
,.analog-vacuum-pv-1,.analog-hivacuum-pv-1,.analog-heat-pv-1,.analog-vacuum-pv-2,.analog-hivacuum-pv-2
,.analog-heat-pv-2,.analog-timer-sv,.analog-timer-pv,.box12,.box13,.box17,.ok-auto{
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
 .gas-valve{
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
 .gas-valve{
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
 .gas-valve:hover {
    filter: brightness(1.2);   /* 밝게 */
    transform: scale(1.05);    /* 살짝 확대 */
}
.box14:hover,
.box13:hover,
.box12:hover,
.box17:hover,
.auto-run-off-box:hover,.auto-run-on-box:hover,
.bell-alarm-reset:hover,
 .bell-alarm-stop:hover{
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
 .bell-alarm-stop:active {
    filter: brightness(0.8);   /* 어둡게 */
    transform: scale(0.95);    /* 살짝 줄어듦 */
}

h1{
	margin-left: 300px;
    margin-top: 1px;
}



	
.pen-rotate {
    animation: rotate 6s linear infinite;
}

@keyframes rotate {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
}



	
.hidden {
    display: none !important;
}	
	
	
	
	
.area-alarm {
    width: 580px;
    height: 330px;
    position: absolute;
    left: 1090px;
    top: 370px;

    background: #ffffff;
    border-radius: 10px;
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
    left: 40px;
    top: 15px;
}

.st-table {
    border-collapse: collapse;
    width: 320px;
}

.st-table th {
    background: #f3f6fb;
    border: 1px solid #d0d3d8;
    text-align: center;
    font-size: 13px;
    font-weight: bold;
    color: #0b63ce;
}

.st-table td {
    border: 1px solid #d0d3d8;
    height: 30px;
    text-align: center;
    font-size: 15px;
    font-weight: bold;
    color: #333;
}


/* 온도분포 */
.tus-table-wrap {
    position: absolute;
    left: 390px;
    top: 15px;
}

.tus-table {
    border-collapse: collapse;
    width: 520px;
}

.tus-table th {
    background: #f3f6fb;
    border: 1px solid #d0d3d8;
    text-align: center;
    font-size: 13px;
    font-weight: bold;
    color: #0b63ce;
}

.tus-table td {
    border: 1px solid #d0d3d8;
    height: 30px;
    text-align: center;
    font-size: 15px;
    font-weight: bold;
    color: #333;
}









/* 오버뷰 전용 트렌드 스타일 (사이즈 축소) */
.ov-trend-wrap {
  position: absolute;
  left: 968px; /* 필요 시 오버뷰 위치에 맞게 조정 */
  top: 15px;
  width: 700px; /* 기존 요청 크기 */
  height: 340px;
  background: #fff;
  border-radius: 8px;
  border: 1px solid #e3e7ee;
  box-shadow: 0 4px 12px rgba(0,0,0,0.06);
  padding: 8px;
  box-sizing: border-box;
  z-index: 10;
  display: flex;
  flex-direction: column;
}

.ov-trend-header {
  display:flex;
  align-items:center;
  gap:8px;
  justify-content:space-between;
  margin-bottom:6px;
}

.ov-trend-title {
  font-weight:700;
  color:#0b63ce;
  font-size:14px;
}

.ov-trend-controls {
  display:flex;
  gap:6px;
  align-items:center;
}

.ov-trend-controls input[type="text"]{
  height:28px;
  padding:4px 6px;
  border-radius:4px;
  border:1px solid #ccc;
  font-size:13px;
  width:130px;
  box-sizing:border-box;
}

.ov-trend-controls .ov-btn {
  height:30px;
  padding:4px 10px;
  background:#0b63ce;
  color:#fff;
  border-radius:6px;
  border: none;
  cursor: pointer;
  font-weight:700;
  font-size:13px;
}

#ov-trend-container {
  flex:1;
  width:100%;
  min-height:180px;
  height: calc(100% - 44px);
}
	
    </style>
    
    
    <body>
    
  
  <div class="st-table-wrap">
    <table class="st-table">
        <tr>
            <th>ZONE PV 1</th>
            <th>ZONE PV 2</th>
            <th>ZONE PV 3</th>
        </tr>
        <tr>
            <td class="analog-vac1_pv"></td>
            <td class="analog-vac2_pv"></td>
            <td class="analog-vac3_pv"></td>            
        </tr>
        <tr>
            <th>PROTECTER PV</th>
            <th>SET POINT</th>
        </tr>
        <tr>
            <td class="analog-protec_pv"></td>
            <td class="analog-tem_sp"></td>
        </tr>        
    </table>
</div>

  
  <div class="tus-table-wrap"> <!-- 위치 조정 원하면 수정 -->
    <table class="tus-table">
        <tr>
            <th>온도분포 1</th>
            <th>온도분포 2</th>
            <th>온도분포 3</th>
            <th>온도분포 4</th>
            <th>온도분포 5</th>
            <th>온도분포 6</th>
        </tr>
        <tr>
            <td class="analog-tem_1"></td>
            <td class="analog-tem_2"></td>
            <td class="analog-tem_3"></td>
            <td class="analog-tem_4"></td>
            <td class="analog-tem_5"></td>
            <td class="analog-tem_6"></td>
        </tr>

        <tr>
            <th>온도분포 7</th>
            <th>온도분포 8</th>
            <th>온도분포 9</th>
            <th>온도분포 10</th>
            <th>온도분포 11</th>
            <th>온도분포 12</th>
        </tr>
        <tr>
            <td class="analog-tem_7"></td>
            <td class="analog-tem_8"></td>
            <td class="analog-tem_9"></td>
            <td class="analog-tem_10"></td>
            <td class="analog-tem_11"></td>
            <td class="analog-tem_12"></td>
        </tr>
    </table>
</div>
  
  
    
  <div class="vacuum-heat">진공로 히터</div>
  <div class="vacuum-valve">고진공 밸브</div>
  <div class="cold-pen">냉각 펜</div>
  <div class="luffing-pump">러핑 펌프</div>
  <div class="diff-pump">확산 펌프</div>
  <div class="booster-pump">부스터 펌프</div>
  <div class="fourline-valve">포라인 밸브</div>
  <div class="luffing-valve">러핑 밸브</div>
  <div class="gas-valve">가스 밸브</div>
  <img class="mainIMG" src="/posco/image/overview/1010.png" />
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
  <img class="nomal-heat" src="/posco/image/overview/nomal-heat.png" />
  <img class="heatpower-red" src="/posco/image/overview/heatpower-red.png" />
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
  <img class="object23" src="/posco/image/overview/object22.png" />
  <img class="object24" src="/posco/image/overview/object23.png" />
  <img class="object25" src="/posco/image/overview/object24.png" />
  <img class="object26" src="/posco/image/overview/object25.png" />
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
  <img class="icon-stop" src="/posco/image/overview/alarm_stop.png" /></div>
  <div class="bell-alarm-reset">
  <img class="icon-reset" src="/posco/image/overview/alarm_reset.png" /></div>
  <div class="bell-recipe"></div>
  <!-- <div class="time-zone-1"></div> -->
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
  <div class="set-low-vacuum"></div>
  <!-- <div class="set-cool-switch-1">OFF</div>
  <div class="set-cool-switch-2">OFF</div>
  <div class="set-cool-switch-3">OFF</div>
  <div class="set-cool-switch-4">OFF</div> -->
  <div class="bx"></div>
  <div class="box15"></div>
  <div class="box16"></div>
  <div class="box17">설정치</div>
  <div class="box18"></div>
  <div class="box19"></div>
  <div class="analog-vacuum-pv-1"></div>
  <div class="analog-hivacuum-pv-1"></div>
  <div class="analog-heat-pv-1"></div>
  <div class="analog-vacuum-pv-2"></div>
  <div class="analog-hivacuum-pv-2"></div>
  <div class="analog-heat-pv-2"></div>
  <div class="analog-timer-sv"></div>
  <div class="analog-timer-pv"></div>
  <div class="ok-auto"></div>
  
  <!-- <div class="text">냉각수 유량스위치-1</div>
  <div class="text2">냉각수 유량스위치-2</div>
  <div class="text3">냉각수 유량스위치-3</div>
  <div class="text4">냉각수 유량스위치-4</div> -->
  <div class="text5">Torr</div>
  <div class="text6">Torr</div>
  <div class="text7">Torr</div>
  <div class="text8">고진공 도달</div>
  <div class="text9">히팅 도달</div>
  <div class="text10">로내 압력</div>
  <div class="text11">진공도</div>
  <!-- <div class="text12">고진공-SET</div>
  <div class="text13">히팅-SET</div> -->
  <div class="text14">냉각타이머</div>
  <div class="text16">분</div>
  <div class="text17">분</div>
  <div class="text18">현재치</div>
  <div class="div">E</div>
  <div class="div2">E</div>
  <div class="div3">E</div>


		
		
		
		
		
   <!-- 알람 내역 영역  -->	
   <div class="area-alarm">
    <div class="alarm-title">알람 내역</div>

    <div class="alarm-list-wrapper">
        <table id="overviewAlarmTable">
            <thead>
                <tr>
                    <th>No</th>
                    <th>내용</th>
                    <th>발생</th>
                    <th>해제</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
</div>


<div class="ov-trend-wrap" id="ovTrendArea">
  <div class="ov-trend-header">
    <div class="ov-trend-title">온도 트렌드</div>
    <div class="ov-trend-controls">
      <input type="text" id="ov-startDate" class="ov-datetime" autocomplete="off" />
      <span style="font-weight:700; font-size:14px; color:#333;">~</span>
      <input type="text" id="ov-endDate" class="ov-datetime" autocomplete="off" />
      <button class="ov-btn" id="ov-trend-refresh">조회</button>
    </div>
  </div>

  <!-- 차트가 그려질 컨테이너 -->
  <div id="ov-trend-container"></div>
</div>


	    
	    
<script>


(function(){
	  // 안전을 위해 전역 오염 최소화: ov-prefixed 이름 사용
	  function ov_paddingZero(n){ return n < 10 ? "0"+n : n; }

	  function ov_trendNow(){
	    const d = new Date();
	    return d.getFullYear()
	      + "-" + ov_paddingZero(d.getMonth()+1)
	      + "-" + ov_paddingZero(d.getDate())
	      + " " + ov_paddingZero(d.getHours())
	      + ":" + ov_paddingZero(d.getMinutes());
	  }
	  function ov_trendYesterday(){
	    const d = new Date();
	    d.setDate(d.getDate() - 1);
	    return d.getFullYear()
	      + "-" + ov_paddingZero(d.getMonth()+1)
	      + "-" + ov_paddingZero(d.getDate())
	      + " " + ov_paddingZero(d.getHours())
	      + ":" + ov_paddingZero(d.getMinutes());
	  }

	  // Highcharts 변수 (local)
	  let ov_chart;
	  let ov_categories, ov_vac1, ov_vac2, ov_vac3, ov_protec, ov_temps;

	  function ov_fetchData() {
	    const s = document.getElementById('ov-startDate').value;
	    const e = document.getElementById('ov-endDate').value;

	    $.ajax({
	      type: "POST",
	      url: "/posco/monitoring/trend/list",
	      data: {
	        startDate: s,
	        endDate: e
	      },
	      success: function(result){
	        if(!result || result.length === 0){
	          // 데이터 없을 때 차트 클리어
	          if(ov_chart && ov_chart.series) {
	            ov_chart.update({ series: [] }, true, false);
	          }
	          return;
	        }

	        // 데이터 매핑
	        ov_categories = result.map(r => new Date(r.tdatetime).getTime());
	        ov_vac1 = result.map(r => Number(r.vac1_pv));
	        ov_vac2 = result.map(r => Number(r.vac2_pv));
	        ov_vac3 = result.map(r => Number(r.vac3_pv));
	        ov_protec = result.map(r => Number(r.protec_pv));
	        const tem_sp = result.map(r => Number(r.tem_sp));

	        // tem_1..12
	        const tems = [];
	        for(let i=1;i<=12;i++){
	          tems.push(result.map(r => Number(r["tem_"+i] || 0)));
	        }

	        // 차트 생성/업데이트
	        if(!ov_chart){
	          ov_createChart(ov_categories, ov_vac1, ov_vac2, ov_vac3, ov_protec, tem_sp, tems);
	        } else {
	          ov_chart.update({
	            xAxis: { categories: ov_categories },
	            series: [
	              { name: '1존온도 PV', data: ov_vac1 },
	              { name: '2존온도 PV', data: ov_vac2 },
	              { name: '3존온도 PV', data: ov_vac3 },
	              { name: '프로텍터온도 PV', data: ov_protec },
	              { name: '온도 SP', data: tem_sp },
	              // tem1..tem12
	              { name: '온도분포1', data: tems[0] },
	              { name: '온도분포2', data: tems[1] },
	              { name: '온도분포3', data: tems[2] },
	              { name: '온도분포4', data: tems[3] },
	              { name: '온도분포5', data: tems[4] },
	              { name: '온도분포6', data: tems[5] },
	              { name: '온도분포7', data: tems[6] },
	              { name: '온도분포8', data: tems[7] },
	              { name: '온도분포9', data: tems[8] },
	              { name: '온도분포10', data: tems[9] },
	              { name: '온도분포11', data: tems[10] },
	              { name: '온도분포12', data: tems[11] }
	            ]
	          }, true, false);
	        }
	      },
	      error: function(){
	        console.error("ov_trend: 데이터 조회 실패");
	      }
	    });
	  }

	  function ov_createChart(categories, vac1, vac2, vac3, protec, tem_sp, tems){
	    // 차트 높이/너비는 컨테이너에 맞춤
	    ov_chart = Highcharts.chart('ov-trend-container', {
	      chart: { type: 'line', zoomType: 'x', height: null },
	      title: { text: '' },
	      xAxis: {
	    	  type: 'datetime',
	    	  categories: categories,
	    	  tickPositions: (function () {
	    	    const total = categories.length;
	    	    if (total <= 1) return categories;  // 데이터 한 개면 그냥 그대로
	    	    
	    	    const ticks = [];
	    	    const count = 5;  // 라벨 5개 고정

	    	    for (let i = 0; i < count; i++) {
	    	      const index = Math.floor((total - 1) * (i / (count - 1)));
	    	      ticks.push(categories[index]);
	    	    }
	    	    return ticks;
	    	  })(),
	    	  labels: {
	    	    formatter: function () {
	    	      const d = new Date(this.value);
	    	      const mm = (d.getMonth() + 1).toString().padStart(2, "0");
	    	      const dd = d.getDate().toString().padStart(2, "0");
	    	      const hh = d.getHours().toString().padStart(2, "0");
	    	      const mi = d.getMinutes().toString().padStart(2, "0");
	    	      return mm + "-" + dd + "\n" + hh + ":" + mi;
	    	    }
	    	  }
	    	}
,
	      yAxis: {
	        title: { text: '온도' },
	        min: 0
	      },
	      tooltip: { shared: true, crosshairs: true, valueDecimals: 1 },
	      legend: { enabled: false }, // 작은 박스라 범례 숨김
	      series: [
	        { name: '1존온도 PV', data: vac1 },
	        { name: '2존온도 PV', data: vac2 },
	        { name: '3존온도 PV', data: vac3 },
	        { name: '프로텍터온도 PV', data: protec },
	        { name: '온도 SP', data: tem_sp },
	        // tem1..tem12
	        { name: '온도분포1', data: tems[0] },
	        { name: '온도분포2', data: tems[1] },
	        { name: '온도분포3', data: tems[2] },
	        { name: '온도분포4', data: tems[3] },
	        { name: '온도분포5', data: tems[4] },
	        { name: '온도분포6', data: tems[5] },
	        { name: '온도분포7', data: tems[6] },
	        { name: '온도분포8', data: tems[7] },
	        { name: '온도분포9', data: tems[8] },
	        { name: '온도분포10', data: tems[9] },
	        { name: '온도분포11', data: tems[10] },
	        { name: '온도분포12', data: tems[11] }
	      ],
	      credits: { enabled: false }
	    });
	  }

	  // 날짜피커 초기화 (간단한 텍스트 셋팅 — 기존 프로젝트에 datepicker 플러그인이 있으면 그걸로 바꿔도 됩니다)
	  function ov_initDates(){
	    document.getElementById('ov-startDate').value = ov_trendYesterday();
	    document.getElementById('ov-endDate').value = ov_trendNow();
	  }

	  // 바인딩
	  function ov_bind(){
	    document.getElementById('ov-trend-refresh').addEventListener('click', function(){
	      ov_fetchData();
	    });
	    // 엔터로도 검색
	    document.getElementById('ov-endDate').addEventListener('keydown', function(e){
	      if(e.key === 'Enter') ov_fetchData();
	    });
	  }

	  // init
	  function ov_init(){
	    ov_initDates();
	    ov_bind();
	    ov_fetchData();
	  }

	  // DOM ready (오버뷰에 이 스크립트가 삽입될 때 즉시 실행)
	  if(document.readyState === 'loading'){
	    document.addEventListener('DOMContentLoaded', ov_init);
	  } else {
	    ov_init();
	  }

	})();






$(document).ready(function () {

	//진공로히터
    $(".vacuum-heat").on("click", function () {
        openPopup("/posco/popup/vacuumHeat", 350, 140);
    });

	//자동운전선택
    $(".box14").on("click", function () {
        openPopup("/posco/popup/autoRun", 380, 150);
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

//on,off 텍스트 변환
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
        "analog-hivacuum-pv-1"
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
    });
}


// =====================
// OPC 값 알람 조회
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
                    console.log("tagName:", tagName, "tagData:", tagData); 
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
            console.log("✅ Ajax 응답 전체:", result);

            const data = result.multiValues;
            /* console.log("▶ 스트링:", data); */

            for (const item of data) {
                console.log("item:", item);
                for (const [tagName, tagData] of Object.entries(item)) {
                    console.log("tagName:", tagName, "tagData:", tagData);
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
                tr.append("<td class='active-alarm'>진행중</td>");

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

document.querySelectorAll('.icon-stop, .icon-reset').forEach(icon => {

 icon.addEventListener('click', function () {
     
     const tagName = this.classList.contains('icon-stop')
         ? "icon-stop"
         : "icon-reset";

     console.log("### OVERVIEW 버튼 클릭됨:", tagName);

     $.ajax({
         url: "/posco/monitoring/writeOverview",
         type: "post",
         data: { tagName: tagName, value: 1 },
         success: function (res) {
             console.log("### OVERVIEW write 성공:", res);
         },
         error: function (err) {
             console.error("### OVERVIEW write 실패:", err);
         }
     });
 });
});



// ==========================
// 현재 시간 표시 (year-month-day hour:minute:second)
// ==========================
function clock(){
            let timetext = document.querySelector('h1'); /* h1 태그 갖고오기 */
            let today = new Date(); /* 날짜와 시간 */
            let H = today.getHours();
            let M = today.getMinutes();
            let S = today.getSeconds();

            timetext.innerHTML = H + ":" + M + ":" + S; /* html에 출력 */
        }
        clock();
        setInterval(clock,1000); /* 1초마다 clock함수 실행 */

</script>

	</body>
</html>
