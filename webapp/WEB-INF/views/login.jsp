<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/mibogear/css/login/style.css">
  <%@include file="include/pluginpage.jsp" %>
  
  <style>
   a,
   button,
   input,
   select,
   h1,
   h2,
   h3,
   h4,
   h5,
   * {
       box-sizing: border-box;
       margin: 0;
       padding: 0;
       border: none;
       text-decoration: none;
       background: none;
   
       -webkit-font-smoothing: antialiased;
   } 
   
   menu, ol, ul {
       list-style-type: none;
       margin: 0;
       padding: 0;
   }
   html, body {
    height: 100%;        
    margin: 0;            
    padding: 0;           
    overflow: hidden;     
}
.background-1 {
    opacity: 0.5;
    width: 1917px;
    height: 953px;
    position: absolute;
    left: 1px;
    top: 0px;
    object-fit: cover;
}
.text-1{
    color: #ffffff;
    text-align: left;
    font-family: "Inter-Regular", sans-serif;
    font-size: 24px;
    font-weight: 400;
    position: absolute;
    left: 310px;
    top: 546px;
    width: 531px;
    height: 36px;
}
.text-2{
    color: #ffffff;
    text-align: left;
    font-family: "Inter-Regular", sans-serif;
    font-size: 17px;
    font-weight: 400;
    position: absolute;
    left: 14px;
    top: 897px;
    width: 531px;
    height: 36px;
}
.text-4{
    color: #f3f3f3;
    text-align: left;
    font-family: "Inter-Bold", sans-serif;
    font-size: 26px;
    font-weight: 700;
    position: absolute;
    left: 1341px;
    top: 285px;
}
   </style>
  <title>Document</title>
</head>
<body>
  <div class="group-1">
    <div class="main"></div>
    <img class="background-1" src="/mibogear/css/login/mibo_background.png" />
    <div class="login-box"></div>
    
    
    
    
    <div class="id-input"></div>
    <div class="pw-input"></div>
    <div class="text-1">이 사이트는 미보기아 임직원 전용입니다.</div>
    <div class="text-2">주소 전라북도 완주군 봉동읍 테크노밸리 3로 15</div>
    <form id="userForm" autocomplete="off">
    	<input type="text" id="n_id" name="user_id" placeholder="아이디를 입력하세요."  />
    	<input type="password" id="n_pw" name="user_pw" placeholder="비밀번호를 입력하세요." />
    </form>
    
    <button class="login_btn" onclick="login();">로그인</button>
    <div class="text-5">아이디</div>
    <div class="text-6">패스워드</div>
    <img class="logo" src="/mibogear/css/login/miboLogo1.png" style="width: 320px;">
<!--     <img class="logo" src="/chunil/css/login/logo0.svg" /> -->
    <div class="text-4">미보기아 로그인</div>
    <div class="text-3">
      Copyright 2025. EZAutomation Co. All rights reserved.
    </div>
  </div>
  
  <script>

//이벤트
$("*").on("keydown",function(e){
	//엔터키가 눌렸을 때
	if(e.keyCode == 13){
		login();
	}
});
  
/* //함수
function login(){
	var userData = new FormData($("#userForm")[0]);
	$.ajax({
		url:"/chunil/user/login/check",
		type:"post",
		contentType: false,
		processData: false,
		dataType: "json",
		data:userData,
		success:function(result){
//			console.log(result);
			location.href = "/chunil/jinhapchunil";
			
//			var pageData = result.loginUserPage;
		}
	});
}
 */




function login() {
    var userData = new FormData($("#userForm")[0]);
    $.ajax({
        url: "/mibogear/user/login/check",
        type: "post",
        contentType: false,
        processData: false,
        dataType: "json",
        data: userData,
        success: function(result) {
            console.log(result); 

            if (result.data && result.data.user_id) {

                location.href = "/mibogear/main";  

            } else {
            	 console.log(userData); 
                alert("로그인 실패! 사용자 정보가 잘못되었습니다.");
            }
        },
        error: function(xhr, status, error) {
            alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
            console.log(error); 
        }
    });
}

//모달

//

  </script>
</body>
</html>