<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>알람</title>
<link rel="stylesheet" href="/posco/css/login/style.css">
     <link rel="stylesheet" href="/posco/css/tabBar/tabBar.css">
     <link rel="stylesheet" href="/posco/css/overview/style.css">
     <%@include file="../include/pluginpage.jsp" %>
<link rel="stylesheet" href="/posco/css/alarm/alarm.css">
<style>
.main {
	width: 98%;
}

.container {
	display: flex;
	justify-content: space-between;
}

div {
	display: flex;
	align-items: center;
	justify-content: center;
	text-align: center;
	font-size: 20px;
	padding: 2px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	box-sizing: border-box;
	border: 1px solid #ccc; /* 경계 확인용 */
	height: 28px; /* 고정 높이로 정렬 유지 */
}

/* 알람 ON 상태 */
.active-alarm {
    background-color: red !important;
    color: yellow !important;
    font-weight: bold;
}

</style>
<body>

	
  <div class="alarm-big-box"></div>
  <div class="vacuum">알람 실시간 현황</div>
  <div class="alarm-1">1존 온도과열</div>
  <div class="alarm-2">1존 온도저하</div>
  <div class="alarm-3">2존 온도과열</div>
  <div class="alarm-4">2존 온도저하</div>
  <div class="alarm-5">3존 온도과열</div>
  <div class="alarm-6">3존 온도저하</div>
  <div class="alarm-7">프로텍터 온도과열</div>
  <div class="alarm-8">1존 SCR이상</div>
  <div class="alarm-9">2존 SCR이상</div>
  <div class="alarm-10">3존 SCR이상</div>
  <div class="alarm-11">러핑 펌프 TRIP</div>
  <div class="alarm-12">부스터 펌프 TRIP</div>
  <div class="alarm-13">DP 펌프 TRIP</div>
  <div class="alarm-14">쿨링팬 TRIP</div>
  <div class="alarm-15">Water in Electorde1</div>
  <div class="alarm-16">Water in Electorde2</div>
  <div class="alarm-17" style="font-size:17px;">Water in Diffusion Pump</div>
  <div class="alarm-18">Water in Electorde3</div>
  <div class="alarm-19">AIR 압력 이상</div>
  <div class="alarm-20">GAS 압력 이상</div>
  <div class="alarm-21">DP 펌프 과열</div>
  <div class="alarm-22">온도분포1 TC 단선</div>
  <div class="alarm-23">온도분포2 TC 단선</div>
  <div class="alarm-24">온도분포3 TC 단선</div>
  <div class="alarm-25">온도분포4 TC 단선</div>
  <div class="alarm-26">온도분포5 TC 단선</div>
  <div class="alarm-27">온도분포6 TC 단선</div>
  <div class="alarm-28">온도분포7 TC 단선</div>
  <div class="alarm-29">온도분포8 TC 단선</div>
  <div class="alarm-30">온도분포9 TC 단선</div>
  <div class="alarm-31">배기팬 TRIP</div>
  <div class="alarm-32">양압 수치 초과</div>





	<script>

	//OPC///////////////////////////////////////////////////////////////////////

	


	function c(key, value){
    const els = document.getElementsByClassName(key);
    if(!els || els.length === 0){
        return;
    }

    Array.from(els).forEach(el => {
        if(value === true || value === 1){  
            el.classList.add("active-alarm"); 
        } else {
            el.classList.remove("active-alarm");
        }
    });
}




	
	// =====================
	// OPC 값 알람 조회
	// =====================
	function alarmView() {
	    $.ajax({
	        url: "/posco/monitoring/alarmView",
	        type: "post",
	        dataType: "json",
	        success: function(result) {
	            /* console.log("✅ Ajax 응답 전체:", result); */ 

	            const data = result.multiValues;
	            /* console.log("▶ multiValues:", data); */ 

	            for(const item of data){
	                /* console.log("item:", item); */ 
	                for(const [tagName, tagData] of Object.entries(item)){
	                    /* console.log("tagName:", tagName, "tagData:", tagData);  */
	                    if(!tagName) continue;
	                    const { action, value } = tagData;

	                    switch(action){
	                        case "c": c(tagName, value); break;
	                    }
	                }
	            }
	        },
	        error: function(err) {
	            //console.error("❌ Ajax 요청 실패:", err);
	        }
	    });
	}


	$(function(){
		alarmView(); 

		alarmViewInterval = setInterval(() => {
	    	alarmView();
	     
	    }, 1000); // 1초마다 갱신

	});
	////////////////////////////////////////////////////////



		

	

	

    </script>

</body>
</html>
