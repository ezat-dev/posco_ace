<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>설비수리이력관리</title>
    <link rel="stylesheet" href="/posco/css/management/productInsert.css">
    <link rel="stylesheet" href="/posco/css/tabBar/tabBar.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
<%@include file="../include/pluginpage.jsp" %> 
    <style>
    
.main{
	width:98%;
}
.container {
	display: flex;
	justify-content: space-between;
}
.suriHistoryModal {
    position: fixed; /* 화면에 고정 */
    top: 50%; /* 수직 중앙 */
    left: 50%; /* 수평 중앙 */
    display : none;
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
      width: 600px;
      height: 390px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.7);
      margin: 20px auto;
      padding: 20px;
      border-radius: 5px;
      overflow-y: auto;
    }

    .insideTable {
      width: 100%;
      border-collapse: collapse;
      table-layout: fixed;
    }

    .insideTable th,
    .insideTable td {
      padding: 10px 12px;
      border: 1px solid #ccc;
      vertical-align: middle;
      font-size: 14px;
      line-height: 1.4;
    }

    .insideTable th {
      background-color: #f5f5f5;
      text-align: left;
      font-weight: 600;
      width: 15%;
      white-space: nowrap;
    }

    .insideTable td {
      text-align: left;
      width: 35%;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .basic,
    .rp-input,
    select,
    input[type="text"],
    input[type="date"],
    textarea {
      width: 100%;
      padding: 6px 8px;
      font-size: 14px;
      border: 1px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;
    }

    textarea {
      resize: vertical;
      min-height: 100px;
    }

    .findImage {
      display: flex;
      flex-direction: column;
      gap: 6px;
      align-items: flex-start;
    }

    .imgArea {
      width: 200px;
      height: 130px;
      border: 1px solid #ddd;
      background-color: #f9f9f9;
      display: flex;
      align-items: center;
      justify-content: center;
      overflow: hidden;
    }

    .imgArea img {
      width: 100%;
      height: 100%;
      object-fit: cover;
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

.findImage{

	width:100%
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
        <button class="select-button" onclick="getSuriHistoryList();">
            <img src="/posco/image/search-icon.png" alt="select" class="button-image">
           조회
        </button>
        <button class="insert-button">
            <img src="/posco/image/insert-icon.png" alt="insert" class="button-image">
         입력 
        </button>
        <button class="excel-button">
            <img src="/posco/image/excel-icon.png" alt="excel" class="button-image">
        엑셀    
        </button>
        <button class="printer-button">
            <img src="/posco/image/printer-icon.png" alt="printer" class="button-image">
       보고서출력     
        </button>
    </div>
</div>
    <main class="main">
		<div class="container">
			<div id="tab1" class="tabulator"></div>
		</div>
	</main>
	    
	    
	    
	    
<form method="post" id="suriHistoryForm" name="suriHistoryForm" enctype="multipart/form-data">
  <div class="suriHistoryModal">
    <div class="detail">
      <div class="header">설비수리이력
      	<span class="header-close">&times;</span>
      </div>
      <table class="insideTable">
        <colgroup>
          <col width="15%">
          <col width="35%">
          <col width="15%">
          <col width="35%">
        </colgroup>
        <tbody>
          <!-- 설비 / 일자 -->
          <tr>
            <th>설비</th>
            <td>
              <input id="fac_code" name="fac_code" class="basic" type="hidden" style="width:50%;" readonly="readonly"> 
              <input id="fac_name" name="fac_name" class="basic" type="text" style="width:50%;" readonly="readonly">
              <input type="button" title="검색" class="btnSearchSmall" value="설비검색" onclick="openFacListModal();">
            </td>
            <th>일자</th>
            <td><input id="ffx_date" name="ffx_date" type="date" class="basic"></td>
          </tr>

          <!-- 내용 / 수리처 -->
          <tr>
            <th>내용</th>
            <td><textarea id="ffx_note" name="ffx_note" class="basic"></textarea></td>
            <th>수리처</th>
            <td><input id="ffx_wrk" name="ffx_wrk" type="text" class="basic"></td>
          </tr>

          <!-- 수리비용 / 담당자 -->
          <tr>
            <th>수리비용</th>
            <td>
              <input id="ffx_cost" name="ffx_cost" type="text" class="basic">
            </td>
            <th>차기점검일</th>
            <td><input id="ffx_next" name="ffx_next" type="date" class="basic"></td>
          </tr>

        </tbody>
      </table>

      <div class="btnSaveClose">
        <button class="delete" type="button" onclick="deleteSuri();" style="display: none;">삭제</button>
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
	$(function(){
		var tdate = todayDate();
		var ydate = yesterDate();
		
		$("#sdate").val(ydate);
		$("#edate").val(tdate);
		getSuriHistoryList();
	});



	//이벤트
	//함수
	function getSuriHistoryList(){
		
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
		    ajaxURL:"/posco/preservation/suriHistory/getSuriHistoryList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{
		    	"sdate": $("#sdate").val(),
                "edate": $("#edate").val(),
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
			    {title:"설비명", field:"fac_name", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input"},     
				{title:"점검일", field:"ffx_date", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input"},	        
		        {title:"수리처", field:"ffx_wrk", sorter:"string", width:100,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"금액", field:"ffx_cost", sorter:"int", width:100,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"내용", field:"ffx_note", sorter:"string", width:600,
			        hozAlign:"center", headerFilter:"input"},      
			    {title:"NO", field:"ffx_no", sorter:"int", width:80,
			        	hozAlign:"center" ,visible:false},   
			    {title:"NO", field:"fac_code", sorter:"int", width:80,
				        hozAlign:"center" ,visible:false},    
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
				$('#suriHistoryForm')[0].reset();
				suriHistoryDetail(data.ffx_no);
				 $('.delete').show();
			},
		});		
	}

	function suriHistoryDetail(ffx_no){
		$.ajax({
			url:"/posco/preservation/suriHistory/suriHistoryDetail",
			type:"post",
			dataType:"json",
			data:{
				"ffx_no":ffx_no,
				"fac_code": fac_code
			},
			success:function(result){
//				console.log(result);
				var allData = result.data;
				
				for(let key in allData){
//					console.log(allData, key);	
					$("[name='"+key+"']").val(allData[key]);
				}

				$('.suriHistoryModal').show().addClass('show');
			}
		});
	}
	

    </script>
    
    
    <script>
		
 	// 드래그 기능 추가
	const modal = document.querySelector('.suriHistoryModal');
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
	const suriHistoryModal = document.querySelector('.suriHistoryModal');
	const closeButton = document.querySelector('.close');
	const headerCloseButton = document.querySelector('.header-close');

	insertButton.addEventListener('click', function() {
		isEditMode = false;  // 추가 모드
	    $('#suriHistoryForm')[0].reset(); // 폼 초기화

	  
	    suriHistoryModal.style.display = 'block'; // 모달 표시

		$('.delete').hide();
	});

	closeButton.addEventListener('click', function() {
		suriHistoryModal.style.display = 'none'; // 모달 숨김
	});

	headerCloseButton.addEventListener('click', function() {
		suriHistoryModal.style.display = 'none';
	});

	//설비수리이력 저장
    function save() {
	    var formData = new FormData($("#suriHistoryForm")[0]);

	    let confirmMsg = "";

	    if (isEditMode && selectedRowData && selectedRowData.ffx_no) {
	        formData.append("mode", "update");
	        formData.append("ffx_no", selectedRowData.ffx_no);
	        confirmMsg = "수정하시겠습니까?";
	    } else {
	        formData.append("mode", "insert");
	        confirmMsg = "저장하시겠습니까?";
	    }

	    if (!confirm(confirmMsg)) {
	        return;
	    }

	    $.ajax({
	        url: "/posco/preservation/suriHistory/suriHistorySave",
	        type: "POST",
	        data: formData,
	        contentType: false,
	        processData: false,
	        dataType: "json",
	        success: function(result) {
	            alert("저장 되었습니다.");
	            $(".suriHistoryModal").hide();
	            getSuriHistoryList();
	        },
	        error: function(xhr, status, error) {
	            console.error("저장 오류:", error);
	        }
	    });
	}


	function deleteSuri() {
	    if (!selectedRowData || !selectedRowData.ffx_no) {
	        alert("삭제할 대상을 선택하세요.");
	        return;
	    }

	    if (!confirm("삭제하시겠습니까?")) {
	        return;
	    }

	    $.ajax({
	        url: "/posco/preservation/suriHistory/suriHistoryDelete",
	        type: "POST",
	        data: {
	        	ffx_no: selectedRowData.ffx_no
	        },
	        dataType: "json",
	        success: function(result) {
	            if (result.status === "success") {
	                alert("삭제되었습니다.");
	                $(".suriHistoryModal").hide();
	                getSuriHistoryList();
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
	    const filename = "설비수리이력관리_" + today + ".xlsx";
	    userTable.download("xlsx", filename, { sheetName: "설비수리이력관리" });
	});


	//설비검색버튼 리스트 모달
    function openFacListModal() {
        document.getElementById('facListModal').style.display = 'flex';

        
        let facListTable = new Tabulator("#facListTabulator", {
            height:"450px",
            layout:"fitColumns",
            selectable:true,
            ajaxURL:"/posco/standardManagement/facInsert/getFacList",
            ajaxConfig:"POST",
            ajaxParams:{
                "fac_code": "",
                "fac_name": "",
                "fac_no":"",
                   
            },
		    ajaxResponse:function(url, params, response){
//				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
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

    
    </script>

	</body>
</html>