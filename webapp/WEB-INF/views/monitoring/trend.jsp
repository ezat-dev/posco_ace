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
                <button class="insert-button">
                    <img src="/posco/css/tabBar/add-outline.png" alt="insert" class="button-image">추가
                </button>
                
			</div>
			<div id="container" style="width: 100%; height: 600px; margin-top:100px;"></div>

<script>

// ---------------------------
// 날짜 유틸 함수 (시:분:초 자동 포함)
// ---------------------------
function paddingZero(n) {
    return n < 10 ? "0" + n : n;
}

function trendToday() {
    const d = new Date();
    return d.getFullYear()
        + "-" + paddingZero(d.getMonth() + 1)
        + "-" + paddingZero(d.getDate())
        + " " + paddingZero(d.getHours())
        + ":" + paddingZero(d.getMinutes());
}

function trendYester() {
    const d = new Date();
    d.setDate(d.getDate() - 1);
    return d.getFullYear()
        + "-" + paddingZero(d.getMonth() + 1)
        + "-" + paddingZero(d.getDate())
        + " " + paddingZero(d.getHours())
        + ":" + paddingZero(d.getMinutes());
}



// ---------------------------
// 변수 선언
// ---------------------------
let categories;
let vac1_pv, vac2_pv, vac3_pv, protec_pv, tem_sp;
let tem_1, tem_2, tem_3, tem_4, tem_5, tem_6;
let tem_7, tem_8, tem_9, tem_10, tem_11, tem_12;

let chart;
let trendInterval;

// ---------------------------
// 최초 로딩
// ---------------------------
$(document).ready(function () {
    $("#startDate").val(trendYester());
    $("#endDate").val(trendToday());
    fetchData();
});

// 조회 버튼
$(".select-button").on("click", fetchData);

// 자동 갱신용 시간 설정
function trendIntervalFunc() {
    $("#startDate").val(yesterDate());
    $("#endDate").val(todayDate());
    fetchData();
}

// ---------------------------
// 데이터 조회 AJAX
// ---------------------------
function fetchData() {

    $.ajax({
        type: "POST",
        url: "/posco/monitoring/trend/list",
        data: {  
            startDate: $("#startDate").val(),
            endDate: $("#endDate").val()
        },
        success: function (result) {

            if(result.length > 0 ){

                categories = result.map(r => new Date(r.tdatetime).getTime());

                vac1_pv = result.map(r => Number(r.vac1_pv));
                vac2_pv = result.map(r => Number(r.vac2_pv));
                vac3_pv = result.map(r => Number(r.vac3_pv));
                protec_pv = result.map(r => Number(r.protec_pv));
                tem_sp = result.map(r => Number(r.tem_sp));

                tem_1 = result.map(r => Number(r.tem_1));
                tem_2 = result.map(r => Number(r.tem_2));
                tem_3 = result.map(r => Number(r.tem_3));
                tem_4 = result.map(r => Number(r.tem_4));
                tem_5 = result.map(r => Number(r.tem_5));
                tem_6 = result.map(r => Number(r.tem_6));
                tem_7 = result.map(r => Number(r.tem_7));
                tem_8 = result.map(r => Number(r.tem_8));
                tem_9 = result.map(r => Number(r.tem_9));
                tem_10 = result.map(r => Number(r.tem_10));
                tem_11 = result.map(r => Number(r.tem_11));
                tem_12 = result.map(r => Number(r.tem_12));

                if(!chart){
                    createTrendChart();
                } else {
                    chart.update({
                        xAxis: { categories: categories },
                        series: [
                            { name: '1존온도 PV', data: vac1_pv },
                            { name: '2존온도 PV', data: vac2_pv },
                            { name: '3존온도 PV', data: vac3_pv },
                            { name: '프로텍터온도 PV', data: protec_pv },
                            { name: '온도 SP', data: tem_sp },
                            { name: '온도분포1', data: tem_1 },
                            { name: '온도분포2', data: tem_2 },
                            { name: '온도분포3', data: tem_3 },
                            { name: '온도분포4', data: tem_4 },
                            { name: '온도분포5', data: tem_5 },
                            { name: '온도분포6', data: tem_6 },
                            { name: '온도분포7', data: tem_7 },
                            { name: '온도분포8', data: tem_8 },
                            { name: '온도분포9', data: tem_9 },
                            { name: '온도분포10', data: tem_10 },
                            { name: '온도분포11', data: tem_11 },
                            { name: '온도분포12', data: tem_12 }
                        ]
                    });
                }
            }
        },
        error: function () {
            alert("데이터 조회 중 오류가 발생했습니다.");
        }
    });
}

// ---------------------------
// HighCharts 생성
// ---------------------------
function createTrendChart(){
    chart = Highcharts.chart('container', {
        chart: { type: 'line' },
        title: { text: '온도 트렌드' },

        xAxis: {
            type: 'datetime',
            categories: categories,
            labels: {
                formatter: function(){
                    return Highcharts.dateFormat(this.value);
                },
                step: 1,
            }
        },

        yAxis: {
            title: { text: "온도",rotation:360 },
            labels:{align:"left",x:10},
            min: 0,
            max: 1200
        },

        tooltip: { shared: true, crosshairs: true },

        series: [
            { name: '1존온도 PV', data: vac1_pv },
            { name: '2존온도 PV', data: vac2_pv },
            { name: '3존온도 PV', data: vac3_pv },
            { name: '프로텍터온도 PV', data: protec_pv },
            { name: '온도 SP', data: tem_sp },
            { name: '온도분포1', data: tem_1 },
            { name: '온도분포2', data: tem_2 },
            { name: '온도분포3', data: tem_3 },
            { name: '온도분포4', data: tem_4 },
            { name: '온도분포5', data: tem_5 },
            { name: '온도분포6', data: tem_6 },
            { name: '온도분포7', data: tem_7 },
            { name: '온도분포8', data: tem_8 },
            { name: '온도분포9', data: tem_9 },
            { name: '온도분포10', data: tem_10 },
            { name: '온도분포11', data: tem_11 },
            { name: '온도분포12', data: tem_12 }
        ]
    });
}

</script>


</body>
</html>