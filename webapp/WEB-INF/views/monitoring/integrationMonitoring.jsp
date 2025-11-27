<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>침탄로작업표준</title>
    <link rel="stylesheet" href="/mibogear/css/login/style.css">
     <link rel="stylesheet" href="/mibogear/css/tabBar/tabBar.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
<%@include file="../include/pluginpage.jsp" %>     
    
    <style>
    
	.container {
		display: flex;
		justify-content: space-between;
/*		margin-left:1008px;
		margin-top:200px;*/
	}

.chimStandardModal {
    position: fixed; /* 화면에 고정 */
    top: 50%; /* 수직 중앙 */
    left: 55%; /* 수평 중앙 */
    display : none;
    transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
    z-index: 1000; /* 다른 요소 위에 표시 */
}
#editPop {
    background: #ffffff;
    border: 1px solid #000000;
    width: 1300px; /* 가로 길이 고정 */
    height: 720px; /* 세로 길이 고정 */
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.7);
    margin: 20px auto; /* 중앙 정렬 */
    padding: 20px;
    border-radius: 5px; /* 모서리 둥글게 */
    overflow-y: auto; /* 세로 스크롤 추가 */
}

.popField {
    margin-bottom: 20px; /* 각 필드셋 간의 여백 */
    border: 1px solid #ccc; /* 테두리 */
    border-radius: 5px; /* 둥근 모서리 */
    padding: 10px; /* 내부 여백 */
}

.popField legend {
    font-weight: bold; /* 굵은 글씨 */
    padding: 0 10px; /* 레전드 패딩 */
}

.popFieldTable, .popFieldTable2, .popFieldTable3 {
    width: 100%; /* 테이블 너비 100% */
    border-collapse: collapse; /* 테두리 겹침 제거 */
}

.popFieldTable th,
.popFieldTable td,
.popFieldTable2 th,
.popFieldTable2 td,
.popFieldTable3 th,
.popFieldTable3 td {
    padding: 5px; /* 셀 패딩 */
    border: 1px solid #ccc; /* 셀 경계선 */
}

.basic {
    background: #ffffff;
    border: 1px solid #949494; /* 경계선 색상 */
    width: calc(100% - 10px); /* 기본 너비 100%에서 여백 제외 */
    padding: 5px; /* 내부 여백 */
    box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1); /* 내부 그림자 */
    border-radius: 3px; /* 둥근 모서리 */
}

.basic[readonly] {
    background-color: #f9f9f9; /* 읽기 전용 필드 색상 */
}

.imgArea {
    width: 100%; /* 이미지 영역 너비 */
    height: 90px; /* 이미지 영역 높이 */
    border: 1px solid #ddd; /* 경계선 */
    
    margin-bottom: 10px; /* 하단 여백 */
}

.imgArea img {
    width: 100%; /* 이미지 너비 */
    height: 100%; /* 이미지 높이 */
    object-fit: cover; /* 이미지 비율 유지 */
}
.header {
    display: flex; /* 플렉스 박스 사용 */
    justify-content: center; /* 중앙 정렬 */
    align-items: center; /* 수직 중앙 정렬 */
    margin-bottom: 10px; /* 상단 여백 */
    background-color: #33363d; /* 배경색 */
    height: 50px; /* 높이 */
    color: white; /* 글자색 */
    font-size: 20px; /* 글자 크기 */
    text-align: center; /* 텍스트 정렬 */
    position: relative;
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
	margin-top: 30px; /* 모달 내용과의 간격 */
	margin-bottom: 20px; /* 모달 하단과 버튼 사이 간격  */
}
.btnSaveClose button {
	width: 100px;
	height: 35px;
	background-color: #FFD700; /* 기본 배경 - 노란색 */
	color: black;
	border: 2px solid #FFC107; /* 노란 테두리 */
	border-radius: 5px;
	font-weight: bold;
	text-align: center;
	cursor: pointer;
	line-height: 35px;
	margin: 0 10px;
	margin-top: 10px;
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
    
body{
	font-size : 15px;
}
.box1 {
	display: flex;
	justify-content: right;
	align-items: center;
	width: 1500px;
	margin-left: -940px;
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
    </style>
    
    
    <body>
    
    <div class="tab">
    <div class="box1">
         <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>		
	</div>
    <div class="button-container">
        <button class="select-button" onclick="getChimStandardList();">
            <img src="/mibogear/css/image/search-icon.png" alt="select" class="button-image">
           
        </button>
        <button class="insert-button">
            <img src="/mibogear/css/image/insert-icon.png" alt="insert" class="button-image">
          
        </button>
        <button class="excel-button">
            <img src="/mibogear/css/image/excel-icon.png" alt="excel" class="button-image">
            
        </button>
        <button class="printer-button" style="pointer-events: none; opacity: 0.5; cursor: not-allowed; filter: grayscale(100%); ">
            <img src="/mibogear/css/image/printer-icon.png" alt="printer" class="button-image">
            
        </button>
    </div>
</div>
    
    
    <main class="main">
		<div class="container">
			<div id="tab1" class="tabulator"></div>
		</div>
	</main>




<form method="post" class="corrForm" id="chimStandardForm" name="chimStandardForm">	    
   <div class="chimStandardModal">    
	
      <div id="editPop">
       <div class="header">
       			침탄로표준등록
       			<span class="header-close">&times;</span>
       </div>
        <fieldset class="popField">
          <legend>제품정보</legend>
          <fieldset class="popField">
              <legend>제품사진</legend>
              <div class="findImage">
                <input type="hidden" name="type" value="standard">
                
                
                <div class="imgArea" id="previewId7" style="height:90px;border:1px solid #ddd;">
                  <img class="rp-img-popup" id="prev_previewId7"  width="30%" height="100%">
                </div>
              </div>
            </fieldset><table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
          <colgroup span="8">
            <col width="7%">
            <col width="18%">
            <col width="7%">
            <col width="18%">
            <col width="7%">
            <col width="18%">
            <col width="7%">
            <col width="18%">
          </colgroup>
            
          <tbody><tr>
            <th class="left">고객명<input id="prod_code" name="prod_code" type="hidden" value=""></th>
            <td class=""><input id="corp_name" name="corp_name" class="basic" type="text" style="width:70%;" value="" readonly="">
            <input class="" type="button" title="제품선택" onclick="openProductListModal();" value="검색"></td>
            <th class="">단중(g)</th>
            <td class=""><input id="prod_danj" name="prod_danj" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
            <th class="">도번/품번</th>
            <td class=""><input id="prod_no" name="prod_no" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
            <th class="">품명</th>
            <td class=""><input id="prod_name" name="prod_name" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
          </tr>
          <tr>
            <th class="left">재질</th>
            <td class=""><input id="prod_jai" name="prod_jai" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
            <th class="">단가</th>
            <td class=""><input id="prod_dang" name="prod_dang" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
            <th class="">주문번호</th>
            <td class=""><input id="prodC_cno" name="prodC_cno" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
            <th class="">PWS No.</th>
            <td class=""><input id="prod_pwsno" name="prod_pwsno" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
          </tr>
          <tr>
            <th class="">공정</th>
            <td class=""><input id="tech_te" name="tech_te" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
            <th class="left">도면/공정도</th>
            <td class=""><input id="prod_do" name="prod_do" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
            <th class="left">Ref No.</th>
            <td class=""><input id="prod_refno" name="prod_refno" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
            <th class="left">검사규격</th>
            <td class=""><input id="prod_gyu" name="prod_gyu" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
          </tr>
          <tr>
            <!-- <th class="">ECD</th>
            <td class=""><input id="prodE5" name="prodE5" class="basic" type="text" style="width:100%;" value="" readonly /></td>
            <th class="left">Ra%</th>
            <td class=""><input id="prodRa" name="prodRa" class="basic" type="text" style="width:100%;" value="" readonly/></td> -->
            <th class="left">기종</th>
            <td class=""><input id="prod_kijong" name="prod_kijong" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
            <td class=""><input id="prod_appear" name="prod_appear" class="basic" type="hidden" style="width:90%;" value="" readonly=""></td>
            <td class=""><input id="prod_transform" name="prod_transform" class="basic" type="hidden" style="width:90%;" value="" readonly=""></td>
            <th class="left" hidden="">기종</th>
            <td class="" hidden="">&gt;<input id="prod_cd" name="prod_cd" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
          </tr>
        </tbody></table>
        </fieldset>

        <table cellspacing="0" cellpadding="0" width="100%" class="">
        <colgroup span="2">
          <col width="70%">
          <col width="30%">
        </colgroup>
        <tbody><tr>
          <td class="" valign="top">
            <div class="">
              <fieldset class="popField">
              <legend>요구규격</legend>
                <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
                  <colgroup span="5">
                    <col width="3%">
                    <col width="5%">
                    <col width="3%">
                    <col width="5%">
                    <col width="3%">
                    <col width="5%">
                    <col width="2%">
                    <col width="5%">
                  </colgroup>
                  <tbody><tr>
                    <th class="">표면경도</th>
                    <td class=""><input id="prod_pg" name="prod_pg" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
                    <th class="">심부경도</th>
                    <td class=""><input id="prod_sg" name="prod_sg" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
                    <th class="">금속조직</th>
                    <td class=""><input id="prod_e1" name="prod_e1" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
                    <th class="">변형량</th>
                    <td class=""><input id="prod_e3" name="prod_e3" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
                  </tr>
                  <tr>
                    <th class="" hidden="">표면경도 비고</th>
                    <td class="" hidden=""><input id="prod_pg3" name="prod_pg3" class="basic" type="text" style="width:90%; display:none;" value="" readonly=""></td>
                    <th class="" hidden="">심부경도 비고</th>
                    <td class="" hidden=""><input id="prod_sg3" name="prod_sg3" class="basic" type="text" style="width:90%; display:none;" value="" readonly=""></td>
                    <!-- <th class="">표면경도 (실측치)</th>
                    <td class=""><input id="prodPgs" name="prodPgs" class="basic" type="text" style="width:100%;" value="" readonly/></td> -->
                    <!-- <th class="">경화거리(ECD)</th>
                    <td class=""><input id="prod_khecd" name="prod_khecd" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
                    <th class="">경화거리(TCD)</th>
                    <td class=""><input id="prod_khtcd" name="prod_khtcd" class="basic" type="text" style="width:90%;" value="" readonly=""></td> -->
                  </tr>
                    <tr>
                    <th class="">경화깊이</th>
                    <td class=""><input id="prod_gd1" name="prod_gd1" class="basic" type="text" style="width:90%;" value="" readonly=""></td><td class="" align="center">기준</td><td class=""><input id="prod_gd2" name="prod_gd2" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
                    <td class="" align="center">~</td><td class=""><input id="prod_gd5" name="prod_gd5" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
                    </tr>
                    <tr>
                    <input id="prod_cd" name="prod_cd" class="basic" type="hidden" value="" readonly="">
                    <input id="prod_e5" name="prod_e5" class="basic" type="hidden" value="" readonly="">
                    <input id="prod_ra" name="prod_ra" class="basic" type="hidden" value="" readonly="">
                    <input id="prod_pgs" name="prod_pgs" class="basic" type="hidden" value="" readonly="">
                    </tr>
                </tbody></table>
              </fieldset>
            </div>

            <div class="" hidden="">
              <fieldset class="popField">
                <legend>침탄경화깊이</legend>
                <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
                  <colgroup span="5">
                    <col width="1%">
                    <col width="8%">
                    <col width="1%">
                    <col width="8%">
                    <col width="1%">
                    <col width="8%">
                  </colgroup>
                  <tbody><tr>
                    <th class="">0.28mm</th>
                    <td class=""><input id="prod_gd1" name="prod_gd1" class="basic" type="text" style="width:100%;" value="" readonly=""></td>
                    <th class="">0.68mm</th>
                    <td class=""><input id="prod_gd2" name="prod_gd2" class="basic" type="text" style="width:100%;" value="" readonly=""></td>
                    <th class="">1.18mm</th>
                    <td class=""><input id="prod_gd3" name="prod_gd3" class="basic" type="text" style="width:100%;" value="" readonly=""></td>
                  </tr>
                </tbody></table>
              </fieldset>
            </div>


            <div class="">
              <fieldset class="popField">
                <legend>전세척</legend>
                <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
                  <tbody><tr>
                  <td class=""><select id="fac_code1" name="fac_code1" class="basic" style="width: 100%">
                        
                          <option value="15">진공세정기 2호기</option>
                        
                          </select>
                  <!-- <td class=""  hidden=""><select id="wstdStep07" name="wstdStep07"class="basic" style="width:145px;">
                          <option></option>
                          <option>STEP1</option>
                          <option>STEP2</option>
                          <option>STEP3</option>
                         </select> -->
                    </td><th class="" style="width:5%;">온도</th>
                    <td class=""><input id="wstd_n01" name="wstd_n01" class="basic" type="text" style="width:80%;" value=""></td>
                    <th class="" style="width:5%;">시간</th>
                    <td class=""><input id="wstd_n02" name="wstd_n02" class="basic" type="text" style="width:80%;" value=""></td>
                    <th class="" style="width:5%;">농도</th>
                    <td class=""><input id="wstd_t66" name="wstd_t66" class="basic" type="text" style="width:80%;" value=""></td>
                      
                </tr>
                </tbody></table>
              </fieldset>
            </div>

            <div class="">
              <fieldset class="popField">
                <legend>공정</legend>
                <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
                  <colgroup span="9">
                    <col width="12%">
                    <col width="11%">
                    <col width="11%">
                    <col width="11%">
                    <col width="11%">
                    <col width="11%">
                    <col width="11%">
                    <col width="11%">
                    <col width="11%">
                  </colgroup>
                  <tbody><tr>
                    <th>구분</th>
                    <th>예열</th>
                    <th>침탄</th>
                    <th>확산</th>
                    <th>강온</th>
                    <th>균열</th>
                    <th>Oil</th>
                    <th>교반기</th>
                    <th>냉각시간</th>
                  </tr>
                  <tr>
                    <th>온도[℃]</th>
                    <td><input id="wstd_gj11" name="wstd_gj11" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj12" name="wstd_gj12" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj13" name="wstd_gj13" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj14" name="wstd_gj14" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj15" name="wstd_gj15" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj16" name="wstd_gj16" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj17" name="wstd_gj17" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj18" name="wstd_gj18" class="basic" type="text" style="width:90%;" value=""></td>
                  </tr>
                  <tr>
                    <th>시간[분]</th>
                    <td><input id="wstd_gj21" name="wstd_gj21" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj22" name="wstd_gj22" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj23" name="wstd_gj23" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj24" name="wstd_gj24" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj25" name="wstd_gj25" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj26" name="wstd_gj26" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj27" name="wstd_gj27" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj28" name="wstd_gj28" class="basic" type="text" style="width:90%;" value=""></td>
                  </tr>
                  <tr>
                    <th>cp%</th>
                    <td><input id="wstd_gj31" name="wstd_gj31" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj32" name="wstd_gj32" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj33" name="wstd_gj33" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj34" name="wstd_gj34" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj35" name="wstd_gj35" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj36" name="wstd_gj36" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj37" name="wstd_gj37" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj38" name="wstd_gj38" class="basic" type="text" style="width:90%;" value=""></td>
                  </tr>
                  <tr>
                    <th>RX[㎥/Hr]</th>
                    <td><input id="wstd_gj39" name="wstd_gj39" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj42" name="wstd_gj42" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj43" name="wstd_gj43" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj44" name="wstd_gj44" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj45" name="wstd_gj45" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                  </tr>
                  <tr>
                    <th>LPG</th>
                    <td><input id="wstd_gj49" name="wstd_gj49" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj52" name="wstd_gj52" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj53" name="wstd_gj53" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj54" name="wstd_gj54" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj55" name="wstd_gj55" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                  </tr>
                  <tr>
                    <th>CH3OH[cc/Hr]</th>
                    <td><input id="wstd_gj59" name="wstd_gj59" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj62" name="wstd_gj62" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj63" name="wstd_gj63" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj64" name="wstd_gj64" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj65" name="wstd_gj65" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                  </tr>
                  <tr>
                    <th>N2[㎥/Hr]</th>
                    <td><input id="wstd_gj69" name="wstd_gj69" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj72" name="wstd_gj72" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj73" name="wstd_gj73" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj74" name="wstd_gj74" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj75" name="wstd_gj75" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                  </tr>
                  <tr>
                    <th>NH3[Nl/min]</th>
                    <td><input id="wstd_gj79" name="wstd_gj79" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj82" name="wstd_gj82" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj83" name="wstd_gj83" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj84" name="wstd_gj84" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstd_gj85" name="wstd_gj85" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                  </tr>
                  <tr>
                    <th>수량</th>
                    <td><input id="wstd_gjsu" name="wstd_gjsu" class="basic" type="text" style="width:90%;" value=""></td>
                  </tr>
                  <tr>
                    <th>rpm</th>
                    <td><input id="wstd_gjrpm" name="wstd_gjrpm" class="basic" type="text" style="width:90%;" value=""></td>
                  </tr>
                </tbody></table>
                <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
                  <colgroup span="2">
                    <col width="10%">
                    <col width="90%">
                  </colgroup>
                  <tbody><tr>
                    <th class="">비고</th>
                    <td class=""><input id="wstd_worknote" name="wstd_worknote" class="basic" type="text" style="width:90%;" value=""></td>
                  </tr>

                </tbody></table>
                <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
                  <colgroup span="2">
                    <col width="10%">
                    <col width="90%">
                  </colgroup>
                  <tbody><tr>
                    <th class="">설비</th>
                    <td class="">
                      <select id="fac_code" name="fac_code" class="basic" style="width: 100%">
                        
                          <option value="5">고주파 1호기(폐기)</option>
                        
                          <option value="6">고주파 2호기 (폐기)</option>
                        
                          <option value="9">고주파 5호기</option>
                        
                          <option value="21">급수시설</option>
                        
                          <option value="10">변성로 1호기</option>
                        
                          <option value="11">변성로 2호기</option>
                        
                          <option value="12">쇼트 1호기</option>
                        
                          <option value="13">쇼트 2호기</option>
                        
                          <option value="14">쇼트 3호기</option>
                        
                          <option value="19">쇼트 4호기</option>
                        
                          <option value="20">전기시설</option>
                        
                          <option value="15">진공세정기 2호기</option>
                        
                          <option value="1">침탄로 1호기</option>
                        
                          <option value="2">침탄로 2호기</option>
                        
                          <option value="3">침탄로 3호기</option>
                        
                          <option value="4">침탄로 4호기</option>
                        
                          <option value="18">침탄로 5호기</option>
                        
                          <option value="22">콤프레샤</option>
                        
                          <option value="16">템퍼링기 1호기</option>
                        
                          <option value="17">템퍼링기 2호기</option>
                        
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <th class="">보고서 유형</th>
                    <td class="">
                      <select id="reportType" name="report_type" class="basic" style="width: 100%">
                        <option value="QT1">QT-Tempering</option>
                        <option value="QT2">QT-1차,2차 Tempering</option>
                        <option value="QT3">QT-심냉처리</option>
                        <option value="QT4">QT-응력제거</option>
                        <option value="CH1">침탄-Tempering</option>
                        <option value="CH2">침탄-1차,2차 Tempering</option>
                        <option value="CH3">침탄-중간검사교정</option>
                        <option value="CH4">침탄-Marking</option>
                      </select>
                    </td>
                  </tr>
                </tbody></table>
              </fieldset>
            </div>
            <div class="">
              <fieldset class="popField">
                <legend>후세척</legend>
                <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
                      <tbody><tr>
                      <td class=""><select id="facCode2" name="fac_code2" class="basic" style="width: 100%">
                           
                           <option value="15">진공세정기 2호기</option>
                           
                           </select>
                      <!-- <td class="" hidden=""><select id="wstdStep08" name="wstdStep08"class="basic" style="width:145px;">
                          <option></option>
                          <option>STEP1</option>
                          <option>STEP2</option>
                          <option>STEP3</option>
                         </select> -->
                    </td><th class="" style="width:5%;">온도</th>
                    <td class=""><input id="wstd_n03" name="wstd_n03" class="basic" type="text" style="width:90%;" value=""></td>
                    <th class="" style="width:5%;">시간</th>
                    <td class=""><input id="wstd_n04" name="wstd_n04" class="basic" type="text" style="width:90%;" value=""></td>
                    <th class="" style="width:5%;">농도</th>
                    <td class=""><input id="wstd_t67" name="wstd_t67" class="basic" type="text" style="width:90%;" value=""></td>
                      </tr>
                </tbody></table>
              </fieldset>
              <fieldset class="popField">
                <legend>1차탬퍼링</legend>
                <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
                  <colgroup span="5">
                    <col width="1%">
                    <col width="5%">
                    <col width="1%">
                    <col width="5%">
                    <col width="1%">
                    <col width="5%">
                  </colgroup>
                  <tbody><tr>
                    <th class="">온도</th>
                    <td class=""><input id="wstd_ready" name="wstd_ready" class="basic" type="text" style="width:90%;" value=""></td>
                    <th class="">시간</th>
                    <td class=""><input id="wstd_worktime" name="wstd_worktime" class="basic" type="text" style="width:90%;" value=""></td>
                    <th class="">비고</th>
                    <td class=""><input id="wstd_t62" name="wstd_t62" class="basic" type="text" style="width:90%;" value=""></td>
                  </tr>
                </tbody></table>
              </fieldset>
              <fieldset class="popField">
                <legend>2차탬퍼링</legend>
                <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
                  <colgroup span="5">
                    <col width="1%">
                    <col width="5%">
                    <col width="1%">
                    <col width="5%">
                    <col width="1%">
                    <col width="5%">
                  </colgroup>
                  <tbody><tr>
                    <th class="">온도</th>
                    <td class=""><input id="wstd_t63" name="wstd_t63" class="basic" type="text" style="width:90%;" value=""></td>
                    <th class="">시간</th>
                    <td class=""><input id="wstd_t64" name="wstd_t64" class="basic" type="text" style="width:90%;" value=""></td>
                    <th class="">비고</th>
                    <td class=""><input id="wstd_t65" name="wstd_t65" class="basic" type="text" style="width:90%;" value=""></td>
                  </tr>
                </tbody></table>
              </fieldset>
              <fieldset class="popField">
                <legend>후처리</legend>
                <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
                  <tbody><tr>
                    <th class="" style="width:10%;">후처리 수량</th>
                    <td class=""><input id="wstd_gj97" name="wstd_gj97" class="basic" type="text" style="width:90%;" value=""></td>
                    <th class="" style="width:10%;">설비</th>
                    <td class=""><select id="fac_code3" name="fac_code3" class="basic" style="width: 90%">
                      
                        <option value="12">쇼트 1호기</option>
                      
                        <option value="13">쇼트 2호기</option>
                      
                        <option value="14">쇼트 3호기</option>
                      
                        <option value="19">쇼트 4호기</option>
                      
                    </select>
                  </td></tr>
                  <tr>
                    <th class="" style="width:5%;">1차처리</th>
                    <td class=""><input id="wstd_gj98" name="wstd_gj98" class="basic" type="text" style="width:90%;" value=""></td>
                    <th class="" style="width:5%;">압력</th>
                    <td class=""><input id="wstd_gj99" name="wstd_gj99" class="basic" type="text" style="width:90%;" value=""></td>
                  </tr>
                  <tr>
                    <th class="" style="width:5%;">2차처리</th>
                    <td class=""><input id="wstd_gj100" name="wstd_gj100" class="basic" type="text" style="width:90%;" value=""></td>
                    <th class="" style="width:5%;">압력</th>
                    <td class=""><input id="wstd_gj101" name="wstd_gj101" class="basic" type="text" style="width:90%;" value=""></td>
                  </tr>
                </tbody></table>
              </fieldset>
            </div>
          </td>


          <td class="" valign="top" style="padding-left:10px;">
            <fieldset class="popField">
              <legend>단취사진</legend>
              <div class="findImage">
                <input type="hidden" name="type" value="standard">
                  <input type="file" id="imgInput0" class="imgInputClass" name=wstd_chim_file_url1 title="이미지 찾기" onchange="previewImage(this,'previewId1')">
                  <!--<input type="button" value="X" title="삭제" class="btnFT" /> -->
                <div class="imgArea" id="previewId1" style="height:90px;border:1px solid #ddd;"><img id="prev_previewId1"  width="100%" height="100%"></div>
              </div>
            </fieldset>
            <fieldset class="popField">
              <legend>도면</legend>
              <input type="hidden" name="type" value="pdffile">
              <input type="file" name="wstdfile" title="" onchange="" style=" width: 140px;" accept=".pdf">
            </fieldset>
            <fieldset class="popField">
              <legend>사진-3</legend>
              <div class="findImage">
              <input type="hidden" name="type" value="standard">
                  <input type="file" id="imgInput1" class="imgInputClass" name=wstd_chim_file_url2 title="이미지 찾기" onchange="previewImage(this,'previewId3')"><!-- <input type="button" value="X" title="삭제" class="btnFT" /> -->
                <div class="imgArea" id="previewId3" style="height:91px;border:1px solid #ddd;"><img id="prev_previewId3"  width="100%" height="100%"></div>
              </div>
            </fieldset>

            <!-- 단취방법 -->
            <div class="">
            <fieldset class="popField">
              <legend>단취방법</legend>
              <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable3">
                <colgroup span="4">
                  <col width="34%">
                  <col width="33%">
                  <col width="25%">
                  <col width="25%">
                </colgroup>
                <tbody><tr>
                  <td class="top">EA/줄(판)</td>
          <td class="top2" colspan="2">
            <input type="text" id="wstd_t32" name="wstd_t32" value="" class="basic" style="width:90%; text-align: right;" onchange="fn_Calc()">
          </td>
          <td class="top2">이하</td>
        </tr>
        <tr>
          <td class="left">줄(판)/단</td>
          <td colspan="3">
            <input type="text" id="wstd_t33" name="wstd_t33" value="" class="basic" style="width:90%; text-align: right;" onchange="fn_Calc()">
          </td>
          <td colspan="2" hidden="">
            <input type="text" id="wstd_t34" name="wstd_t34" value="" class="basic" style="width:90%; display:none;">
          </td>
        </tr>
        <tr>
          <td class="left">단/Tray</td>
          <td>
            <input type="text" id="wstd_t41" name="wstd_t41" value="" class="basic" style="width:90%; text-align: right;" onchange="fn_Calc()">
          </td>
          <td>Tray차지</td>
          <td>
            <input type="text" id="wstd_t42" name="wstd_t42" value="" class="basic" style="width:90%; text-align: right;" onchange="fn_Calc()">
          </td>
        </tr>
        <tr>
          <td class="left">추가수량</td>
          <td colspan="3">
            <input type="text" id="wstd_t87" name="wstd_t87" value="" class="basic" style="width:90%; text-align: right;" onchange="fn_Calc()">
          </td>
        </tr>
        <tr>
          <td class="left">단취수량</td>
          <td colspan="2">
            <input type="text" id="wstd_t43" name="wstd_t43" value="" class="basic" style="width:90%; text-align: right;" readonly>
          </td>
          <td>EA/CH</td>
        </tr>
        <tr>
          <td class="left">Jig무게</td>
          <td colspan="2">
            <input type="text" id="wstd_t44" name="wstd_t44" value="" class="basic" style="width:90%; text-align: right;" onchange="fn_Calc()">
          </td>
          <td>kg</td>
        </tr>
        <tr>
          <td class="left">제품무게/ch</td>
          <td colspan="2">
            <input type="text" id="wstd_t51" name="wstd_t51" value="" class="basic" style="width:90%; text-align: right;" readonly>
          </td>
          <td>kg</td>
        </tr>
        <tr>
          <td class="left">총단중/ch</td>
          <td colspan="2">
            <input type="text" id="wstd_t52" name="wstd_t52" value="" class="basic" style="width:90%; text-align: right;" readonly>
          </td>
          <td>kg</td>
                </tr>

                <tr height="5px"></tr>

                <tr>
                  <th class="left" colspan="4">단취시 유의사항</th>
                </tr>
                <tr>
                  <td class="left" colspan="4">
                    ● <input type="text" id="wstd_t53" name="wstd_t53" value="" class="basic" style="width:91%;">
                  </td>
                </tr>
                <tr>
                  <td class="left" colspan="4">
                    ● <input type="text" id="wstd_t54" name="wstd_t54" value="" class="basic" style="width:91%;">
                  </td>
                </tr>
                <tr>
                  <td class="left" colspan="4">
                    ● <input type="text" id="wstd_t30" name="wstd_t30" value="" class="basic" style="width:91%;">
                  </td>
                </tr>
                <tr>
                  <td class="left">단중</td>
                  <td colspan="2"><input type="text" id="wstd_t40" name="wstd_t40" value="1" class="basic" style="width:90%; text-align: right;" onchange="fn_Calc()"></td>
                  <td>kg</td>
                </tr>
                <tr>
                  <!-- <td class="left">HIGH NO</td> -->
                  <td colspan="2" hidden=""><input type="text" id="wstd_t50" name="wstd_t50" value="" class="basic" style="width:97%; text-align: right; display:none;" readonly=""></td>
                  <!-- <td>EA</td> -->
                </tr>
                <tr>
                  <!-- <td class="left">LOW NO</td> -->
                  <td colspan="2" hidden=""><input type="text" id="wstd_t55" name="wstd_t55" value="" class="basic" style="width:97%; text-align: right; display:none;" readonly=""></td>
                  <!-- <td>EA</td> -->
                </tr>
              </tbody></table>
            </fieldset>
            </div>
           </td>
          </tr>
        </tbody></table>
        
        <div style="margin-top:10px; border-top:1px solid #bbb; height:1px;"></div>
          <div class="clear"></div>
          
        <fieldset class="popField">
          <legend>심냉처리</legend>
            <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
            <colgroup span="5">
              <col width="60">
              <col width="100">
              <col width="60">
              <col width="100">
              <col width="60">
              <col width="100">
              <col width="60">
              <col width="100">
              <col width="70">
              <col width="100">
              <col width="40">
              <col width="100">
            </colgroup>
            <tbody><tr>
              <th class="left">예냉온도</th>
              <td class=""><input id="wstd_t68" name="wstd_t68" class="basic" type="text" style="width:90%;" value=""></td>
              <th class="">예냉시간</th>
              <td class=""><input id="wstd_t69" name="wstd_t69" class="basic" type="text" style="width:90%;" value=""></td>
              <th class="">심냉온도</th>
              <td class=""><input id="wstd_t70" name="wstd_t70" class="basic" type="text" style="width:90%;" value=""></td>
              <th class="">심냉시간</th>
              <td class=""><input id="wstd_t71" name="wstd_t71" class="basic" type="text" style="width:90%;" value=""></td>
              <th class="">방냉후실온</th>
              <td class=""><input id="wstd_t72" name="wstd_t72" class="basic" type="text" style="width:90%;" value=""></td>
              <th class="">비고</th>
              <td class=""><input id="wstd_t73" name="wstd_t73" class="basic" type="text" style="width:90%;" value=""></td>
            </tr>
            </tbody></table>
        </fieldset>
        
        <div class="">
          <fieldset class="popField">
            <legend>개정이력</legend>
            <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable2">
              <colgroup span="5">
                <col width="">
                <col width="">
                <col width="">
                <col width="">
              </colgroup>
              <tbody><tr>
                <th class="left">NO</th>
                <th class="">개정일자</th>
                <th class="">사유</th>
                <th class="">확인</th>
              </tr>
              <tr>
                <td class="left">1</td>
                <td class=""><input id="wstd_g11" name="wstd_g11" class="basic" type="text" style="width:98%;" value=""></td>
                <td class=""><input id="wstd_g12" name="wstd_g12" class="basic" type="text" style="width:98%;" value=""></td>
                <td class=""></td>
              </tr>
              <tr>
                <td class="left">2</td>
                <td class=""><input id="wstd_g21" name="wstd_g21" class="basic" type="text" style="width:98%;" value=""></td>
                <td class=""><input id="wstd_g22" name="wstd_g22" class="basic" type="text" style="width:98%;" value=""></td>
                <td class=""></td>
              </tr>
              <tr>
                <td class="left">3</td>
                <td class=""><input id="wstd_g31" name="wstd_g31" class="basic" type="text" style="width:98%;" value=""></td>
                <td class=""><input id="wstd_g32" name="wstd_g32" class="basic" type="text" style="width:98%;" value=""></td>
                <td class=""></td>
              </tr>
              <tr>
                <td class="left">4</td>
                <td class=""><input id="wstd_g41" name="wstd_g41" class="basic" type="text" style="width:98%;" value=""></td>
                <td class=""><input id="wstd_g42" name="wstd_g42" class="basic" type="text" style="width:98%;" value=""></td>
                <td class=""></td>
              </tr>
            </tbody></table>
          </fieldset>
        </div>
        <div class="btnSaveClose">
        	<button class="delete" type="button" onclick="deleteChim();"  style="display: none;">삭제</button>
            <button class="save" type="button" onclick="save();">저장</button>
            <button type="button" id="btnSaveAs" style="display:none;" onclick="saveAs()">다른이름저장</button>
            <button class="close" type="button" onclick="window.close();">닫기</button>
    	</div>
     </div>
  </div>    
 </form>   
 
 
 
 <!-- (검색버튼) 팝업창 -->
	<div id="productListModal" class="modal-overlay" style="display: none;">
		<div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">제품 리스트</span> <span class="modal-close" onclick="closeProductListModal();">&times;</span>
			</div>
			<div id="productListTabulator" style="height: 500px;"></div>
		</div>
	</div>
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
<script>

    let now_page_code = "e04";

	//전역변수
    var cutumTable;	
    var isEditMode = false; //수정,최초저장 구분값

	//로드
	$(function(){
		//전체 거래처목록 조회
		getChimStandardList();
	});

    $(function(){	
        // 파일 선택시 이미지 띄우기
      $('.imgInputClass').change(function(event){
        var selectedFile = event.target.files[0];
      var reader = new FileReader();
      
      var img = $(this).parent().parent().find('img')[0];
      img.title = selectedFile.name;
      
      reader.onload = function(event) {
        img.src = event.target.result;
      };
      
      reader.readAsDataURL(selectedFile);
      });
    });

	//이벤트
	//함수
	function getChimStandardList(){
		userTable = new Tabulator("#tab1", {
		    height:"750px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    selectableRows:true,
		    reactiveData:true,
		    headerHozAlign:"center",
		    ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/management/chimStandardInsert/getChimStandardList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{
		    	/* "corp_name": $("#corp_name").val(),
                "prod_name": $("#prod_name").val(),
                "prod_no": $("#prod_no").val(),
                "fac_name": $("#fac_name").val(), */
			    },
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		        {title:"NO", field:"idx", sorter:"int", width:80,
		        	hozAlign:"center"},
		        {title:"고객명", field:"corp_name", sorter:"string", width:120,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"품명", field:"prod_name", sorter:"string", width:220,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"도번/품번", field:"prod_no", sorter:"string", width:200,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"기종", field:"prod_kijong", sorter:"string", width:100,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"재질", field:"prod_jai", sorter:"int", width:200,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"단가", field:"prod_dang", sorter:"int", width:200,
			        hozAlign:"center", headerFilter:"input"},
			    {title:"설비", field:"fac_name", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input"},
				{title:"공정", field:"tech_te", sorter:"int", width:150,
					hozAlign:"center", headerFilter:"input"},
					{title:"", field:"wstd_code", visible:false},
					/* {title:"단취사진", field:"wstd_chim_file_name1", width:100,
						hozAlign:"center", formatter:"image",
					    cssClass:"rp-img-popup",
				      	formatterParams:{
					      	height:"30px", width:"30px",
					      	urlPrefix:"/tkPrint/사진/침탄로작업표준/"
					      	}, 
					    cellMouseEnter:function(e, cell){ productImage(cell.getValue());} 
					    },
						{title:"사진-3", field:"wstd_chim_file_name2", width:100,
							hozAlign:"center", formatter:"image",
						    cssClass:"rp-img-popup",
					      	formatterParams:{
						      	height:"30px", width:"30px",
						      	urlPrefix:"/tkPrint/사진/침탄로작업표준/"
						      	}, 
						    cellMouseEnter:function(e, cell){ productImage(cell.getValue());} 
						    }, */
		    ],
		    rowFormatter:function(row){
			    var data = row.getData();
			    
			    row.getElement().style.fontWeight = "700";
				row.getElement().style.backgroundColor = "#FFFFFF";
			},
			rowClick:function(e, row){

				$("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").each(function(index, item){
						
					if($(this).hasClass("row_select")){							
						$(this).removeClass('row_select');
						row.getElement().className += " row_select";
					}else{
						$("#tab1 div.row_select").removeClass("row_select");
						row.getElement().className += " row_select";	
					}
				});

				var rowData = row.getData();
				
			},
			rowDblClick:function(e, row){

				var data = row.getData();
				selectedRowData = data;
				isEditMode = true;
				$('#chimStandardForm')[0].reset();

/*
				Object.keys(data).forEach(function (key) {
			        const field = $('#chimStandardForm [name="' + key + '"]');

			        if (field.length) {
			            field.val(data[key]);
			        }
				});
*/


				getChimStandardDetail(data.wstd_code);
				$("#btnSaveAs").show();
				$('.delete').show();
			},
		});		
	}
	

function getChimStandardDetail(wstd_code){
	$.ajax({
		url:"/tkheat/management/chimStandardInsert/getChimStandardDetail",
		type:"post",
		dataType:"json",
		data:{
			"wstd_code":wstd_code
		},
		success:function(result){
			console.log(result);
			var allData = result.data;
			
			for(let key in allData){
//				console.log(allData, key);	
				$("[name='"+key+"']").val(allData[key]);
			}

			// 이미지 초기화
			$("#prev_previewId1, #prev_previewId3, #prev_previewId7").attr("src", "/tkheat/css/image/no_image.png");

			// 단취사진
			if (allData.wstd_chim_file_name1) {
				console.log("원본 파일명:", allData.wstd_chim_file_name1);
				console.log("인코딩된 경로:", encodeURIComponent(allData.wstd_chim_file_name1));
				const path = "/tkPrint/사진/침탄로작업표준/" + allData.wstd_chim_file_name1;
				console.log("path: ", path);
				$("#prev_previewId1").attr("src", path);
				//$(".aphoto").attr("href", path).text(d.product_file_name);
			}
			// 사진-3
			if (allData.wstd_chim_file_name2) {
				console.log("원본 파일명:", allData.wstd_chim_file_name2);
				console.log("인코딩된 경로:", encodeURIComponent(allData.wstd_chim_file_name2));
				const path = "/tkPrint/사진/침탄로작업표준/" + allData.wstd_chim_file_name2;
				console.log("path: ", path);
				$("#prev_previewId3").attr("src", path);
				$("#prev_previewId7").attr("src", path);
				//$(".aphoto").attr("href", path).text(d.product_file_name);
			}

			$('.chimStandardModal').show().addClass('show');
		}
	});
}
	
    </script>
    
    
   <script>
		
 // 드래그 기능 추가
	const modal = document.querySelector('.chimStandardModal');
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
	const insertButton = document.querySelector('.insert-button');
	const chimStandardModal = document.querySelector('.chimStandardModal');
	const closeButton = document.querySelector('.close');
	const headerCloseButton = document.querySelector('.header-close');

	insertButton.addEventListener('click', function() {
		isEditMode = false;  // 추가 모드
	    $('#chimStandardForm')[0].reset(); // 폼 초기화
	    chimStandardModal.style.display = 'block'; // 모달 표시

		$('.delete').hide();
		$("#btnSaveAs").hide();
	});

	closeButton.addEventListener('click', function() {
		chimStandardModal.style.display = 'none'; // 모달 숨김
	});

	headerCloseButton.addEventListener('click', function() {
		chimStandardModal.style.display = 'none';
	});





	//제품검색버튼 리스트 모달
    function openProductListModal() {
        document.getElementById('productListModal').style.display = 'flex';

        
        let productListTable = new Tabulator("#productListTabulator", {
            height:"450px",
            layout:"fitColumns",
            selectable:true,
            ajaxURL:"/tkheat/management/productInsert/productList",
            ajaxConfig:"POST",
            ajaxParams:{
                "corp_name": "",
                "prod_code": "",
                   
            },
		    ajaxResponse:function(url, params, response){
//				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
				console.log(response);
		        return response.data; //return the response data to tabulator
		    },    
            columns:[
                {title:"NO", field:"idx", width:80, hozAlign:"center"},
                {title:"거래처", field:"corp_name", width:120, hozAlign:"center"},
                {title:"품명", field:"prod_name", width:120, hozAlign:"center",visible:false},
                {title:"품번", field:"prod_no", width:150, hozAlign:"center"},
                {title:"규격", field:"prod_gyu", width:100, hozAlign:"center"},
                {title:"재질", field:"prod_jai", width:200, hozAlign:"center"},
                {title:"공정", field:"tech_te", width:200, hozAlign:"center"},
                {title:"표면경도", field:"prod_pg", width:200, hozAlign:"center"},
                {title:"심부경도", field:"prod_sg", width:200, hozAlign:"center"},
                {title:"경화깊이", field:"prod_gd2", width:200, hozAlign:"center"},
                {title:"경화깊이1", field:"prod_gd1", width:200, hozAlign:"center"},
                {title:"경화깊이2", field:"prod_gd3", width:200, hozAlign:"center"},
            ],
            rowDblClick:function(e, row){
                let data = row.getData();
                
                document.getElementById('corp_name').value = data.corp_name;
                document.getElementById('prod_code').value = data.prod_code;
                document.getElementById('prod_danj').value = data.prod_danj;
                document.getElementById('prod_no').value = data.prod_no;
                document.getElementById('prod_name').value = data.prod_name;
                document.getElementById('prod_jai').value = data.prod_jai;
                document.getElementById('prod_dang').value = data.prod_dang;
                document.getElementById('prod_pwsno').value = data.prod_pwsno;
                document.getElementById('tech_te').value = data.tech_te;
                document.getElementById('prod_do').value = data.prod_do;
                document.getElementById('prod_refno').value = data.prod_refno;
                document.getElementById('prod_gyu').value = data.prod_gyu;
                document.getElementById('prod_kijong').value = data.prod_kijong;
                document.getElementById('prod_pg').value = data.prod_pg;
                document.getElementById('prod_sg').value = data.prod_sg;
                document.getElementById('prod_e1').value = data.prod_e1;
                document.getElementById('prod_e3').value = data.prod_e3;
                document.getElementById('prod_khecd').value = data.prod_khecd;
                document.getElementById('prod_khtcd').value = data.prod_khtcd;
                document.getElementById('prod_gd1').value = data.prod_gd1;
                document.getElementById('prod_gd2').value = data.prod_gd2;
                document.getElementById('prod_gd5').value = data.prod_gd5;


                
                document.getElementById('productListModal').style.display = 'none';
            }
        });
    }

    function closeProductListModal() {
        document.getElementById('productListModal').style.display = 'none';
    }

    
  //침탄로작업표준 저장
    function save() {
	    var formData = new FormData($("#chimStandardForm")[0]);

	    let confirmMsg = "";

	    if (isEditMode && selectedRowData && selectedRowData.wstd_code) {
	        formData.append("mode", "update");
	        formData.append("wstd_code", selectedRowData.wstd_code);
	        confirmMsg = "수정하시겠습니까?";
	    } else {
	        formData.append("mode", "insert");
	        confirmMsg = "저장하시겠습니까?";
	    }

	    if (!confirm(confirmMsg)) {
	        return;
	    }

	    $.ajax({
	        url: "/tkheat/management/chimStandardInsert/chimStandardInsertSave",
	        type: "POST",
	        data: formData,
	        contentType: false,
	        processData: false,
	        dataType: "json",
	        success: function(result) {
	        	alert("저장 되었습니다.");
                $(".chimStandardModal").hide();
                getChimStandardList();
	        },
	        error: function(xhr, status, error) {
	            console.error("저장 오류:", error);
	        }
	    });
	}

    function saveAs() {
        var formData = new FormData($("#chimStandardForm")[0]);
        formData.append("mode", "insert");
        if (!confirm("다른 이름으로 저장하시겠습니까?")) return;

        $.ajax({
            url: "/tkheat/management/chimStandardInsert/chimStandardInsertSave",
            type: "POST",
            data: formData,
            contentType: false,
            processData: false,
            dataType: "json",
            success: function(result) {
                alert("다른 이름으로 저장되었습니다.");
                $(".chimStandardModal").hide();
                getChimStandardList();
            },
            error: function(xhr, status, error) {
                console.error("다른이름저장 오류:", error);
            }
        });
    }
    	


	function deleteChim() {
	    if (!selectedRowData || !selectedRowData.wstd_code) {
	        alert("삭제할 대상을 선택하세요.");
	        return;
	    }

	    if (!confirm("삭제하시겠습니까?")) {
	        return;
	    }

	    $.ajax({
	        url: "/tkheat/management/chimStandardInsert/chimStandardDelete",
	        type: "POST",
	        data: {
	        	wstd_code: selectedRowData.wstd_code
	        },
	        dataType: "json",
	        success: function(result) {
	            if (result.status === "success") {
	                alert("삭제되었습니다.");
	                $(".chimStandardModal").hide();
	                getChimStandardList();
	            } else {
	                alert("삭제 중 오류가 발생했습니다: " + result.message);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error("삭제 오류:", error);
	            alert("삭제 요청 중 오류가 발생했습니다.");
	        }
	    });
	}

    //엑셀 다운로드
	$(".excel-button").click(function () {
	    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
	    const filename = "침탄로작업표준_" + today + ".xlsx";
	    userTable.download("xlsx", filename, { sheetName: "침탄로작업표준" });
	});


	document.addEventListener("DOMContentLoaded", function() {
		console.log({
			  t32: wstd_t32.value,
			  t33: wstd_t33.value,
			  t41: wstd_t41.value,
			  t42: wstd_t42.value,
			  t44: wstd_t44.value,
			  t40: wstd_t40 ? wstd_t40.value : "없음",
			  t87: wstd_t87.value
			});
		  window.fn_Calc = function() {
		    var wstd_t32 = document.getElementById("wstd_t32");
		    var wstd_t33 = document.getElementById("wstd_t33");
		    var wstd_t41 = document.getElementById("wstd_t41");
		    var wstd_t42 = document.getElementById("wstd_t42");
		    var wstd_t44 = document.getElementById("wstd_t44");
		    var wstd_t40 = document.getElementById("wstd_t40"); 
		    var wstd_t43 = document.getElementById("wstd_t43");
		    var wstd_t51 = document.getElementById("wstd_t51");
		    var wstd_t52 = document.getElementById("wstd_t52");
		    var wstd_t87 = document.getElementById("wstd_t87");

		    // wstd_t40이 없으면 1로 기본처리 (옵션)
		    var wstd_t40_val = wstd_t40 ? Number(fn_rtnnumber(wstd_t40.value)) : 1;

		    if (
		      wstd_t32.value !== "" && wstd_t33.value !== "" &&
		      wstd_t41.value !== "" && wstd_t42.value !== "" &&
		      wstd_t44.value !== "" &&
		      wstd_t87.value !== ""
		    ) {
		      // 단취수량 계산
		      var calc_t43 = 
		        Number(fn_rtnnumber(wstd_t32.value)) *
		        Number(fn_rtnnumber(wstd_t33.value)) *
		        Number(fn_rtnnumber(wstd_t41.value)) *
		        Number(fn_rtnnumber(wstd_t42.value)) +
		        Number(fn_rtnnumber(wstd_t87.value));

		      wstd_t43.value = fn_addComma(calc_t43);

		      // 제품무게/ch 계산
		      var calc_t51 = calc_t43 * wstd_t40_val;
		      wstd_t51.value = fn_addComma(calc_t51.toFixed(2));

		      // 총단중/ch 계산
		      var calc_t52 = Number(fn_rtnnumber(wstd_t44.value)) + calc_t51;
		      wstd_t52.value = fn_addComma(calc_t52.toFixed(1));
		    } else {
		      // 입력값 부족 시 결과 초기화
		      wstd_t43.value = "";
		      wstd_t51.value = "";
		      wstd_t52.value = "";
		    }
		  };

		  window.fn_addComma = function(n) {
		    if (isNaN(n)) return 0;
		    var reg = /(^[+-]?\d+)(\d{3})/;
		    n = n.toString();
		    while (reg.test(n)) {
		      n = n.replace(reg, '$1' + ',' + '$2');
		    }
		    return n;
		  };

		  window.fn_rtnnumber = function(n) {
		    if (typeof n !== "string") return n;
		    return n.replace(/,/g, "");
		  };
		});

	

    </script>

	</body>
</html>
