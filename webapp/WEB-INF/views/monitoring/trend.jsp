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
    <script src="/posco/js/highcharts/highcharts.js"></script>
<script src="/posco/js/highcharts/exporting.js"></script>
<script src="/posco/js/highcharts/export-data.js"></script>
<script src="/posco/js/highcharts/offline-exporting.js"></script>

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



/* ===== 조회 영역 ===== */
.button-container{
    display:flex;
    align-items:center;
    gap:15px;
    width:1600px;
    padding:15px 20px;
    background:#f4f4f4;
    border-radius:8px;
    box-shadow:0 2px 6px rgba(0,0,0,0.1);
}

.select-button, .insert-button{
    display:flex;
    align-items:center;
    gap:6px;
    padding:8px 16px;
    border-radius:6px;
    border:1px solid #aaa;
    background:#e0e0e0;
    cursor:pointer;
    font-size:14px;
    transition:all 0.2s;
}

.select-button:hover,
.insert-button:hover{
    background:#cfcfcf;
}

/* ===== 라디오 버튼 영역 ===== */
.trend-radio-group{
    display:flex;
    align-items:center;
    gap:20px;
    margin-left:20px;
}

.trend-radio-group label{
    display:flex;
    align-items:center;
    gap:6px;
    font-size:15px;
    cursor:pointer;
}

.trend-radio-group input[type="radio"]{
    accent-color:#555;
    transform:scale(1.2);
}

    </style>
    </head>
<body>


			
			

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
                    <img src="/posco/css/tabBar/search-icon.png" alt="select" class="button-image">조회
                </button>
                <div class="trend-radio-group">
			    <label><input type="radio" name="trendMode" value="HIST" checked> 히스토리컬</label>
			    <label><input type="radio" name="trendMode" value="REAL"> 실시간</label>
			    <label><input type="radio" name="trendMode" value="PATTERN"> 패턴 트렌드</label>
			    <div class="trend-option">
				    <label>
				        <input type="checkbox" id="toggleMarker">
				        포인트 표시
				    </label>
				</div>
			    
			</div>
			</div>
			<div id="container" style="width: 100%; height: 600px; margin-top:100px;"></div>

<script>
/* ===============================
   공통 변수
================================ */
let chart = null;
let timer = null;
let currentMode = "HIST";
let markerEnabled = false;

/* ===============================
   날짜 유틸
================================ */
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

/* ===============================
   차트 생성
================================ */
function createChart(series){
    chart = Highcharts.chart("container",{
        chart:{
            type:"line",
            zoomType:"x",
            panning:true,
            panKey:"shift"
        },
        title:{ text:"온도 트렌드" },

        plotOptions:{
            series:{
                marker:{
                    enabled: markerEnabled
                },
                states:{
                    hover:{
                        lineWidthPlus:0
                    }
                }
            }
        },

        xAxis:{
            type:"datetime",
            labels:{
                formatter:function(){
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
            xDateFormat:"%Y-%m-%d %H:%M"
        },

        exporting:{
            enabled:true,
            buttons:{
                contextButton:{
                    menuItems:["downloadPNG","downloadCSV"]
                }
            }
        },

        series: series
    });
}

/* ===============================
   차트 Clear
================================ */
function clearChart(){
    if(!chart) return;
    while(chart.series.length){
        chart.series[0].remove(false);
    }
    chart.redraw();
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
   히스토리컬 트렌드
================================ */
function loadHistory(){
    stopTimer();
    currentMode = "HIST";

    $.post("/posco/monitoring/trend/list",{
        startDate:$("#startDate").val(),
        endDate:$("#endDate").val()
    },function(result){

        if(!result || result.length === 0){
            clearChart();
            return;
        }

        const categories = result.map(r => new Date(r.tdatetime).getTime());

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

        chart ? chart.update({series}) : createChart(series);
    });
}

/* ===============================
   실시간 트렌드
================================ */
function startRealtime(){
    stopTimer();
    currentMode = "REAL";

    loadRealtime();
    timer = setInterval(loadRealtime, 5000);
}

function loadRealtime(){
    $.post("/posco/monitoring/trend/realtime",function(result){

        if(!result || result.length === 0){
            clearChart();
            return;
        }

        const categories = result.map(r => new Date(r.tdatetime).getTime());

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

        chart ? chart.update({series}) : createChart(series);
    });
}

/* ===============================
   패턴 트렌드
================================ */
function startPattern(){
    stopTimer();
    currentMode = "PATTERN";

    loadPatternCurrent();
    timer = setInterval(loadPatternCurrent, 5000);
}

function loadPatternCurrent(){
    $.post("/posco/monitoring/trend/pattern/current",function(resp){

        if(!resp || resp.running !== true){
            clearChart();
            return;
        }

        $.post("/posco/monitoring/trend/pattern",{patternNo:resp.patternNo},function(result){

            if(!result || result.length === 0){
                clearChart();
                return;
            }

            const categories = result.map(r => new Date(r.tdatetime).getTime());

            const series = [
                { name:'1존온도 PV', data: result.map((r,i)=>[categories[i],+r.vac1_pv]) },
                { name:'2존온도 PV', data: result.map((r,i)=>[categories[i],+r.vac2_pv]) },
                { name:'3존온도 PV', data: result.map((r,i)=>[categories[i],+r.vac3_pv]) },
                { name:'온도 SP', data: result.map((r,i)=>[categories[i],+r.tem_sp]) },
                { name:'온도 TSP', data: result.map((r,i)=>[categories[i],+r.tem_tsp]) }
            ];

            chart ? chart.update({series}) : createChart(series);
        });
    });
}

/* ===============================
   이벤트
================================ */
$("#btnSearch").on("click",function(){
    if(currentMode === "HIST") loadHistory();
});

$("input[name='trendMode']").on("change",function(){
    const v = $(this).val();
    if(v==="HIST") loadHistory();
    if(v==="REAL") startRealtime();
    if(v==="PATTERN") startPattern();
});

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
    $("#startDate").val(before1Hour());
    $("#endDate").val(now());
    loadHistory();
});
</script>

</body>
</html>