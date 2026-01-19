<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>히스토리컬 트렌드</title>
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
        
        /* 시간 범위 버튼 */
        .range-buttons {
            display: flex;
            gap: 8px;
            margin-left: 20px;
        }
        
        .range-btn {
            padding: 6px 12px;
            border: 1px solid #007bff;
            background: white;
            color: #007bff;
            border-radius: 4px;
            cursor: pointer;
            font-size: 13px;
            transition: all 0.2s;
        }
        
        .range-btn:hover {
            background: #007bff;
            color: white;
        }
        
        .range-btn.active {
            background: #007bff;
            color: white;
        }
    </style>
</head>
<body>

<div class="button-container">
    <label class="daylabel">검색 날짜 :</label>
    <div class="date_input" style="display: flex; align-items: center;">
        <input type="text" autocomplete="off" class="datetimeSet" id="startDate">
        <span class="mid"> ~ </span>
        <input type="text" autocomplete="off" class="datetimeSet" id="endDate">
    </div>
    <button class="select-button" id="btnSearch">
        <img src="/posco/css/tabBar/search-icon.png" alt="select" class="button-image">조회
    </button>
    
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
        // 30일 이상: 1일 간격, 월-일만 표시
        tickInterval = 24 * 60 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d", this.value);
        };
    } else if (rangeDays > 14) {
        // 14~30일: 12시간 간격, 월-일, 시:분
        tickInterval = 12 * 60 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    } else if (rangeDays > 7) {
        // 7~14일: 6시간 간격
        tickInterval = 6 * 60 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    } else if (rangeDays > 3) {
        // 3~7일: 3시간 간격
        tickInterval = 3 * 60 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    } else if (rangeDays > 1) {
        // 1~3일: 1시간 간격
        tickInterval = 60 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    } else if (rangeHours > 6) {
        // 6~24시간: 30분 간격
        tickInterval = 30 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    } else if (rangeHours > 3) {
        // 3~6시간: 15분 간격
        tickInterval = 15 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    } else if (rangeHours > 1) {
        // 1~3시간: 10분 간격
        tickInterval = 10 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    } else if (rangeMinutes > 30) {
        // 30~60분: 5분 간격
        tickInterval = 5 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%H:%M", this.value);
        };
    } else if (rangeMinutes > 15) {
        // 15~30분: 2분 간격
        tickInterval = 2 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%H:%M", this.value);
        };
    } else {
        // 15분 이하: 1분 간격
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
        
        // 줌 비율 (휠 방향에 따라)
        const zoomFactor = e.originalEvent.deltaY > 0 ? 1.1 : 0.9;
        const newRange = range * zoomFactor;
        
        // 최소/최대 범위 제한
        if (newRange > (dataMax - dataMin)) {
            xAxis.setExtremes(dataMin, dataMax);
            // 전체 범위일 때 최적 설정 적용
            const settings = getOptimalSettings(dataMax - dataMin);
            updateXAxis(settings.tickInterval, settings.labelFormat);
            return;
        }
        
        if (newRange < 60000) { // 최소 1분
            return;
        }
        
        // 마우스 위치를 중심으로 줌
        const mouseX = e.originalEvent.offsetX;
        const chartWidth = chartObj.chartWidth;
        const mouseRatio = mouseX / chartWidth;
        
        const center = currentMin + (range * mouseRatio);
        const newMin = center - (newRange * mouseRatio);
        const newMax = center + (newRange * (1 - mouseRatio));
        
        // 범위 제한
        const finalMin = Math.max(dataMin, newMin);
        const finalMax = Math.min(dataMax, newMax);
        
        xAxis.setExtremes(finalMin, finalMax);
        
        // 줌 레벨에 따른 최적 설정 적용
        const settings = getOptimalSettings(finalMax - finalMin);
        updateXAxis(settings.tickInterval, settings.labelFormat);
    });
}

/* 차트 생성 */
function createChart(series, dataRange){
    const legendState = loadLegendState();
    
    if(legendState){
        series.forEach(s => {
            if(legendState.hasOwnProperty(s.name)){
                s.visible = legendState[s.name];
            }
        });
    }
    
    // 데이터 범위에 따른 최적 설정
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
                        
                        // 선택 영역에 따른 최적 설정 적용
                        const settings = getOptimalSettings(range);
                        setTimeout(function() {
                            updateXAxis(settings.tickInterval, settings.labelFormat);
                        }, 100);
                    }
                }
            }
        },
        title:{ text:"히스토리컬 트렌드" },
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
    
    // 마우스 휠 줌 활성화
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
        
        // 데이터 범위 계산
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

/* 이벤트 핸들러 */
$("#btnSearch").on("click", loadHistory);

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
</script>
</body>
</html>