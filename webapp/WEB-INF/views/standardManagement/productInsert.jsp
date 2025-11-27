<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제품등록</title>
    <link rel="stylesheet" href="/mibogear/css/standardManagement/productInsert.css">
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
/* 📋 제품등록 테이블 폼 */
.product-content-table {
	padding: 10px 20px;
}

.product-table {
	width: 100%;
	border-collapse: collapse;
	font-size: 14px;
	color: #333;
}

.product-table th, .product-table td {
	border: 1px solid #ccc;
	padding: 8px 10px;
	vertical-align: middle;
}

.product-table th {
	background-color: #f4f4f4;
	text-align: center;
	font-weight: bold;
	width: 120px;
}

.product-table td input[type="text"] {
	width: 90%;
	padding: 6px 8px;
	border: 1px solid #aaa;
	border-radius: 3px;
	font-size: 13px;
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

.productModal {
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
</style>
    
    
    <body>
    
    <div class="tab">
    
    <div class="box1">
           <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
        
			</div>
    
    <div class="button-container">
        <button class="select-button" onclick="getProductList();">
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


<form method="post" class="corrForm" id="productInsertForm" name="productInsertForm">	    
<div class="productModal">    
 <div class="detail">
 <div class="header">
 	제품등록
 	<span class="header-close">&times;</span>
 </div>
    	<div class="product-content-table">

    <table class="product-table">
        <colgroup>
            <col width="120px">
            <col width="330px">
            <col width="120px">
            <col width="330px">
        </colgroup>

        <tbody>
            <tr>
                <th>구분</th>
                <td>
                    <select id="prod_gubn" name="prod_gubn" class="division-select">
                        <option value="">선택</option>
                        <option value="양산">양산</option>
                        <option value="개발">개발</option>
                    </select>
                </td>
                <th>거래처</th>
                <td>
                    <div class="search-box">
                        <input type="text" id="corp_name" name="corp_name" placeholder="거래처명  검색">
                        <input id="corp_code" name="corp_code"  type="hidden" readonly="readonly">
                        <button type="button" class="search-btn" onclick="openCutumModal();">검색</button>
                    </div>
                </td>
            </tr>
            <tr>
                <th>관리번호</th>
                <td><input type="text" id="prod_cno" name="prod_cno"></td>
                <th>품명</th>
                <td><input type="text" id="prod_name" name="prod_name"></td>
            </tr>
            <tr>
                <th>품번</th>
                <td><input type="text" id="prod_no" name="prod_no"></td>
                <th>모델명</th>
                <td><input type="text" id="prod_model" name="prod_model"></td>
            </tr>
            <tr>
                <th>재질</th>
                <td><input type="text" id="prod_jai" name="prod_jai"></td>
                <th>규격</th>
                <td><input type="text" id="prod_gyu" name="prod_gyu"></td>
            </tr>
            <tr>
                <th>공정순서</th>
                <td colspan="3">
                    <div class="process-list">
                        <label><input type="checkbox" id="prod_fac1" name="prod_fac1"> 승온</label>
                        <label><input type="checkbox" id="prod_fac2" name="prod_fac2"> 침탄</label>
                        <label><input type="checkbox" id="prod_fac3" name="prod_fac3"> 확산</label>
                        <label><input type="checkbox" id="prod_fac4" name="prod_fac4"> 강온</label>
                        <label><input type="checkbox" id="prod_fac5" name="prod_fac5"> 소입</label>
                        <label><input type="checkbox" id="prod_fac6" name="prod_fac6"> 드레인</label>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>

</div>

    	
    	
	    <div class="btnSaveClose">
	    		<button class="delete" type="button" onclick="deleteProduct();"  style="display: none;">삭제</button>
	            <button class="save" type="button" onclick="save();">저장</button>
	            <button id="btnSaveAs" class="saveAs" type="button" onclick="saveAsNew();" style="display:none;">다른이름저장</button>
	            <button class="close" type="button" onclick="window.close();">닫기</button>
	    </div>
	  </div>
	</div>
</form>
	    
	    
	    
	    <!-- 거래처(검색버튼) 팝업창 -->
	<div id="cutumListModal" class="modal-overlay" style="display: none;">
		<div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">거래처 리스트</span> <span class="modal-close" onclick="closeCutumListModal()">&times;</span>
			</div>
			<div id="cutumListTabulator" style="height: 500px;"></div>
		</div>
	</div>
    
	    

	    
<script>


   
	//전역변수
    var productTable;	
    var isEditMode = false; //수정,최초저장 구분값
    
	//로드
	$(function(){
		//전체 거래처목록 조회
		getProductList();
	});

	//이벤트
	//함수
	function getProductList(){
		userTable = new Tabulator("#tab1", {
		    height:"750px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/mibogear/standardManagement/productInsert/productList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{
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
		        {title:"코드", field:"prod_code", sorter:"string", width:120,
			        hozAlign:"center", headerFilter:"input", visible:false},
				{title:"거래처명", field:"corp_name", sorter:"string", width:200,
				    hozAlign:"center", headerFilter:"input"}, 
				{title:"품명", field:"prod_name", sorter:"string", width:200,
				    hozAlign:"center", headerFilter:"input"}, 
		        {title:"품번", field:"prod_no", sorter:"string", width:200,
		        	hozAlign:"center", headerFilter:"input"},		        
		        {title:"규격", field:"prod_gyu", sorter:"string", width:200,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"재질", field:"prod_jai", sorter:"string", width:200,
		        	hozAlign:"center", headerFilter:"input"},
		        	{title:"거래처명", field:"corp_code", sorter:"string", width:200,
					    hozAlign:"center", headerFilter:"input",visible:false},  	
		        
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
				$('#productInsertForm')[0].reset();
				

				console.log(data);
				
/* 				productInsertDetail(data.prod_code);	
				 $('.delete').show();  */

				    const d = row.getData();
				    selectedRowData = d;
				    $('#productInsertForm')[0].reset();
				    
				    // 상세조회 Ajax 요청 실행
				    productInsertDetail(d.prod_code);
				    
				    $("#btnSaveAs").show();
				    $('.delete').show();  // 필요 시
			},
		});		
	}
	

	// 상세 조회
	function productInsertDetail(prod_code) {
    $.ajax({
        url: "/mibogear/standardManagement/productInsert/productInsertDetail",
        type: "post",
        dataType: "json",
        data: { "prod_code": prod_code },
        success: function (result) {
            console.log("result", result);
            const d = result.data;

            // 폼 초기화
            $('#productInsertForm')[0].reset();

            // 기본 데이터 바인딩
           for (let key in d) {
			    if (key === "prod_date") {
			        $("[name='" + key + "']").val(d[key].substring(0, 10));
			    } else if (key.startsWith("prod_fac")) {
			        const checkbox = $("#" + key);
			        if (checkbox.length) {
			            const val = d[key] || "";
			            checkbox.prop("checked", val.includes("1"));
			        }
			    } else {
			        $("[name='" + key + "']").val(d[key]);
			        
			    }
			}
           
            // 모달 열기
            $('.productModal').show().addClass('show');
        },
        error: function (xhr, status, error) {
            console.error("제품 상세 조회 오류:", error);
        }
    });
}

</script>
    
    
    <script>
		
 // 드래그 기능 추가
	const modal = document.querySelector('.productModal');
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
	const productModal = document.querySelector('.productModal');
	const closeButton = document.querySelector('.close');
	const headerCloseButton = document.querySelector('.header-close');

	insertButton.addEventListener('click', function() {
		isEditMode = false;  // 추가 모드
	    $('#productInsertForm')[0].reset(); // 폼 초기화
		
	    productModal.style.display = 'block'; // 모달 표시

		$('.delete').hide();
		$("#btnSaveAs").hide();
	});

	closeButton.addEventListener('click', function() {
		productModal.style.display = 'none'; // 모달 숨김
	});

	headerCloseButton.addEventListener('click', function() {
		productModal.style.display = 'none';
	});


	//설비검색버튼 리스트 모달
    function openCutumModal() {
        document.getElementById('cutumListModal').style.display = 'flex';

        
        let cutumListTable = new Tabulator("#cutumListTabulator", {
            height:"450px",
            layout:"fitColumns",
            selectable:true,
            ajaxURL:"/mibogear/standardManagement/cutumInsert/cutumInsertList",
            ajaxConfig:"POST",
            ajaxParams:{
            	"corp_name": "",
                "corp_plc": "",
                "corp_gubn": "",
                "corp_mast": "",
                "corp_code": "",   
            },
		    ajaxResponse:function(url, params, response){
//				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
				console.log(response);
		        return response.data; //return the response data to tabulator
		    },    
            columns:[
            	{title:"구분ID", field:"corp_gubn", sorter:"string", width:120,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"거래처명", field:"corp_name", sorter:"string", width:150,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"사업자번호", field:"corp_no", sorter:"string", width:200,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"거래처코드", field:"corp_code", width:120, hozAlign:"center",visible:false},	
            ],
            rowDblClick:function(e, row){
                let data = row.getData();
                
               
                document.getElementById('corp_name').value = data.corp_name;
                document.getElementById('corp_code').value = data.corp_code;
                
                document.getElementById('cutumListModal').style.display = 'none';
            }
        });
    }

    function closeCutumListModal() {
        document.getElementById('cutumListModal').style.display = 'none';
    }


  //제품등록 저장
   function save() {
    // 체크박스 처리: 체크 안된 것도 'N'으로 강제로 값 지정
    const checkboxFields = ["prod_fac1", "prod_fac2", "prod_fac3", "prod_fac4", "prod_fac5", "prod_fac6"];
    checkboxFields.forEach(field => {
        const checked = $("#" + field).is(":checked");
        // 존재하는 hidden input이 있으면 set, 없으면 추가
        if ($("#hidden_" + field).length === 0) {
            $("<input>").attr({
                type: "hidden",
                id: "hidden_" + field,
                name: field,
                value: checked ? "1" : "0"
            }).appendTo("#productInsertForm");
        } else {
            $("#hidden_" + field).val(checked ? "1" : "0");
        }
    });

    var formData = new FormData($("#productInsertForm")[0]);

    let confirmMsg = "";
    if (isEditMode && selectedRowData && selectedRowData.prod_code) {
        formData.append("mode", "update");
        formData.append("prod_code", selectedRowData.prod_code);
        confirmMsg = "수정하시겠습니까?";
    } else {
        formData.append("mode", "insert");
        confirmMsg = "저장하시겠습니까?";
    }

    if (!confirm(confirmMsg)) {
        return;
    }

    $.ajax({
        url: "/mibogear/standardManagement/productInsert/productInsertSave",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function (result) {
            console.log(result);
            alert("저장 되었습니다.");
            $(".productModal").hide();
            getProductList();
        },
        error: function (xhr, status, error) {
            console.error("저장 오류:", error);
        }
    });
}

   function saveAsNew() {
	    const checkboxFields = ["prod_fac1", "prod_fac2", "prod_fac3", "prod_fac4", "prod_fac5", "prod_fac6"];
	    checkboxFields.forEach(field => {
	        const checked = $("#" + field).is(":checked");
	        if ($("#hidden_" + field).length === 0) {
	            $("<input>").attr({
	                type: "hidden",
	                id: "hidden_" + field,
	                name: field,
	                value: checked ? "1" : "0"
	            }).appendTo("#productInsertForm");
	        } else {
	            $("#hidden_" + field).val(checked ? "1" : "0");
	        }
	    });

	    var formData = new FormData($("#productInsertForm")[0]);

	    formData.append("mode", "insert");
	    formData.delete("prod_code");

	    if (!confirm("현재 데이터를 바탕으로 새 제품을 등록하시겠습니까?")) {
	        return;
	    }

	    $.ajax({
	        url: "/mibogear/standardManagement/productInsert/productInsertSave",
	        type: "POST",
	        data: formData,
	        contentType: false,
	        processData: false,
	        dataType: "json",
	        success: function (result) {
	            console.log(result);
	            alert("새로운 제품으로 저장되었습니다.");
	            $(".productModal").hide();
	            getProductList();
	        },
	        error: function (xhr, status, error) {
	            console.error("다른이름으로 저장 오류:", error);
	            alert("저장 중 오류가 발생했습니다.");
	        }
	    });
	}
	
    function deleteProduct() {
	    if (!selectedRowData || !selectedRowData.prod_code) {
	        alert("삭제할 대상을 선택하세요.");
	        return;
	    }

	    if (!confirm("삭제하시겠습니까?")) {
	        return;
	    }

	    $.ajax({
	        url: "/mibogear/standardManagement/productInsert/productDelete",
	        type: "POST",
	        data: {
	        	prod_code: selectedRowData.prod_code
	        },
	        dataType: "json",
	        success: function(result) {
	            if (result.status === "success") {
	                alert("삭제되었습니다.");
	                $(".productModal").hide();
	                getProductList();
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
	    const filename = "제품등록_" + today + ".xlsx";
	    userTable.download("xlsx", filename, { sheetName: "제품등록" });
	});



	
	

    </script>

	</body>
</html>
