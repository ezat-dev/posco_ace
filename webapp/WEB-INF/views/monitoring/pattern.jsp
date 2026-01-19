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
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    background: #f5f5f5;
    font-family: "Noto Sans KR", "맑은 고딕", sans-serif;
    color: #333;
    overflow: hidden;
}

.main {
    width: 100%;
    height: 100%;
    background: white;
    padding: 20px;
    overflow-y: auto;
    overflow-x: hidden;
}

/* 헤더 영역 */
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
    padding-bottom: 12px;
    border-bottom: 3px solid #33363d;
}

.header-title {
    font-size: 26px;
    font-weight: bold;
    color: #33363d;
    display: flex;
    align-items: center;
    gap: 12px;
}

.header-title::before {
    content: "⚙";
    font-size: 32px;
}

/* 기본 스타일 (배경색 제거) */
#patternStatus {
    color: white;
    padding: 10px 20px;
    border-radius: 6px;
    font-size: 16px;
    font-weight: bold;
    display: inline-block;
    min-width: 120px;
    text-align: center;
    transition: all 0.3s ease;
    /* background 제거 - 클래스에서만 배경색 지정 */
}

/* 기본 상태 (클래스 없을 때) */
#patternStatus:not(.reading):not(.writing):not(.read-complete):not(.write-complete) {
    background: linear-gradient(135deg, #6b7280, #9ca3af);
    box-shadow: 0 3px 12px rgba(107, 114, 128, 0.4);
}

/* 읽기중 */
#patternStatus.reading {
    background: linear-gradient(135deg, #2563eb, #3b82f6) !important;
    animation: pulse 1.5s infinite;
    box-shadow: 0 3px 12px rgba(37, 99, 235, 0.4) !important;
}

/* 쓰기중 */
#patternStatus.writing {
    background: linear-gradient(135deg, #f59e0b, #f97316) !important;
    animation: pulse 1.5s infinite;
    box-shadow: 0 3px 12px rgba(245, 158, 11, 0.4) !important;
}

/* 읽기 완료 */
#patternStatus.read-complete {
    background: linear-gradient(135deg, #10b981, #059669) !important;
    box-shadow: 0 3px 12px rgba(16, 185, 129, 0.4) !important;
}

/* 쓰기 완료 */
#patternStatus.write-complete {
    background: linear-gradient(135deg, #10b981, #059669) !important;
    box-shadow: 0 3px 12px rgba(16, 185, 129, 0.4) !important;
}

@keyframes pulse {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.7; }
}
/* 통합 섹션 스타일 */
.combined-section {
    background: white;
    border-radius: 12px;
    padding: 15px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.section-title {
    font-size: 18px;
    font-weight: bold;
    color: #33363d;
    margin-bottom: 12px;
    display: flex;
    align-items: center;
    gap: 8px;
    position: relative;
}

.section-title::before {
    content: "📊";
    font-size: 22px;
}

/* 현재 운전 상태 테이블과 패턴 정보 테이블 간격 */
.seg-table-wrap {
    margin-bottom: 20px;
}

.st-table-wrap {
    margin-top: 20px;
}

/* 현재 운전 상태 - 최상단 */
.status-section {
    background: white;
    border-radius: 12px;
    padding: 15px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    margin-bottom: 15px;
}

/* 세그먼트 테이블 */
.seg-table-wrap {
    position: static;
    overflow-x: auto;
}

.seg-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    border-radius: 8px;
    overflow: hidden;
}

.seg-table th {
    background: linear-gradient(135deg, #33363d, #4a4d57);
    color: white;
    padding: 12px 8px;
    text-align: center;
    font-weight: bold;
    font-size: 18px;
    border: 1px solid rgba(255, 255, 255, 0.2);
}

.seg-table td {
    padding: 12px 8px;
    text-align: center;
    font-size: 18px;
    font-weight: bold;
    color: #333;
    border: 1px solid #e0e0e0;
    background: white;
}

/* 컨트롤 패널 영역 */
.control-panel {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 15px;
    margin-bottom: 15px;
}

.control-card {
    background: white;
    border-radius: 12px;
    padding: 18px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease;
}

.card-title {
    font-size: 16px;
    font-weight: bold;
    color: #33363d;
    margin-bottom: 15px;
    display: flex;
    align-items: center;
    gap: 8px;
}

.card-title::before {
    content: "●";
    font-size: 20px;
}

/* 버튼 그룹 */
.btn-group {
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
}

/* 기존 버튼 클래스명 유지 */
.pattern-read,
.pattern-write,
.pattern-skip,
.pattern-manage-btn {
    flex: 1;
    min-width: 100px;
    height: 55px;
    border: none;
    border-radius: 10px;
    font-size: 14px;
    font-weight: bold;
    color: white;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 3px 12px rgba(0, 0, 0, 0.2);
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
    position: static;
}

.pattern-read {
    background: linear-gradient(135deg, #33363d, #4a4d57);
}

.pattern-read::before {
    content: "📖";
}

.pattern-write {
    background: linear-gradient(135deg, #33363d, #4a4d57);
}

.pattern-write::before {
    content: "✏️";
}

.pattern-skip {
    background: linear-gradient(135deg, #33363d, #4a4d57);
}

.pattern-skip::before {
    content: "⏭️";
}

.pattern-manage-btn {
    background: linear-gradient(135deg, #2563eb, #3b82f6);
}

.pattern-manage-btn::before {
    content: "📁";
}

.pattern-read:hover,
.pattern-write:hover,
.pattern-skip:hover,
.pattern-manage-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
}

.pattern-read:active,
.pattern-write:active,
.pattern-skip:active,
.pattern-manage-btn:active {
    transform: translateY(-1px);
}

/* 입력 영역 */
.input-group {
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.pattern-label {
    font-size: 14px;
    font-weight: bold;
    color: #555;
}

.pattern-run,
.analog-pattern-number {
    width: 100%;
    height: 40px;
    padding: 8px 12px;
    border: 2px solid #e0e0e0;
    border-radius: 8px;
    font-size: 16px;
    font-weight: bold;
    text-align: center;
    transition: all 0.3s ease;
}

.pattern-run:focus,
.analog-pattern-number:focus {
    outline: none;
    border-color: #33363d;
    box-shadow: 0 0 0 3px rgba(51, 54, 61, 0.1);
}

.pattern-on {
    width: 100%;
    height: 42px;
    background: linear-gradient(135deg, #33363d, #4a4d57);
    border: none;
    border-radius: 10px;
    color: white;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s ease;
    margin-top: 8px;
    box-shadow: 0 3px 12px rgba(51, 54, 61, 0.3);
    position: static;
    display: flex;
    align-items: center;
    justify-content: center;
}

.pattern-on:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(51, 54, 61, 0.4);
}

.pattern-on.active {
    animation: pulse-btn 1.5s infinite;
}

@keyframes pulse-btn {
    0%, 100% {
        box-shadow: 0 3px 12px rgba(51, 54, 61, 0.3);
    }
    50% {
        box-shadow: 0 3px 20px rgba(51, 54, 61, 0.6);
    }
}

/* 스위치 버튼 */
.switch-group {
    display: flex;
    gap: 12px;
}

.pattern-switch-on,
.pattern-switch-off {
    flex: 1;
    height: 55px;
    border: none;
    border-radius: 10px;
    font-size: 13px;
    font-weight: bold;
    color: white;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 3px 12px rgba(0, 0, 0, 0.2);
    position: static;
    display: flex;
    align-items: center;
    justify-content: center;
}

.pattern-switch-on {
    background: linear-gradient(135deg, #33363d, #4a4d57);
}

.pattern-switch-on::before {
    content: "🟢 ";
}

.pattern-switch-off {
    background: linear-gradient(135deg, #33363d, #4a4d57);
}

.pattern-switch-off::before {
    content: "🔴 ";
}

.pattern-switch-on:hover,
.pattern-switch-off:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
}

/* 패턴 박스 숨김 (카드로 대체) */
.pattern-box,
.pattern-swap {
    display: none;
}

/* 테이블 섹션 */
.table-section {
    background: white;
    border-radius: 12px;
    padding: 15px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

/* 테이블 래퍼 */
.st-table-wrap {
    position: static;
    overflow-x: auto;
}

.st-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    background: white;
    border-radius: 8px;
    overflow: hidden;
    table-layout: auto;
}

.st-table th {
    background: linear-gradient(135deg, #33363d, #4a4d57);
    color: white;
    padding: 10px 6px;
    text-align: center;
    font-weight: bold;
    font-size: 20px;
    border: 1px solid rgba(255, 255, 255, 0.2);
}

.st-table td {
    padding: 8px 6px;
    text-align: center;
    font-size: 13px;
    font-weight: 600;
    color: #333;
    border: 1px solid #e0e0e0;
    background: white;
    transition: background 0.2s ease;
}

.st-table td:hover {
    background: #f8f9ff;
}

/* Seg 램프 전용 스타일 */
.st-table td.seg-lamp {
    position: relative;
    cursor: pointer;
    /* 기본 상태는 일반 td와 동일 (border: 1px solid #e0e0e0, background: white) */
}

/* Seg 램프 active-on 상태 - 노란색 배경 점멸 */
.st-table td.seg-lamp.active-on {
    animation: blink-bg-yellow 1s infinite !important;
    font-weight: bold !important;
    color: #000 !important;
    border: 1px solid #fbc02d !important;
}

/* 노란색 배경 점멸 애니메이션 */
@keyframes blink-bg-yellow {
    0%, 100% { 
        background: #ffeb3b;
        box-shadow: 0 0 15px rgba(255, 235, 59, 0.8);
    }
    50% { 
        background: #fff9c4;
        box-shadow: 0 0 5px rgba(255, 235, 59, 0.3);
    }
}

.st-table .pattern-number {
    background: linear-gradient(135deg, #33363d, #4a4d57);
    color: white;
}

/* 오버레이 */
.pattern-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    z-index: 9999;
    display: none;
    align-items: center;
    justify-content: center;
}

.pattern-overlay-text {
    background: white;
    padding: 30px 50px;
    font-size: 24px;
    font-weight: bold;
    border-radius: 12px;
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
    color: #33363d;
}

/* 버튼 테두리 애니메이션 */
.btn {
    border: 5px solid transparent;
    box-sizing: border-box;
}

.btn.active-on {
    border-color: #00ff00;
    animation: blink-border-green 1s infinite;
}

.btn.active-off {
    border-color: #ff0000;
    animation: blink-border-red 1s infinite;
}

@keyframes blink-border-green {
    0%, 100% { border-color: rgba(0,255,0,1); }
    50% { border-color: rgba(0,255,0,0.2); }
}

@keyframes blink-border-red {
    0%, 100% { border-color: rgba(255,0,0,1); }
    50% { border-color: rgba(255,0,0,0.2); }
}

/* 반응형 */
@media (max-width: 1400px) {
    .control-panel {
        grid-template-columns: 1fr;
    }
}



</style>
</head>
<body>
    <main class="main">
        <!-- 헤더 -->
        <div class="header">
            <div class="header-title">진공 열처리로 패턴 관리</div>
            
        </div>

        <!-- 1. 컨트롤 패널 (최상단) -->
<div class="control-panel">
    <!-- 패턴 제어 -->
    <div class="control-card">
        <div class="card-title">패턴 제어</div>
        <div class="btn-group">
            <div class="pattern-skip">패턴 스킵</div>
            <div class="pattern-manage-btn">패턴 관리</div>
        </div>
    </div>

    <!-- 운전 패턴 설정 -->
    <!-- <div class="control-card">
        <div class="card-title">운전 패턴 설정</div>
        <div class="input-group">
            <label class="pattern-label">운전 패턴번호</label>
            <input type="number" class="pattern-run" min="1" max="14">
            <div class="pattern-on">적용</div>
        </div>
    </div> -->

    <!-- 온도계 통신 전환 -->
    <div class="control-card">
        <div class="card-title">LL50A 통신 전환(비가동중일때만 전환 가능)</div>
        <div class="switch-group">
            <div class="btn pattern-switch-on" data-tag="pattern-switch-on">LL50A 통신 전환 ON</div>
            <div class="btn pattern-switch-off" data-tag="pattern-switch-off">LL50A 통신 전환 OFF</div>
        </div>
    </div>
</div>

<!-- 2. 현재 운전 상태 + 패턴 정보 통합 -->
<div class="combined-section">
    <!-- 현재 운전 상태 -->
    <div class="section-title">
    <span>패턴 운전 상태</span>
    <span style="margin-left: 10px;">상태: <span id="patternStatus">-</span></span>
</div>
		    <!-- 현재 운전 상태 테이블 -->
		<div class="seg-table-wrap">
		    <table class="seg-table">
		        <tr>
		            <th>현재 운전 패턴번호</th>
		            <th>패턴 이름</th>
		            <th>현재 진행 Seg</th>
		            <th>현재 진행 Seg 남은시간(분)</th>
		        </tr>
		        <tr>
		            <td class="analog-pattern-status"></td>
		            <td id="current-pattern-name">-</td>
		            <td class="analog-seg-status"></td>
		            <td class="analog-seg-time"></td>
		        </tr>      
		    </table>
		</div>

    <!-- 패턴 정보 테이블 -->
    <div class="st-table-wrap">
        <table class="st-table">
            <colgroup>
                <col span="21">
            </colgroup>

            <tr>
			    <td class="big">Seg</td>
			    <td class="seg-lamp lamp-seg-1" data-tag="lamp-seg-1">1</td>
			    <td class="seg-lamp lamp-seg-2" data-tag="lamp-seg-2">2</td>
			    <td class="seg-lamp lamp-seg-3" data-tag="lamp-seg-3">3</td>
			    <td class="seg-lamp lamp-seg-4" data-tag="lamp-seg-4">4</td>
			    <td class="seg-lamp lamp-seg-5" data-tag="lamp-seg-5">5</td>
			    <td class="seg-lamp lamp-seg-6" data-tag="lamp-seg-6">6</td>
			    <td class="seg-lamp lamp-seg-7" data-tag="lamp-seg-7">7</td>
			    <td class="seg-lamp lamp-seg-8" data-tag="lamp-seg-8">8</td>
			    <td class="seg-lamp lamp-seg-9" data-tag="lamp-seg-9">9</td>
			    <td class="seg-lamp lamp-seg-10" data-tag="lamp-seg-10">10</td>
			    <td class="seg-lamp lamp-seg-11" data-tag="lamp-seg-11">11</td>
			    <td class="seg-lamp lamp-seg-12" data-tag="lamp-seg-12">12</td>
			    <td class="seg-lamp lamp-seg-13" data-tag="lamp-seg-13">13</td>
			    <td class="seg-lamp lamp-seg-14" data-tag="lamp-seg-14">14</td>
			    <td class="seg-lamp lamp-seg-15" data-tag="lamp-seg-15">15</td>
			    <td class="seg-lamp lamp-seg-16" data-tag="lamp-seg-16">16</td>
			    <td class="seg-lamp lamp-seg-17" data-tag="lamp-seg-17">17</td>
			    <td class="seg-lamp lamp-seg-18" data-tag="lamp-seg-18">18</td>
			    <td class="seg-lamp lamp-seg-19" data-tag="lamp-seg-19">19</td>
			    <td class="seg-lamp lamp-seg-20" data-tag="lamp-seg-20">20</td>
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
</div>

        <!-- 오버레이 (기존 유지) -->
        <div class="pattern-overlay">
            <div class="pattern-overlay-text">처리 중...</div>
        </div>

        <!-- 숨겨진 기존 요소들 (JS 호환성 유지) -->
        <div class="pattern-box" style="display:none;">
            <div class="pattern-left"></div>
        </div>
        <div class="pattern-swap" style="display:none;"></div>
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

$(".pattern-skip").on("click", function () {
    openPopup("/posco/popup/patternSkip", 350, 140);
});

$(".pattern-manage-btn").on("click", function () {
    openPopup("/posco/popup/patternInfo", 1700, 900);
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

    Array.from(els).forEach(el => {
        if (el.tagName === "INPUT") {
            el.value = val;
        } else {
            el.innerText = val;
        }
    });
}



function patternNumber(key, val) {
    const els = document.getElementsByClassName(key);
    if (!els || els.length === 0) return;

    Array.from(els).forEach(el => {
        if (el.tagName === "INPUT") {
            el.value = val;
        } else {
            el.innerText = val;
        }
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
                        case "patternNumber": patternNumber(tagName, value); break;
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
	
	// ✅ pollLampStatus 초기화 (DOM 로드 후 실행)
	console.log("🔍 DOM 로드 완료 - pollLampStatus 초기화");
	pollLampStatus();
	setInterval(pollLampStatus, 1000);
	loadCurrentPatternName();
    setInterval(loadCurrentPatternName, 2000);
});

var patternDataReadInterval;

//패턴 조회 함수(1초주기 동작)
function patternDataRead(){
       $.ajax({
           url: "/posco/monitoring/read/patternAnalog",
           type: "post",
           data: {},
           success: function (res) {
               /* console.log(res);       */                                            
			var opcDatas = res.multiValues;

			for(var rows in opcDatas){
				for(var row in opcDatas[rows]){
					
					var d = opcDatas[rows];

					if(d[row].action == "value"){
						/* console.log(row, d[row].value) */
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

				/* console.log(res); */
                
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
                alert("패턴번호가 컨트롤러에 설정 되었습니다.");
            },
            error: function() {
                console.error("❌ 운전 패턴번호 WRITE 실패");
                alert("적용 실패.");
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

    if (!btn || !input) {
        console.error("❌ pattern-read 또는 analog-pattern-number 없음");
        return;
    }

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
function setPatternStatus(text, statusClass) {
    const statusEl = document.getElementById("patternStatus");
    if (statusEl) {
        statusEl.textContent = text;  // "읽기중...", "쓰기중..." 등만 표시
        
        // 기존 상태 클래스 제거
        statusEl.className = '';
        
        // 새 클래스 추가
        if (statusClass) {
            statusEl.classList.add(statusClass);
        }
    }
}

//비트값 ON 체크용 헬퍼
function isBitOn(value) {
 return value === true || value === 1;
}

//읽기중 / 쓰기중 상태 체크 (순차 실행)
function pollPatternWaitStatus() {
    // ① 읽기중 체크 (OVERVIEW 그룹의 pattern-wait-read)
    $.ajax({
        url: "/posco/monitoring/read/waitbit",
        type: "get",
        data: { tagName: "pattern-wait-read" },
        success: function (res) {
            if (res.status === "OK" && isBitOn(res.value)) {
                setPatternStatus("읽기중...", "reading");
            } else {
                // 읽기중이 아니면 쓰기중 체크
                checkWriteStatus();
            }
        },
        error: function() {
            // 에러 시에도 다음 체크
            checkWriteStatus();
        }
    });
}

// 쓰기중 체크
function checkWriteStatus() {
    $.ajax({
        url: "/posco/monitoring/read/waitbit",
        type: "get",
        data: { tagName: "pattern-wait-write" },
        success: function (res) {
            if (res.status === "OK" && isBitOn(res.value)) {
                setPatternStatus("쓰기중...", "writing");
            } else {
                // 읽기중도 쓰기중도 아니면 완료 상태 체크
                pollPatternDoneLamp();
            }
        },
        error: function() {
            // 에러 시에도 완료 상태 체크
            pollPatternDoneLamp();
        }
    });
}

// 읽기 완료 / 쓰기 완료 체크
function pollPatternDoneLamp() {
    // ① 읽기 완료 체크 (OVERVIEW 그룹의 pattern-read-lamp)
    $.ajax({
        url: "/posco/monitoring/read/waitbit",
        type: "get",
        data: { tagName: "pattern-read-lamp" },
        success: function (res) {
            if (res.status === "OK" && isBitOn(res.value)) {
                setPatternStatus("읽기 완료", "read-complete");
            } else {
                // 읽기 완료가 아니면 쓰기 완료 체크
                checkWriteComplete();
            }
        },
        error: function() {
            checkWriteComplete();
        }
    });
}

// 쓰기 완료 체크
function checkWriteComplete() {
    $.ajax({
        url: "/posco/monitoring/read/waitbit",
        type: "get",
        data: { tagName: "pattern-write-lamp" },
        success: function (res) {
            if (res.status === "OK" && isBitOn(res.value)) {
                setPatternStatus("쓰기 완료", "write-complete");
            } else {
                // 모든 상태가 아니면 "-" 표시
                setPatternStatus("-");
            }
        },
        error: function() {
            setPatternStatus("-");
        }
    });
}

//1초마다 상태 갱신
setInterval(() => {
 pollPatternWaitStatus();
}, 1000);


//온도계 통신전환 ON/OFF 비트
document.querySelectorAll('.pattern-switch-on, .pattern-switch-off').forEach(icon => {

	 icon.addEventListener('click', function () {
	     
	     const tagName = this.classList.contains('pattern-switch-on')
	         ? "pattern-switch-on"
	         : "pattern-switch-off";

	     console.log("### OVERVIEW 버튼 클릭됨:", tagName);

	     $.ajax({
	         url: "/posco/monitoring/writeOverview",
	         type: "post",
	         data: { tagName: tagName, value: 1 },
	         success: function (res) {
	             console.log("### 온도계통신전환 성공:", res);
	         },
	         error: function (err) {
	             console.error("### 온도계통신전환 실패:", err);
	         }
	     });
	 });
	});


//램프 상태 체크 함수
function pollLampStatus() {
    console.log("🔍 pollLampStatus 실행됨");
    
    // ON Lamp (온도계 통신전환)
    $.ajax({
       url: "/posco/monitoring/read/patternLamp",
       type: "get",
       data: { tagName: "pattern-switch-lamp-on" },
       success: function(res) {
           if (res.status === "OK") {
               const isOn = res.value === true;
               const onBtn = document.querySelector("[data-tag='pattern-switch-on']");
               if (onBtn) {
                   if (isOn) {
                       onBtn.classList.add("active-on");
                   } else {
                       onBtn.classList.remove("active-on");
                   }
               }
           }
       }
    });
    
    // OFF Lamp (온도계 통신전환)
    $.ajax({
       url: "/posco/monitoring/read/patternLamp",
       type: "get",
       data: { tagName: "pattern-switch-lamp-off" },
       success: function(res) {
           if (res.status === "OK") {
               const isOff = res.value === true;
               const offBtn = document.querySelector("[data-tag='pattern-switch-off']");
               if (offBtn) {
                   if (isOff) {
                       offBtn.classList.add("active-off");
                   } else {
                       offBtn.classList.remove("active-off");
                   }
               }
           }
       }
    });
    
    // Seg별 램프 비트신호 (1~20번 전체)
    console.log("🔍 Seg 램프 체크 시작");
    
    for (let i = 1; i <= 20; i++) {
        (function(segNum) {
            $.ajax({
                url: "/posco/monitoring/read/segLamp",
                type: "get",
                data: { tagName: "lamp-seg-" + segNum },
                success: function(res) {
                    console.log("📊 Seg " + segNum + " 응답:", res);
                    
                    if (res.status === "OK") {
                        const isOn = res.value === true;
                        const segBtn = document.querySelector("[data-tag='lamp-seg-" + segNum + "']");
                        
                        console.log("🔍 Seg " + segNum + " - 요소:", segBtn);
                        console.log("🔍 Seg " + segNum + " - 비트값:", isOn);
                        
                        if (segBtn) {
                            if (isOn) {
                                segBtn.classList.add("active-on");
                                console.log("✅ Seg " + segNum + " active-on 추가");
                                console.log("🔍 현재 클래스:", segBtn.className);
                            } else {
                                segBtn.classList.remove("active-on");
                            }
                        } else {
                            console.error("❌ Seg " + segNum + " 요소를 찾을 수 없음!");
                        }
                    } else {
                        console.warn("⚠️ Seg " + segNum + " 상태 ERR:", res);
                    }
                },
                error: function(err) {
                    console.error("❌ Seg " + segNum + " AJAX 실패:", err);
                }
            });
        })(i);
    }
}


//패턴 이름 조회 함수
function loadCurrentPatternName() {
    // 현재 운전 패턴번호 가져오기
    const patternNo = parseInt($('.analog-pattern-status').text());
    
    if (isNaN(patternNo) || patternNo < 1 || patternNo > 14) {
        $('#current-pattern-name').text('-');
        return;
    }
    
    // DB에서 패턴 이름 조회
    $.ajax({
        url: "/posco/monitoring/pattern/name",
        type: "get",
        data: { pattern_no: patternNo },
        success: function(res) {
            if (res.status === "OK" && res.pattern_name) {
                $('#current-pattern-name').text(res.pattern_name);
            } else {
                $('#current-pattern-name').text('패턴 ' + patternNo);
            }
        },
        error: function() {
            $('#current-pattern-name').text('패턴 ' + patternNo);
        }
    });
}

</script>
</body>
</html>