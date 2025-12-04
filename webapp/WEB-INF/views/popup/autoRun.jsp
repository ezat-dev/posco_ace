<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>진공로 히터 제어</title>

    <style>
       body {
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
}

/* 상단 제목 영역 */
.header {
    background-color: #33363d;
    color: white;
    padding: 10px 0;
    font-size: 18px;
    text-align: center;
    position: relative;
}

/* 팝업 컨테이너 */
.popup-box {
    width: 100%;
    padding: 10px 0 20px 0;   /* 최소한의 여백 */
    text-align: center;
}

/* 버튼 영역 */
.btnSaveClose {
    display: flex;
    justify-content: center;
    gap: 20px;   /* 버튼 사이 간격 */
    margin-top: 15px;
}

.btnSaveClose button {
    width: 120px;
    height: 40px;
    font-size: 16px;
    font-weight: bold;
    border-radius: 4px;
    cursor: pointer;
    border: none;
}

/* OFF 버튼 */
.off {
    background-color: #d9534f;
    color: white;
}
.off:hover {
    background-color: #c9302c;
}

/* ON 버튼 */
.on {
    background-color: #5cb85c;
    color: white;
}
.on:hover {
    background-color: #449d44;
}

/* 자동운전종료 버튼 */
.stop {
    background-color: #f0ad4e;
    color: white;
}
.stop:hover {
    background-color: #ec971f;
}


    </style>
</head>

<body>

    

   <body style="margin:0; padding:0; background:#fff;">

    <div class="popup-box">

    <div class="header">
       운전선택
    </div>

    <!-- 모드 선택 버튼 -->
    <div class="btnSaveClose">
        <button class="off" type="button">수동모드</button>
        <button class="on" type="button">자동모드</button>
        <button class="stop" type="button">자동운전종료</button>
    </div>

</div>


</body>


</body>
</html>
