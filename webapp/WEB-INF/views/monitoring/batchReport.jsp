<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>배치리포트</title>
   <%@include file="../include/pluginpage.jsp" %>    
    <jsp:include page="../include/tabBar.jsp"/>

    <style>
       .container {
	display: flex;
	justify-content: space-between;
}
.tabulator {
	width: 100%;
	max-width: 100%;
	max-height: 900px;
	overflow-x: hidden !important;  
}
        
.tabulator .tabulator-cell {
	white-space: normal !important;
	word-break: break-word; 
	text-align: center;
}
        
.row_select{
	background-color:#9ABCEA !important;
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
	margin-right: 10px;
}

/* 배치 리포트 모달 */
.batch-modal {
    display: none;
    position: fixed;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 9999;
    overflow-y: auto;
}

.batch-modal-content {
    background: white;
    width: 90%;
    max-width: 1400px;
    margin: 20px auto;
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
}

.batch-modal.show {
    display: block;
}

.modal-close {
    position: absolute;
    right: 110px;
    top: 15px;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
    color: #666;
}

.modal-close:hover {
    color: #000;
}

.batch-section {
    margin-bottom: 30px;
    background: #f8f9fa;
    padding: 20px;
    border-radius: 10px;
}

.batch-section-title {
    font-size: 20px;
    font-weight: bold;
    color: #33363d;
    margin-bottom: 15px;
    padding-bottom: 10px;
    border-bottom: 2px solid #33363d;
}

/* 패턴 정보 테이블 */
.pattern-info-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    margin-top: 15px;
}

.pattern-info-table th,
.pattern-info-table td {
    border: 1px solid #e0e0e0;
    padding: 10px;
    text-align: center;
    font-size: 14px;
}

.pattern-info-table th {
    background: linear-gradient(135deg, #33363d, #4a4d57);
    color: white;
    font-weight: bold;
}

.pattern-info-table td {
    background: white;
}

/* 알람 테이블 */
.alarm-table-wrapper {
    max-height: 300px;
    overflow-y: auto;
    margin-top: 15px;
}

.alarm-table {
    width: 100%;
    border-collapse: collapse;
}

.alarm-table th,
.alarm-table td {
    border: 1px solid #e0e0e0;
    padding: 10px;
    text-align: center;
    font-size: 13px;
}

.alarm-table th {
    background: linear-gradient(135deg, #e74c3c, #c0392b);
    color: white;
    font-weight: bold;
    position: sticky;
    top: 0;
}

.alarm-table td {
    background: white;
}

.alarm-table tr.active-alarm {
    background: rgba(255, 0, 0, 0.08);
    color: #d30000;
    font-weight: bold;
}

/* 트렌드 차트 */
.trend-chart-container {
    width: 100%;
    height: 400px;
    margin-top: 15px;
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
        <button class="select-button" onclick="getPatternList();">
            <img src="/posco/image/search-icon.png" alt="select" class="button-image">
           조회
        </button>
    </div>
</div>
    <main class="main">
		<div class="container">
			<div id="tab1" class="tabulator"></div>
		</div>
	</main>

<!-- 배치 리포트 모달 -->
<div class="batch-modal" id="batchModal">
    <div class="batch-modal-content">
        <span class="modal-close" onclick="closeBatchModal()">&times;</span>
        
        <!-- 1. 패턴 정보 섹션 -->
        <div class="batch-section">
            <div class="batch-section-title">패턴 정보</div>
            <table class="pattern-info-table">
                <thead>
                    <tr>
                        <th>Seg</th>
                        <th>1</th><th>2</th><th>3</th><th>4</th><th>5</th>
                        <th>6</th><th>7</th><th>8</th><th>9</th><th>10</th>
                        <th>11</th><th>12</th><th>13</th><th>14</th><th>15</th>
                        <th>16</th><th>17</th><th>18</th><th>19</th><th>20</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="font-weight: bold;">시간(분)</td>
                        <td id="seg-time-1"></td><td id="seg-time-2"></td><td id="seg-time-3"></td><td id="seg-time-4"></td><td id="seg-time-5"></td>
                        <td id="seg-time-6"></td><td id="seg-time-7"></td><td id="seg-time-8"></td><td id="seg-time-9"></td><td id="seg-time-10"></td>
                        <td id="seg-time-11"></td><td id="seg-time-12"></td><td id="seg-time-13"></td><td id="seg-time-14"></td><td id="seg-time-15"></td>
                        <td id="seg-time-16"></td><td id="seg-time-17"></td><td id="seg-time-18"></td><td id="seg-time-19"></td><td id="seg-time-20"></td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold;">온도(℃)</td>
                        <td id="seg-temp-1"></td><td id="seg-temp-2"></td><td id="seg-temp-3"></td><td id="seg-temp-4"></td><td id="seg-temp-5"></td>
                        <td id="seg-temp-6"></td><td id="seg-temp-7"></td><td id="seg-temp-8"></td><td id="seg-temp-9"></td><td id="seg-temp-10"></td>
                        <td id="seg-temp-11"></td><td id="seg-temp-12"></td><td id="seg-temp-13"></td><td id="seg-temp-14"></td><td id="seg-temp-15"></td>
                        <td id="seg-temp-16"></td><td id="seg-temp-17"></td><td id="seg-temp-18"></td><td id="seg-temp-19"></td><td id="seg-temp-20"></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- 2. 알람 발생 내역 -->
        <div class="batch-section">
            <div class="batch-section-title">알람 발생 내역</div>
            <div class="alarm-table-wrapper">
                <table class="alarm-table">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>PLC주소</th>
                            <th>알람내용</th>
                            <th>발생시간</th>
                            <th>해제시간</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody id="modalAlarmTableBody"></tbody>
                </table>
            </div>
        </div>

        <!-- 3. 온도 트렌드 -->
        <div class="batch-section">
            <div class="batch-section-title">온도 트렌드</div>
            <div class="trend-chart-container" id="modalTrendChart"></div>
        </div>
    </div>
</div>

<script>
// ---------------------------
// 최초 로딩
// ---------------------------
$(document).ready(function () {
	var tdate = todayDate();
	var ydate = yesterDate();
	
	$("#sdate").val(ydate);
	$("#edate").val(tdate);
    getPatternList();
});


var printIconProc = function(cell, formatterParams){
   var icon = "<img src='/posco/image/search-icon.png' alt='report' class='button-image' style='cursor:pointer;'></img>";
   return icon;
};

	   
function getPatternList(){	
	userTable = new Tabulator("#tab1", {
	    height:"750px",
	    layout:"fitColumns",
	    selectable:true,
	    tooltips:true,
	    selectableRangeMode:"click",
	    reactiveData:true,
	    headerHozAlign:"center",
	    ajaxConfig:"POST",
	    ajaxLoader:false,
	    ajaxURL:"/posco/pattern/getPatternList",
	    ajaxProgressiveLoad:"scroll",
	    ajaxParams:{
	    	"sdate": $("#sdate").val(),
            "edate": $("#edate").val(),
		    },
	    placeholder:"조회된 데이터가 없습니다.",
	    paginationSize:20,
	    ajaxResponse:function(url, params, response){
			$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
	        return response;
	    },
	    columns:[
	        {title:"NO", field:"idx", sorter:"number", width:80, hozAlign:"center"},
	        {title:"운전 시작일", field:"proc_date", sorter:"string", width:250, hozAlign:"center", headerFilter:"input"},	
		    {title:"운전 패턴번호", field:"proc_ptrn_no", sorter:"number", width:120, hozAlign:"center", headerFilter:"input"},     
			{title:"운전 시작시간", field:"proc_ptrn_start", sorter:"string", width:300, hozAlign:"center", headerFilter:"input"}, 
			{title:"운전 종료시간", field:"proc_ptrn_end", sorter:"string", width:300, hozAlign:"center", headerFilter:"input"}, 	
			{   
                headerSort:false,
                formatter:printIconProc, 
                width:150, 
                title:"배치 리포트",
                cellClick:function(e, cell){
                    var rowData = cell.getRow().getData();
                    openBatchModal(rowData);
                }
            },
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
	});		
}

// 모달오픈
function openBatchModal(rowData) {
    console.log("선택된 데이터:", rowData);
    
    var patternNo = rowData.proc_ptrn_no;
    var startTime = rowData.proc_ptrn_start;
    var endTime = rowData.proc_ptrn_end;
    
    console.log("패턴번호:", patternNo);
    console.log("시작시간:", startTime);
    console.log("종료시간:", endTime);
    
    // 1. 패턴 정보 조회
    loadPatternInfo(patternNo);
    
    // 2. 알람 내역 조회
    loadAlarmHistory(startTime, endTime);
    
    // 3. 트렌드 차트 조회
    loadTrendChart(startTime, endTime);
    
 
    $("#batchModal").addClass("show");
}


function closeBatchModal() {
    $("#batchModal").removeClass("show");
}


function loadPatternInfo(patternNo) {
    $.ajax({
        url: "/posco/pattern/getPatternInfo",
        type: "POST",
        data: { patternNo: patternNo },
        success: function(result) {
            
            for(var i = 1; i <= 20; i++) {
                $("#seg-time-" + i).text(result["ptrn_seg" + i + "_time"] || "-");
                $("#seg-temp-" + i).text(result["ptrn_seg" + i + "_temp"] || "-");
            }
        },
        error: function() {
            alert("패턴 정보 조회 실패");
        }
    });
}

//알람
function loadAlarmHistory(startTime, endTime) {
    var startDate = startTime.substring(0, 10);
    var endDate = endTime.substring(0, 10);
    
    console.log("알람 조회 - 시작:", startDate, "종료:", endDate);
    
    $.ajax({
        url: "/posco/monitoring/alarmRecordListAll/list",
        type: "POST",
        data: {
            s_sdate: startDate,
            s_edate: endDate
        },
        success: function(resp) {
            console.log("알람 데이터:", resp);
            
            var arr = resp.data || [];
            var $tbody = $("#modalAlarmTableBody").empty();
            
            if(arr.length === 0) {
                $tbody.append('<tr><td colspan="6">알람 발생 내역이 없습니다.</td></tr>');
                return;
            }
            
            arr.forEach(function(r, idx) {
                var tr = $("<tr></tr>");
                tr.append("<td>" + (idx + 1) + "</td>");
                tr.append("<td>" + (r.a_addr || "") + "</td>");
                tr.append("<td style='text-align:left;'>" + (r.a_desc || "") + "</td>");
                tr.append("<td>" + (r.a_stime || "") + "</td>");
                tr.append("<td>" + (r.a_etime || "") + "</td>");
                
                if(!r.a_etime || r.a_etime === "") {
                    tr.addClass("active-alarm");
                    tr.append("<td style='color:#d30000; font-weight:bold;'>진행 중</td>");
                } else {
                    tr.append("<td>-</td>");
                }
                
                $tbody.append(tr);
            });
        },
        error: function(xhr, status, error) {
            console.error("알람 내역 조회 실패:", error);
            alert("알람 내역 조회 실패");
        }
    });
}


function loadTrendChart(startTime, endTime) {
    var startFormatted = startTime.substring(0, 16);
    var endFormatted = endTime.substring(0, 16); 
    
    console.log("트렌드 조회 - 시작:", startFormatted, "종료:", endFormatted);
    
    $.ajax({
        url: "/posco/monitoring/trend/list",
        type: "POST",
        data: {
            startDate: startFormatted, 
            endDate: endFormatted      
        },
        success: function(result) {
            console.log("트렌드 데이터:", result);
            
            if(result.length === 0) {
                $("#modalTrendChart").html("<p style='text-align:center; padding:50px;'>트렌드 데이터가 없습니다.</p>");
                return;
            }
            
            var categories = result.map(r => new Date(r.tdatetime).getTime());
            
            Highcharts.chart('modalTrendChart', {
                chart: { 
                    type: 'line',
                    zoomType: 'x'
                },
                title: { text: '온도 트렌드' },
                xAxis: {
                    type: 'datetime',
                    labels: {
                        formatter: function() {
                            return Highcharts.dateFormat('%H:%M', this.value);
                        }
                    }
                },
                yAxis: {
                    title: { text: "온도 (℃)" },
                    min: 0,
                    max: 1200
                },
                plotOptions: {
                    line: {
                        marker: { enabled: false }
                    }
                },
                tooltip: {
                    shared: true,
                    xDateFormat: '%Y-%m-%d %H:%M'
                },
                legend: {
                    layout: 'horizontal',
                    align: 'center',
                    verticalAlign: 'bottom'
                },
                series: [
                    { name: '1존온도 PV', data: result.map((r, idx) => [categories[idx], Number(r.vac1_pv)]) },
                    { name: '2존온도 PV', data: result.map((r, idx) => [categories[idx], Number(r.vac2_pv)]) },
                    { name: '3존온도 PV', data: result.map((r, idx) => [categories[idx], Number(r.vac3_pv)]) },
                    { name: '온도 SP', data: result.map((r, idx) => [categories[idx], Number(r.tem_sp)]) },
                    { name: '온도 TSP', data: result.map((r, idx) => [categories[idx], Number(r.tem_tsp)]) }
                ]
            });
        },
        error: function(xhr, status, error) {
            console.error("트렌드 데이터 조회 실패:", error);
            alert("트렌드 데이터 조회 실패");
        }
    });
}

</script>


</body>
</html>