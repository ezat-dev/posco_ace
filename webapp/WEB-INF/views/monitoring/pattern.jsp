<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>알람발생 빈도</title>
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

    </style>

<body>
    <main class="main">
    
    
      <div class="st-table-wrap">
    <table class="st-table">

        
        <colgroup>
            <col span="21">
        </colgroup>

        
        <tr>
            <th colspan="3" class="pattern-number"></th>
            <th colspan="19">진공 열처리로 패턴 프로그램</th>
        </tr>

        
        <tr>
            <td>Seg</td>
            <td>1</td>
            <td>2</td>
            <td>3</td>
            <td>4</td>
            <td>5</td>
            <td>6</td>
            <td>7</td>
            <td>8</td>
            <td>9</td>
            <td>10</td>
            <td>11</td>
            <td>12</td>
            <td>13</td>
            <td>14</td>
            <td>15</td>
            <td>16</td>
            <td>17</td>
            <td>18</td>
            <td>19</td>
            <td>20</td>
        </tr>

        
        <tr>
            <td>시간(분)</td>
            <td class="pattern-time-1"></td>
            <td class="pattern-time-2"></td>
            <td class="pattern-time-3"></td>
            <td class="pattern-time-4"></td>
            <td class="pattern-time-5"></td>
            <td class="pattern-time-6"></td>
            <td class="pattern-time-7"></td>
            <td class="pattern-time-8"></td>
            <td class="pattern-time-9"></td>
            <td class="pattern-time-10"></td>
            <td class="pattern-time-11"></td>
            <td class="pattern-time-12"></td>
            <td class="pattern-time-13"></td>
            <td class="pattern-time-14"></td>
            <td class="pattern-time-15"></td>
            <td class="pattern-time-16"></td>
            <td class="pattern-time-17"></td>
            <td class="pattern-time-18"></td>
            <td class="pattern-time-19"></td>
            <td class="pattern-time-20"></td>
        </tr>

        
        <tr>
            <td>온도(℃)</td>
            <td class="pattern-temp-1"></td>
            <td class="pattern-temp-2"></td>
            <td class="pattern-temp-3"></td>
            <td class="pattern-temp-4"></td>
            <td class="pattern-temp-5"></td>
            <td class="pattern-temp-6"></td>
            <td class="pattern-temp-7"></td>
            <td class="pattern-temp-8"></td>
            <td class="pattern-temp-9"></td>
            <td class="pattern-temp-10"></td>
            <td class="pattern-temp-11"></td>
            <td class="pattern-temp-12"></td>
            <td class="pattern-temp-13"></td>
            <td class="pattern-temp-14"></td>
            <td class="pattern-temp-15"></td>
            <td class="pattern-temp-16"></td>
            <td class="pattern-temp-17"></td>
            <td class="pattern-temp-18"></td>
            <td class="pattern-temp-19"></td>
            <td class="pattern-temp-20"></td>
        </tr>

    </table>
</div>


	<div class="pattern-read">패턴 읽기</div>
	<div class="pattern-write">패턴 쓰기</div>
	
	
	
	
	<div class="pattern-box">
    <!-- 왼쪽 영역 -->
    <div class="pattern-left">
        <div class="pattern-label">운전 패턴번호</div>
        <input type="text" class="pattern-input">
    </div>

    <!-- 오른쪽 영역 -->
    <div class="pattern-right">
        적용
    </div>
</div>

	
	
	
		
	
	
	
	
	
	
	
	
	</div>
	
	
    </main>
    
<script>




</script>

</body>
</html>