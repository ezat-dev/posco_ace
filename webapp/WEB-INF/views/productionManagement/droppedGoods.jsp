<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>낙하품관리</title>
<%@include file="../include/pluginpage.jsp" %>
    <jsp:include page="../include/tabBar.jsp"/>
    <link href="https://unpkg.com/tabulator-tables@5.5.0/dist/css/tabulator.min.css" rel="stylesheet">
</head>
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
<body>

	<div class="tab">
		<!-- <div class="box1">
	           <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
	           <label class="daylabel">검색일자 :</label>
				<input type="text" autocomplete="off" class="daySet" id="w_date" name="w_date" style="font-size: 16px; margin-bottom:10px;" placeholder="시작 날짜 선택">
			</div> --> 
		<div class="button-container">
			<button class="select-button" onclick="getDroppedGoodsList();">
				<img src="/chunil/css/tabBar/search-icon.png" alt="select"
					class="button-image">조회
			</button>
			<button class="insert-button">
				<img src="/chunil/css/tabBar/add-outline.png" alt="insert"
					class="button-image">추가
			</button>
			<button class="delete-button">
				<img src="/chunil/css/tabBar/xDel3.png" alt="delete"
					class="button-image">삭제
			</button>
			<button class="excel-download-button">
				<img src="/chunil/css/tabBar/excel-icon.png" alt="excel"
					class="button-image">엑셀다운로드
			</button>
			<button class="excel-upload-button">
				<img src="/chunil/css/tabBar/excel-icon.png" alt="excel"
					class="button-image">엑셀업로드
			</button>
			<input type="file" id="fileInput" style="display: none;">
		</div>
	</div>

	
		<div class="container">
			<div id="tab1" class="tabulator"></div>
		</div>
	
	
	
	
	
	<script>
	//전역변수
	  let now_page_code = "c02";

	//로드
	$(function(){
		$(".headerP").text("조건관리 - 열전대교체이력");
	});

	//로드
	$(function(){
		//전체 거래처목록 조회
		getDroppedGoodsList();
	});

	//이벤트
	//함수
	function getDroppedGoodsList() {
		userTable = new Tabulator("#tab1", {
			height: "620px",
			layout: "fitColumns",
			selectable: true,
			tooltips: true,
			selectableRangeMode: "click",
			reactiveData: true,
			headerHozAlign: "center",
			ajaxConfig: "POST",
			ajaxLoader: false,
			ajaxURL: "/chunil/productionManagement/droppedGoods/getDroppedGoodsList",
			ajaxParams: { "w_date" : $("#w_date").val()},
			ajaxResponse: function (url, params, response) {
				$("#tab1 .tabulator-col.tabulator-sortable").css("height", "55px");
				return response.data;
			},
			placeholder: "조회된 데이터가 없습니다.",
			paginationSize: 20,
			columns: [
			    { title: "작업 No", field: "d_lot", hozAlign: "center" },
			    { title: "투입시간", field: "w_sdatetime", hozAlign: "center" },
			    { title: "품번", field: "w_pnum", hozAlign: "center" },
			    { title: "품명", field: "item_name", hozAlign: "center" },
			    {
			        title: "낙하품유무", hozAlign: "center", columns: [ 
			            { title: "투입", field: "d_in", hozAlign: "center", editor: "select", editorParams: { values: ["O", "X"] } },
			            { title: "침탄", field: "d_qf", hozAlign: "center", editor: "select", editorParams: { values: ["O", "X"] } },
			            { title: "템퍼링", field: "d_tf", hozAlign: "center", editor: "select", editorParams: { values: ["O", "X"] } },
			            { title: "퇴출", field: "d_out", hozAlign: "center", editor: "select", editorParams: { values: ["O", "X"] } }
			        ]
			    },
			    { title: "특이사항", field: "d_bigo", hozAlign: "center", editor: "input" }
			],
			rowFormatter: function (row) {
				row.getElement().style.fontWeight = "700";
				row.getElement().style.backgroundColor = "#FFFFFF";
			},
			rowClick: function (e, row) {
				$("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").removeClass("row_select");
				row.getElement().classList.add("row_select");
			},
			cellEdited: function(cell) {
			    const field = cell.getField(); 
			    const value = cell.getValue(); 
			    const rowData = cell.getRow().getData(); 
			    const d_lot = rowData.d_lot; 

			    $.ajax({
			        url: "/chunil/productionManagement/droppedGoods/updateDroppedGoods",
			        type: "POST",
			        contentType: "application/json",
			        data: JSON.stringify({
			            d_lot: d_lot,
			            column: field,
			            value: value
			        }),
			        success: function(res) {
			            if (res.result !== "success") {
			                alert("저장 실패: " + res.message);
			            }
			        },
			        error: function() {
			            alert("서버 통신 실패");
			        }
			    });
			},
		});
	}


	





</script>

</body>
</html>