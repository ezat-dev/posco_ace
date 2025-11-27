
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>온도조절계보정현황</title>
    <%@include file="../include/pluginpage.jsp" %>
    <jsp:include page="../include/tabBar.jsp"/>
    <link href="https://unpkg.com/tabulator-tables@5.5.0/dist/css/tabulator.min.css" rel="stylesheet">
    <style>
.container {
	max-width: 95%;
	margin: 0 auto;
}

.tab {
	width: 95%;
	margin-bottom: 37px;
	margin-top: 5px;
	height: 45px;
	border-radius: 6px 6px 0px 0px;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.button-container {
	display: flex;
	gap: 10px;
}

.box1 {
	display: flex;
	align-items: center;
	margin-right: auto;
	color: white;
	font-weight: bold;
}

.tabulator {
	background: white;
	border-radius: 6px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	margin-bottom: 80px;
}

.daylabel {
	margin: 0 10px;
}

.daySet {
	padding: 6px 10px;
	font-size: 14px;
	border-radius: 4px;
	border: 1px solid #ccc;
}

.button-image {
	width: 16px;
	height: 16px;
}

.select-button, .insert-button, .delete-button, .excel-download-button,
	.excel-upload-button {
	height: 36px;
	padding: 6px 10px;
	font-size: 13px;
	border-radius: 4px;
	background: white;
	border: 1px solid #aaa;
	display: flex;
	align-items: center;
	gap: 5px;
	cursor: pointer;
}

.box1 {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-left: 20px;
	font-size: 14px;
}

.box1 label {
	font-weight: bold;
	margin-right: 5px;
}

.box1 select {
	padding: 4px 10px;
	font-size: 14px;
	height: 32px;
	border-radius: 4px;
	border: 1px solid #ccc;
}

.button-container label {
	font-weight: bold;
	margin-right: 5px;
	height: 37px;
	padding-top:3px;
}

.button-container select {
	padding: 4px 10px;
	font-size: 14px;
	height: 37px;
	border-radius: 4px;
	border: 1px solid #ccc;
}

.box1 .tabP {
	font-size: 16px;
	font-weight: bold;
	color: white;
	margin: 0 10px 0 0;
}
.modal {
  position: fixed;
  z-index: 9999;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0,0,0,0.4); /* 반투명 검정 배경 */
}

/* 모달 본문 */
.modal-content {
  background-color: #fff;
  margin: 15% auto;
  padding: 20px;
  border-radius: 8px;
  width: 300px;
  text-align: center;
  box-shadow: 0px 0px 15px rgba(0,0,0,0.3);
  animation: fadeIn 0.3s ease-in-out;
}

/* 모달 애니메이션 */
@keyframes fadeIn {
  from { opacity: 0; margin-top: 50px; }
  to { opacity: 1; margin-top: 15%; }
}

/* 버튼 스타일 (선택 사항) */
.modal-content button {
  margin: 8px;
  padding: 6px 12px;
  font-size: 14px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
</style>
</head>
<body>

	<div class="tab">
		<div class="box1">
			<p class="tabP">조건관리 - 열전대교체이력</p>
		</div>
		<div class="button-container">
			<label for="sdate">년도 선택:</label> 
			<select id="sdate">
				<option value="2025">2025</option>
				<option value="2026">2026</option>
				<option value="2027">2027</option>
			</select>
		
			<button class="select-button" onclick="getTempCorrData();">
				<img src="/mibogear/css/tabBar/search-icon.png" alt="select"
					class="button-image">조회
			</button>
			<button class="insert-button">
				<img src="/mibogear/css/tabBar/add-outline.png" alt="insert"
					class="button-image">추가
			</button>
			<button class="delete-button">
				<img src="/mibogear/css/tabBar/xDel3.png" alt="delete"
					class="button-image">삭제
			</button>
			<button class="excel-download-button">
				<img src="/mibogear/css/tabBar/excel-icon.png" alt="excel"
					class="button-image">엑셀다운로드
			</button>
			<button class="excel-upload-button">
				<img src="/mibogear/css/tabBar/excel-icon.png" alt="excel"
					class="button-image">엑셀업로드
			</button>
			<input type="file" id="fileInput" style="display: none;">
		</div>
	</div>

	<main class="main">
		<div class="container">
			<h3>퀜칭로</h3>
			<div id="tab1" class="tabulator"></div>

			<h3>템퍼링로</h3>
			<div id="tab2" class="tabulator"></div>
		</div>
	</main>
	
	<div id="inputModal" class="modal" style="display:none;">
	  <div class="modal-content">
	    <h3 id="modalTitle"></h3>
	    <input type="text" id="inputValue">
	    <input type="date" id="dateValue" style="display:none;">
	    <button onclick="saveInput()">저장</button>
	    <button onclick="closeModal()">닫기</button>
	  </div>
	</div>

	<script>
		//전역변수
		let now_page_code = "c03";

		$(function() {
			getTempCorrectionQueList();
			getTempCorrectionTemList();
			
			getTempCorrData();
		});


		function getTempCorrData(){
			$.ajax({
				url:"/mibogear/condition/tempCorrection/getTempCorrectionQueList",
				type:"post",
				dataType:"json",
				data:{
					"year":$("#sdate").val()
				},
				success:function(result){
					var d = result.data;
					
					var qArray = new Array();
					var tArray = new Array();
					
					if(d.length > 0){
						for(var i=0; i<d.length; i++){
							var gbVal = "";
							if(d[i].gb.indexOf("퀜칭로") != -1){
								gbVal = d[i].gb.replace("퀜칭로 ","");
								d[i].gb = gbVal;
								qArray.push(d[i]);
							}
							
							if(d[i].gb.indexOf("템퍼링로") != -1){
								gbVal = d[i].gb.replace("템퍼링로 ","");
								d[i].gb = gbVal;
								
								tArray.push(d[i]);
							}
						}
						
						corrQue.setData(qArray);
						corrTem.setData(tArray);
					}
				}
			})
		}
		
		let corrQue;
		function getTempCorrectionQueList() {
			corrQue = new Tabulator("#tab1", {
		        height: "233px",
		        layout: "fitColumns",
		        selectable: true,
		        tooltips: true,
		        selectableRangeMode: "click",
		        reactiveData: true,
		        headerHozAlign: "center",
/*
		        ajaxConfig: "POST",
		        ajaxLoader: false,
		        ajaxURL: "/mibogear/condition/tempCorrection/getTempCorrectionQueList",
		        ajaxParams: {
		            year: $("#sdate").val()
		        },
*/
		        ajaxResponse: function (url, params, response) {
		            $("#tab1 .tabulator-col.tabulator-sortable").css("height", "55px");
		            return response.data; // 리스트 전체 반환
		        },
		        placeholder: "조회된 데이터가 없습니다.",
		        paginationSize: 20,
		        columns: [
		        	{
		        		title:"cnt",
		        		field:"cnt",
		        		visible:false		        		
		        	},
		            {
		                title: "구분",
		                field: "gb",
		                hozAlign: "center",
		                width: 120,
		                headerSort: false
		            },
		            {
		                title: "보정전",
		                field: "val1",
		                hozAlign: "center",
		                editor: "input"
		            },
		            {
		                title: "상반기 보정",
		                field: "val2",
		                hozAlign: "center",
		                editor: "input"
		            },
		            {
		                title: "하반기 보정",
		                field: "val3",
		                hozAlign: "center",
		                editor: "input"
		            }
		        ],
		        rowFormatter: function (row) {
		            row.getElement().style.fontWeight = "600";
		            row.getElement().style.backgroundColor = "#fdfdfd";
		        },
		        cellEdited: function(cell) {
				    var field = cell.getField(); 
				    var value = cell.getValue(); 
				    var rowData = cell.getRow().getData(); 
				    var cnt = rowData.cnt; 

				    $.ajax({
				        url: "/mibogear/condition/tempCorrection/updateTempCorrectionField",
				        type: "POST",
				        dataType:"json",			        
				        data: {
				        	"c_field":field,
				        	"c_value":value,
				        	"cnt":cnt
				        },
				        success: function(result) {
				        	
				        }
				    });
				}
		    });
		}



		function closeModal() {
		    $("#inputModal").hide();
		}


		
		let corrTem;
		function getTempCorrectionTemList() {
			corrTem = new Tabulator("#tab2",{
						height : "233px",
						layout : "fitColumns",
						selectable : true, //로우 선택설정
						tooltips : true,
						selectableRangeMode : "click",
						reactiveData : true,
						headerHozAlign : "center",
/*						
						ajaxConfig : "POST",
						ajaxLoader : false,
						ajaxURL : "/mibogear/condition/tempCorrection/getTempCorrectionTemList",
						ajaxProgressiveLoad : "scroll",
						ajaxParams : {},
*/
						placeholder : "조회된 데이터가 없습니다.",
						paginationSize : 20,
						ajaxResponse : function(url, params, response) {
							$("#tab1 .tabulator-col.tabulator-sortable").css(
									"height", "55px");
							return response; //return the response data to tabulator
						},
						columns : [ {
							title : "구분",
							field : "gb",
							hozAlign : "center",
							width : 120,
							headerSort : false
						}, {
							title : "보정전",
							field : "val1",
							hozAlign : "center",
							editor : "input"
						}, {
							title : "상반기 보정",
							field : "val2",
							hozAlign : "center",
							editor : "input"
						}, {
							title : "하반기 보정",
							field : "val3",
							hozAlign : "center",
							editor : "input"
						} ],
						rowFormatter : function(row) {
							row.getElement().style.fontWeight = "600";
							row.getElement().style.backgroundColor = "#fdfdfd";
						},
						cellDblClick : function(e, cell) {
							cell.edit(true);
						},
					});
		}
	</script>
</body>
</html>
