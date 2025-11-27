<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>트렌드</title>
   <%@include file="../include/pluginpage.jsp" %>    
    <jsp:include page="../include/tabBar.jsp"/>

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
          .button-container {
    		display: flex;
		    gap: 10px;
		    margin-left: auto;
		    margin-right: 10px;
		    margin-top: 40px;
		    width: 780px;
		}
		.box1 {
		    display: flex;
		    justify-content: right;
		    align-items: center;
		    width: 1100px;
		    margin-right: 20px;
		    margin-top:4px;
		}
        .dayselect {
            width: 20%;
            text-align: center;
            font-size: 15px;
        }
        .daySet {
        	width: 20%;
      		text-align: center;
            height: 16px;
            padding: 11px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 15px;
        }
       .daylabel {
		    margin-right: 10px;
		    margin-bottom: 13px;
		    font-size: 20px;
		    margin-left: 20px;
		    margin-top: 3px;
		}
        button-container.button{
        height: 16px;
        }
        
        
        
        /*모달css  */
		   .modal {
		    display: none;
		    position: fixed;
		    left: 0;
		    top: 0;
		    width: 100%;
		    height: 100%;
		    background-color: rgba(0, 0, 0, 0.5);
		    transition: opacity 0.3s ease-in-out;
		    overflow: auto;
		    z-index:20010;
		}
		.row_select {
		    background-color: #d0d0d0 !important;
		}
		
		.modal-content {
		    background: white;
		    width: 60%; /* 가로 길이를 50%로 설정 */
		    max-width: 600px; /* 최대 너비를 설정하여 너무 커지지 않도록 */
		    max-height: 800px; /* 화면 높이에 맞게 제한 */
		    overflow-y: auto;
		    margin: 2% auto; /* 수평 중앙 정렬 */
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
		    background-color: white;
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
		    width: 60%;
		    padding: 8px;
		    margin-bottom: 10px;
		    border: 1px solid #ccc;
		    border-radius: 5px;
		}

		.modal-content select {
		    width: 104%;
		    height: 38px;
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
		 .mid{
        margin-right: 9px;
	    font-size: 20px;
	    font-weight: bold;
	
	    height: 42px;
	    margin-left: 9px;
        }


    </style>
    </head>
<body>

<div id="modalContainer" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <!-- 추가, 수정 -->
    <h2>트렌드 데이터 등록</h2>
    <hr />
    <div id="signDataTable"></div>
    <hr />
    <form id="corrForm" autocomplete="off">
      <label>작업자</label>
      <input type="text" name="tc_cnt" value="0" style="display:none;">
      <input type="text" name="tc_user_code" style="display:none;">
      <input type="text" name="tc_user_name" style="" readonly="readonly">

      <label>등록시간</label>
      <input type="text"  name="tc_regtime" readonly="readonly">

      <label>등록내용</label>
      <input type="text" name="tc_name">

      <label>비고</label>
	  <input type="text" name="tc_desc">
		<hr />
		
      <button type="submit" id="saveCorrStatus">저장</button>
      <button type="button" id="closeModal">닫기</button>
    </form>
  </div>
</div>


     		<div class="button-container">
        		<label class="daylabel">검색 날짜 :</label>
			<div class="date_input" style="text-align: center; ">
			    <input type="text" autocomplete="off" class="datetimeSet" id="startDate"
			        style="font-size: 16px; margin: 5px; border-radius: 4px; border: 1px solid #ccc; text-align: center;    height: 30px;">

				<span class="mid" style="font-size: 20px; font-weight: bold; margin-bottom:10px;"> ~ </span>
				
			   <input type="text" autocomplete="off" class="datetimeSet" id="endDate"
			        style="font-size: 16px; margin: 5px; border-radius: 4px; border: 1px solid #ccc; text-align: center;    height: 30px;">
			</div>
				<button class="select-button">
                    <img src="/chunil/css/tabBar/search-icon.png" alt="select" class="button-image">조회
                </button>
                <button class="insert-button">
                    <img src="/chunil/css/tabBar/add-outline.png" alt="insert" class="button-image">추가
                </button>
                
			</div>
			<div id="container" style="width: 100%; height: 700px; margin-top:100px;"></div>

<script>
let now_page_code = "a02";

let categories;

let q_pv_1,q_pv_2,q_pv_3,q_pv_4,q_pv_5;
let t_pv_1,t_pv_2,t_pv_3,t_pv_4,t_pv_5;
let cp_pv_1,cp_pv_2;
let tc_val_pv,tc_val_label;
let tc_val_series;
var trendInterval;

$(document).ready(function () {
    $(".datetimeSet").datepicker({
        language: 'ko',
        timepicker: true,
        dateFormat: 'yyyy-mm-dd',
        timeFormat: 'hh:ii',
        autoClose: true
    });

    // 시간 셋팅    
    $("#startDate").val(trendStime());
    $("#endDate").val(trendEtime());

    fetchData();
    trendInterval = setInterval("trendIntervalFunc()",1000*60);
});

// 조회 버튼
$(".select-button").on("click", function(){
	fetchData();
});

// 등록 버튼
$(".insert-button").on("click", function(){
    var userCode = "${loginUser.user_code}";
    var userName = "${loginUser.user_name}";
    
    $("input[name='tc_user_code']").val(userCode);
    $("input[name='tc_user_name']").val(userName);
    $("input[name='tc_regtime']").val(trendEtime());
	
	$('#modalContainer').show().addClass('show');
	getSignDataList();
	signData();
});

// 모달 닫기
$('.close, #closeModal').click(function() {
	$('#corrForm')[0].reset();
    $('#modalContainer').removeClass('show').hide();
});

// 저장
$('#saveCorrStatus').click(function(event) {
    event.preventDefault();
    var formData = new FormData($('#corrForm')[0]);

    $.ajax({
      url: "/chunil/monitoring/trend/sign/save",
      type: "POST",
      data: formData,
      processData: false,
      contentType: false,
      success: function(result) {
		alert("저장되었습니다!");
		signData();               
		selectedRowData = null;
      },
      error: function() {
        alert('저장 중 오류가 발생했습니다.');
      }
    });
});

function trendIntervalFunc(){
    $("#startDate").val(trendStime());
    $("#endDate").val(trendEtime());
    fetchData();
}

// 온도변경, 사인오프 등록데이터 조회
function signData(){
	$.ajax({
		url:"/chunil/monitoring/trend/sign/list",
		type:"post",
		dataType:"json",
		data:{},
		success:function(result){			
			signDataTable.setData(result.data);
		}
	})
}

var signDataTable;
function getSignDataList(){
	signDataTable = new Tabulator('#signDataTable', {
	    height: '200px',
	    layout: 'fitDataFill',
	    headerSort: false,
	    reactiveData: true,
	    columnHeaderVertAlign: "middle",
	    headerHozAlign: 'center',
	    renderHorizontal:"virtual",
	    ajaxResponse:function(url, params, response){
			$("#dataTable .tabulator-col.tabulator-sortable").css("height","55px");
	        return response; 
	    },
	    placeholder: "조회된 데이터가 없습니다.",
	    columns: [
	      { title: "tc_cnt", field: "tc_cnt",  width: 120, hozAlign: "center", visible:false},
	      { title: "작업자", field: "tc_user_name", width: 80, hozAlign: "center" },
	      { title: "작업내용", field: "tc_name", width: 140, hozAlign: "center" },		      
	      { title: "작업시간", field: "tc_regtime", width: 140, hozAlign: "center" },
	      { title: "비고",  field: "tc_bigo",    width: 180, hozAlign: "center" },
	    ],
	    rowClick: function(e, row) {
	      $('#signDataTable .tabulator-row').removeClass('row_select');
	      row.getElement().classList.add('row_select');
	      selectedRowData = row.getData();
	    },
	    rowDblClick: function(e, row) {
	  	  var d = row.getData();
	  	}
	});
}

var signListObj = new Object();

// 조회 버튼 클릭 이벤트 정의
function fetchData() {
    const startDate = $('#startDate').val();
    const endDate = $('#endDate').val();

    $.ajax({
        type: "POST",
        url: "/chunil/monitoring/trend/list",
        data: { startDate, endDate },
        success: function (result) {
            if(result.length > 0 ){
				signListObj = new Object();
                categories = result.map(r => r.regtime);
                
                result.map(r =>
                	signListObj[r.regtime] = (r.tc_val_name != "") ? r.tc_val_name : (r.lot_name != "") ? r.lot_name : ""
                );

                q_pv_1 = result.map(r => Number(r.q_pv_1));
                q_pv_2 = result.map(r => Number(r.q_pv_2));
				q_pv_3 = result.map(r => Number(r.q_pv_3));
                q_pv_4 = result.map(r => Number(r.q_pv_4));
                q_pv_5 = result.map(r => Number(r.q_pv_5));

                t_pv_1 = result.map(r => Number(r.t_pv_1));
                t_pv_2 = result.map(r => Number(r.t_pv_2));
                t_pv_3 = result.map(r => Number(r.t_pv_3));
                t_pv_4 = result.map(r => Number(r.t_pv_4));
                t_pv_5 = result.map(r => Number(r.t_pv_5));    

                cp_pv_1 = result.map(r => Number(r.cp_pv_1));              
                cp_pv_2 = result.map(r => Number(r.cp_pv_2));

                tc_val_pv = result.map(r => (r.tc_val != 0 && r.tc_val != null) ? r.tc_val : (r.lot_val != 0 && r.lot_val != null) ? r.lot_val : null);

				if(typeof chart == "undefined"){
					getTrend();
				}else{
			        chart.update({
			        	xAxis: { categories: categories },
			        	series: [
				            { name: '소입로1존', data: q_pv_1, color:"#FF0000", yAxis:0, marker:{radius:1}},
				            { name: '소입로2존', data: q_pv_2, color:"#0000FF", yAxis:0, marker:{radius:1}},
				            { name: '소입로3존', data: q_pv_3, color:"#FF00DD", yAxis:0, marker:{radius:1}},
				            { name: '소입로4존', data: q_pv_4, color:"#003399", yAxis:0, marker:{radius:1}},
				            { name: '소입로5존', data: q_pv_5, color:"#980000", yAxis:0, marker:{radius:1}},
				            { name: '소려로1존', data: t_pv_1, color:"#5F00FF", yAxis:0, marker:{radius:1}},
				            { name: '소려로2존', data: t_pv_2, color:"#1DDB16", yAxis:0, marker:{radius:1}},
				            { name: '소려로3존', data: t_pv_3, color:"#99004C", yAxis:0, marker:{radius:1}},
				            { name: '소려로4존', data: t_pv_4, color:"#FF5E00", yAxis:0, marker:{radius:1}},
				            { name: '소려로5존', data: t_pv_5, color:"#0100FF", yAxis:0, marker:{radius:1}},
				            { name: 'CP-A', data: cp_pv_1, color:"#000000", yAxis:0, marker:{radius:1}},
				            { name: 'CP-B', data: cp_pv_2, color:"#5D5D5D", yAxis:0, marker:{radius:1}},
			        	]
			        })
				}
            }
        },
        error: function (xhr, status, error) {
            console.error("❌ 에러:", error);
            alert("데이터 조회 중 오류가 발생했습니다.");
        }
    });
}

let chart;
function getTrend(){
	chart = Highcharts.chart('container', {
        chart: { type: 'line'},
        title: { text: '온도 트렌드' },
        xAxis: {
        	type: 'datetime',
            categories: categories,
            title: { text: '시간' },
            labels: {
            	formatter:function(){
            		return dataLabelFormat(this.value);
            	}
            },
            tickInterval:60
        },
        yAxis:[
            {
                title: { text : "온도", rotation : 360 },
                labels:{ align:"left", x:10 },
                min : 0, max : 2000
            },
            {
            	opposite:true,
                title: { text : "CP", rotation : 360 },
                labels:{ align:"left", x:10 },
                min : 0, max : 2
		    }
        ],        
        tooltip: { shared: true, crosshairs: true },
        plotOptions:{
        	series:{
        		dataLabels:{
        			enabled:true,
        			formatter:function(){
        				var rtn = "";
        				if(this.y == 1000 || this.y == 1200){
        					rtn = signListObj[this.x];
        				}
        				return rtn;
        			}        			
        		}
        	}
        },
        series: [
            { name: '소입로1존', data: q_pv_1, color:"#FF0000", yAxis:0, marker:{radius:1}},
            { name: '소입로2존', data: q_pv_2, color:"#0000FF", yAxis:0, marker:{radius:1}},
            { name: '소입로3존', data: q_pv_3, color:"#FF00DD", yAxis:0, marker:{radius:1}},
            { name: '소입로4존', data: q_pv_4, color:"#003399", yAxis:0, marker:{radius:1}},
            { name: '소입로5존', data: q_pv_5, color:"#980000", yAxis:0, marker:{radius:1}},
            { name: '소려로1존', data: t_pv_1, color:"#5F00FF", yAxis:0, marker:{radius:1}},
            { name: '소려로2존', data: t_pv_2, color:"#1DDB16", yAxis:0, marker:{radius:1}},
            { name: '소려로3존', data: t_pv_3, color:"#99004C", yAxis:0, marker:{radius:1}},
            { name: '소려로4존', data: t_pv_4, color:"#FF5E00", yAxis:0, marker:{radius:1}},
            { name: '소려로5존', data: t_pv_5, color:"#0100FF", yAxis:0, marker:{radius:1}},
            { name: 'CP-A', data: cp_pv_1, color:"#000000", yAxis:0, marker:{radius:1}},
            { name: 'CP-B', data: cp_pv_2, color:"#5D5D5D", yAxis:0, marker:{radius:1}},
        ]
    });
}

function dataLabelFormat(val){
	var d = new Date(val);
	var mm = paddingZero(d.getMonth()+1);
	var dd = paddingZero(d.getDate());
	var ho = paddingZero(d.getHours());
	var mi = paddingZero(d.getMinutes());
	return mm+"-"+dd+"</br>"+ho+":"+mi;
}

</script>

</body>
</html>