<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>알람</title>
<%@include file="../include/pluginpage.jsp"%>
<jsp:include page="../include/tabBar.jsp" />
<link rel="stylesheet" href="/geomet/css/monitoring/alarm.css">
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
	font-size: 13px;
	padding: 2px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	box-sizing: border-box;
	border: 1px solid #ccc; /* 경계 확인용 */
	height: 28px; /* 고정 높이로 정렬 유지 */
}
</style>
<body>

	<!-- <main class="main">
	<div class="alarm-big-box-1"></div>
    <div class="alarm-1">소입로 1존 FAN 이상</div>
    <div class="alarm-2">소입로 2존 FAN 이상</div>
    <div class="alarm-3">소입로 3존 FAN 이상</div>
    <div class="alarm-4">소입로 4존 FAN 이상</div>
    <div class="alarm-5">유조냉각 펌프#1 이상</div>
    <div class="alarm-6">유조냉각 펌프#2 이상</div>
    <div class="alarm-7">유조제트펌프 이상</div>
    <div class="alarm-8">유조콘베어 건조블로워 이상</div>
    <div class="alarm-9">소려로 1존 FAN 이상</div>
    <div class="alarm-10">소려로 2존 FAN 이상</div>
    <div class="alarm-11">소려로 3존 FAN 이상</div>
    <div class="alarm-12">소려로 4존 FAN 이상</div>
    <div class="alarm-13">소려로 5존 FAN 이상</div>
    <div class="alarm-14">소입로 1존 온도이상</div>
    <div class="alarm-15">소입로 2존 온도이상</div>
    <div class="alarm-16">소입로 3존 온도이상</div>
    <div class="alarm-17">소입로 4존 온도이상</div>
    <div class="alarm-18">소입로 5존 온도이상</div>
    <div class="alarm-19">중간세정기 온도이상</div>
    <div class="alarm-20">전세정기 온도이상</div>
    <div class="alarm-21">소입유조 온도이상</div>
    <div class="alarm-22">소려로 1존 온도이상</div>
    <div class="alarm-23">소려로 2존 온도이상</div>
    <div class="alarm-24">소려로 3존 온도이상</div>
    <div class="alarm-25">소려로 4존 온도이상</div>
    <div class="alarm-26">소려로 5존 온도이상</div>
    <div class="alarm-27">냉각조 온도이상</div>
    <div class="alarm-28">소입로 1존 SCR 이상</div>
    <div class="alarm-29">소입로 2존 SCR 이상</div>
    <div class="alarm-30">소입로 3존 SCR 이상</div>
    <div class="alarm-31">소입로 4존 SCR 이상</div>
    <div class="alarm-32">소입로 5존 SCR 이상</div>
    <div class="alarm-33">전세정기 인버터 이상</div>
    <div class="alarm-34">소입로 인버터 이상</div>
    <div class="alarm-35">아지테이터 인버터 이상</div>
    <div class="alarm-36">소입유조 인버터 이상</div>
    <div class="alarm-37">중간세정기 인버터 이상</div>
    <div class="alarm-38">소려로 인버터 이상</div>
    <div class="alarm-39">전세정기 스프레이펌프 이상</div>
    <div class="alarm-40">전세정기 FAN 이상</div>
    <div class="alarm-41">전세정기 오일스키머 이상</div>
    <div class="alarm-42">중간세정기 스프레이펌프 이상</div>
    <div class="alarm-43">중간세정기 FAN 이상</div>
    <div class="alarm-44">중간세정기 유수분리기 이상</div>
    <div class="alarm-45">냉각조 순환펌프 이상</div>
    <div class="alarm-46">냉각조 콘베이어 이상</div>
    <div class="alarm-47">소입로 처리품 과다</div>
    <div class="alarm-48">소려로 처리품 과다</div>
    <div class="alarm-49">전세정기 액면이상</div>
    <div class="alarm-50">중간세정기 액면이상</div>
    <div class="alarm-51">소입로 구동 이상</div>
    <div class="alarm-52">AIR 압력 이상</div>
    <div class="alarm-53">LPG 압력 이상</div>
    <div class="alarm-54">소입유조 액면이상</div>
    <div class="alarm-55">소입유조 액면 하한</div>
    <div class="alarm-56">냉각조 액면이상</div>
    <div class="alarm-57">CP 콘트롤 이상</div>
    <div class="alarm-58">소입로 CP 측정온도 도달,펌프기동요청</div>
    <div class="alarm-59">중간세정기 물보충 요청경보</div>
    <div class="alarm-60">유조 온도 상한, 냉각수 동작요청</div>
    <div class="alarm-61">중간세정기 오일스키머 기동 요청</div>
    <div class="alarm-62"></div>
    <div class="alarm-63">유조 구동모터 이상</div>
    <div class="alarm-64">소려로 구동모터 이상</div>
    <div class="alarm-65"></div>
    <div class="alarm-66">중간세정기 구동 콘베어 이상</div>
    <div class="alarm-67">방청조 구동 콘베어 이상</div>
    <div class="alarm-68">소입유조 냉각수 점검필요, 온도이상</div>
    <div class="alarm-69">소입유조 히터 점검필요, 온도이상</div>
    <div class="alarm-70">소려로 히터,조절계 점검필요</div>
    <div class="alarm-71">방청조 냉각수 점검필요</div>
    <div class="alarm-72">전세정기 온도조절계 점검필요</div>
    <div class="alarm-73">중간세정기 온도조절계 점검필요</div>
    <div class="alarm-74">소입로 FAN-1 동작 감지 이상</div>
    <div class="alarm-75">소입로 FAN-2 동작 감지 이상</div>
    <div class="alarm-76">소입로 FAN-3 동작 감지 이상</div>
    <div class="alarm-77">소입로 FAN-4 동작 감지 이상</div>
    <div class="alarm-78">아지테이터 동작 감지 이상</div>
    <div class="alarm-79">소려로 FAN-1 동작 감지 이상</div>
    <div class="alarm-80">소려로 FAN-2 동작 감지 이상</div>
    <div class="alarm-81">소려로 FAN-3 동작 감지 이상</div>
    <div class="alarm-82">소려로 FAN-4 동작 감지 이상</div>
    <div class="alarm-83">소려로 FAN-5 동작 감지 이상</div>
    <div class="alarm-84">전세정기 물보충 요청경보</div>
    <div class="alarm-85">소입로 구동롤러 구동요청(온도높음)</div>
    <div class="alarm-86">유조 펌프구동요청(소입로 온도높음)</div>
    <div class="alarm-87">내부전지 전압</div>
    <div class="alarm-88"></div>
    <div class="alarm-89"></div>
    <div class="alarm-90"></div>
    <div class="alarm-91"></div>
    <div class="alarm-92"></div>
    <div class="bcf-1">열처리 1호기</div>
	</main> -->


	<script>

	

	//로드
	/* $(function(){
		$(".headerP").text("조건관리 - 일상점검일지");
	}); */

	//로드
	$(function(){
		getAlarm1();
		
	});
	


	/* //OPC값 알람 조회
    function getAlarm1(){
		$.ajax({
			url:"/tkheat/monitoring/getAlarm1",
			type:"post",
			dataType:"json",
			success:function(result){				
				var data = result.multiValues;
				
	            for(let key in data){
	            	for(let keys in data[key]){
	            		var d = data[key];
						
						if(d[keys].action == "c"){
							c(keys, d[keys].value)	
						}
	            	}                    	
	            }
			}
		});
	}
	
	function c(keys, value){
//		$("."+keys).text(value);
		
		if(value == true){
			$("."+keys).css("background-color","red");
			$("."+keys).css("color","white");
		}else{
			$("."+keys).css("background-color","#f1f1f1");
			$("."+keys).css("color","black");
		}
		
	} */

	

	

    </script>

</body>
</html>
