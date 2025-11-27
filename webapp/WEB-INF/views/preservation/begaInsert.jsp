<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비가동정보</title>
    <link rel="stylesheet" href="/mibogear/css/standardstandardManagement/productInsert.css">
    <link rel="stylesheet" href="/mibogear/css/tabBar/tabBar.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
<%@include file="../include/pluginpage.jsp" %> 
    <style>
.main {
	width: 98%;
}

.container {
	display: flex;
	justify-content: space-between;
}

.begaInsertModal {
	position: fixed; /* 화면에 고정 */
	top: 50%; /* 수직 중앙 */
	left: 50%; /* 수평 중앙 */
	display: none;
	transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
	z-index: 1000; /* 다른 요소 위에 표시 */
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

.detail {
	background: #ffffff;
	border: 1px solid #000000;
	width: 800px; /* 가로 길이 고정 */
	height: 630px; /* 세로 길이 고정 */
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.7);
	margin: 20px auto; /* 중앙 정렬 */
	padding: 20px;
	border-radius: 5px; /* 모서리 둥글게 */
	overflow-y: auto; /* 세로 스크롤 추가 */
}

.insideTable {
	width: 100%; /* 테이블 너비 100% */
	border-collapse: collapse; /* 테두리 겹침 제거 */
}

.insideTable th, .insideTable td {
	padding: 8px; /* 셀 패딩 */
	border: 1px solid #ccc; /* 셀 경계선 */
	vertical-align: middle; /* 수직 정렬 */
}

.insideTable th {
	background: #f0f0f0; /* 헤더 배경색 */
}

.basic, .rp-input, .form-control {
	width: calc(100% - 12px); /* 너비 조정 */
	padding: 5px; /* 내부 여백 */
	border: 1px solid #949494; /* 경계선 색상 */
	border-radius: 3px; /* 둥근 모서리 */
}

.basic[readonly] {
	background-color: #f9f9f9; /* 읽기 전용 필드 색상 */
}

textarea {
	width: 100%; /* 너비 100% */
	padding: 5px; /* 내부 여백 */
	border: 1px solid #949494; /* 경계선 색상 */
	border-radius: 3px; /* 둥근 모서리 */
}

.findImage {
	display: flex; /* 플렉스 박스 사용 */
	align-items: center; /* 수직 정렬 */
}

.findImage input[type="file"] {
	margin-right: 10px; /* 오른쪽 여백 */
}

.imgArea {
	width: 200px; /* 이미지 영역 너비 */
	height: 150px; /* 이미지 영역 높이 */
	border: 1px solid #ddd; /* 경계선 */
	margin-bottom: 10px; /* 하단 여백 */
}

.imgArea img {
	width: 100%; /* 이미지 너비 */
	height: 100%; /* 이미지 높이 */
	object-fit: cover; /* 이미지 비율 유지 */
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
.box1 {
	display: flex;
	justify-content: right;
	align-items: center;
	width: 1500px;
	margin-left: -1050px;
}

.box1 select{
	width: 5%
}  
.box1 input[type="date"] {
	width: 150px;
	padding: 5px 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 6px;
	background-color: #f9f9f9;
	color: #333;
	outline: none;
	transition: border 0.3s ease;
}

.box1 input[type="date"]:focus {
	border: 1px solid #007bff;
	background-color: #fff;
}  
.box1 label,
.box1 input {
	margin-right: 10px; /* 요소 사이 간격 */
}  
th{
	font-size:14px;
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
		<label class="daylabel">기간 : </label>
		<input type="date" class="sdate" id="sdate" style="font-size: 16px;" autocomplete="off"> ~ 
		<input type="date" class="edate" id="edate" style="font-size: 16px;" autocomplete="off">		
	</div>
    
    <div class="button-container">
        <button class="select-button" onclick="getBegaInsertList();">
            <img src="/mibogear/image/search-icon.png" alt="select" class="button-image">
           
        </button>
        <button class="insert-button">
            <img src="/mibogear/image/insert-icon.png" alt="insert" class="button-image">
          
        </button>
        <button class="excel-button">
            <img src="/mibogear/image/excel-icon.png" alt="excel" class="button-image">
            
        </button>
        <button class="printer-button">
            <img src="/mibogear/image/printer-icon.png" alt="printer" class="button-image">
            
        </button>
    </div>
</div>
    <main class="main">
		<div class="container">
			<div id="tab1" class="tabulator"></div>
		</div>
	</main>
	    
	    
 <form method="post" id="begaInsertForm" name="begaInsertForm">   
  <div class="begaInsertModal">	
	<div class="detail">
			<div class="header">
				설비비가동등록
				<span class="header-close">&times;</span>
			</div>
                <table cellspacing="0" cellpadding="0" width="100%">
                    <tbody><tr>
                        <td class="">
                            <table cellspacing="0" cellpadding="0" width="100%" class="insideTable">
                                <colgroup span="4">
                                    <col width="*">
                                    <col width="40%">
                                    <col width="*">
                                    <col width="40%">
                                </colgroup>
                                <tbody><tr>
                                    <th class="left">설비</th>
                                    <td class="">
                                    	<!-- <input type="hidden" name="fstp_code" id="fstp_code"> -->
                                        <input id="fac_code" name="fac_code" class="basic" type="hidden" style="width:50%;" readonly="readonly"> 
                                        <input id="fac_name" name="fac_name" class="basic" type="text" style="width:50%;" readonly="readonly">
                                        <input type="button" title="검색" class="btnSearchSmall" value="설비검색" onclick="openFacListModal();"></td>
                                    <th rowspan="7" class=""><span class="left">설비중지시간(분)</span></th>
                                    <td rowspan="7" class="">
                                        <table cellspacing="0" cellpadding="0" width="100%" class="insideTable">
                                            <tbody><tr>
                                                <th class="thSub">ITEM변경</th>
                                                <td class="tdRight"><input id="fstp_01" name="fstp_01" class="basic" type="text" style="width:90%;" value="0""></td>
                                                </tr>
                                            <tr>
                                                <th class="thSub">물량부족</th>
                                                <td class="tdRight"><input id="fstp_02" name="fstp_02" class="basic" type="text" style="width:90%;" value="0""></td>
                                                </tr>
                                            <tr>
                                                <th class="thSub">설비이상(기계)</th>
                                                <td class="tdRight"><input id="fstp_03" name="fstp_03" class="basic" type="text" style="width:90%;" value="0""></td>
                                                </tr>
                                            <tr>
                                                <th class="thSub">설비이상(전기)</th>
                                                <td class="tdRight"><input id="fstp_04" name="fstp_04" class="basic" type="text" style="width:90%;" value="0""></td>
                                                </tr>
                                            <tr>
                                                <th class="thSub">교육</th>
                                                <td class="tdRight"><input id="fstp_05" name="fstp_05" class="basic" type="text" style="width:90%;" value="0""></td>
                                            </tr>
                                            <tr>
                                                <th class="thSub">교대</th>
                                                <td class="tdRight"><input id="fstp_06" name="fstp_06" class="basic" type="text" style="width:90%;" value="0""></td>
                                            </tr>
                                            <tr>
                                                <th class="thSub">식사</th>
                                                <td class="tdRight"><input id="fstp_07" name="fstp_07" class="basic" type="text" style="width:90%;" value="0""></td>
                                            </tr>
                                            <tr>
                                                <th class="thSub">휴식</th>
                                                <td class="tdRight"><input id="fstp_08" name="fstp_08" class="basic" type="text" style="width:90%;" value="0""></td>
                                            </tr>
                                            <tr>
                                                <th class="thSub">기타</th>
                                                <td class="tdRight"><input id="fstp_09" name="fstp_09" class="basic" type="text" style="width:90%;" value="0""></td>
                                                </tr>
                                            <tr>
                                                <th class="thSub">계</th>
                                                <td class="tdRight"><input id="fstp_10" name="fstp_10" class="basic" type="text" style="width:90%;" value="0" readonly="readonly"></td>
                                            </tr>
                                        </tbody></table>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="left">일자</th>
                                    <td class=""><input id="fstp_date" name="fstp_date" class="date js-datepicker hasDatepicker" type="date" style="width:100px;"  maxlength="20" size="20" ></td>
                                    </tr>
                                <tr>
                                    <th class="">계획시간(분)</th>
                                    <td class=""><input id="fstp_plan" name="fstp_plan" class="basic" type="text" style="width:90%;" value="1440"></td>
                                    </tr>
                                <tr>
                                    <th class="">투입시간(분)</th>
                                    <td class=""><input id="fstp_tu" name="fstp_tu" class="basic" type="text" style="width:90%;" value="1440"></td>
                                    </tr>
                                <tr>
                                    <th class="">준비시간(분)</th>
                                    <td class=""><input id="fstp_stby" name="fstp_stby" class="basic" type="text" style="width:90%;" value=""></td>
                                </tr>
                                <tr>
                                    <th class="left">TOTAL현황</th>
                                    <td class="">
                                        <table cellspacing="0" cellpadding="0" width="100%" class="insideTable">
                                            <tbody><tr>
                                                <th class="thSub">실가동시간(분)</th>
                                                <td class="tdRight"><input id="fstp_sil" name="fstp_sil" class="basic" type="text" style="width:90%;" value="" readonly="readonly"></td>
                                                </tr>
                                            <tr>
                                                <th class="thSub">인원</th>
                                                <td class="tdRight"><input id="fstp_man" name="fstp_man" class="basic" type="text" style="width:90%;" value=""></td>
                                                </tr>
                                            <tr>
                                                <th class="thSub">M-Hr</th>
                                                <td class="tdRight"><input id="fstp_mhr" name="fstp_mhr" class="basic" type="text" style="width:90%;" value="" readonly="readonly"></td>
                                            </tr>
                                        </tbody></table>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="left">비고</th>
                                    <td valign="top" class=""><textarea name="fstp_bigo" id="fstp_bigo" class="basic" style="width:90%; height:40px;"></textarea></td>
                                </tr>
                            </tbody></table>
                        </td>
                        </tr>
                </tbody></table>
                <div class="btnSaveClose">
                	 <button class="delete" type="button" onclick="deleteBega();"  style="display: none;">삭제</button>
					 <button class="save" type="button" onclick="save();">저장</button>
					 <button class="close" type="button" onclick="window.close();">닫기</button>
    	  		</div>
            </div>
         </div>   
        </form>


	<!-- 설비목록(검색버튼) 팝업창 -->
	<div id="facListModal" class="modal-overlay" style="display: none;">
		<div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">설비 리스트</span> <span class="modal-close" onclick="closeFacListModal()">&times;</span>
			</div>
			<div id="facListTabulator" style="height: 500px;"></div>
		</div>
	</div>


	<script>
		//전역변수
		var cutumTable;
		var isEditMode = false; //수정,최초저장 구분값

		//로드
		$(function() {
			var tdate = todayDate();
			var ydate = yesterDate();
			
			$("#sdate").val(ydate);
			$("#edate").val(tdate);
			getBegaInsertList();
		});

		//이벤트
		//함수
		function getBegaInsertList() {
			userTable = new Tabulator(
					"#tab1",
					{
						height : "750px",
						layout : "fitColumns",
						selectable : true, //로우 선택설정
						tooltips : true,
						selectableRangeMode : "click",
						reactiveData : true,
						headerHozAlign : "center",
						ajaxConfig : "POST",
						ajaxLoader : false,
						ajaxURL : "/mibogear/preservation/begaInsert/getBegaInsertList",
						ajaxProgressiveLoad : "scroll",
						ajaxParams : {
							"sdate" : $("#sdate").val(),
							"edate" : $("#edate").val(),
						},
						placeholder : "조회된 데이터가 없습니다.",
						paginationSize : 20,
						ajaxResponse : function(url, params, response) {
							$("#tab1 .tabulator-col.tabulator-sortable").css(
									"height", "29px");
							return response; //return the response data to tabulator
						},
						columns : [ {
							title : "NO",
							field : "idx",
							sorter : "int",
							width : 80,
							hozAlign : "center"
						}, {
							title : "일자",
							field : "fstp_date",
							sorter : "string",
							width : 120,
							hozAlign : "center"
						}, {
							title : "설비명",
							field : "fac_name",
							sorter : "string",
							width : 120,
							hozAlign : "center"
						}, {
							title : "계획시간(분)",
							field : "fstp_plan",
							sorter : "string",
							width : 120,
							hozAlign : "center"
						}, {
							title : "투입시간(분)",
							field : "fstp_tu",
							sorter : "string",
							width : 150,
							hozAlign : "center"
						}, {
							title : "준비시간(분)",
							field : "fstp_stby",
							sorter : "string",
							width : 120,
							hozAlign : "center"
						}, {
							title : "ITEM변경",
							field : "fstp_01",
							sorter : "string",
							width : 100,
							hozAlign : "center"
						}, {
							title : "물량부족",
							field : "fstp_02",
							sorter : "string",
							width : 100,
							hozAlign : "center"
						}, {
							title : "설비이상(기계)",
							field : "fstp_03",
							sorter : "string",
							width : 100,
							hozAlign : "center"
						}, {
							title : "설비이상(전기)",
							field : "fstp_04",
							sorter : "string",
							width : 100,
							hozAlign : "center"
						}, {
							title : "교육",
							field : "fstp_05",
							sorter : "string",
							width : 100,
							hozAlign : "center"
						}, {
							title : "교대",
							field : "fstp_06",
							sorter : "string",
							width : 100,
							hozAlign : "center"
						}, {
							title : "식사",
							field : "fstp_07",
							sorter : "string",
							width : 100,
							hozAlign : "center"
						}, {
							title : "휴식",
							field : "fstp_08",
							sorter : "string",
							width : 100,
							hozAlign : "center"
						}, {
							title : "기타",
							field : "fstp_09",
							sorter : "string",
							width : 100,
							hozAlign : "center"
						},
						{title:"비가동코드", field:"fstp_code", width:200, hozAlign:"center",visible:false},
						{title:"", field:"fstp_bigo", width:200, hozAlign:"center",visible:false},
						{title:"", field:"fstp_10", width:200, hozAlign:"center",visible:false},
						],
						rowFormatter : function(row) {
							var data = row.getData();

							row.getElement().style.fontWeight = "700";
							row.getElement().style.backgroundColor = "#FFFFFF";
						},
						rowClick : function(e, row) {

							$(
									"#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row")
									.each(
											function(index, item) {

												if ($(this).hasClass(
														"row_select")) {
													$(this).removeClass(
															'row_select');
													row.getElement().className += " row_select";
												} else {
													$("#tab1 div.row_select")
															.removeClass(
																	"row_select");
													row.getElement().className += " row_select";
												}
											});

							var rowData = row.getData();

						},
						rowDblClick:function(e, row){

							var data = row.getData();
							selectedRowData = data;
							isEditMode = true;
							console.log(selectedRowData.fstp_code)
							$('#begaInsertForm')[0].reset();

							/* Object.keys(data).forEach(function (key) {
						        const field = $('#begaInsertForm [name="' + key + '"]');

						        if (field.length) {
						            field.val(data[key]);
						        }
							}); */
							begaInsertDetail(data.fstp_code);
							 $('.delete').show();
						},
					});
		}

		function begaInsertDetail(fstp_code){
			$.ajax({
				url:"/mibogear/preservation/begaInsert/begaInsertDetail",
				type:"post",
				dataType:"json",
				data:{
					"fstp_code":fstp_code
				},
				success:function(result){
//					console.log(result);
					var allData = result.data;
					
					for(let key in allData){
//						console.log(allData, key);	
						$("#begaInsertForm [name='"+key+"']").val(allData[key]);
					}

					$('.begaInsertModal').show().addClass('show');
				}
			});
		}

		



		//설비검색버튼 리스트 모달
	    function openFacListModal() {
	        document.getElementById('facListModal').style.display = 'flex';

	        
	        let facListTable = new Tabulator("#facListTabulator", {
	            height:"450px",
	            layout:"fitColumns",
	            selectable:true,
	            ajaxURL:"/mibogear/standardManagement/facInsert/getFacList",
	            ajaxConfig:"POST",
	            ajaxParams:{
	                "fac_code": "",
	                "fac_name": "",
	                "fac_no":"",
	                   
	            },
			    ajaxResponse:function(url, params, response){
//					$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
					console.log(response);
			        return response.data; //return the response data to tabulator
			    },    
	            columns:[
	                {title:"NO", field:"idx", width:80, hozAlign:"center"},
	                {title:"설비NO", field:"fac_no", width:120, hozAlign:"center"},
	                {title:"설비NO", field:"fac_code", width:120, hozAlign:"center",visible:false},
	                {title:"설비명", field:"fac_name", width:150, hozAlign:"center"},
	                {title:"규격", field:"fac_gyu", width:100, hozAlign:"center"},
	                {title:"형식", field:"fac_hyun", width:200, hozAlign:"center"},
	                {title:"용도", field:"fac_yong", width:200, hozAlign:"center"},
	                
	            ],
	            rowDblClick:function(e, row){
	                let data = row.getData();
	                
	                console.log("선택된 설비:", data);
	                document.getElementById('fac_code').value = data.fac_code;
	                document.getElementById('fac_name').value = data.fac_name;
	                
	                document.getElementById('facListModal').style.display = 'none';
	            }
	        });
	    }

	    function closeFacListModal() {
	        document.getElementById('facListModal').style.display = 'none';
	    }



		//비가동등록 저장
	    function save() {
		    var formData = new FormData($("#begaInsertForm")[0]);

		    let confirmMsg = "";

		    if (isEditMode && selectedRowData && selectedRowData.fstp_code) {
		        formData.append("mode", "update");
		        formData.append("fstp_code", selectedRowData.fstp_code);
		        confirmMsg = "수정하시겠습니까?";
		    } else {
		        formData.append("mode", "insert");
		        confirmMsg = "저장하시겠습니까?";
		    }

		    if (!confirm(confirmMsg)) {
		        return;
		    }

		    $.ajax({
		        url: "/mibogear/preservation/begaInsert/begaInsertSave",
		        type: "POST",
		        data: formData,
		        contentType: false,
		        processData: false,
		        dataType: "json",
		        success: function(result) {
		            alert("저장 되었습니다.");
		            $(".begaInsertModal").hide();
		            getBegaInsertList();
		        },
		        error: function(xhr, status, error) {
		            console.error("저장 오류:", error);
		        }
		    });
		}


		function deleteBega() {
		    if (!selectedRowData || !selectedRowData.fstp_code) {
		        alert("삭제할 대상을 선택하세요.");
		        return;
		    }

		    if (!confirm("삭제하시겠습니까?")) {
		        return;
		    }

		    $.ajax({
		        url: "/mibogear/preservation/begaInsert/begaDelete",
		        type: "POST",
		        data: {
		        	fstp_code: selectedRowData.fstp_code
		        },
		        dataType: "json",
		        success: function(result) {
		            if (result.status === "success") {
		                alert("삭제되었습니다.");
		                $(".begaInsertModal").hide();
		                getBegaInsertList();
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
			
	</script>
    
    
    <script>
		
 	// 드래그 기능 추가
	const modal = document.querySelector('.begaInsertModal');
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
	const begaInsertModal = document.querySelector('.begaInsertModal');
	const closeButton = document.querySelector('.close');
	const headerCloseButton = document.querySelector('.header-close');

	insertButton.addEventListener('click', function() {
		isEditMode = false;  // 추가 모드
	    $('#begaInsertForm')[0].reset(); // 폼 초기화
	    begaInsertModal.style.display = 'block'; // 모달 표시

		$('.delete').hide();
	});

	closeButton.addEventListener('click', function() {
		begaInsertModal.style.display = 'none'; // 모달 숨김
	});
		
	headerCloseButton.addEventListener('click', function() {
		begaInsertModal.style.display = 'none';
	});

    </script>
    
    
    <script>

	

    $(function(){

    	  // 1~9 입력창 변화 감지
    	  $("#fstp_01, #fstp_02, #fstp_03, #fstp_04, #fstp_05, #fstp_06, #fstp_07, #fstp_08, #fstp_09").on("input", function() {
    	    updateSum();
    	  });

    	  // 계획, 대기, 인원 변화 감지
    	  $("#fstp_plan, #fstp_stby, #fstp_man").on("input", function() {
    	    updateSil();
    	  });

    	  // 합계 계산
    	  function updateSum() {
    	    let sum = 0;
    	    for(let i=1; i<=9; i++) {
    	      let val = parseInt($("#fstp_0" + i).val());
    	      if(!isNaN(val)) sum += val;
    	    }
    	    $("#fstp_10").val(sum);
    	  }

    	  // 실가동시간 계산
    	  function updateSil() {
    	    let plan = parseInt($("#fstp_plan").val()) || 0;
    	    let stby = parseInt($("#fstp_stby").val()) || 0;

    	    let sil = plan - stby;
    	    if(sil < 0) sil = 0;

    	    $("#fstp_sil").val(sil);
    	    updateMhr(); // 실가동시간 계산 후 M-Hr도 업데이트
    	  }

    	  // M-Hr 계산
    	  function updateMhr() {
    	    let sil = parseInt($("#fstp_sil").val()) || 0;
    	    let man = parseFloat($("#fstp_man").val()) || 0;

    	    if(man > 0) {
    	      let mhr = (sil / 60 / man).toFixed(2);
    	      $("#fstp_mhr").val(mhr);
    	    } else {
    	      $("#fstp_mhr").val("");
    	    }
    	  }

    	  // 초기 계산
    	  updateSum();
    	  updateSil();

    	});


    </script>
    
    

	</body>
</html>
