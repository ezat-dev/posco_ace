<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>냉각타이머</title>
<meta name="viewport" content="width=device-width,initial-scale=1">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
    html,body{margin:0;padding:0;height:100%;font-family:Arial,Helvetica,sans-serif;background:#fff;}
    .container{box-sizing:border-box;width:100%;height:100%;display:flex;flex-direction:column;align-items:center;justify-content:center;padding:6px;}

    .header{width:100%;text-align:center;background:#33363d;color:#fff;padding:6px 0;font-size:16px;border-radius:4px;}

    .box-wrap { margin-top: 16px; width: 90%; max-width: 300px; }
    .row { display:flex; justify-content:space-between; margin-bottom:12px; }
    .row label { font-weight:600; }
    .row input {
        width:120px; height:32px; padding:4px;
        font-size:16px; border:1px solid #ccc; border-radius:4px; text-align:right;
    }

    .btn-save {
        width:180px; height:38px; background:#4caf50; color:#fff;
        border:none; border-radius:6px; font-size:17px; cursor:pointer;
        margin-top:20px; font-weight:700;
    }

   .heat-inline {
    display: flex;
    align-items: center;
    gap: 10px;       /* 요소 간 간격 */
}

.heat-inline label {
    min-width: 70px; /* 라벨 폭 고정 (조정 가능) */
    font-weight: 600;
}

.heat-inline input {
    width: 80px;     /* 입력박스 크기 조절 */
    height: 32px;
    padding: 4px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 4px;
    text-align: right;
}

.unit-text {
    font-size: 16px;
    font-weight: bold;
}

</style>
</head>

<body>
<div class="container">

    <div class="header">냉각타이머 설정</div>

    <div class="box-wrap">
        <div class="row heat-inline">
    <label>설정치</label>

    <input type="text" class="input-cool-sv">
</div>
    </div>

    <button class="btn-save" id="btnSave">저장</button>
</div>

<div id="toast" class="toast"></div>

<script>


// ===============================
// (1) 오버뷰 아날로그 값 읽기
// ===============================
$(document).ready(function () {
    // 팝업 로딩 시 – 오버뷰 태그 읽어서 인풋에 표시
    loadAnalogValue("analog-timer-sv", ".input-cool-sv");

    // 저장 클릭 시
    $("#btnSave").click(function () {
        savePopupValues();
    });
});


// ===============================
// (1) 오버뷰 값 읽기
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
// (2) 저장 → POPUP 태그에 쓰기
// ===============================
function savePopupValues() {

    const v1 = $(".input-cool-sv").val().trim();

    // =============================
    // 값 검증 (정수, 0~999)
    // =============================
    const intVal = parseInt(v1);

    if (isNaN(intVal) || intVal < 0 || intVal > 9999) {
        alert("0 ~ 9999 사이의 정수만 입력 가능합니다.");
        return;
    }

    // =============================
    // 저장 확인창
    // =============================
    if (!confirm("저장하시겠습니까?")) {
        return;
    }

    // =============================
    // 저장 호출
    // =============================
    $.ajax({
        url: "/posco/monitoring/write/popInput",
        type: "post",
        data: {
            tagName: "input-cool-sv",
            value: intVal
        },
        success: function (res) {
        	alert("저장되었습니다.");
        }
    });
}


</script>
</body>
</html>
