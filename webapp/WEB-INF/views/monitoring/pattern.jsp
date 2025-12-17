<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>패턴관리</title>
	<%@include file="../include/pluginpage.jsp" %>    
    <jsp:include page="../include/tabBar.jsp"/>
</head>
    <style>
       


    /* 기본 레이아웃 (테이블 높이/패딩 축소 적용) */
    body{ background:#fff; font-family:"Noto Sans KR", "맑은 고딕", sans-serif; color:#222; margin:0; padding:0; overflow: hidden; }
   .main {
    max-width:1800px;
    margin:18px auto;
    padding:16px;
    height: 100%;
    overflow: hidden; /* 내부 카드 스크롤만 허용 */
	}
	
.st-table-wrap {
    position: absolute;
    left: 60px;
    top: 85px;
}

.st-table {
    border-collapse: collapse;
    width: 1560px;          /* 21칸 × 40px */
    table-layout: fixed;  /* ★ 이게 매우 중요 */
}
.st-table col {
    width: calc(100% / 21);
}
.st-table th,
.st-table td {
    border: 1px solid #d0d3d8;
    height: 40px;
    text-align: center;
}

.st-table th {
    background: #f3f6fb;
    font-weight: bold;
    color: #0b63ce;
}

.st-table td {
    font-size: 15px;
    font-weight: bold;
    color: #333;
}




.pattern-read {
  background: #003366;
  border-style: solid;
  border-color: #c7c7c7;
  border-width: 1px;
  width: 171px;
  height: 51px;
  position: absolute;
  left: 601px;
  top: 314px;
}

.pattern-write {
  background: #3196FA;
  border-style: solid;
  border-color: #c7c7c7;
  border-width: 1px;
  width: 171px;
  height: 51px;
  position: absolute;
  left: 871px;
  top: 314px;
}
/* 클릭 시 (마우스 다운) */
.pattern-read:active,
.pattern-write:active {
    filter: brightness(0.8);   /* 어둡게 */
    transform: scale(0.95);    /* 살짝 줄어듦 */
}

/* 마우스 오버 시 */
.pattern-read:hover,
.pattern-write:hover {
    filter: brightness(1.2);   /* 밝게 */
    transform: scale(1.05);    /* 살짝 확대 */
}

.pattern-read{
	 display: flex;
    justify-content: center;
    align-items: center;
    font-weight: bold;
    text-align: center;
    color: white;
    font-size: 25px; 
}
.pattern-write{
	 display: flex;
    justify-content: center;
    align-items: center;
    font-weight: bold;
    text-align: center;
    color: white;
    font-size: 25px; 
}

.pattern-box {
	position: absolute;
  	left: 531px;
  	top: 414px;
    width: 580px;
    height: 290px;
    border: 1px solid #000;
    background: transparent;
    padding: 30px;
    box-sizing: border-box;
}

/* 왼쪽 영역 */
.pattern-left {
    display: flex;
    flex-direction: column;
}

.pattern-label {
    font-size: 14px;
    margin-bottom: 8px;
}

.pattern-input {
    width: 200px;
    height: 32px;
    padding: 4px 8px;
    box-sizing: border-box;
}

/* 오른쪽 적용 버튼 (div) */
.pattern-right {
    width: 100px;
    height: 40px;
    border: 1px solid #000;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    user-select: none;
}
.pattern-on.active {
    border: 3px solid #00c853;
}



/* 공통 오버레이 */
.pattern-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.3);
    z-index: 9999;
    display: none;
    align-items: center;
    justify-content: center;
}

.pattern-overlay-text {
    background: #fff;
    padding: 30px 50px;
    font-size: 26px;
    font-weight: bold;
    border-radius: 10px;
    box-shadow: 0 0 20px rgba(0,0,0,0.3);
}

    </style>

<body>
    <main class="main">
    
    <div id="patternStatus" style="position:absolute; left:60px; top:50px; font-size:20px; font-weight:bold; color:#003366;">
    상태: -
</div>


      <div class="st-table-wrap">
    <table class="st-table">

        
        <colgroup>
            <col span="21">
        </colgroup>

        
        <tr>
            <th colspan="3" class="pattern-number">
				<input type="number" class="analog-pattern-number" min="1" max="14">
			</th>
            <th colspan="19">진공 열처리로 패턴 프로그램</th>
        </tr>

        
        <tr>
            <td class="big">Seg</td>
            <td class="big">1</td>
            <td class="big">2</td>
            <td class="big">3</td>
            <td class="big">4</td>
            <td class="big">5</td>
            <td class="big">6</td>
            <td class="big">7</td>
            <td class="big">8</td>
            <td class="big">9</td>
            <td class="big">10</td>
            <td class="big">11</td>
            <td class="big">12</td>
            <td class="big">13</td>
            <td class="big">14</td>
            <td class="big">15</td>
            <td class="big">16</td>
            <td class="big">17</td>
            <td class="big">18</td>
            <td class="big">19</td>
            <td class="big">20</td>
        </tr>

        
        <tr>
            <td>시간(분)</td>
            <td class="analog-pattern-time-1"></td>
            <td class="analog-pattern-time-2"></td>
            <td class="analog-pattern-time-3"></td>
            <td class="analog-pattern-time-4"></td>
            <td class="analog-pattern-time-5"></td>
            <td class="analog-pattern-time-6"></td>
            <td class="analog-pattern-time-7"></td>
            <td class="analog-pattern-time-8"></td>
            <td class="analog-pattern-time-9"></td>
            <td class="analog-pattern-time-10"></td>
            <td class="analog-pattern-time-11"></td>
            <td class="analog-pattern-time-12"></td>
            <td class="analog-pattern-time-13"></td>
            <td class="analog-pattern-time-14"></td>
            <td class="analog-pattern-time-15"></td>
            <td class="analog-pattern-time-16"></td>
            <td class="analog-pattern-time-17"></td>
            <td class="analog-pattern-time-18"></td>
            <td class="analog-pattern-time-19"></td>
            <td class="analog-pattern-time-20"></td>
        </tr>

        
        <tr>
            <td>온도(℃)</td>
            <td class="analog-pattern-temp-1"></td>
            <td class="analog-pattern-temp-2"></td>
            <td class="analog-pattern-temp-3"></td>
            <td class="analog-pattern-temp-4"></td>
            <td class="analog-pattern-temp-5"></td>
            <td class="analog-pattern-temp-6"></td>
            <td class="analog-pattern-temp-7"></td>
            <td class="analog-pattern-temp-8"></td>
            <td class="analog-pattern-temp-9"></td>
            <td class="analog-pattern-temp-10"></td>
            <td class="analog-pattern-temp-11"></td>
            <td class="analog-pattern-temp-12"></td>
            <td class="analog-pattern-temp-13"></td>
            <td class="analog-pattern-temp-14"></td>
            <td class="analog-pattern-temp-15"></td>
            <td class="analog-pattern-temp-16"></td>
            <td class="analog-pattern-temp-17"></td>
            <td class="analog-pattern-temp-18"></td>
            <td class="analog-pattern-temp-19"></td>
            <td class="analog-pattern-temp-20"></td>
        </tr>

    </table>
</div>

	
	<div class="pattern-read">패턴 읽기</div>
	<div class="pattern-write">패턴 수정</div>
	
	
	
	
	<div class="pattern-box">
    
    <div class="pattern-left">
        <div class="pattern-label">운전 패턴번호</div>
        <input type="number" class="pattern-run" min="1" max="14">
    </div>

   
    <div class="pattern-on">
        적용
    </div>
</div>


		
    </main>
    
<script>


function bindPatternRangeAlert(selector) {

    document.querySelectorAll(selector).forEach(input => {

        input.addEventListener("change", function () {
            const min = parseInt(this.min, 10);
            const max = parseInt(this.max, 10);
            const val = parseInt(this.value, 10);

            if (isNaN(val)) return;

            if (val < min || val > max) {
                alert("패턴 번호는 " + min + " ~ " + max + " 사이만 입력 가능합니다.");
                this.value = "";
                this.focus();
            }
        });

    });
}

// 적용
bindPatternRangeAlert(".pattern-run, .analog-pattern-number");



$(".pattern-write").on("click", function () {
    openPopup("/posco/popup/patternWrite", 1250, 300);
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



function valueDisplay(key, val) {
    const els = document.getElementsByClassName(key);
    if (!els || els.length === 0) return;

    let displayValue = val;

    Array.from(els).forEach(el => {
        el.innerText = displayValue;
    });
}




//=====================
//OPC 값 조회
//=====================
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
//	                    case "green": green(tagName, value); break;
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
 //overviewListView();        // 첫 실행
 //overviewListViewString();  // 첫 실행
/*
 overviewInterval = setInterval(() => {
     overviewListView();
     overviewListViewString();
  
 }, 2500); // 1초마다 갱신
*/

	patternDataRead();
	patternDataReadInterval = setInterval("patternDataRead()",1000);
});

var patternDataReadInterval;

//패턴 조회 함수(1초주기 동작)
function patternDataRead(){
       $.ajax({
           url: "/posco/monitoring/read/patternAnalog",
           type: "post",
           data: {},
           success: function (res) {
               console.log(res);                                                  
			var opcDatas = res.multiValues;

			for(var rows in opcDatas){
				for(var row in opcDatas[rows]){
					
					var d = opcDatas[rows];

					if(d[row].action == "value"){
						console.log(row, d[row].value)
						$("."+row).text(d[row].value);
					}						 
				}
			}                
           }

       });
}

//패턴비트 ON 함수




(function(){
    console.log("### Pattern Read Logic Loaded");

    const btn = document.querySelector('.pattern-read');
    const patternInput = document.querySelector('.analog-pattern-number');

    if (!btn || !patternInput) {
        console.error("❌ pattern-read 또는 analog-pattern-number 없음");
        return;
    }

    btn.addEventListener('click', function () {

        const patternValue = parseInt(patternInput.value, 10);

        if (isNaN(patternValue)) {
            alert("패턴 번호를 입력하세요.");
            return;
        }

        console.log("### Step1: Analog WRITE →", patternValue);

        // ① 아날로그 값 먼저 WRITE (D6010)
        $.ajax({
            url: "/posco/monitoring/write/patternAnalog",
            type: "post",
            data: {
                tagName: "analog-pattern-number", // 👉 D6010
                value: patternValue
            },
            success: function (res) {

				console.log(res);
                
/*
                console.log("### Analog WRITE 성공 → BIT WRITE 시작");

                // ② 비트 ON (pattern-read)
                $.ajax({
                    url: "/posco/monitoring/write/patternBit",
                    type: "post",
                    data: {
                        tagName: "pattern-read",
                        value: 1
                    },
                    success: function () {
                        console.log("✅ Pattern Read Triggered");
                    },
                    error: function () {
                        console.error("❌ BIT WRITE 실패");
                    }
                });
 */               
            },
            error: function () {
                console.error("❌ Analog WRITE 실패");
            }
        });

    });

})();



//운전 패턴 적용 버튼
(function () {

    const applyBtn = document.querySelector(".pattern-on");
    const input = document.querySelector(".pattern-run");

    if (!applyBtn || !input) return;

    applyBtn.addEventListener("click", function () {

        const patternNo = parseInt(input.value, 10);
        if (isNaN(patternNo)) {
            alert("운전 패턴번호를 입력하세요.");
            return;
        }

        // ① 운전 패턴번호 WRITE (읽기 비트 ❌)
        $.ajax({
            url: "/posco/monitoring/write/patternAnalogOnly",
            type: "post",
            data: {
                tagName: "pattern-run",
                value: patternNo
            },
            success: function() {
                console.log("✅ 운전 패턴번호 WRITE 완료");
            },
            error: function() {
                console.error("❌ 운전 패턴번호 WRITE 실패");
            }
        });

        // ② 패턴 적용 비트 WRITE (5초 유지)
        $.ajax({
            url: "/posco/monitoring/write/patternApplyBit",
            type: "post",
            data: {
                tagName: "pattern-on",
                value: 1
            },
            success: function() {
                console.log("✅ 패턴 적용 트리거 완료");
            },
            error: function() {
                console.error("❌ 패턴 적용 트리거 실패");
            }
        });

    });

})();
















(function () {

    const btn = document.querySelector('.pattern-read');
    const input = document.querySelector('.analog-pattern-number');

    btn.addEventListener('click', function () {

        const patternNo = parseInt(input.value, 10);
        if (isNaN(patternNo)) {
            alert("패턴 번호를 입력하세요.");
            return;
        }

        $.ajax({
            url: "/posco/monitoring/write/patternRead",
            type: "post",
            data: { patternNo: patternNo },
            success: function () {
                console.log("✅ 패턴 읽기 트리거 완료");
            }
        });
    });

})();


//상태 표시 함수
function setPatternStatus(text) {
    const statusEl = document.getElementById("patternStatus");
    if (statusEl) {
        statusEl.innerText = "상태: " + text;
    }
}

// 비트값 ON 체크용 헬퍼
function isBitOn(value) {
    return value === true || value === 1;
}

// 읽기중 / 쓰기중 상태 체크
function pollPatternWaitStatus() {
    let waitOn = false;

    // 읽기중
    $.ajax({
        url: "/posco/monitoring/read/waitbit",
        type: "get",
        data: { tagName: "pattern-wait-read" },
        success: function (res) {
            if (res.status === "OK" && isBitOn(res.value)) {
                setPatternStatus("읽기중...");
                waitOn = true;
            }
        }
    });

    // 쓰기중
    $.ajax({
        url: "/posco/monitoring/read/waitbit",
        type: "get",
        data: { tagName: "pattern-wait-write" },
        success: function (res) {
            if (res.status === "OK" && isBitOn(res.value)) {
                setPatternStatus("쓰기중...");
                waitOn = true;
            }
        },
        complete: function () {
            if (!waitOn) setPatternStatus("-"); // 아무 작업 없으면 상태 초기화
        }
    });
}

// 읽기 완료 / 쓰기 완료 체크
function pollPatternDoneLamp() {
    // 읽기 완료
    $.ajax({
        url: "/posco/monitoring/read/waitbit",
        type: "get",
        data: { tagName: "pattern-read-lamp" },
        success: function (res) {
            if (res.status === "OK" && isBitOn(res.value)) {
                setPatternStatus("읽기 완료");
            }
        }
    });

    // 쓰기 완료
    $.ajax({
        url: "/posco/monitoring/read/waitbit",
        type: "get",
        data: { tagName: "pattern-write-lamp" },
        success: function (res) {
            if (res.status === "OK" && isBitOn(res.value)) {
                setPatternStatus("쓰기 완료");
            }
        }
    });
}

// 1초마다 상태 갱신
setInterval(() => {
    pollPatternWaitStatus();
    pollPatternDoneLamp();
}, 1000);





</script>


</body>
</html>