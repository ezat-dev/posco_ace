<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>패턴 트렌드</title>
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
            color: #007bff;
        }
        
        .pattern-info {
            display: flex;
            gap: 20px;
            font-size: 14px;
            color: #555;
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
    <div class="status-text">📊 패턴 운전 트렌드</div>
    
    <div class="pattern-info" id="patternInfo">
        <!-- 동적으로 채워짐 -->
    </div>
    <div class="range-buttons">
    <button class="range-btn" data-range="1">1분</button>
    <button class="range-btn" data-range="2">2분</button>
    <button class="range-btn active" data-range="5">5분</button>
    <button class="range-btn" data-range="10">10분</button>
    <button class="range-btn" data-range="30">30분</button>
    <button class="range-btn" data-range="60">1시간</button>
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
let timer = null;
let markerEnabled = false;
let currentPatternNo = null;
let patternEnded = false;

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
        // 1~2분: 시:분만 표시
        return function() {
            return Highcharts.dateFormat("%H:%M", this.value);
        };
    } else {
        // 5분 이상: 월-일, 시:분 (2줄)
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

/* 줌 레벨에 따른 최적 tick interval 계산 */
function getOptimalTickIntervalForZoom(rangeMillis) {
    const rangeMinutes = rangeMillis / (60 * 1000);
    
    if (rangeMinutes <= 5) return 1;        // 5분 이하: 1분
    if (rangeMinutes <= 15) return 2;       // 15분 이하: 2분
    if (rangeMinutes <= 30) return 5;       // 30분 이하: 5분
    if (rangeMinutes <= 60) return 10;      // 60분 이하: 10분
    if (rangeMinutes <= 180) return 30;     // 3시간 이하: 30분
    return 60;                               // 그 이상: 1시간
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
            // 전체 범위일 때 최적 tick interval 적용
            const optimalInterval = getOptimalTickIntervalForZoom(dataMax - dataMin);
            updateXAxis(optimalInterval);
            
            // 버튼 상태 초기화
            $('.range-btn').removeClass('active');
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
        
        // 줌 레벨에 따른 최적 tick interval 적용
        const optimalInterval = getOptimalTickIntervalForZoom(finalMax - finalMin);
        updateXAxis(optimalInterval);
        
        // 버튼 상태 초기화
        $('.range-btn').removeClass('active');
    });
}

/* 차트 생성 */
function createChart(series){
    const legendState = loadLegendState();
    
    // 패턴 트렌드는 온도분포 기본 숨김
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
                        
                        // 선택 영역에 따른 최적 tick interval 적용
                        const optimalInterval = getOptimalTickIntervalForZoom(range);
                        setTimeout(function() {
                            updateXAxis(optimalInterval);
                        }, 100);
                        
                        // 버튼 상태 초기화
                        $('.range-btn').removeClass('active');
                    }
                }
            }
        },
        title:{ text:"패턴 트렌드" },
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
            tickInterval: 5 * 60 * 1000, // 기본 5분 간격
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

/* 차트 완전 제거 (패턴 종료 시) */
function destroyChart(){
    if(chart){
        chart.destroy();
        chart = null;
    }
}

/* 패턴 트렌드 조회 */
function loadPatternCurrent(){
    $.post("/posco/monitoring/trend/pattern/current",function(resp){
        if(!resp || resp.running !== true){
            // 패턴이 종료되었거나 없는 경우
            if(currentPatternNo !== null && !patternEnded){
                // 패턴이 방금 종료된 경우
                patternEnded = true;
                $("#patternInfo").html('<span style="color: #dc3545; font-weight: bold;">⚠️ 패턴 ' + currentPatternNo + ' 운전이 종료되었습니다.</span>');
                
                // 5초 후 차트와 정보 완전 휘발
                setTimeout(function(){
                    destroyChart();
                    $("#patternInfo").html('<span style="color: #999;">대기 중...</span>');
                    currentPatternNo = null;
                    patternEnded = false;
                }, 5000);
            } else if(currentPatternNo === null){
                // 처음부터 패턴이 없는 경우
                destroyChart();
                $("#patternInfo").html('<span style="color: #dc3545;">⚠️ 현재 운전 중인 패턴이 없습니다.</span>');
            }
            return;
        }

        // 새로운 패턴 시작 감지
        const patternNo = resp.patternNo;
        if(currentPatternNo !== patternNo){
            currentPatternNo = patternNo;
            patternEnded = false;
            destroyChart(); // 이전 패턴 차트 완전 제거
        }

        // 패턴 정보 표시
        const startTime = resp.startTime || '-';
        const endTime = resp.endTime || '진행 중';
        
        $("#patternInfo").html(
            '<span><strong>패턴 번호:</strong> ' + patternNo + '</span>' +
            '<span><strong>시작 시간:</strong> ' + startTime + '</span>' +
            '<span><strong>종료 시간:</strong> ' + endTime + '</span>'
        );

        // 패턴 종료 시간이 있으면 패턴 종료 플래그 설정
        if(resp.endTime && resp.endTime !== '진행 중'){
            if(!patternEnded){
                patternEnded = true;
                $("#patternInfo").html(
                    '<span style="color: #dc3545; font-weight: bold;"><strong>패턴 번호:</strong> ' + patternNo + '</span>' +
                    '<span style="color: #dc3545; font-weight: bold;"><strong>시작 시간:</strong> ' + startTime + '</span>' +
                    '<span style="color: #dc3545; font-weight: bold;"><strong>종료 시간:</strong> ' + endTime + ' (종료됨)</span>'
                );
                
                // 5초 후 차트 휘발
                setTimeout(function(){
                    destroyChart();
                    $("#patternInfo").html('<span style="color: #999;">대기 중...</span>');
                    currentPatternNo = null;
                    patternEnded = false;
                }, 5000);
            }
            return; // 종료된 패턴은 더 이상 업데이트하지 않음
        }

        // 패턴 데이터 조회
        $.post("/posco/monitoring/trend/pattern",{patternNo:patternNo},function(result){
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
                { name:'온도 TSP', data: result.map((r,i)=>[categories[i],+r.tem_tsp]) }
            ];

            if(!chart){
                createChart(newSeries);
            } else {
                newSeries.forEach((s, idx) => {
                    if(chart.series[idx]) {
                        chart.series[idx].setData(s.data, false);
                    }
                });
                chart.redraw();
            }
        });
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

// 시간 범위 버튼 클릭 - tick interval만 변경
$('.range-btn').on('click', function(){
    const range = parseInt($(this).data('range'));
    $('.range-btn').removeClass('active');
    $(this).addClass('active');
    
    // X축 tick interval만 업데이트
    updateXAxis(range);
});

/* 초기화 및 타이머 시작 */
$(function(){
    loadPatternCurrent();
    timer = setInterval(loadPatternCurrent, 5000);
});

/* 페이지 떠날 때 타이머 정리 */
$(window).on('beforeunload', function() {
    stopTimer();
});
</script>

</body>
</html>