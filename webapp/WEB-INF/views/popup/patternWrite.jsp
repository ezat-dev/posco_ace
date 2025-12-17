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
                <td><input class="input-pattern-time-20"></td>
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
                <td><input class="input-pattern-temp-20"></td>
            </tr>
        </table>
    </div>

    
    <div class="btn-area">
        <button class="btn btn-save">저장</button>
        <button class="btn btn-close" onclick="window.close()">닫기</button>
    </div>

</div>

<script>


// ===============================
// (1) 오버뷰 아날로그 값 READ
// ===============================
$(document).ready(function () {

    // ✅ 패턴 번호
    loadAnalogValue("analog-pattern-number", ".analog-pattern-number");

    // 시간
    loadAnalogValue("analog-pattern-time-1", ".input-pattern-time-1");
    loadAnalogValue("analog-pattern-time-2", ".input-pattern-time-2");
    loadAnalogValue("analog-pattern-time-3", ".input-pattern-time-3");
    loadAnalogValue("analog-pattern-time-4", ".input-pattern-time-4");
    loadAnalogValue("analog-pattern-time-5", ".input-pattern-time-5");
    loadAnalogValue("analog-pattern-time-6", ".input-pattern-time-6");
    loadAnalogValue("analog-pattern-time-7", ".input-pattern-time-7");
    loadAnalogValue("analog-pattern-time-8", ".input-pattern-time-8");
    loadAnalogValue("analog-pattern-time-9", ".input-pattern-time-9");
    loadAnalogValue("analog-pattern-time-10", ".input-pattern-time-10");
    loadAnalogValue("analog-pattern-time-11", ".input-pattern-time-11");
    loadAnalogValue("analog-pattern-time-12", ".input-pattern-time-12");
    loadAnalogValue("analog-pattern-time-13", ".input-pattern-time-13");
    loadAnalogValue("analog-pattern-time-14", ".input-pattern-time-14");
    loadAnalogValue("analog-pattern-time-15", ".input-pattern-time-15");
    loadAnalogValue("analog-pattern-time-16", ".input-pattern-time-16");
    loadAnalogValue("analog-pattern-time-17", ".input-pattern-time-17");
    loadAnalogValue("analog-pattern-time-18", ".input-pattern-time-18");
    loadAnalogValue("analog-pattern-time-19", ".input-pattern-time-19");
    loadAnalogValue("analog-pattern-time-20", ".input-pattern-time-20");

    // 온도
    loadAnalogValue("analog-pattern-temp-1", ".input-pattern-temp-1");
    loadAnalogValue("analog-pattern-temp-2", ".input-pattern-temp-2");
    loadAnalogValue("analog-pattern-temp-3", ".input-pattern-temp-3");
    loadAnalogValue("analog-pattern-temp-4", ".input-pattern-temp-4");
    loadAnalogValue("analog-pattern-temp-5", ".input-pattern-temp-5");
    loadAnalogValue("analog-pattern-temp-6", ".input-pattern-temp-6");
    loadAnalogValue("analog-pattern-temp-7", ".input-pattern-temp-7");
    loadAnalogValue("analog-pattern-temp-8", ".input-pattern-temp-8");
    loadAnalogValue("analog-pattern-temp-9", ".input-pattern-temp-9");
    loadAnalogValue("analog-pattern-temp-10", ".input-pattern-temp-10");
    loadAnalogValue("analog-pattern-temp-11", ".input-pattern-temp-11");
    loadAnalogValue("analog-pattern-temp-12", ".input-pattern-temp-12");
    loadAnalogValue("analog-pattern-temp-13", ".input-pattern-temp-13");
    loadAnalogValue("analog-pattern-temp-14", ".input-pattern-temp-14");
    loadAnalogValue("analog-pattern-temp-15", ".input-pattern-temp-15");
    loadAnalogValue("analog-pattern-temp-16", ".input-pattern-temp-16");
    loadAnalogValue("analog-pattern-temp-17", ".input-pattern-temp-17");
    loadAnalogValue("analog-pattern-temp-18", ".input-pattern-temp-18");
    loadAnalogValue("analog-pattern-temp-19", ".input-pattern-temp-19");
    loadAnalogValue("analog-pattern-temp-20", ".input-pattern-temp-20");

    // 저장 버튼
    $(".btn-save").click(savePopupValues);
});


// ===============================
// (2) 아날로그 READ
// ===============================
function loadAnalogValue(tag, selector) {
    $.ajax({
        url: "/posco/monitoring/read/analog",
        type: "get",
        data: { tagName: tag },
        success: function (res) {
            if (res.status === "OK") {
                $(selector).val(res.value);
            }
        }
    });
}


// ===============================
// (3) 저장 → POPUP WRITE
// ===============================
function savePopupValues() {

    const tagValueMap = [
        ["input-pattern-time-1", $(".input-pattern-time-1").val()],
        ["input-pattern-time-2", $(".input-pattern-time-2").val()],
        ["input-pattern-time-3", $(".input-pattern-time-3").val()],
        ["input-pattern-time-4", $(".input-pattern-time-4").val()],
        ["input-pattern-time-5", $(".input-pattern-time-5").val()],
        ["input-pattern-time-6", $(".input-pattern-time-6").val()],
        ["input-pattern-time-7", $(".input-pattern-time-7").val()],
        ["input-pattern-time-8", $(".input-pattern-time-8").val()],
        ["input-pattern-time-9", $(".input-pattern-time-9").val()],
        ["input-pattern-time-10", $(".input-pattern-time-10").val()],
        ["input-pattern-time-11", $(".input-pattern-time-11").val()],
        ["input-pattern-time-12", $(".input-pattern-time-12").val()],
        ["input-pattern-time-13", $(".input-pattern-time-13").val()],
        ["input-pattern-time-14", $(".input-pattern-time-14").val()],
        ["input-pattern-time-15", $(".input-pattern-time-15").val()],
        ["input-pattern-time-16", $(".input-pattern-time-16").val()],
        ["input-pattern-time-17", $(".input-pattern-time-17").val()],
        ["input-pattern-time-18", $(".input-pattern-time-18").val()],
        ["input-pattern-time-19", $(".input-pattern-time-19").val()],
        ["input-pattern-time-20", $(".input-pattern-time-20").val()],

        ["input-pattern-temp-1", $(".input-pattern-temp-1").val()],
        ["input-pattern-temp-2", $(".input-pattern-temp-2").val()],
        ["input-pattern-temp-3", $(".input-pattern-temp-3").val()],
        ["input-pattern-temp-4", $(".input-pattern-temp-4").val()],
        ["input-pattern-temp-5", $(".input-pattern-temp-5").val()],
        ["input-pattern-temp-6", $(".input-pattern-temp-6").val()],
        ["input-pattern-temp-7", $(".input-pattern-temp-7").val()],
        ["input-pattern-temp-8", $(".input-pattern-temp-8").val()],
        ["input-pattern-temp-9", $(".input-pattern-temp-9").val()],
        ["input-pattern-temp-10", $(".input-pattern-temp-10").val()],
        ["input-pattern-temp-11", $(".input-pattern-temp-11").val()],
        ["input-pattern-temp-12", $(".input-pattern-temp-12").val()],
        ["input-pattern-temp-13", $(".input-pattern-temp-13").val()],
        ["input-pattern-temp-14", $(".input-pattern-temp-14").val()],
        ["input-pattern-temp-15", $(".input-pattern-temp-15").val()],
        ["input-pattern-temp-16", $(".input-pattern-temp-16").val()],
        ["input-pattern-temp-17", $(".input-pattern-temp-17").val()],
        ["input-pattern-temp-18", $(".input-pattern-temp-18").val()],
        ["input-pattern-temp-19", $(".input-pattern-temp-19").val()],
        ["input-pattern-temp-20", $(".input-pattern-temp-20").val()]
    ];

    if (!confirm("저장하시겠습니까?")) return;

    writeSequential(tagValueMap, 0);
}


// ===============================
// (4) 순차 WRITE
// ===============================
function writeSequential(list, idx) {

    if (idx >= list.length) {
        triggerPatternWriteBit();
        return;
    }

    const tagName = list[idx][0];
    const value = list[idx][1];

    $.ajax({
        url: "/posco/monitoring/write/patternInput",
        type: "post",
        data: {
            tagName: tagName,
            value: value
        },
        success: function () {
            writeSequential(list, idx + 1);
        },
        error: function () {
            alert("저장 실패 : " + tagName);
        }
    });
}


// ===============================
// (5) pattern-write BIT
// ===============================
function triggerPatternWriteBit() {

    $.ajax({
        url: "/posco/monitoring/write/patternWriteBit",
        type: "post",
        data: {
            tagName: "pattern-write",
            value: 1
        },
        success: function () {

            // ⭐ 부모 화면 즉시 갱신
            if (window.opener && !window.opener.closed) {
                window.opener.overviewListView();
                window.opener.overviewListViewString();
            }

            alert("저장되었습니다.");
            window.close();
        },
        error: function () {
            alert("패턴 WRITE 비트 실패");
        }
    });
}


</script>


</body>
</html>
