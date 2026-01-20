<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>실시간 트렌드</title>
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
            margin-top: 20px;
        }
        
        .trend-option label {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 15px;
            cursor: pointer;
        }
        
        .status-text {
            font-size: 16px;
            font-weight: bold;
            color: #28a745;
        }
        
        /* 시간 범위 버튼 */
        .range-buttons {
            display: flex;
            gap: 8px;
            margin-left: auto;
            margin-right: 20px;
        }
        
        .range-btn {
            padding: 6px 12px;
            border: 1px solid #28a745;
            background: white;
            color: #28a745;
            border-radius: 4px;
            cursor: pointer;
            font-size: 13px;
            transition: all 0.2s;
        }
        
        .range-btn:hover {
            background: #28a745;
            color: white;
        }
        
        .range-btn.active {
            background: #28a745;
            color: white;
        }
    </style>
</head>
<body>

<div class="button-container">
    <div class="status-text">🔴 실시간 데이터 수신 중...</div>
    
    <div class="range-buttons">
    <button class="range-btn" data-range="1">1분</button>
    <button class="range-btn" data-range="2">2분</button>
    <button class="range-btn" data-range="5">5분</button>
    <button class="range-btn" data-range="10">10분</button>
    <button class="range-btn" data-range="15">15분</button>
    <button class="range-btn" data-range="30">30분</button>
</div>
    
    <div class="trend-option">
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
let timer = null;
let markerEnabled = false;
let selectedRangeMinutes = 60; // 기본 1시간

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

/* tick interval에 따른 레이블 형식 결정 */
function getLabelFormat(tickIntervalMinutes) {
    if (tickIntervalMinutes <= 2) {
        return function() {
            return Highcharts.dateFormat("%H:%M", this.value);
        };
    } else {
        return function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    }
}

/* X축 업데이트 */
function updateXAxis(tickIntervalMinutes) {
    if(!chart) return;
    
    const tickInterval = tickIntervalMinutes * 60 * 1000;
    const labelFormat = getLabelFormat(tickIntervalMinutes);
    
    chart.xAxis[0].update({
        tickInterval: tickInterval,
        labels: {
            formatter: labelFormat
        }
    });
}

/* 선택된 범위에 맞춰 차트 표시 범위 조정 */
function applySelectedRange(rangeMinutes) {
    if(!chart) return;
    
    const xAxis = chart.xAxis[0];
    const extremes = xAxis.getExtremes();
    const dataMax = extremes.dataMax; // 최신 데이터 시간
    
    // 선택된 범위만큼만 표시 (최신 데이터 기준)
    const rangeMillis = rangeMinutes * 60 * 1000;
    const newMin = dataMax - rangeMillis;
    xAxis.setExtremes(Math.max(extremes.dataMin, newMin), dataMax);
}

/* 줌 레벨에 따른 최적 tick interval 계산 */
function getOptimalTickIntervalForZoom(rangeMillis) {
    const rangeMinutes = rangeMillis / (60 * 1000);
    
    if (rangeMinutes <= 5) return 1;
    if (rangeMinutes <= 15) return 2;
    if (rangeMinutes <= 30) return 5;
    if (rangeMinutes <= 60) return 10;
    return 15;
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
        
        // 줌 비율
        const zoomFactor = e.originalEvent.deltaY > 0 ? 1.1 : 0.9;
        const newRange = range * zoomFactor;
        
        // 선택된 범위 내에서만 줌
        const maxAllowedRange = selectedRangeMinutes * 60 * 1000;
        
        // 최대 범위 제한
        if (newRange > maxAllowedRange) {
            // 선택된 범위로 복귀
            const newMin = dataMax - maxAllowedRange;
            xAxis.setExtremes(Math.max(dataMin, newMin), dataMax);
            
            // 선택된 버튼에 맞는 tick interval 적용
            const tickInterval = selectedRangeMinutes <= 5 ? 1 :
                                 selectedRangeMinutes <= 10 ? 2 :
                                 selectedRangeMinutes <= 15 ? 5 :
                                 selectedRangeMinutes <= 30 ? 5 : 10;
            updateXAxis(tickInterval);
            return;
        }
        
        // 최소 범위 제한 (1분)
        if (newRange < 60000) {
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
        let finalMin = Math.max(dataMin, newMin);
        let finalMax = Math.min(dataMax, newMax);
        
        // 선택된 범위를 벗어나지 않도록
        const selectedRangeMillis = selectedRangeMinutes * 60 * 1000;
        const minAllowedTime = dataMax - selectedRangeMillis;
        
        if(finalMin < minAllowedTime) {
            const shift = minAllowedTime - finalMin;
            finalMin = minAllowedTime;
            finalMax = Math.min(dataMax, finalMax + shift);
        }
        if(finalMax > dataMax) {
            finalMax = dataMax;
        }
        
        xAxis.setExtremes(finalMin, finalMax);
        
        // 줌 레벨에 따른 최적 tick interval 적용
        const optimalInterval = getOptimalTickIntervalForZoom(finalMax - finalMin);
        updateXAxis(optimalInterval);
    });
}

/* 차트 생성 */
function createChart(series){
    const legendState = loadLegendState();
    
    // 실시간은 온도분포 기본 숨김
    series.forEach(s => {
        if(s.name.includes('온도분포')){
            s.visible = false;
        }
    });
    
    if(legendState){
        series.forEach(s => {
            if(legendState.hasOwnProperty(s.name)){
                s.visible = legendState[s.name];
            }
        });
    }
    
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
                        
                        const optimalInterval = getOptimalTickIntervalForZoom(range);
                        setTimeout(function() {
                            updateXAxis(optimalInterval);
                        }, 100);
                    }
                }
            }
        },
        title:{ text:"실시간 트렌드" },
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
            tickInterval: 10 * 60 * 1000, // 기본 10분 간격 (1시간 범위)
            labels:{
                formatter: function(){
                    return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
                }
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
        series: series
    });
    
    // 마우스 휠 줌 활성화
    enableMouseWheelZoom();
}

/* 차트 Clear */
function clearChart(){
    if(!chart) return;
    while(chart.series.length){
        chart.series[0].remove(false);
    }
    chart.redraw();
}

/* 타이머 제어 */
function stopTimer(){
    if(timer){
        clearInterval(timer);
        timer = null;
    }
}

/* 실시간 트렌드 조회 */
function loadRealtime(){
    $.post("/posco/monitoring/trend/realtime",function(result){
        if(!result || result.length === 0){
            clearChart();
            return;
        }

        const categories = result.map(r => new Date(r.tdatetime).getTime());

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
            createChart(newSeries);
            
            // 초기 로딩 시 1시간 범위 표시 (전체 데이터)
            // applySelectedRange는 호출하지 않음 - 전체 1시간 데이터 표시
        } else {
            // 기존 표시 범위 저장
            const xAxis = chart.xAxis[0];
            const oldExtremes = xAxis.getExtremes();
            const wasShowingFullRange = (oldExtremes.max === oldExtremes.dataMax);
            
            newSeries.forEach((s, idx) => {
                if(chart.series[idx]) {
                    chart.series[idx].setData(s.data, false);
                }
            });
            chart.redraw();
            
            // 전체 범위를 보고 있었다면 계속 전체 범위 유지
            // 줌/팬 중이었다면 상대적 위치 유지
            if(wasShowingFullRange) {
                const newExtremes = xAxis.getExtremes();
                applySelectedRange(selectedRangeMinutes);
            }
        }
    });
}

/* 이벤트 핸들러 */
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

// 시간 범위 버튼 클릭
$('.range-btn').on('click', function(){
    const range = parseInt($(this).data('range'));
    $('.range-btn').removeClass('active');
    $(this).addClass('active');
    
    // 선택된 범위 저장
    selectedRangeMinutes = range;
    
    // 범위에 맞춰 차트 표시
    applySelectedRange(range);
    
    // 버튼에 맞는 tick interval 적용
    const tickInterval = range <= 5 ? 1 :
                         range <= 10 ? 2 :
                         range <= 15 ? 5 :
                         range <= 30 ? 5 : 10;
    updateXAxis(tickInterval);
});

/* 초기화 및 타이머 시작 */
$(function(){
    // 버튼 초기 상태: 아무것도 선택 안 함 (전체 1시간 표시)
    $('.range-btn').removeClass('active');
    
    loadRealtime();
    timer = setInterval(loadRealtime, 5000);
});

/* 페이지 떠날 때 타이머 정리 */
$(window).on('beforeunload', function() {
    stopTimer();
});
</script>

</body>
</html>