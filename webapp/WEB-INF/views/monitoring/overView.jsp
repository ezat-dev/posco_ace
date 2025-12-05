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

	
	/* 모든 클릭 가능한 오버뷰 요소 기본 스타일 */
.vacuum-heat,
 .box14,.box13,.box12,.box17, 
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
.box17:hover{
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
 .gas-valve:active {
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
	
    </style>
    
    
    <body>
  
  
  
  <div class="footer"></div>
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
  <div class="rectangle-103"></div>
  <img class="object" src="/posco/image/overview/object0.png" />
  <img class="object2" src="/posco/image/overview/object1.png" />
  <img class="object3" src="/posco/image/overview/object2.png" />
  <img class="object4" src="/posco/image/overview/object3.png" />
  <img class="object5" src="/posco/image/overview/object4.png" />
  <img class="object6" src="/posco/image/overview/object5.png" />
  <img class="object7" src="/posco/image/overview/object6.png" />
  <img class="object8" src="/posco/image/overview/object7.png" />
  <img class="object9" src="/posco/image/overview/object8.png" />
  <img class="object10" src="/posco/image/overview/object9.png" />
  <img class="object11" src="/posco/image/overview/object10.png" />
  <img class="nomal-heat" src="/posco/image/overview/nomal-heat0.png" />
  <img class="heatpower-red" src="/posco/image/overview/heatpower-red0.png" />
  <img class="object12" src="/posco/image/overview/object11.png" />
  <img class="object13" src="/posco/image/overview/object12.png" />
  <img class="object14" src="/posco/image/overview/object13.png" />
  <img class="object15" src="/posco/image/overview/object14.png" />
  <img class="object16" src="/posco/image/overview/object15.png" />
  <img class="object17" src="/posco/image/overview/object16.png" />
  <img class="object18" src="/posco/image/overview/object17.png" />
  <img class="object19" src="/posco/image/overview/object18.png" />
  <img class="object20" src="/posco/image/overview/object19.png" />
  <img class="object21" src="/posco/image/overview/object20.png" />
  <img class="object22" src="/posco/image/overview/object21.png" />
  <img class="object23" src="/posco/image/overview/object22.png" />
  <img class="object24" src="/posco/image/overview/object23.png" />
  <img class="object25" src="/posco/image/overview/object24.png" />
  <img class="object26" src="/posco/image/overview/object25.png" />
  <img class="object27" src="/posco/image/overview/object26.png" />
  <img class="object28" src="/posco/image/overview/object27.png" />
  <img class="object29" src="/posco/image/overview/object28.png" />
  <img class="object30" src="/posco/image/overview/object29.png" />
  <img class="object31" src="/posco/image/overview/object30.png" />
  <img class="object32" src="/posco/image/overview/object31.png" />
  <img class="object33" src="/posco/image/overview/object32.png" />
  <img class="object34" src="/posco/image/overview/object33.png" />
  <img class="vacuum-heat" src="/posco/image/overview/vacuum-heat0.png" />
  <img class="cold-pen" src="/posco/image/overview/cold-pen0.png" />
  <img class="luffing-pump" src="/posco/image/overview/luffing-pump0.png" />
  <img class="diff-pump" src="/posco/image/overview/diff-pump0.png" />
  <div class="lamp-text-diff-pump-on">OFF</div>
  <!-- <div class="diff-pump-off">OFF</div> -->
  <img class="booster-pump" src="/posco/image/overview/booster-pump0.png" />
  <img class="fourline-valve" src="/posco/image/overview/fourline-valve0.png" />
  <img class="luffing-valve" src="/posco/image/overview/luffing-valve0.png" />
  <!-- <div class="lamp-text-luffing-valve-off">닫힘</div> -->
  <div class="lamp-text-luffing-valve-on">닫힘</div>
  <div class="green-luffing-valve"></div>
  <img class="vacuum-valve" src="/posco/image/overview/vacuum-valve0.png" />
  <!-- <div class="lamp-text-vacuum-valve-off">닫힘</div> -->
  <div class="lamp-text-vacuum-valve-on">닫힘</div>
  <!-- <div class="lamp-text-fourline-valve-off">닫힘</div> -->
  <div class="lamp-text-fourline-valve-on">닫힘</div>
  <div class="green-fourline-valve"></div>
  <!-- <div class="lamp-text-gas-valve-off">닫힘</div> -->
  <div class="lamp-text-gas-valve-on">닫힘</div>
  <img class="gas-valve" src="/posco/image/overview/gas-valve0.png" />
  <div class="green-gas-valve"></div>
  <div class="ellipse-1"></div>
  <img class="pen-4" src="/posco/image/overview/pen-40.png" />
  <div class="ellipse-2"></div>
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
  <div class="time-zone-1"></div>
  <div class="logo-zone"></div>
  <div class="box8"></div>
  <div class="box9"></div>
  <div class="box10"></div>
  <div class="box11"></div>
  <div class="box12">히팅-SET</div>
  <div class="box13">고진공-SET</div>
  <div class="box14">운전 선택</div>
  <div class="auto-run-off-box">자동운전 정지</div>
  <div class="auto-run-on-box">자동운전 시작</div>
  <div class="set-vacuum">OFF</div>
  <div class="set-heat">OFF</div>
  <div class="set-low-vacuum"></div>
  <div class="set-cool-switch-1">OFF</div>
  <div class="set-cool-switch-2">OFF</div>
  <div class="set-cool-switch-3">OFF</div>
  <div class="set-cool-switch-4">OFF</div>
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
  
  <div class="text">냉각수 유량스위치-1</div>
  <div class="text2">냉각수 유량스위치-2</div>
  <div class="text3">냉각수 유량스위치-3</div>
  <div class="text4">냉각수 유량스위치-4</div>
  <div class="text5">Torr</div>
  <div class="text6">Torr</div>
  <div class="text7">Torr</div>
  <div class="text8">고진공-SET LAMP</div>
  <div class="text9">히팅-SET LAMP</div>
  <div class="text10">저진공 압력스위치</div>
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
   
   
   
   </div>		


	    
	    
<script>








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
            el.style.backgroundColor = "#8e8e8e"; // 기본 회색
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

function valueDisplay(key, val){
    const els = document.getElementsByClassName(key);
    if(!els || els.length === 0){
        //console.warn(`valueDisplay: DOM element not found for key "${key}"`);
        return;
    }
    Array.from(els).forEach(el => el.innerText = val);
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
