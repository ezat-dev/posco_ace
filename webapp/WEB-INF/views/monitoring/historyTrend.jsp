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
        
        .button-container {
            display: flex;
            align-items: center;
            gap: 15px;
            width: 1600px;
            padding: 15px 20px;
            background: #f4f4f4;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        }
        
        .select-button {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 8px 16px;
            border-radius: 6px;
            border: 1px solid #aaa;
            background: #e0e0e0;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.2s;
        }
        
        .select-button:hover {
            background: #cfcfcf;
        }
        
        .trend-option label {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 15px;
            cursor: pointer;
        }
        
        .daylabel {
            margin-right: 10px;
            font-size: 16px;
            font-weight: bold;
        }
        
        .datetimeSet {
            font-size: 16px;
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ccc;
            text-align: center;
        }
        
        .mid {
            margin: 0 5px;
            font-size: 18px;
            font-weight: bold;
        }
        
        /* 모드 버튼 */
        .mode-buttons {
            display: flex;
            gap: 8px;
            margin-left: 20px;
        }
        
        .mode-btn {
            padding: 8px 16px;
            border: 1px solid #007bff;
            background: white;
            color: #007bff;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            transition: all 0.2s;
        }
        
        .mode-btn:hover {
            background: #007bff;
            color: white;
        }
        
        .mode-btn.active {
            background: #007bff;
            color: white;
        }
        
        .mode-btn.realtime-btn.active {
            background: #28a745;
            border-color: #28a745;
            color: white;
        }
        
        .mode-btn.realtime-btn:hover {
            background: #28a745;
            border-color: #28a745;
            color: white;
        }
    </style>
</head>
<body>

<div class="button-container">
    <label class="daylabel">검색 날짜 :</label>
    <div class="date_input" id="dateInputArea" style="display: flex; align-items: center;">
        <input type="text" autocomplete="off" class="datetimeSet" id="startDate">
        <span class="mid"> ~ </span>
        <input type="text" autocomplete="off" class="datetimeSet" id="endDate">
    </div>
    <button class="select-button" id="btnSearch">
        <img src="/posco/css/tabBar/search-icon.png" alt="select" class="button-image">조회
    </button>
    
    <div class="mode-buttons">
        <button class="mode-btn active" id="btnHistorical">히스토리컬</button>
        <button class="mode-btn realtime-btn" id="btnRealtime">🔴 실시간</button>
    </div>
    
    <div class="trend-option" style="margin-left: auto;">
        <label>
            <input type="checkbox" id="toggleMarker">
            포인트 표시
        </label>
    </div>
</div>

<div id="container" style="width: 100%; height: 600px; margin-top: 20px;"></div>

<script>
/* 전역 변수 */
let chart = null;
let markerEnabled = false;
let currentMode = "HISTORICAL"; // "HISTORICAL" or "REALTIME"
let realtimeTimer = null;

/* 날짜 유틸 */
function pad(n){ return n < 10 ? "0"+n : n; }

function now(){
    const d = new Date();
    return d.getFullYear()+"-"+pad(d.getMonth()+1)+"-"+pad(d.getDate())+" "
         + pad(d.getHours())+":"+pad(d.getMinutes());
}

function before1Hour(){
    const d = new Date();
    d.setHours(d.getHours()-1);
    return d.getFullYear()+"-"+pad(d.getMonth()+1)+"-"+pad(d.getDate())+" "
         + pad(d.getHours())+":"+pad(d.getMinutes());
}

/* 범례 상태 저장/복원 */
function saveLegendState(){
    if(!chart) return;
    const state = {};
    chart.series.forEach(s => {
        state[s.name] = s.visible;
    });
    localStorage.setItem('trendLegendState', JSON.stringify(state));
}

function loadLegendState(){
    const saved = localStorage.getItem('trendLegendState');
    return saved ? JSON.parse(saved) : null;
}

/* 데이터 범위에 따른 최적 tick interval 및 레이블 형식 계산 */
function getOptimalSettings(rangeMillis) {
    const rangeMinutes = rangeMillis / (60 * 1000);
    const rangeHours = rangeMinutes / 60;
    const rangeDays = rangeHours / 24;
    
    let tickInterval, labelFormat;
    
    if (rangeDays > 30) {
        tickInterval = 24 * 60 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d", this.value);
        };
    } else if (rangeDays > 14) {
        tickInterval = 12 * 60 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    } else if (rangeDays > 7) {
        tickInterval = 6 * 60 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    } else if (rangeDays > 3) {
        tickInterval = 3 * 60 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    } else if (rangeDays > 1) {
        tickInterval = 60 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    } else if (rangeHours > 6) {
        tickInterval = 30 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    } else if (rangeHours > 3) {
        tickInterval = 15 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    } else if (rangeHours > 1) {
        tickInterval = 10 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    } else if (rangeMinutes > 30) {
        tickInterval = 5 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%H:%M", this.value);
        };
    } else if (rangeMinutes > 15) {
        tickInterval = 2 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%H:%M", this.value);
        };
    } else {
        tickInterval = 1 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%H:%M", this.value);
        };
    }
    
    return { tickInterval, labelFormat };
}

/* X축 업데이트 */
function updateXAxis(tickInterval, labelFormat) {
    if(!chart) return;
    chart.xAxis[0].update({
        tickInterval: tickInterval,
        labels: {
            formatter: labelFormat
        }
    });
}

/* 마우스 휠 줌 기능 */
function enableMouseWheelZoom() {
    $('#container').on('wheel', function(e) {
        if (!chart) return;
        
        e.preventDefault();
        
        const chartObj = chart;
        const xAxis = chartObj.xAxis[0];
        const extremes = xAxis.getExtremes();
        const dataMin = extremes.dataMin;
        const dataMax = extremes.dataMax;
        const currentMin = extremes.min;
        const currentMax = extremes.max;
        const range = currentMax - currentMin;
        
        const zoomFactor = e.originalEvent.deltaY > 0 ? 1.1 : 0.9;
        const newRange = range * zoomFactor;
        
        if (newRange > (dataMax - dataMin)) {
            xAxis.setExtremes(dataMin, dataMax);
            const settings = getOptimalSettings(dataMax - dataMin);
            updateXAxis(settings.tickInterval, settings.labelFormat);
            return;
        }
        
        if (newRange < 60000) {
            return;
        }
        
        const mouseX = e.originalEvent.offsetX;
        const chartWidth = chartObj.chartWidth;
        const mouseRatio = mouseX / chartWidth;
        
        const center = currentMin + (range * mouseRatio);
        const newMin = center - (newRange * mouseRatio);
        const newMax = center + (newRange * (1 - mouseRatio));
        
        const finalMin = Math.max(dataMin, newMin);
        const finalMax = Math.min(dataMax, newMax);
        
        xAxis.setExtremes(finalMin, finalMax);
        
        const settings = getOptimalSettings(finalMax - finalMin);
        updateXAxis(settings.tickInterval, settings.labelFormat);
    });
}

/* 차트 생성 */
function createChart(series, dataRange){
    const legendState = loadLegendState();
    
    // 실시간 모드일 때만 온도분포 기본 숨김
    if(currentMode === "REALTIME") {
        series.forEach(s => {
            if(s.name.includes('온도분포')){
                s.visible = false;
            }
        });
    }
    
    if(legendState){
        series.forEach(s => {
            if(legendState.hasOwnProperty(s.name)){
                s.visible = legendState[s.name];
            }
        });
    }
    
    const settings = getOptimalSettings(dataRange);
    
    chart = Highcharts.chart("container",{
        chart:{
            type:"line",
            zoomType:"x",
            panning:true,
            panKey:"shift",
            events: {
                selection: function(event) {
                    if (event.xAxis) {
                        const min = event.xAxis[0].min;
                        const max = event.xAxis[0].max;
                        const range = max - min;
                        
                        const settings = getOptimalSettings(range);
                        setTimeout(function() {
                            updateXAxis(settings.tickInterval, settings.labelFormat);
                        }, 100);
                    }
                }
            }
        },
        title:{ 
            text: currentMode === "REALTIME" ? "실시간 트렌드" : "히스토리컬 트렌드"
        },
        plotOptions:{
            series:{
                marker:{
                    enabled: markerEnabled
                },
                states:{
                    hover:{
                        lineWidthPlus:0
                    }
                },
                events: {
                    legendItemClick: function() {
                        setTimeout(saveLegendState, 100);
                    }
                }
            }
        },
        xAxis:{
            type:"datetime",
            tickInterval: settings.tickInterval,
            labels:{
                formatter: settings.labelFormat
            }
        },
        yAxis:{
            title:{ text:"온도(℃)" },
            min:0
        },
        tooltip:{
            shared:true,
            crosshairs:true,
            xDateFormat:"%Y-%m-%d %H:%M:%S"
        },
        exporting:{
            enabled:true,
            buttons:{
                contextButton:{
                    menuItems:[
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
        series: series
    });
    
    enableMouseWheelZoom();
}

/* 파일명 생성 */
function getExportFilename(extension) {
    const now = new Date();
    const year = now.getFullYear();
    const month = pad(now.getMonth() + 1);
    const day = pad(now.getDate());
    const hour = pad(now.getHours());
    const minute = pad(now.getMinutes());
    const second = pad(now.getSeconds());
    
    return year + month + day + hour + minute + second + "_온도파일." + extension;
}

/* CSV 서버 저장 */
function downloadCSVToServer() {
    if (!chart) {
        alert('차트 데이터가 없습니다.');
        return;
    }
    
    const csv = chart.getCSV();
    
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

/* 차트 Clear */
function clearChart(){
    if(!chart) return;
    while(chart.series.length){
        chart.series[0].remove(false);
    }
    chart.redraw();
}

/* 타이머 정리 */
function stopRealtimeTimer(){
    if(realtimeTimer){
        clearInterval(realtimeTimer);
        realtimeTimer = null;
    }
}

/* 히스토리컬 트렌드 조회 */
function loadHistory(){
    const startDate = $("#startDate").val();
    const endDate = $("#endDate").val();
    
    $.post("/posco/monitoring/trend/list",{
        startDate: startDate,
        endDate: endDate
    },function(result){
        if(!result || result.length === 0){
            clearChart();
            alert('조회된 데이터가 없습니다.');
            return;
        }

        const categories = result.map(r => new Date(r.tdatetime).getTime());
        
        const dataMin = Math.min(...categories);
        const dataMax = Math.max(...categories);
        const dataRange = dataMax - dataMin;

        const series = [
            { name:'1존온도 PV', data: result.map((r,i)=>[categories[i],+r.vac1_pv]) },
            { name:'2존온도 PV', data: result.map((r,i)=>[categories[i],+r.vac2_pv]) },
            { name:'3존온도 PV', data: result.map((r,i)=>[categories[i],+r.vac3_pv]) },
            { name:'온도 SP', data: result.map((r,i)=>[categories[i],+r.tem_sp]) },
            { name:'온도 TSP', data: result.map((r,i)=>[categories[i],+r.tem_tsp]) },
            { name:'온도분포1', data: result.map((r,i)=>[categories[i],+r.tem_1]) },
            { name:'온도분포2', data: result.map((r,i)=>[categories[i],+r.tem_2]) },
            { name:'온도분포3', data: result.map((r,i)=>[categories[i],+r.tem_3]) },
            { name:'온도분포4', data: result.map((r,i)=>[categories[i],+r.tem_4]) },
            { name:'온도분포5', data: result.map((r,i)=>[categories[i],+r.tem_5]) },
            { name:'온도분포6', data: result.map((r,i)=>[categories[i],+r.tem_6]) },
            { name:'온도분포7', data: result.map((r,i)=>[categories[i],+r.tem_7]) },
            { name:'온도분포8', data: result.map((r,i)=>[categories[i],+r.tem_8]) },
            { name:'온도분포9', data: result.map((r,i)=>[categories[i],+r.tem_9]) }
        ];

        if(chart){
            clearChart();
        }
        createChart(series, dataRange);
    });
}

/* 실시간 트렌드 조회 */
function loadRealtime(){
    $.post("/posco/monitoring/trend/realtime",function(result){
        if(!result || result.length === 0){
            clearChart();
            return;
        }

        const categories = result.map(r => new Date(r.tdatetime).getTime());
        
        const dataMin = Math.min(...categories);
        const dataMax = Math.max(...categories);
        const dataRange = dataMax - dataMin;

        const newSeries = [
            { name:'1존온도 PV', data: result.map((r,i)=>[categories[i],+r.vac1_pv]) },
            { name:'2존온도 PV', data: result.map((r,i)=>[categories[i],+r.vac2_pv]) },
            { name:'3존온도 PV', data: result.map((r,i)=>[categories[i],+r.vac3_pv]) },
            { name:'온도 SP', data: result.map((r,i)=>[categories[i],+r.tem_sp]) },
            { name:'온도 TSP', data: result.map((r,i)=>[categories[i],+r.tem_tsp]) },
            { name:'온도분포1', data: result.map((r,i)=>[categories[i],+r.tem_1]) },
            { name:'온도분포2', data: result.map((r,i)=>[categories[i],+r.tem_2]) },
            { name:'온도분포3', data: result.map((r,i)=>[categories[i],+r.tem_3]) },
            { name:'온도분포4', data: result.map((r,i)=>[categories[i],+r.tem_4]) },
            { name:'온도분포5', data: result.map((r,i)=>[categories[i],+r.tem_5]) },
            { name:'온도분포6', data: result.map((r,i)=>[categories[i],+r.tem_6]) },
            { name:'온도분포7', data: result.map((r,i)=>[categories[i],+r.tem_7]) },
            { name:'온도분포8', data: result.map((r,i)=>[categories[i],+r.tem_8]) },
            { name:'온도분포9', data: result.map((r,i)=>[categories[i],+r.tem_9]) }
        ];

        if(!chart){
            createChart(newSeries, dataRange);
        } else {
            newSeries.forEach((s, idx) => {
                if(chart.series[idx]) {
                    chart.series[idx].setData(s.data, false);
                }
            });
            chart.redraw();
        }
    });
}

/* 모드 전환 */
function switchToHistorical(){
    currentMode = "HISTORICAL";
    stopRealtimeTimer();
    
    $("#btnHistorical").addClass("active");
    $("#btnRealtime").removeClass("active");
    
    $("#dateInputArea").show();
    $("#btnSearch").show();
    
    loadHistory();
}

function switchToRealtime(){
    currentMode = "REALTIME";
    stopRealtimeTimer();
    
    $("#btnHistorical").removeClass("active");
    $("#btnRealtime").addClass("active");
    
    $("#dateInputArea").hide();
    $("#btnSearch").hide();
    
    loadRealtime();
    realtimeTimer = setInterval(loadRealtime, 5000);
}

/* 이벤트 핸들러 */
$("#btnSearch").on("click", loadHistory);

$("#btnHistorical").on("click", switchToHistorical);
$("#btnRealtime").on("click", switchToRealtime);

$("#toggleMarker").on("change",function(){
    markerEnabled = this.checked;
    if(chart){
        chart.update({
            plotOptions:{
                series:{
                    marker:{ enabled: markerEnabled }
                }
            }
        });
    }
});

/* 초기화 */
$(function(){
    $("#startDate").val(before1Hour());
    $("#endDate").val(now());
    loadHistory();
});

/* 페이지 떠날 때 타이머 정리 */
$(window).on('beforeunload', function() {
    stopRealtimeTimer();
});
</script>
</body>
</html>