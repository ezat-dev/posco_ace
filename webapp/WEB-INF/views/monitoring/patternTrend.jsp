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

        /* ===== 상단 정보 영역 ===== */
        .button-container{
            display:flex;
            align-items:center;
            gap:15px;
            width:1600px;
            padding:15px 20px;
            background:#f4f4f4;
            border-radius:8px;
            box-shadow:0 2px 6px rgba(0,0,0,0.1);
            margin-top: 20px;
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

        /* ===== 포인트 표시 체크박스 ===== */
        .trend-option{
            margin-left: auto;
        }

        .trend-option label{
            display:flex;
            align-items:center;
            gap:6px;
            font-size:15px;
            cursor:pointer;
        }
    </style>
</head>
<body>

<div class="button-container">
    <div class="status-text">📊 패턴 운전 트렌드</div>
    
    <div class="pattern-info" id="patternInfo">
        <span style="color: #999;">대기 중...</span>
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
/* ===============================
   전역 변수
================================ */
let chart = null;
let timer = null;
let markerEnabled = false;
let isLoading = false;
let currentPatternNo = null;
let patternEnded = false;

/* ===============================
   날짜 유틸
================================ */
function pad(n){ return n < 10 ? "0"+n : n; }

/* ===============================
   범례 상태 저장/복원 (localStorage)
================================ */
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

/* ===============================
   데이터 범위에 따른 최적 설정
================================ */
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

/* ===============================
   마우스 휠 줌 기능
================================ */
function enableMouseWheelZoom() {
    $('#container').off('wheel').on('wheel', function(e) {
        if (!chart) return;
        
        e.preventDefault();
        
        const xAxis = chart.xAxis[0];
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
            xAxis.update({
                tickInterval: settings.tickInterval,
                labels: { formatter: settings.labelFormat }
            });
            return;
        }
        
        if (newRange < 60000) return;
        
        const mouseX = e.originalEvent.offsetX;
        const chartWidth = chart.chartWidth;
        const mouseRatio = mouseX / chartWidth;
        
        const center = currentMin + (range * mouseRatio);
        const newMin = center - (newRange * mouseRatio);
        const newMax = center + (newRange * (1 - mouseRatio));
        
        const finalMin = Math.max(dataMin, newMin);
        const finalMax = Math.min(dataMax, newMax);
        
        xAxis.setExtremes(finalMin, finalMax);
        
        const settings = getOptimalSettings(finalMax - finalMin);
        xAxis.update({
            tickInterval: settings.tickInterval,
            labels: { formatter: settings.labelFormat }
        });
    });
}

/* ===============================
   파일명 생성
================================ */
function getExportFilename(extension) {
    const now = new Date();
    const year = now.getFullYear();
    const month = pad(now.getMonth() + 1);
    const day = pad(now.getDate());
    const hour = pad(now.getHours());
    const minute = pad(now.getMinutes());
    const second = pad(now.getSeconds());
    
    const patternPrefix = currentPatternNo ? "패턴" + currentPatternNo + "_" : "";
    return patternPrefix + year + month + day + hour + minute + second + "_온도파일." + extension;
}

/* ===============================
   CSV 서버 저장
================================ */
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

/* ===============================
   차트 생성 - 완전히 새로 생성
================================ */
function createChart(series, dataMin, dataMax){
    const legendState = loadLegendState();
    
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
    
    const dataRange = dataMax - dataMin;
    const settings = getOptimalSettings(dataRange);
    
    console.log("✅ 차트 생성:", new Date(dataMin), "~", new Date(dataMax));
    
    chart = Highcharts.chart("container",{
        chart:{
            type:"line",
            zoomType:"x",
            panning:true,
            panKey:"shift"
        },
        title:{ text:"패턴 트렌드" },

        plotOptions:{
            series:{
                marker:{ enabled: markerEnabled },
                states:{ hover:{ lineWidthPlus:0 } },
                events: {
                    legendItemClick: function() {
                        setTimeout(saveLegendState, 100);
                    }
                }
            }
        },

        xAxis:{
            type:"datetime",
            min: dataMin,  // ✅ 명시적 범위 설정
            max: dataMax,  // ✅ 명시적 범위 설정
            tickInterval: settings.tickInterval,
            labels:{ formatter: settings.labelFormat }
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

/* ===============================
   차트 완전 제거
================================ */
function destroyChart(){
    if(chart){
        chart.destroy();
        chart = null;
    }
}

/* ===============================
   타이머 제어
================================ */
function stopTimer(){
    if(timer){
        clearInterval(timer);
        timer = null;
    }
}

/* ===============================
   패턴 트렌드 조회
================================ */
function loadPatternCurrent(){
    if(isLoading) return;
    isLoading = true;
    
    $.post("/posco/monitoring/trend/pattern/current",function(resp){
        
        console.log("========================================");
        console.log("현재 패턴 정보:", resp);
        
        if(!resp || resp.running !== true){
            if(currentPatternNo !== null && !patternEnded){
                patternEnded = true;
                $("#patternInfo").html('<span style="color: #dc3545; font-weight: bold;">⚠️ 패턴 ' + currentPatternNo + ' 운전이 종료되었습니다.</span>');
                
                setTimeout(function(){
                    destroyChart();
                    $("#patternInfo").html('<span style="color: #999;">대기 중...</span>');
                    currentPatternNo = null;
                    patternEnded = false;
                }, 5000);
            } else if(currentPatternNo === null){
                destroyChart();
                $("#patternInfo").html('<span style="color: #dc3545;">⚠️ 현재 운전 중인 패턴이 없습니다.</span>');
            }
            isLoading = false;
            return;
        }

        const patternNo = resp.patternNo;
        if(currentPatternNo !== patternNo){
            console.log("🔄 새로운 패턴 시작:", patternNo);
            currentPatternNo = patternNo;
            patternEnded = false;
            destroyChart();
        }

        const startTime = resp.startTime || '-';
        const endTime = resp.endTime || '진행 중';
        
        $("#patternInfo").html(
            '<span><strong>패턴 번호:</strong> ' + patternNo + '</span>' +
            '<span><strong>시작 시간:</strong> ' + startTime + '</span>' +
            '<span><strong>종료 시간:</strong> ' + endTime + '</span>'
        );

        if(resp.endTime && resp.endTime !== '진행 중'){
            if(!patternEnded){
                patternEnded = true;
                $("#patternInfo").html(
                    '<span style="color: #dc3545; font-weight: bold;"><strong>패턴 번호:</strong> ' + patternNo + '</span>' +
                    '<span style="color: #dc3545; font-weight: bold;"><strong>시작 시간:</strong> ' + startTime + '</span>' +
                    '<span style="color: #dc3545; font-weight: bold;"><strong>종료 시간:</strong> ' + endTime + ' (종료됨)</span>'
                );
                
                setTimeout(function(){
                    destroyChart();
                    $("#patternInfo").html('<span style="color: #999;">대기 중...</span>');
                    currentPatternNo = null;
                    patternEnded = false;
                }, 5000);
            }
            isLoading = false;
            return;
        }

        // ✅ 패턴 데이터 조회
        $.post("/posco/monitoring/trend/pattern",{patternNo:patternNo},function(result){
            
            console.log("패턴 트렌드 데이터 수신:", result ? result.length : 0, "개");
            
            if(!result || result.length === 0){
                console.warn("❌ 데이터 없음");
                destroyChart();
                isLoading = false;
                return;
            }

            console.log("첫 데이터:", result[0]);
            console.log("마지막 데이터:", result[result.length-1]);

            const categories = result.map(r => new Date(r.tdatetime).getTime());
            
            const dataMin = Math.min(...categories);
            const dataMax = Math.max(...categories);

            console.log("시간 범위:", new Date(dataMin), "~", new Date(dataMax));
            console.log("========================================");

            const newSeries = [
                { name:'1존온도 PV', data: result.map((r,i)=>[categories[i],+r.vac1_pv]) },
                { name:'2존온도 PV', data: result.map((r,i)=>[categories[i],+r.vac2_pv]) },
                { name:'3존온도 PV', data: result.map((r,i)=>[categories[i],+r.vac3_pv]) },
                { name:'온도 SP', data: result.map((r,i)=>[categories[i],+r.tem_sp]) },
                { name:'온도 TSP', data: result.map((r,i)=>[categories[i],+r.tem_tsp]) }
            ];

            // ✅ 차트가 없으면 새로 생성
            if(!chart){
                createChart(newSeries, dataMin, dataMax);
            } else {
                // ✅ 차트 업데이트 - 데이터 + X축 범위
                newSeries.forEach((s, idx) => {
                    if(chart.series[idx]) {
                        chart.series[idx].setData(s.data, false);
                    }
                });
                
                // X축 범위 업데이트
                const dataRange = dataMax - dataMin;
                const settings = getOptimalSettings(dataRange);
                
                chart.xAxis[0].setExtremes(dataMin, dataMax, false);
                chart.xAxis[0].update({
                    tickInterval: settings.tickInterval,
                    labels: { formatter: settings.labelFormat }
                }, false);
                
                chart.redraw();
            }
            
            isLoading = false;
        }).fail(function(){
            console.error("❌ 패턴 트렌드 조회 실패");
            isLoading = false;
        });
        
    }).fail(function(){
        console.error("❌ 현재 패턴 조회 실패");
        isLoading = false;
    });
}

/* ===============================
   이벤트
================================ */
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

/* ===============================
   초기화
================================ */
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