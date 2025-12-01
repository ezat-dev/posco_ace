<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>침탄로작업표준</title>
    <link rel="stylesheet" href="/posco/css/login/style.css">
     <link rel="stylesheet" href="/posco/css/tabBar/tabBar.css">
     <link rel="stylesheet" href="/posco/css/overview/style.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
<%@include file="../include/pluginpage.jsp" %>     
    
    <style>
    	 body {overflow:hidden}
			/* 📑 탭 스타일 */
.tabs {
	display: flex;
	gap: 15px;
}
.division-select {
	width: 120px;
	padding: 6px;
	border: 1px solid #aaa;
	border-radius: 3px;
	font-size: 13px;
}
.tabs input[type="radio"] {
	display: none;
}

.tabs label {
	padding: 5px 12px;
	border: 1px solid #ccc;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.2s ease, color 0.2s ease;
}

.tabs input[type="radio"]:checked + label {
	background-color: #FFD700;
	border-color: #FFC107;
	font-weight: bold;
	color: #000;
}

/* 🔍 거래처 검색 버튼 */
.search-box {
	display: flex;
	align-items: center;
	gap: 5px;
}

.search-box input {
	flex: 1;
}

.search-box .search-btn {
	padding: 5px 10px;
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.search-box .search-btn:hover {
	background-color: #45a049;
}

/* ⚙️ 공정순서 체크박스 */
.process-list {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	padding: 5px 10px;
}

.process-list label {
	display: flex;
	align-items: center;
	gap: 5px;
	cursor: pointer;
}

.detail {
	background: #ffffff;
	border: 1px solid #000000;
	width: 300px; /* 가로 길이 고정 */
	height: 110px; /* 세로 길이 고정 */
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.7);
	margin: 20px auto; /* 중앙 정렬 */
	padding: 20px;
	border-radius: 5px; /* 모서리 둥글게 */
	overflow-y: auto; /* 세로 스크롤 추가 */
	position: relative; /* 자식 요소의 절대 위치 설정을 위한 기준 */
	overflow:hidden
}

.insideTable {
	width: 100%; /* 내부 테이블 너비 100% */
	border-collapse: collapse;
}

.insideTable th, .insideTable td {
	padding: 5px; /* 셀 패딩을 줄여 세로 길이 감소 */
	border: 1px solid #ccc; /* 셀 경계선 */
	text-align: left; /* 텍스트 왼쪽 정렬 */
}

.insideTable th {
	background: #f0f0f0; /* 헤더 배경색 */
	font-weight: bold; /* 굵은 글씨 */
}

.basic {
	background: #ffffff;
	border: 1px solid #949494; /* 경계선 색상 */
	width: calc(50% - 10px); /* 입력 박스 너비 조정 */
	padding: 5px; /* 내부 여백 */
	box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1); /* 내부 그림자 */
	border-radius: 3px; /* 둥근 모서리 */
	display: inline-block; /* 인라인 블록으로 설정하여 가로 정렬 */
	margin-right: 5px; /* 입력 박스 간격 조정 */
}

.basic:last-child {
	margin-right: 0; /* 마지막 입력 박스의 여백 제거 */
}



.btnSearchCorp:hover, .btn1T:hover {
	background: #0056b3; /* 호버 시 색상 변경 */
}

.resultArea2 {
	background: #f9f9f9; /* 결과 영역 배경색 */
	padding: 10px; /* 내부 여백 */
	border: 1px solid #ddd; /* 경계선 */
	border-radius: 5px; /* 모서리 둥글게 */
}

.imgArea {
	width: 200px; /* 이미지 영역 너비 */
	height: 150px; /* 이미지 영역 높이 */
	border: 1px solid #ddd; /* 경계선 */
	margin-bottom: 10px; /* 하단 여백 */
}

.imgClass {
	width: 100%; /* 이미지 너비 */
	height: 100%; /* 이미지 높이 */
	object-fit: cover; /* 이미지 비율 유지 */
}

.tdRight {
	text-align: right; /* 오른쪽 정렬 */
}

.thSub2 {
	width: 100px; /* 서브 헤더 너비 */
}
.thSub {
	width: 100px; /* 서브 헤더 너비 */
}
.valClean {
	margin-left: 5px; /* 여백 */
}

textarea {
	border: 1px solid #949494; /* 경계선 색상 */
	padding: 5px; /* 내부 여백 */
	width: calc(100% - 10px); /* 너비 100%에서 여백 제외 */
	height: 100px; /* 높이 */
	border-radius: 3px; /* 둥근 모서리 */
}

.vacuum-heatModal {
	position: fixed; /* 화면에 고정 */
	top: 50%; /* 수직 중앙 */
	left: 50%; /* 수평 중앙 */
	display: none;
	transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
	z-index: 1000; /* 다른 요소 위에 표시 */
}

.header {
	display: flex;
	justify-content: center;
	align-items: center;
	position: relative; /* 닫기버튼의 절대 위치 기준 */
	margin-bottom: 10px;
	background-color: #33363d;
	height: 50px;
	color: white;
	font-size: 20px;
	text-align: center;
}

.header-close {
	position: absolute;
	right: 15px;
	top: 10px;
	cursor: pointer;
	font-size: 20px;
	color: white;
}
.btnSaveClose {
	display: flex;
	justify-content: center; /* 가운데 정렬 */
	gap: 20px; /* 버튼 사이 여백 */
}
.btnSaveClose button {
	width: 150px;
	height: 45px;
	background-color: #FFD700; /* 기본 배경 - 노란색 */
	color: black;
	border: 2px solid #FFC107; /* 노란 테두리 */
	border-radius: 5px;
	font-weight: bold;
	text-align: center;
	cursor: pointer;
	line-height: 35px;
	margin: 0 10px;
	transition: background-color 0.3s ease, transform 0.2s ease;
}

/* 저장 버튼 호버 시 */
.btnSaveClose .save:hover {
	background-color: #FFC107;
	transform: scale(1.05);
}

/* 닫기 버튼 - 회색 톤 */
.btnSaveClose .close {
	background-color: #A9A9A9;
	color: black;
	border: 2px solid #808080;
}

/* 닫기 버튼 호버 시 */
.btnSaveClose .close:hover {
	background-color: #808080;
	transform: scale(1.05);
}

.box1 {
	display: flex;
	justify-content: right;
	align-items: center;
	width: 1500px;
	margin-left: -250px;
}

.box1 input{
	width : 5%;
}
.box1 select{
	width: 5%
}
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0,0,0,0.6);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 9999;
}

.modal-content {
  background: white;
  padding: 20px;
  border-radius: 8px;
  width: 90%;
  max-width: 1000px;
  position: relative;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  font-weight: bold;
  font-size: 18px;
  margin-bottom: 10px;
}

.modal-close {
  cursor: pointer;
  font-size: 24px;
}
.formTable {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
  font-size: 15px;
}

.formTable th {
  width: 20%;
  background-color: #f3f3f3;
  border: 1px solid #ddd;
  text-align: center;
  padding: 8px;
  font-weight: bold;
}

.formTable td {
  border: 1px solid #ddd;
  padding: 8px;
}

.inputField {
  width: 95%;
  height: 30px;
  padding: 5px;
  border: 1px solid #aaa;
  border-radius: 4px;
  box-sizing: border-box;
}
    </style>
    
    
    <body>
  	    
    
  <div class="vacuum-heatModal">    
    <div class="detail">
      <div class="header">
        	진공로히터
        <span class="header-close">&times;</span>
      </div>

      <div class="btnSaveClose">
        <button class="off" type="button" onclick="">OFF</button>
        <button class="on" type="button" onclick="">ON</button>
      </div>
    </div>
  </div>
	    
	    
	    
	    
	    
	    
<script>




/* //드래그 기능 추가
const modal = document.querySelector('.vacuum-heatModal');
const header = document.querySelector('.header'); // 헤더를 드래그할 요소로 사용

header.addEventListener('mousedown', function(e) {
	// transform 제거를 위한 초기 위치 설정
	const rect = modal.getBoundingClientRect();
	modal.style.left = rect.left + 'px';
	modal.style.top = rect.top + 'px';
	modal.style.transform = 'none'; // 중앙 정렬 해제

	let offsetX = e.clientX - rect.left;
	let offsetY = e.clientY - rect.top;

	function moveModal(e) {
		modal.style.left = (e.clientX - offsetX) + 'px';
		modal.style.top = (e.clientY - offsetY) + 'px';
	}

	function stopMove() {
		window.removeEventListener('mousemove', moveModal);
		window.removeEventListener('mouseup', stopMove);
	}

	window.addEventListener('mousemove', moveModal);
	window.addEventListener('mouseup', stopMove);
});
	

// 모달 열기
const insertButton = document.querySelector('.vacuum-heat');
const vacuum-heatModal = document.querySelector('.vacuum-heatModal');
const closeButton = document.querySelector('.close');
const headerCloseButton = document.querySelector('.header-close');


insertButton.addEventListener('click', function() {
	vacuum-heatModal.style.display = 'block'; // 모달 표시

	
	$('.delete').hide();
});

closeButton.addEventListener('click', function() {
	vacuum-heatModal.style.display = 'none'; // 모달 숨김
});

headerCloseButton.addEventListener('click', function() {
	vacuum-heatModal.style.display = 'none';
}); */























</script>

	</body>
</html>
