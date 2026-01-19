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
    position: relative;
}

.batch-modal.show {
    display: block;
}

.modal-close {
    position: absolute;
    right: 30px;
    top: 20px;
    font-size: 32px;
    font-weight: bold;
    cursor: pointer;
    color: #666;
    z-index: 10;
}

.modal-close:hover {
    color: #000;
}

/* 모달 헤더 */
.batch-modal-header {
    text-align: center;
    margin-bottom: 30px;
    padding-bottom: 20px;
    border-bottom: 3px solid #33363d;
}

.batch-modal-title {
    font-size: 28px;
    font-weight: bold;
    color: #33363d;
    margin-bottom: 10px;
}

.batch-modal-subtitle {
    font-size: 16px;
    color: #666;
}

.batch-modal-subtitle span {
    margin: 0 15px;
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
    z-index: 1;
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
    height: 450px;
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
        
        <!-- 모달 헤더 -->
        <div class="batch-modal-header">
            <div class="batch-modal-title" id="modalPatternTitle"></div>
            <div class="batch-modal-subtitle">
                <span><strong>시작:</strong> <span id="modalStartTime"></span></span>
                <span><strong>종료:</strong> <span id="modalEndTime"></span></span>
            </div>
        </div>

        <!-- 1. 알람 발생 내역 -->
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

        <!-- 2. 온도 트렌드 -->
        <div class="batch-section">
            <div class="batch-section-title">온도 트렌드</div>
            <div class="trend-chart-container" id="modalTrendChart"></div>
        </div>
    </div>
</div>

<script>
// ---------------------------
// 전역 변수
// ---------------------------
let modalChart = null;  // ✅ 모달 차트 전역 변수 추가

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

/* 날짜 유틸 */
function pad(n){ return n < 10 ? "0"+n : n; }

function getExportFilename(extension) {
    const now = new Date();
    const year = now.getFullYear();
    const month = pad(now.getMonth() + 1);
    const day = pad(now.getDate());
    const hour = pad(now.getHours());
    const minute = pad(now.getMinutes());
    const second = pad(now.getSeconds());
    
    return year + month + day + hour + minute + second + "_배치리포트." + extension;
}

/* CSV 서버 저장 */
function downloadCSVToServer() {
    if (!modalChart) {
        alert('차트 데이터가 없습니다.');
        return;
    }
    
    const csv = modalChart.getCSV();
    
    if (!csv || csv.trim() === '') {
        alert('CSV 데이터가 비어있습니다.');
        return;
    }
    
    const filename = getExportFilename('csv');
    
    $.ajax({
        url: '/posco/monitoring/trend/saveCSV',
        type: 'POST',
        data: {
            csvData: csv,
            filename: filename
        },
        success: function(response) {
            if (response.status === 'OK') {
                alert('CSV 파일이 저장되었습니다.\n경로: ' + response.path);
            } else {
                alert('CSV 저장 실패: ' + (response.error || '알 수 없는 오류'));
            }
        },
        error: function(xhr, status, error) {
            alert('CSV 저장 중 오류가 발생했습니다.\n' + error);
        }
    });
}

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
            {title:"운전 시작일", field:"proc_date", sorter:"string", width:180, hozAlign:"center", headerFilter:"input"},	
            {title:"운전 패턴번호", field:"proc_ptrn_no", sorter:"number", width:120, hozAlign:"center", headerFilter:"input"},
            {title:"패턴 이름", field:"pattern_name", sorter:"string", width:200, hozAlign:"center", headerFilter:"input"},
            {title:"운전 시작시간", field:"proc_ptrn_start", sorter:"string", width:250, hozAlign:"center", headerFilter:"input"}, 
            {title:"운전 종료시간", field:"proc_ptrn_end", sorter:"string", width:250, hozAlign:"center", headerFilter:"input"}, 	
            {   
                headerSort:false,
                formatter:printIconProc, 
                width:120, 
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

// 모달 오픈
function openBatchModal(rowData) {
    console.log("선택된 데이터:", rowData);
    
    var patternNo = rowData.proc_ptrn_no;
    var patternName = rowData.pattern_name || ('패턴 ' + patternNo);
    var startTime = rowData.proc_ptrn_start;
    var endTime = rowData.proc_ptrn_end;
    
    console.log("패턴번호:", patternNo);
    console.log("패턴이름:", patternName);
    console.log("시작시간:", startTime);
    console.log("종료시간:", endTime);
    
    // 헤더 정보 설정
    $("#modalPatternTitle").text(patternName + " (패턴 " + patternNo + ")");
    $("#modalStartTime").text(startTime);
    $("#modalEndTime").text(endTime);
    
    // 알람 내역 조회
    loadAlarmHistory(startTime, endTime);
    
    // 트렌드 차트 조회
    loadTrendChart(startTime, endTime);
    
    $("#batchModal").addClass("show");
}

function closeBatchModal() {
    $("#batchModal").removeClass("show");
    
    // ✅ 차트 메모리 해제
    if(modalChart) {
        modalChart.destroy();
        modalChart = null;
    }
}

function loadAlarmHistory(startTime, endTime) {
    console.log("알람 조회 - 시작:", startTime, "종료:", endTime);
    
    $.ajax({
        url: "/posco/monitoring/batchReport/alarms",
        type: "POST",
        data: {
            startTime: startTime,
            endTime: endTime
        },
        success: function(resp) {
            console.log("알람 응답:", resp);
            
            if(!resp.success) {
                console.error("알람 조회 실패:", resp.error);
                $("#modalAlarmTableBody").html('<tr><td colspan="6" style="color:red;">알람 조회 중 오류가 발생했습니다.</td></tr>');
                return;
            }
            
            var arr = resp.data || [];
            var $tbody = $("#modalAlarmTableBody").empty();
            
            if(arr.length === 0) {
                $tbody.append('<tr><td colspan="6">해당 기간 동안 알람 발생 내역이 없습니다.</td></tr>');
                return;
            }
            
            console.log("표시할 알람 개수:", arr.length);
            
            arr.forEach(function(r, idx) {
                var tr = $("<tr></tr>");
                tr.append("<td>" + (idx + 1) + "</td>");
                tr.append("<td>" + (r.a_addr || "") + "</td>");
                tr.append("<td style='text-align:left; padding-left:10px;'>" + (r.a_desc || "") + "</td>");
                tr.append("<td>" + (r.a_stime || "") + "</td>");
                
                // 해제시간 처리
                if(!r.a_etime || r.a_etime === "") {
                    tr.addClass("active-alarm");
                    tr.append("<td style='color:#d30000; font-weight:bold;'>-</td>");
                    tr.append("<td style='color:#d30000; font-weight:bold;'>진행 중</td>");
                } else {
                    tr.append("<td>" + r.a_etime + "</td>");
                    tr.append("<td style='color:#28a745;'>해제됨</td>");
                }
                
                $tbody.append(tr);
            });
        },
        error: function(xhr, status, error) {
            console.error("알람 내역 조회 실패:", error);
            console.error("상태:", status);
            console.error("응답:", xhr.responseText);
            
            $("#modalAlarmTableBody").html(
                '<tr><td colspan="6" style="color:red;">알람 조회 중 오류가 발생했습니다.<br>' + 
                error + '</td></tr>'
            );
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
            
            // 데이터 범위 계산
            var dataMin = Math.min(...categories);
            var dataMax = Math.max(...categories);
            var dataRange = dataMax - dataMin;
            
            // 최적 tick interval 계산
            var tickInterval, labelFormat;
            var rangeHours = dataRange / (1000 * 60 * 60);
            
            if (rangeHours <= 1) {
                tickInterval = 5 * 60 * 1000;
                labelFormat = '%H:%M';
            } else if (rangeHours <= 3) {
                tickInterval = 10 * 60 * 1000;
                labelFormat = '%H:%M';
            } else if (rangeHours <= 6) {
                tickInterval = 30 * 60 * 1000;
                labelFormat = '%H:%M';
            } else {
                tickInterval = 60 * 60 * 1000;
                labelFormat = '%m-%d %H:%M';
            }
            
            // ✅ modalChart 전역 변수에 할당
            modalChart = Highcharts.chart('modalTrendChart', {
                chart: { 
                    type: 'line',
                    zoomType: 'x'
                },
                title: { text: '온도 트렌드' },
                xAxis: {
                    type: 'datetime',
                    tickInterval: tickInterval,
                    labels: {
                        formatter: function() {
                            return Highcharts.dateFormat(labelFormat, this.value);
                        }
                    }
                },
                yAxis: {
                    title: { text: "온도 (℃)" },
                    min: 0
                },
                plotOptions: {
                    line: {
                        marker: { enabled: false }
                    }
                },
                tooltip: {
                    shared: true,
                    xDateFormat: '%Y-%m-%d %H:%M:%S'
                },
                legend: {
                    layout: 'horizontal',
                    align: 'center',
                    verticalAlign: 'bottom'
                },
                exporting: {
                    enabled: true,
                    buttons: {
                        contextButton: {
                            menuItems: [
                                {
                                    text: 'PNG 다운로드',
                                    onclick: function() {
                                        this.exportChart({
                                            type: 'image/png',
                                            filename: getExportFilename('png')
                                        });
                                    }
                                },
                                {
                                    text: 'CSV 다운로드',
                                    onclick: function() {
                                        downloadCSVToServer();
                                    }
                                }
                            ]
                        }
                    },
                    csv: {
                        dateFormat: '%Y-%m-%d %H:%M:%S'
                    }
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