<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일상점검일지</title>
	<%@include file="../include/pluginpage.jsp" %>    
    <jsp:include page="../include/tabBar.jsp"/>
</head>
    <style>
        .container {
            display: flex;
            justify-content: space-between;
            padding: 20px;
            margin-left: 1008px;
            margin-top: 200px;
        }
        .view {
            display: flex;
            justify-content: center;
            margin-top: 1%;
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
        .modal {
            display: none;
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            transition: opacity 0.3s ease-in-out;
        }
	    .modal-content {
	        background: white;
	        width: 24%;
	        max-width: 500px;
	        height: 80vh; 
	        overflow-y: auto; 
	        margin: 6% auto 0;
	        padding: 20px;
	        border-radius: 10px;
	        position: relative;
	        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
	        transform: scale(0.8);
	        transition: transform 0.3s ease-in-out, opacity 0.3s ease-in-out;
	        opacity: 0;
	    }
        .modal.show {
            display: block;
            opacity: 1;
        }
        .modal.show .modal-content {
            transform: scale(1);
            opacity: 1;
        }
        .close {
            background-color:white;
            position: absolute;
            right: 15px;
            top: 10px;
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
        }
        .closePumbun {
            background-color:white;
            position: absolute;
            right: 15px;
            top: 10px;
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
        }
        .modal-content form {
            display: flex;
            flex-direction: column;
        }
        .modal-content label {
            font-weight: bold;
            margin: 10px 0 5px;
        }
        .modal-content input, .modal-content textarea {
            width: 97%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .modal-content button {
            background-color: #d3d3d3;
            color: black;
            padding: 10px;
            border: none;
            border-radius: 5px;
            margin-top: 10px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .modal-content button:hover {
            background-color: #a9a9a9;
        }
        
        .button-container {
    		display: flex;
		    gap: 10px;
		    margin-left: auto;
		    margin-right: 10px;
		    margin-top: 40px;
		}
		.box1 {
		    display: flex;
		    justify-content: right;
		    align-items: center;
		    width: 800px;
		    margin-right: 20px;
		    margin-top:4px;
		}
        .dayselect {
            width: 20%;
            text-align: center;
            font-size: 15px;
        }
        .monthSet {
        	width: 20%;
      		text-align: center;
            height: 16px;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 15px;
        }
        .daylabel {
            margin-right: 10px;
            margin-bottom: 13px;
            font-size: 18px;
            margin-left: 20px;
        }
        button-container.button{
        height: 16px;
        }
         .mid{
        margin-right: 9px;
	    font-size: 20px;
	    font-weight: bold;
	
	    height: 42px;
	    margin-left: 9px;
        }
        .row_select {
	    background-color: #ffeeba !important;
	    }
	    .excel-download-button,
		.excel-upload-button {
  		  height: 40px;
  		  background-color: white; 
   		 border: 1px solid black; 
   		 border-radius: 4px;
   		 padding: 4px 10px; 
   		 display: flex;
  		  align-items: center;
  		  gap: 5px;
  		  cursor: pointer;
}

.button-image {
    width: 16px; 
    height: 16px;
}

/*품번모달*/
        .pumbunModal {
            display: none;
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            transition: opacity 0.3s ease-in-out;
        }
	    .pumbun-modal-content {
	        background: white;
	        width: 60%;
	        max-width: 1200px;
	        height: 80vh; 
	        overflow-y: auto; 
	        margin: 6% auto 0;
	        padding: 20px;
	        border-radius: 10px;
	        position: relative;
	        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
	        transform: scale(0.8);
	        transition: transform 0.3s ease-in-out, opacity 0.3s ease-in-out;
	        opacity: 0;
	    }
        .pumbunModal.show {
            display: block;
            opacity: 1;
        }
        .pumbunModal.show .pumbun-modal-content {
            transform: scale(1);
            opacity: 1;
        }


        .pumbun-modal-content button {
            background-color: #d3d3d3;
            color: black;
            padding: 10px;
            border: none;
            border-radius: 5px;
            margin-top: 10px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .pumbun-modal-content button:hover {
            background-color: #a9a9a9;
        }
        .pumbun-modal-content form {
            display: flex;
            flex-direction: column;
        }
        .pumbun-modal-content label {
            font-weight: bold;
            margin: 10px 0 5px;
        }
        .pumbun-modal-content input, .pumbun-modal-content textarea {
            width: 97%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }


    </style>

<body>
    <main class="main">
        <div class="tab">
        

            <div class="button-container">
            
               <div class="box1">
	
	            <label class="daylabel">조회일자 :</label>
	            <input type="text" id="s_sdate" class="dayselect monthSet"/>
			</div>
                <button class="select-button">
                    <img src="/chunil/css/tabBar/search-icon.png" alt="select" class="button-image">조회
                </button>
                <button class="insert-button">
                    <img src="/chunil/css/tabBar/add-outline.png" alt="insert" class="button-image">추가
                </button>
                <button class="delete-button">
				    <img src="/chunil/css/tabBar/xDel3.png" alt="delete" class="button-image"> 삭제
				</button>
                
                
                <button class="excel-download-button">
                    <img src="/chunil/css/tabBar/excel-icon.png" alt="excel" class="button-image">엑셀다운로드
                </button>
                
                
            </div>
        </div>

        <div class="view">
            <div id="dataTable"></div>
        </div>
    </main>
    
<script>
let now_page_code = "c04";

var dataTable;
var selectedRowData = null;

$(function() {
	var tdate = todayDate();
	var tdate2 = tdate.substr(0,7);
	
	$("#s_sdate").val(tdate2);
	getDailyCheck();
	getDailyCheckData();

});

//이벤트
  $('.select-button').click(function() {
	  getDailyCheckData();
	  getDailyCheck();
  });

//엑셀 다운로드
 $('.excel-download-button').click(function() {
	    dataTable.download("xlsx", "스페어부품 관리.xlsx", {sheetName:"스페어부품 관리",
	    	 visibleColumnsOnly: false //숨겨진 데이터도 출력
	    	 });
	});

 $(".excel-upload-button").on("click", function () {
     $("#fileInput").click(); 
 });


//함수
function getDailyCheckData(){
	$.ajax({
		url:"/chunil/condition/dailyCheck/list",
		type:"post",
		dataType:"json",
		data:{
			"d_sdate":$("#s_sdate").val()
		},
		success:function(result){
			dataTable.setData(result.data);
		}
	})
}




function getDailyCheck(){
	  dataTable = new Tabulator('#dataTable', {
		    height: '750px',
		    layout: 'fitDataFill',
		    headerSort: false,
		    reactiveData: true,
		    columnHeaderVertAlign: "middle",
		    rowVertAlign: "middle",
		    headerHozAlign: 'center',
//		    ajaxConfig: { method: 'POST' },
//		    ajaxURL: "/chunil/productionManagement/alarmRecord/list",
//		    ajaxProgressiveLoad:"scroll",
//		    ajaxParams: {
//		    	"a_sdate":$("#s_sdate").val(),
//		    	"a_edate":$("#s_edate").val()
//		    },		    
		    ajaxResponse:function(url, params, response){
				$("#dataTable .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    placeholder: "조회된 데이터가 없습니다.",
		    columns: [
		      { title: "년-월", field: "d_ym", width: 80, hozAlign: "center", headerSort:false, frozen:true},
		      { title: "점검항목", field: "d_title", width: 250, hozAlign: "left", headerSort:false, frozen:true },
		      { title: "점검내용", field: "d_desc", width: 450, hozAlign: "left", headerSort:false, frozen:true },
		      { title: "1일", field: "d01",  width: 60, hozAlign: "center", headerSort:false, 
		    	  editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}
		      },
		      { title: "2일", field: "d02",width: 60, hozAlign: "center", headerSort:false,
		    	  editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}
		      },
		      { title: "3일", field: "d03",width: 60, hozAlign: "center", headerSort:false,
		    	  editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}
		      },
		      { title: "4일", field: "d04",width: 60, hozAlign: "center", headerSort:false,
		    	  editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}
		      },
		      { title: "5일", field: "d05",width: 60, hozAlign: "center", headerSort:false,
		    	  editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}
		      },
		      { title: "6일", field: "d06",width: 60, hozAlign: "center", headerSort:false,
		    	  editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}
		      },
		      { title: "7일", field: "d07",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "8일", field: "d08",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "9일", field: "d09",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "10일", field: "d10",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "11일", field: "d11",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "12일", field: "d12",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "13일", field: "d13",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "14일", field: "d14",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "15일", field: "d15",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "16일", field: "d16",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "17일", field: "d17",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "18일", field: "d18",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "19일", field: "d19",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "20일", field: "d20",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "21일", field: "d21",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "22일", field: "d22",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "23일", field: "d23",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "24일", field: "d24",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "25일", field: "d25",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "26일", field: "d26",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "27일", field: "d27",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "28일", field: "d28",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "29일", field: "d29",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "30일", field: "d30",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "31일", field: "d31",width: 60, hozAlign: "center", headerSort:false, editor:"select", editorParams:{values:{"OK":"OK", "NG":"NG"}}},
		      { title: "비고", field: "d_bigo",width: 200, hozAlign: "center", headerSort:false },
			    {field:"cnt",visible:false},
		    ],
		    rowClick: function(e, row) {
		      $('#dataTable .tabulator-row').removeClass('row_select');
		      row.getElement().classList.add('row_select');
		      selectedRowData = row.getData();
		    },
			cellEdited: function(cell) {
			    var field = cell.getField(); 
			    var value = cell.getValue(); 
			    var rowData = cell.getRow().getData(); 
			    var cnt = rowData.cnt; 

			    $.ajax({
			        url: "/chunil/condition/dailycheck/update",
			        type: "POST",
			        dataType:"json",			        
			        data: {
			        	"d_field":field,
			        	"d_value":value,
			        	"cnt":cnt
			        },
			        success: function(result) {
			        	
			        }
			    });
			},
		  });
}

</script>

</body>
</html>