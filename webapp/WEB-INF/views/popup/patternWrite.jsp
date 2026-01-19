<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>패턴쓰기</title>
<meta name="viewport" content="width=device-width,initial-scale=1">

<%@include file="../include/pluginpage.jsp" %> 

<style>
   html,body{
    margin:0;
    padding:0;
    height:100%;
    font-family:Arial,Helvetica,sans-serif;
    background:#fff;
}

/* ===== 팝업 레이아웃 ===== */
.container{
    box-sizing:border-box;
    width:100%;
    height:100%;
    display:flex;
    flex-direction:column;
    align-items:center;
    padding:10px;
}

.header{
    width:100%;
    text-align:center;
    background:#33363d;
    color:#fff;
    padding:8px 0;
    font-size:16px;
    border-radius:4px;
}

/* ===== 테이블 영역 ===== */
.table-wrap{
    margin-top:10px;
    width:100%;
    overflow-x:auto;
    border:1px solid #ccc;
}

.st-table{
    border-collapse:collapse;
    table-layout:fixed;
    width:1200px; /* 팝업보다 크게 */
}

.st-table th,
.st-table td{
    border:1px solid #d0d3d8;
    height:38px;
    text-align:center;
    font-size:13px;
}

.st-table th{
    background:#f3f6fb;
    font-weight:bold;
    color:#0b63ce;
}

.st-table input{
    width:90%;
    height:28px;
    border:1px solid #bbb;
    border-radius:4px;
    text-align:right;
    font-size:13px;
}

/* ===== 하단 버튼 ===== */
.btn-area{
    margin-top:12px;
    display:flex;
    gap:12px;
}

.btn{
    width:140px;
    height:36px;
    border:none;
    border-radius:6px;
    font-size:15px;
    font-weight:bold;
    cursor:pointer;
}

.btn-save{
    background:#4caf50;
    color:#fff;
}

.btn-close{
    background:#777;
    color:#fff;
}
.current-pattern{
    margin-top:8px;
    margin-bottom:6px;
    padding:6px 12px;
    font-size:15px;
    font-weight:bold;
    background:#f3f6fb;
    border:1px solid #cfd6e0;
    border-radius:4px;
    color:#003366;
}
</style>
</head>

<body>
<div class="container">

    <div class="header">패턴 프로그램 편집</div>
	<div class="current-pattern">
	    <input type="number" class="analog-pattern-number" disabled>
	</div>
    <!-- ===== 테이블 ===== -->
    <div class="table-wrap">
        <table class="st-table">
            <tr>
                <th>Seg</th>
                <th>1</th><th>2</th><th>3</th><th>4</th><th>5</th>
                <th>6</th><th>7</th><th>8</th><th>9</th><th>10</th>
                <th>11</th><th>12</th><th>13</th><th>14</th><th>15</th>
                <th>16</th><th>17</th><th>18</th><th>19</th><th>20</th>
            </tr>

            <!-- 시간 -->
            <tr>
                <th>시간(분)</th>
                <td><input class="input-pattern-time-1"></td>
                <td><input class="input-pattern-time-2"></td>
                <td><input class="input-pattern-time-3"></td>
                <td><input class="input-pattern-time-4"></td>
                <td><input class="input-pattern-time-5"></td>
                <td><input class="input-pattern-time-6"></td>
                <td><input class="input-pattern-time-7"></td>
                <td><input class="input-pattern-time-8"></td>
                <td><input class="input-pattern-time-9"></td>
                <td><input class="input-pattern-time-10"></td>
                <td><input class="input-pattern-time-11"></td>
                <td><input class="input-pattern-time-12"></td>
                <td><input class="input-pattern-time-13"></td>
                <td><input class="input-pattern-time-14"></td>
                <td><input class="input-pattern-time-15"></td>
                <td><input class="input-pattern-time-16"></td>
                <td><input class="input-pattern-time-17"></td>
                <td><input class="input-pattern-time-18"></td>
                <td><input class="input-pattern-time-19"></td>
                <td><input class="input-pattern-time-20" disabled></td>
            </tr>

            <!-- 온도 -->
            <tr>
                <th>온도(℃)</th>
                <td><input class="input-pattern-temp-1"></td>
                <td><input class="input-pattern-temp-2"></td>
                <td><input class="input-pattern-temp-3"></td>
                <td><input class="input-pattern-temp-4"></td>
                <td><input class="input-pattern-temp-5"></td>
                <td><input class="input-pattern-temp-6"></td>
                <td><input class="input-pattern-temp-7"></td>
                <td><input class="input-pattern-temp-8"></td>
                <td><input class="input-pattern-temp-9"></td>
                <td><input class="input-pattern-temp-10"></td>
                <td><input class="input-pattern-temp-11"></td>
                <td><input class="input-pattern-temp-12"></td>
                <td><input class="input-pattern-temp-13"></td>
                <td><input class="input-pattern-temp-14"></td>
                <td><input class="input-pattern-temp-15"></td>
                <td><input class="input-pattern-temp-16"></td>
                <td><input class="input-pattern-temp-17"></td>
                <td><input class="input-pattern-temp-18"></td>
                <td><input class="input-pattern-temp-19"></td>
                <td><input class="input-pattern-temp-20" disabled></td>
            </tr>
        </table>
    </div>

    
    <div class="btn-area">
        <button class="btn btn-save">패턴적용</button>
        <button class="btn btn-close" onclick="window.close()">닫기</button>
    </div>

</div>

<script>
// URL에서 패턴 번호 가져오기
let currentPatternNo = 1; // 기본값

$(document).ready(function () {
    const urlParams = new URLSearchParams(window.location.search);
    const patternNo = urlParams.get('patternNo');
    
    if (patternNo) {
        currentPatternNo = parseInt(patternNo, 10);
        console.log("현재 수정 중인 패턴:", currentPatternNo);
    }
    
    // 패턴 번호 표시
    $(".analog-pattern-number").val(currentPatternNo);
    
    // ✅ 자동 READ 제거 - INFO 그룹에서 직접 데이터만 로드
    loadPatternDataFromINFO();
    
    // 저장 버튼 이벤트
    $(".btn-save").click(savePopupValues);
});

// PLC에서 패턴 데이터 읽기 (READ 비트 트리거)
/* function loadPatternFromPLC() {
    console.log("📖 패턴 " + currentPatternNo + " 읽기 시작...");
    
    $.ajax({
        url: "/posco/monitoring/write/patternInfoRead",
        type: "post",
        data: {
            patternNo: currentPatternNo,
            tagName: "pattern-read-" + currentPatternNo
        },
        success: function () {
            console.log("✅ READ 비트 트리거 완료");
            
            // READ 완료 후 1.5초 대기하고 INFO 그룹에서 데이터 읽기
            setTimeout(function() {
                loadPatternDataFromINFO();
            }, 1500);
        },
        error: function () {
            alert("패턴 읽기 실패");
        }
    });
} */

function loadPatternDataFromINFO() {
    console.log("📊 INFO 그룹에서 데이터 로드 중...");
    
    $(".analog-pattern-number").val(currentPatternNo);
    
    $.ajax({
        url: "/posco/monitoring/read/patternInfoAnalog",
        type: "post",
        success: function(res) {
            if (res.status === "NG") {
                console.warn("⚠️ PLC 연결 끊김 - 2초 후 재시도");
                
                // ✅ 2초 후 재시도
                setTimeout(function() {
                    loadPatternDataFromINFO();
                }, 2000);
                return;
            }
            
            const opcDatas = res.multiValues;
            
            if (!opcDatas || opcDatas.length === 0) {
                console.warn("⚠️ 데이터 없음 - 재시도");
                setTimeout(function() {
                    loadPatternDataFromINFO();
                }, 2000);
                return;
            }
            
            // 시간 데이터 세팅
            for (let i = 1; i <= 20; i++) {
                const tagName = "info-pattern-" + currentPatternNo + "-time-" + i;
                const data = findOpcData(opcDatas, tagName);
                if (data) {
                    $(".input-pattern-time-" + i).val(data.value);
                    console.log("✓ " + tagName + " = " + data.value);
                }
            }
            
            // 온도 데이터 세팅
            for (let i = 1; i <= 20; i++) {
                const tagName = "info-pattern-" + currentPatternNo + "-temp-" + i;
                const data = findOpcData(opcDatas, tagName);
                if (data) {
                    $(".input-pattern-temp-" + i).val(data.value);
                    console.log("✓ " + tagName + " = " + data.value);
                }
            }
            
            console.log("✅ 패턴 " + currentPatternNo + " 데이터 로드 완료");
        },
        error: function(xhr, status, error) {
            console.error("❌ 패턴 데이터 로드 실패:", error);
            
            // ✅ AJAX 에러 시에도 재시도
            setTimeout(function() {
                console.log("🔄 재시도 중...");
                loadPatternDataFromINFO();
            }, 2000);
        }
    });
}

// OPC 데이터에서 특정 태그 찾기
function findOpcData(opcDatas, tagName) {
    for (let i = 0; i < opcDatas.length; i++) {
        if (opcDatas[i][tagName]) {
            return opcDatas[i][tagName];
        }
    }
    return null;
}

// INFO 그룹에서 값 읽기
function loadInfoValue(infoTag, inputSelector) {
    $.ajax({
        url: "/posco/monitoring/read/infoanalog",
        type: "get",
        data: { tagName: infoTag },
        success: function (res) {
            if (res.status === "OK") {
                $(inputSelector).val(res.value);
                console.log("✓ " + infoTag + " → " + inputSelector + " = " + res.value);
            }
        },
        error: function() {
            console.warn("⚠️ " + infoTag + " 읽기 실패");
        }
    });
}

//패턴 수정 (저장)
function savePopupValues() {
    const tagValueMap = [];
    let hasError = false;
    
    // ✅ 시간 데이터 수집 + 검증
    for (let i = 1; i <= 20; i++) {
        const value = $(".input-pattern-time-" + i).val();
        
        // ✅ 빈 값 체크
        if (!value || value.trim() === "") {
            alert("시간 " + i + " 값을 입력해주세요.");
            $(".input-pattern-time-" + i).focus();
            hasError = true;
            break;
        }
        
        // ✅ 숫자 검증
        const numValue = parseInt(value, 10);
        if (isNaN(numValue) || numValue < 0 || numValue > 59999) {
            alert("시간 " + i + " 값은 0~59999 범위 내에서 입력해주세요. (입력값: " + value + ")");
            $(".input-pattern-time-" + i).focus();
            hasError = true;
            break;
        }
        
        tagValueMap.push([
            "input-pattern-time-" + i,
            numValue.toString()  // ✅ 정수로 변환 후 문자열로
        ]);
    }
    
    if (hasError) return;
    
    // ✅ 온도 데이터 수집 + 검증
    for (let i = 1; i <= 20; i++) {
        const value = $(".input-pattern-temp-" + i).val();
        
        // ✅ 빈 값 체크
        if (!value || value.trim() === "") {
            alert("온도 " + i + " 값을 입력해주세요.");
            $(".input-pattern-temp-" + i).focus();
            hasError = true;
            break;
        }
        
        // ✅ 숫자 검증
        const numValue = parseInt(value, 10);
        if (isNaN(numValue) || numValue < 0 || numValue > 1500) {
            alert("온도 " + i + " 값은 0~1500 범위 내에서 입력해주세요. (입력값: " + value + ")");
            $(".input-pattern-temp-" + i).focus();
            hasError = true;
            break;
        }
        
        tagValueMap.push([
            "input-pattern-temp-" + i,
            numValue.toString()  // ✅ 정수로 변환 후 문자열로
        ]);
    }
    
    if (hasError) return;

    if (!confirm("패턴 " + currentPatternNo + "을 수정 하시겠습니까?")) return;

    console.log("💾 저장할 데이터:", tagValueMap);
    console.log("📌 패턴 번호:", currentPatternNo);
    
    // ✅ 저장 버튼 비활성화 (중복 클릭 방지)
    $(".btn-save").prop("disabled", true).text("저장 중...");
    
    writeSequentialToPOPUP(tagValueMap);
}

// POPUP 그룹에 데이터 저장
function writeSequentialToPOPUP(list) {
    var listParam = JSON.stringify(list);
    
    console.log("📤 POPUP 그룹에 데이터 전송 중...");
    console.log("📦 전송 데이터:", listParam);
    
    $.ajax({
        url: "/posco/monitoring/write/patternInputList",
        type: "post",
        traditional: true,
        data: {
            "listParam": listParam,
            "patternNo": currentPatternNo  // ✅ 패턴 번호 전달
        },
        success: function (result) {
            console.log("✅ POPUP 그룹 저장 완료:", result);
            
            if (result.status === "ERROR") {
                alert("저장 실패: " + (result.message || "알 수 없는 오류"));
                $(".btn-save").prop("disabled", false).text("패턴적용");
                return;
            }
            
            // ✅ 1초 대기 후 WRITE 비트 트리거 (PLC 쓰기 완료 대기)
            setTimeout(function() {
                triggerPatternWriteBit();
            }, 1000);
        },
        error: function (xhr, status, error) {
            console.error("❌ 저장 실패:", error);
            alert("저장 실패: " + error);
            $(".btn-save").prop("disabled", false).text("패턴적용");
        }
    });
}

// 패턴별 쓰기 비트 트리거 (INFO 그룹)
function triggerPatternWriteBit() {
    console.log("📝 WRITE 비트 트리거 중...");
    
    $.ajax({
        url: "/posco/monitoring/write/patternInfoWrite",
        type: "post",
        data: {
            patternNo: currentPatternNo,
            tagName: "pattern-write-" + currentPatternNo
        },
        success: function () {
            console.log("✅ 패턴 " + currentPatternNo + " WRITE 비트 트리거 완료");
            
            alert("패턴 " + currentPatternNo + "의 수정이 완료되었습니다.");
            
            // 부모 창 새로고침
            if (window.opener && !window.opener.closed) {
                if (typeof window.opener.updateAllPatternData === 'function') {
                    window.opener.updateAllPatternData();
                }
            }
            
            window.close();
        },
        error: function (xhr, status, error) {
            console.error("❌ WRITE 비트 트리거 실패:", error);
            alert("패턴 WRITE 비트 실패: " + error);
            $(".btn-save").prop("disabled", false).text("패턴적용");
        }
    });
}
</script>

</body>
</html>