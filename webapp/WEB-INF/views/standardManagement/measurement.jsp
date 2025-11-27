<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>측정기기등록</title>
    <link rel="stylesheet" href="/mibogear/css/standardstandardstandardManagement/productInsert.css">
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
	width: 700px; /* 가로 길이 고정 */
	height: 410px; /* 세로 길이 고정 */
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.7);
	margin: 20px auto; /* 중앙 정렬 */
	padding: 20px;
	border-radius: 5px; /* 모서리 둥글게 */
	overflow-y: auto; /* 세로 스크롤 추가 */
	position: relative; /* 자식 요소의 절대 위치 설정을 위한 기준 */
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

.measurementModal {
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
    
    <div class="tab">
    
    <div class="box1">
           <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
        
			</div>
    
    <div class="button-container">
        <button class="select-button" onclick="getMeasureList();">
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


<form method="post" class="corrForm" id="measurementForm" name="measurementForm">	    
  <div class="measurementModal">    
    <div class="detail">
      <div class="header">
        측정기기등록
        <span class="header-close">&times;</span>
      </div>

      <table class="formTable">
        <tr>
          <th>측정기기명</th>
          <td><input type="text" id="ter_name" name="ter_name" class="inputField">
          <input id="ter_code" name="ter_code"  type="hidden" readonly="readonly"></td>
          
          <th>측정기기번호</th>
          <td><input type="text" id="ter_no" name="ter_no" class="inputField"></td>
        </tr>
        <tr>
          <th>모델명</th>
          <td><input type="text" id="ter_model" name="ter_model" class="inputField"></td>
          <th>측정기기종류</th>
          <td><input type="text" id="ter_kind" name="ter_kind" class="inputField"></td>
        </tr>
        <tr>
          <th>관리자</th>
          <td><input type="text" id="ter_man" name="ter_man" class="inputField"></td>
          <th>비고</th>
          <td><input type="text" id="ter_bigo" name="ter_bigo" class="inputField"></td>
        </tr>
      </table>

      <div class="btnSaveClose">
        <button class="delete" type="button" onclick="deleteMea();" style="display: none;">삭제</button>
        <button class="save" type="button" onclick="save();">저장</button>
        <button id="btnSaveAs" class="saveAs" type="button" onclick="saveAsNew();" style="display:none;">다른이름저장</button>
        <button class="close" type="button" onclick="window.close();">닫기</button>
      </div>
    </div>
  </div>
</form>

	    
	    
	    

	    
<script>


   
//전역변수
var cutumTable;	
var isEditMode = false; //수정,최초저장 구분값


//로드
$(function(){
	//전체 거래처목록 조회
	getMeasureList();
});


//이벤트
//함수
	function getMeasureList(){
		
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
		    ajaxURL:"/mibogear/standardManagement/measurement/measureList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{},
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		        {title:"NO", field:"idx", sorter:"int", width:100,
		        	hozAlign:"center"},
		        {title:"측정기기명", field:"ter_name", sorter:"string", width:200,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"측정기기번호", field:"ter_no", sorter:"string", width:200,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"모델명", field:"ter_model", sorter:"string", width:200,
			        hozAlign:"center", headerFilter:"input"},	
			    {title:"측정기기종류", field:"ter_kind", sorter:"string", width:200,
				    hozAlign:"center", headerFilter:"input"},
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
				$('#measurementForm')[0].reset();
				console.log("data.ter_code",data.ter_code);
				measureDetail(data.ter_code);
	
				 $('.delete').show();
			},
		});		
	}
	
	//더블클릭 했을 때 데이터 가져오기
		function measureDetail(ter_code){
		$.ajax({
			url:"/mibogear/standardManagement/getMeasurmentDetail",
			type:"post",
			dataType:"json",
			data:{
				"ter_code":ter_code
			},
			success:function(result){
				console.log(result);
				var allData = result.data;
				
				for(let key in allData){
	//				console.log(allData, key);	
					$("#measurementForm [name='"+key+"']").val(allData[key]);
				}
	
				$('.measurementModal').show().addClass('show');
			}
		});
	}
	
	
	</script>
	
	
	<script>
		
	// 드래그 기능 추가
	const modal = document.querySelector('.measurementModal');
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
	const measurementModal = document.querySelector('.measurementModal');
	const closeButton = document.querySelector('.close');
	
	insertButton.addEventListener('click', function() {
		isEditMode = false;  // 추가 모드
	    $('#measurementForm')[0].reset(); // 폼 초기화
	    measurementModal.style.display = 'block'; // 모달 표시
	
		
	    
		$('.delete').hide();
	});
	
	closeButton.addEventListener('click', function() {
		measurementModal.style.display = 'none'; // 모달 숨김
	});
	
	
	
	//측정기기 저장
	function save() {
	    var formData = new FormData($("#measurementForm")[0]);
	
	    let confirmMsg = "";
	
	    if (isEditMode && selectedRowData && selectedRowData.ter_code) {
	        formData.append("mode", "update");
	        formData.append("wstd_code", selectedRowData.ter_code);
	        confirmMsg = "수정하시겠습니까?";
	    } else {
	        formData.append("mode", "insert");
	        confirmMsg = "저장하시겠습니까?";
	    }
	
	    if (!confirm(confirmMsg)) {
	        return;
	    }
	
	    $.ajax({
	        url: "/mibogear/standardManagement/measurement/measureInsertSave",
	        type: "POST",
	        data: formData,
	        contentType: false,
	        processData: false,
	        dataType: "json",
	        success: function(result) {
	        	alert("저장 되었습니다.");
	            $(".measurementModal").hide();
	            getMeasureList();
	        },
	        error: function(xhr, status, error) {
	            console.error("저장 오류:", error);
	        }
	    });
	}
	
	
	function deleteMea() {
	    if (!selectedRowData || !selectedRowData.ter_code) {
	        alert("삭제할 대상을 선택하세요.");
	        return;
	    }
	
	    if (!confirm("삭제하시겠습니까?")) {
	        return;
	    }
	
	    $.ajax({
	        url: "/mibogear/standardManagement/measurement/measureDelete",
	        type: "POST",
	        data: {
	        	ter_code: selectedRowData.ter_code
	        },
	        dataType: "json",
	        success: function(result) {
	            if (result.status === "success") {
	                alert("삭제되었습니다.");
	                $(".measurementModal").hide();
	                getMeasureList();
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

	</body>
</html>
