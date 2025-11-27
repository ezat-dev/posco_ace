<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>침탄로작업표준</title>
    <link rel="stylesheet" href="/mibogear/css/login/style.css">
     <link rel="stylesheet" href="/mibogear/css/tabBar/tabBar.css">
     <link rel="stylesheet" href="/mibogear/css/overview/style.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
<%@include file="../include/pluginpage.jsp" %>     
    
    <style>
    
	
    </style>
    
    
    <body>
    
   
    
    
    <main class="main">
		<div class="group-5">
    <div class="group-2">
      <img class="rail" src="/mibogear/image/overview/rail0.png" />
      <img class="rail2" src="/mibogear/image/overview/rail1.png" />
      <img class="rail3" src="/mibogear/image/overview/rail2.png" />
      <img class="rail4" src="/mibogear/image/overview/rail3.png" />
      <img class="rail5" src="/mibogear/image/overview/rail4.png" />
      <img class="rail6" src="/mibogear/image/overview/rail5.png" />
      <img class="rail7" src="/mibogear/image/overview/rail6.png" />
      <img class="rail8" src="/mibogear/image/overview/rail7.png" />
      <img class="rail9" src="/mibogear/image/overview/rail8.png" />
      <img class="rail10" src="/mibogear/image/overview/rail9.png" />
      <img class="rail11" src="/mibogear/image/overview/rail10.png" />
      <img class="rail12" src="/mibogear/image/overview/rail11.png" />
      <img class="rail13" src="/mibogear/image/overview/rail12.png" />
      <img class="rail14" src="/mibogear/image/overview/rail13.png" />
      <img class="rail15" src="/mibogear/image/overview/rail14.png" />
      <img class="rail16" src="/mibogear/image/overview/rail15.png" />
      <img class="rail17" src="/mibogear/image/overview/rail16.png" />
      <img class="rail18" src="/mibogear/image/overview/rail17.png" />
      <img class="rail19" src="/mibogear/image/overview/rail18.png" />
      <img class="rail20" src="/mibogear/image/overview/rail19.png" />
      <img class="rail21" src="/mibogear/image/overview/rail20.png" />
      <img class="rail22" src="/mibogear/image/overview/rail21.png" />
      <img class="rail23" src="/mibogear/image/overview/rail22.png" />
      <img class="rail24" src="/mibogear/image/overview/rail23.png" />
      <img class="rail25" src="/mibogear/image/overview/rail24.png" />
      <img class="rail26" src="/mibogear/image/overview/rail25.png" />
      <img class="obj-1" src="/mibogear/image/overview/obj-10.png" />
      <img class="obj-2" src="/mibogear/image/overview/obj-20.png" />
      <img class="obj-3" src="/mibogear/image/overview/obj-30.png" />
      <img class="obj-4" src="/mibogear/image/overview/obj-40.png" />
      <img class="obj-5" src="/mibogear/image/overview/obj-50.png" />
      <img class="obj-6" src="/mibogear/image/overview/obj-60.png" />
      <img class="obj-7" src="/mibogear/image/overview/obj-70.png" />
      <img class="obj-8" src="/mibogear/image/overview/obj-80.png" />
      <img class="obj-9" src="/mibogear/image/overview/obj-90.png" />
      <img class="obj-10" src="/mibogear/image/overview/obj-100.png" />
      <img class="obj-11" src="/mibogear/image/overview/obj-110.png" />
      <img class="obj-12" src="/mibogear/image/overview/obj-120.png" />
      <img class="obj-13" src="/mibogear/image/overview/obj-130.png" />
      <img class="obj-14" src="/mibogear/image/overview/obj-140.png" />
      <img class="obj-15" src="/mibogear/image/overview/obj-150.png" />
      <img class="obj-16" src="/mibogear/image/overview/obj-160.png" />
      <img class="obj-17" src="/mibogear/image/overview/obj-170.png" />
      <img class="obj-18" src="/mibogear/image/overview/obj-180.png" />
      <img class="obj-19" src="/mibogear/image/overview/obj-190.png" />
      <img class="obj-20" src="/mibogear/image/overview/obj-200.png" />
      <img class="obj-21" src="/mibogear/image/overview/obj-210.png" />
      <img class="obj-22" src="/mibogear/image/overview/obj-220.png" />
      <img class="obj-23" src="/mibogear/image/overview/obj-230.png" />
      <img class="obj-24" src="/mibogear/image/overview/obj-240.png" />
      <img class="obj-25" src="/mibogear/image/overview/obj-250.png" />
      <img class="obj-26" src="/mibogear/image/overview/obj-260.png" />
      <img class="obj-27" src="/mibogear/image/overview/obj-270.png" />
      <img class="cart-1" src="/mibogear/image/overview/cart-10.png" />
      <img class="cart-2" src="/mibogear/image/overview/cart-20.png" />
      <img class="cart-3" src="/mibogear/image/overview/cart-30.png" />
      <img class="cart-4" src="/mibogear/image/overview/cart-40.png" />
      <img class="cart-5" src="/mibogear/image/overview/cart-50.png" />
      <img class="cart-6" src="/mibogear/image/overview/cart-60.png" />
      <img class="cart-7" src="/mibogear/image/overview/cart-70.png" />
      <img class="cart-8" src="/mibogear/image/overview/cart-80.png" />
      <img class="cart-9" src="/mibogear/image/overview/cart-90.png" />
      <img class="cart-10" src="/mibogear/image/overview/cart-100.png" />
      <img class="cart-11" src="/mibogear/image/overview/cart-110.png" />
      <img class="cart-12" src="/mibogear/image/overview/cart-120.png" />
      <img class="cart-13" src="/mibogear/image/overview/cart-130.png" />
      <img class="cart-14" src="/mibogear/image/overview/cart-140.png" />
      <img class="cart-15" src="/mibogear/image/overview/cart-150.png" />
      <img class="cart-16" src="/mibogear/image/overview/cart-160.png" />
      <img class="cart-17" src="/mibogear/image/overview/cart-170.png" />
      <img class="cart-18" src="/mibogear/image/overview/cart-180.png" />
      <img class="cart-19" src="/mibogear/image/overview/cart-190.png" />
      <img class="cart-20" src="/mibogear/image/overview/cart-200.png" />
      <img class="cart-21" src="/mibogear/image/overview/cart-210.png" />
      <img class="tong-1" src="/mibogear/image/overview/tong-10.png" />
      <img class="tong-2" src="/mibogear/image/overview/tong-20.png" />
      <img class="tong-3" src="/mibogear/image/overview/tong-30.png" />
      <img class="tong-4" src="/mibogear/image/overview/tong-40.png" />
      <img class="tong-5" src="/mibogear/image/overview/tong-50.png" />
      <img class="tong-6" src="/mibogear/image/overview/tong-60.png" />
      <img class="tong-7" src="/mibogear/image/overview/tong-70.png" />
      <img class="tong-8" src="/mibogear/image/overview/tong-80.png" />
      <img class="tong-9" src="/mibogear/image/overview/tong-90.png" />
      <img class="tong-10" src="/mibogear/image/overview/tong-100.png" />
      <img class="tong-11" src="/mibogear/image/overview/tong-110.png" />
      <img class="tong-12" src="/mibogear/image/overview/tong-120.png" />
      <img class="tong-13" src="/mibogear/image/overview/tong-130.png" />
      <img class="tong-14" src="/mibogear/image/overview/tong-140.png" />
      <img class="tong-15" src="/mibogear/image/overview/tong-150.png" />
      <img class="tong-16" src="/mibogear/image/overview/tong-160.png" />
      <img class="tong-17" src="/mibogear/image/overview/tong-170.png" />
      <img class="tong-18" src="/mibogear/image/overview/tong-180.png" />
      <img class="tong-19" src="/mibogear/image/overview/tong-190.png" />
      <img class="tong-20" src="/mibogear/image/overview/tong-200.png" />
      <img class="tong-21" src="/mibogear/image/overview/tong-210.png" />
      <img class="tong-22" src="/mibogear/image/overview/tong-220.png" />
      <img class="tong-23" src="/mibogear/image/overview/tong-230.png" />
      <img class="tong-24" src="/mibogear/image/overview/tong-240.png" />
      <img class="tong-25" src="/mibogear/image/overview/tong-250.png" />
      <img class="tong-26" src="/mibogear/image/overview/tong-260.png" />
      <img class="tong-27" src="/mibogear/image/overview/tong-270.png" />
      <img class="tong-28" src="/mibogear/image/overview/tong-280.png" />
      <img class="tong-29" src="/mibogear/image/overview/tong-290.png" />
      <img class="tong-30" src="/mibogear/image/overview/tong-300.png" />
      <img class="tong-31" src="/mibogear/image/overview/tong-310.png" />
      <img class="tong-32" src="/mibogear/image/overview/tong-320.png" />
      <img class="tong-33" src="/mibogear/image/overview/tong-330.png" />
      <img class="tong-34" src="/mibogear/image/overview/tong-340.png" />
      <img class="tong-35" src="/mibogear/image/overview/tong-350.png" />
      <img class="tong-36" src="/mibogear/image/overview/tong-360.png" />
      <img class="tong-37" src="/mibogear/image/overview/tong-370.png" />
      <img class="tong-38" src="/mibogear/image/overview/tong-380.png" />
      <img class="tong-39" src="/mibogear/image/overview/tong-390.png" />
      <img class="tong-40" src="/mibogear/image/overview/tong-400.png" />
      <img class="tong-41" src="/mibogear/image/overview/tong-410.png" />
      <img class="tong-42" src="/mibogear/image/overview/tong-420.png" />
      <img class="tong-43" src="/mibogear/image/overview/tong-430.png" />
      <img class="tong-44" src="/mibogear/image/overview/tong-440.png" />
      <img class="tong-45" src="/mibogear/image/overview/tong-450.png" />
      <img class="tong-46" src="/mibogear/image/overview/tong-460.png" />
      <img class="tong-47" src="/mibogear/image/overview/tong-470.png" />
      <img class="tong-48" src="/mibogear/image/overview/tong-480.png" />
      <img class="tong-49" src="/mibogear/image/overview/tong-490.png" />
      <img class="tong-50" src="/mibogear/image/overview/tong-500.png" />
      <img class="tong-51" src="/mibogear/image/overview/tong-510.png" />
      <img class="tong-52" src="/mibogear/image/overview/tong-520.png" />
      <img class="tong-53" src="/mibogear/image/overview/tong-530.png" />
      <img class="tong-54" src="/mibogear/image/overview/tong-540.png" />
      <img class="tong-55" src="/mibogear/image/overview/tong-550.png" />
      <img class="tong-56" src="/mibogear/image/overview/tong-560.png" />
      <img class="tong-57" src="/mibogear/image/overview/tong-570.png" />
      <img class="tong-58" src="/mibogear/image/overview/tong-580.png" />
      <img class="tong-59" src="/mibogear/image/overview/tong-590.png" />
      <img class="tong-60" src="/mibogear/image/overview/tong-600.png" />
      <img class="tong-61" src="/mibogear/image/overview/tong-610.png" />
      <img class="tong-62" src="/mibogear/image/overview/tong-620.png" />
      <img class="tong-63" src="/mibogear/image/overview/tong-630.png" />
      <img class="tong-64" src="/mibogear/image/overview/tong-640.png" />
      <img class="tong-65" src="/mibogear/image/overview/tong-650.png" />
      <img class="door-1" src="/mibogear/image/overview/door-10.png" />
      <img class="door-2" src="/mibogear/image/overview/door-20.png" />
      <img class="door-3" src="/mibogear/image/overview/door-30.png" />
      <img class="door-4" src="/mibogear/image/overview/door-40.png" />
      <img class="nobody-pen-1" src="/mibogear/image/overview/nobody-pen-10.png" />
      <img class="body-pen-1" src="/mibogear/image/overview/body-pen-10.png" />
      <img class="offpen-1" src="/mibogear/image/overview/offpen-10.png" />
      <img class="onpen-1" src="/mibogear/image/overview/onpen-10.png" />
      <img class="nobody-pen-2" src="/mibogear/image/overview/nobody-pen-20.png" />
      <img class="body-pen-2" src="/mibogear/image/overview/body-pen-20.png" />
      <img class="offpen-2" src="/mibogear/image/overview/offpen-20.png" />
      <img class="onpen-2" src="/mibogear/image/overview/onpen-20.png" />
      <img class="nobody-pen-3" src="/mibogear/image/overview/nobody-pen-30.png" />
      <img class="body-pen-3" src="/mibogear/image/overview/body-pen-30.png" />
      <img class="offpen-3" src="/mibogear/image/overview/offpen-30.png" />
      <img class="onpen-3" src="/mibogear/image/overview/onpen-30.png" />
      <img class="nobody-pen-4" src="/mibogear/image/overview/nobody-pen-40.png" />
      <img class="body-pen-4" src="/mibogear/image/overview/body-pen-40.png" />
      <img class="offpen-4" src="/mibogear/image/overview/offpen-40.png" />
      <img class="onpen-4" src="/mibogear/image/overview/onpen-40.png" />
      <img class="nomalpen-1" src="/mibogear/image/overview/nomalpen-10.png" />
      <img class="greenpen-1" src="/mibogear/image/overview/greenpen-10.png" />
      <img class="nomalpen-2" src="/mibogear/image/overview/nomalpen-20.png" />
      <img class="greenpen-2" src="/mibogear/image/overview/greenpen-20.png" />
      <img class="nomalpen-3" src="/mibogear/image/overview/nomalpen-30.png" />
      <img class="greenpen-3" src="/mibogear/image/overview/greenpen-30.png" />
      <img class="nomalpen-4" src="/mibogear/image/overview/nomalpen-40.png" />
      <img class="greenpen-4" src="/mibogear/image/overview/greenpen-40.png" />
      <img class="nomalpen-5" src="/mibogear/image/overview/nomalpen-50.png" />
      <img class="greenpen-6" src="/mibogear/image/overview/greenpen-60.png" />
      <img class="nomalpen-7" src="/mibogear/image/overview/nomalpen-70.png" />
      <img class="greenpen-7" src="/mibogear/image/overview/greenpen-70.png" />
      <img class="longoff-1" src="/mibogear/image/overview/longoff-10.png" />
      <img class="longon-1" src="/mibogear/image/overview/longon-10.png" />
      <img class="longoff-2" src="/mibogear/image/overview/longoff-20.png" />
      <img class="longon-2" src="/mibogear/image/overview/longon-20.png" />
      <img class="longoff-3" src="/mibogear/image/overview/longoff-30.png" />
      <img class="longon-3" src="/mibogear/image/overview/longon-30.png" />
      <img class="longoff-4" src="/mibogear/image/overview/longoff-40.png" />
      <img class="longon-4" src="/mibogear/image/overview/longon-40.png" />
      <img class="longoff-5" src="/mibogear/image/overview/longoff-50.png" />
      <img class="longon-5" src="/mibogear/image/overview/longon-50.png" />
      <img class="longoff-6" src="/mibogear/image/overview/longoff-60.png" />
      <img class="longon-6" src="/mibogear/image/overview/longon-60.png" />
      <img class="longoff-7" src="/mibogear/image/overview/longoff-70.png" />
      <img class="longon-7" src="/mibogear/image/overview/longon-70.png" />
      <img class="longoff-8" src="/mibogear/image/overview/longoff-80.png" />
      <img class="longon-8" src="/mibogear/image/overview/longon-80.png" />
      <img class="graypen-1" src="/mibogear/image/overview/graypen-10.png" />
      <img class="bluepen-1" src="/mibogear/image/overview/bluepen-10.png" />
      <img class="graypen-2" src="/mibogear/image/overview/graypen-20.png" />
      <img class="bluepen-2" src="/mibogear/image/overview/bluepen-20.png" />
      <img class="graypen-3" src="/mibogear/image/overview/graypen-30.png" />
      <img class="bluepen-3" src="/mibogear/image/overview/bluepen-30.png" />
      <img class="graypen-4" src="/mibogear/image/overview/graypen-40.png" />
      <img class="bluepen-4" src="/mibogear/image/overview/bluepen-40.png" />
      <img class="graypen-5" src="/mibogear/image/overview/graypen-50.png" />
      <img class="bluepen-5" src="/mibogear/image/overview/bluepen-50.png" />
      <img class="graypen-6" src="/mibogear/image/overview/graypen-60.png" />
      <img class="bluepen-6" src="/mibogear/image/overview/bluepen-60.png" />
      <img class="graypen-7" src="/mibogear/image/overview/graypen-70.png" />
      <img class="bluepen-7" src="/mibogear/image/overview/bluepen-70.png" />
      <img class="graypen-8" src="/mibogear/image/overview/graypen-80.png" />
      <img class="bluepen-8" src="/mibogear/image/overview/bluepen-80.png" />
      <img class="bignomal-1" src="/mibogear/image/overview/bignomal-10.png" />
      <img class="down-1" src="/mibogear/image/overview/down-10.png" />
      <img class="up-1" src="/mibogear/image/overview/up-10.png" />
      <img class="bignomal-2" src="/mibogear/image/overview/bignomal-20.png" />
      <img class="down-2" src="/mibogear/image/overview/down-20.png" />
      <img class="up-2" src="/mibogear/image/overview/up-20.png" />
      <img class="bignomal-3" src="/mibogear/image/overview/bignomal-30.png" />
      <img class="down-3" src="/mibogear/image/overview/down-30.png" />
      <img class="up-3" src="/mibogear/image/overview/up-30.png" />
      <img class="bignomal-4" src="/mibogear/image/overview/bignomal-40.png" />
      <img class="down-4" src="/mibogear/image/overview/down-40.png" />
      <img class="up-4" src="/mibogear/image/overview/up-40.png" />
      <img class="gray-box-1" src="/mibogear/image/overview/gray-box-10.png" />
      <img class="red-box-1" src="/mibogear/image/overview/red-box-10.png" />
      <img class="gray-box-2" src="/mibogear/image/overview/gray-box-20.png" />
      <img class="red-box-2" src="/mibogear/image/overview/red-box-20.png" />
      <img class="gray-box-3" src="/mibogear/image/overview/gray-box-30.png" />
      <img class="red-box-3" src="/mibogear/image/overview/red-box-30.png" />
      <img class="gray-box-4" src="/mibogear/image/overview/gray-box-40.png" />
      <img class="red-box-4" src="/mibogear/image/overview/red-box-40.png" />
      <img class="gray-box-5" src="/mibogear/image/overview/gray-box-50.png" />
      <img class="red-box-5" src="/mibogear/image/overview/red-box-50.png" />
      <img class="gray-box-6" src="/mibogear/image/overview/gray-box-60.png" />
      <img class="red-box-6" src="/mibogear/image/overview/red-box-60.png" />
      <img class="gray-box-7" src="/mibogear/image/overview/gray-box-70.png" />
      <img class="red-box-7" src="/mibogear/image/overview/red-box-70.png" />
      <img class="gray-box-8" src="/mibogear/image/overview/gray-box-80.png" />
      <img class="red-box-8" src="/mibogear/image/overview/red-box-80.png" />
      <img class="gray-box-9" src="/mibogear/image/overview/gray-box-90.png" />
      <img class="red-box-9" src="/mibogear/image/overview/red-box-90.png" />
      <img class="gray-box-10" src="/mibogear/image/overview/gray-box-100.png" />
      <img class="red-box-10" src="/mibogear/image/overview/red-box-100.png" />
      <img class="gray-box-11" src="/mibogear/image/overview/gray-box-110.png" />
      <img class="red-box-11" src="/mibogear/image/overview/red-box-110.png" />
      <img class="gray-box-12" src="/mibogear/image/overview/gray-box-120.png" />
      <img class="red-box-12" src="/mibogear/image/overview/red-box-120.png" />
      <img class="gray-box-13" src="/mibogear/image/overview/gray-box-130.png" />
      <img class="red-box-13" src="/mibogear/image/overview/red-box-130.png" />
      <img class="gray-box-14" src="/mibogear/image/overview/gray-box-140.png" />
      <img class="red-box-14" src="/mibogear/image/overview/red-box-140.png" />
      <img class="gray-box-15" src="/mibogear/image/overview/gray-box-150.png" />
      <img class="red-box-15" src="/mibogear/image/overview/red-box-150.png" />
      <img class="gray-box-16" src="/mibogear/image/overview/gray-box-160.png" />
      <img class="red-box-16" src="/mibogear/image/overview/red-box-160.png" />
      <img class="red-1" src="/mibogear/image/overview/red-10.png" />
      <img class="green-1" src="/mibogear/image/overview/green-10.png" />
      <img class="red-2" src="/mibogear/image/overview/red-20.png" />
      <img class="green-2" src="/mibogear/image/overview/green-20.png" />
      <img class="red-3" src="/mibogear/image/overview/red-30.png" />
      <img class="green-3" src="/mibogear/image/overview/green-30.png" />
      <img class="red-4" src="/mibogear/image/overview/red-40.png" />
      <img class="green-4" src="/mibogear/image/overview/green-40.png" />
      <img class="red-5" src="/mibogear/image/overview/red-50.png" />
      <img class="green-5" src="/mibogear/image/overview/green-50.png" />
      <img class="red-6" src="/mibogear/image/overview/red-60.png" />
      <img class="green-6" src="/mibogear/image/overview/green-60.png" />
      <img class="red-7" src="/mibogear/image/overview/red-70.png" />
      <img class="green-7" src="/mibogear/image/overview/green-70.png" />
      <img class="red-8" src="/mibogear/image/overview/red-80.png" />
      <img class="green-8" src="/mibogear/image/overview/green-80.png" />
      <img class="red-9" src="/mibogear/image/overview/red-90.png" />
      <img class="green-9" src="/mibogear/image/overview/green-90.png" />
      <img class="red-10" src="/mibogear/image/overview/red-100.png" />
      <img class="green-10" src="/mibogear/image/overview/green-100.png" />
      <img class="nomal-1" src="/mibogear/image/overview/nomal-10.png" />
      <img class="close-1" src="/mibogear/image/overview/close-10.png" />
      <img class="open-1" src="/mibogear/image/overview/open-10.png" />
      <img class="nomal-2" src="/mibogear/image/overview/nomal-20.png" />
      <img class="close-2" src="/mibogear/image/overview/close-20.png" />
      <img class="open-2" src="/mibogear/image/overview/open-20.png" />
      <img class="nomal-3" src="/mibogear/image/overview/nomal-30.png" />
      <img class="close-3" src="/mibogear/image/overview/close-30.png" />
      <img class="open-3" src="/mibogear/image/overview/open-30.png" />
      <img class="nomal-4" src="/mibogear/image/overview/nomal-40.png" />
      <img class="close-4" src="/mibogear/image/overview/close-40.png" />
      <img class="open-4" src="/mibogear/image/overview/open-40.png" />
      <img class="nomal-5" src="/mibogear/image/overview/nomal-50.png" />
      <img class="close-5" src="/mibogear/image/overview/close-50.png" />
      <img class="open-5" src="/mibogear/image/overview/open-50.png" />
      <img class="noaml-6" src="/mibogear/image/overview/noaml-60.png" />
      <img class="close-6" src="/mibogear/image/overview/close-60.png" />
      <img class="open-6" src="/mibogear/image/overview/open-60.png" />
      <img class="nomal-7" src="/mibogear/image/overview/nomal-70.png" />
      <img class="close-7" src="/mibogear/image/overview/close-70.png" />
      <img class="open-7" src="/mibogear/image/overview/open-70.png" />
      <img class="nomal-8" src="/mibogear/image/overview/nomal-80.png" />
      <img class="close-8" src="/mibogear/image/overview/close-80.png" />
      <img class="open-8" src="/mibogear/image/overview/open-80.png" />
      <img class="nomal-9" src="/mibogear/image/overview/nomal-90.png" />
      <img class="colse-9" src="/mibogear/image/overview/colse-90.png" />
      <img class="open-9" src="/mibogear/image/overview/open-90.png" />
      <img class="nomal-11" src="/mibogear/image/overview/nomal-110.png" />
      <img class="close-11" src="/mibogear/image/overview/close-110.png" />
      <img class="open-11" src="/mibogear/image/overview/open-110.png" />
      <img class="nomal-10" src="/mibogear/image/overview/nomal-100.png" />
      <img class="close-10" src="/mibogear/image/overview/close-100.png" />
      <img class="open-10" src="/mibogear/image/overview/open-100.png" />
      <img class="nomal-12" src="/mibogear/image/overview/nomal-120.png" />
      <img class="close-12" src="/mibogear/image/overview/close-120.png" />
      <img class="open-12" src="/mibogear/image/overview/open-120.png" />
    </div>
    <div class="group-1">
      <div class="text-box-1"></div>
      <div class="text-box-2" style="text-align:center;">온도(℃)</div>
      <div class="text-box-3" style="text-align:center;">설정값</div>
      <div class="text-box-4" style="text-align:center;">현재값</div>
      <div class="text-box-5" style="text-align:center;">침탄</div>
      <div class="text-box-6" style="text-align:center;">유조</div>
      <div class="text-box-7" style="text-align:center;">CP</div>
      <div class="text-box-8" style="text-align:center;">소려</div>
      <div class="text-box-9"></div>
      <div class="text-box-10" style="text-align:center;">온도(℃)</div>
      <div class="text-box-11" style="text-align:center;">설정값</div>
      <div class="text-box-12" style="text-align:center;">현재값</div>
      <div class="text-box-13" style="text-align:center;">침탄</div>
      <div class="text-box-14" style="text-align:center;">유조</div>
      <div class="text-box-15" style="text-align:center;">CP</div>
      <div class="text-box-16" style="text-align:center;">시간(분)</div>
      <div class="text-box-17" style="text-align:center;">설정값</div>
      <div class="text-box-18" style="text-align:center;">현재값</div>
      <div class="text-box-19" style="text-align:center;">승온</div>
      <div class="text-box-20" style="text-align:center;">침탄</div>
      <div class="text-box-21" style="text-align:center;">확산</div>
      <div class="text-box-22" style="text-align:center;">강온</div>
      <div class="text-box-23" style="text-align:center;">소입</div>
      <div class="text-box-24" style="text-align:center;">드레인</div>
      <div class="text-box-25" style="text-align:center;">시간(분)</div>
      <div class="text-box-26" style="text-align:center;">설정값</div>
      <div class="text-box-27" style="text-align:center;">현재값</div>
      <div class="text-box-28" style="text-align:center;">승온</div>
      <div class="text-box-29" style="text-align:center;">침탄</div>
      <div class="text-box-30" style="text-align:center;">확산</div>
      <div class="text-box-31" style="text-align:center;">강온</div>
      <div class="text-box-32" style="text-align:center;">소입</div>
      <div class="text-box-33" style="text-align:center;">드레인</div>
      <div class="text-box-34" style="text-align:center;">시간(분)</div>
      <div class="text-box-35" style="text-align:center;">설정값</div>
      <div class="text-box-36" style="text-align:center;">현재값</div>
      <div class="text-box-37" style="text-align:center;">1차냉각</div>
      <div class="text-box-38" style="text-align:center;">소려</div>
      <div class="text-box-39" style="text-align:center;">2차냉각</div>
      <div class="text-box-40"></div>
      <div class="text-box-41" style="text-align:center;">온도(℃)</div>
      <div class="text-box-42" style="text-align:center;">설정값</div>
      <div class="text-box-43" style="text-align:center;">현재값</div>
      <div class="text-box-44" style="text-align:center;">침탄</div>
      <div class="text-box-45" style="text-align:center;">유조</div>
      <div class="text-box-46" style="text-align:center;">CP</div>
      <div class="text-box-47" style="text-align:center;">소려</div>
      <div class="text-box-48"></div>
      <div class="text-box-49" style="text-align:center;">온도(℃)</div>
      <div class="text-box-50" style="text-align:center;">설정값</div>
      <div class="text-box-51" style="text-align:center;">현재값</div>
      <div class="text-box-52" style="text-align:center;">침탄</div>
      <div class="text-box-53" style="text-align:center;">유조</div>
      <div class="text-box-54" style="text-align:center;">CP</div>
      <div class="text-box-55" style="text-align:center;">시간(분)</div>
      <div class="text-box-56" style="text-align:center;">설정값</div>
      <div class="text-box-57" style="text-align:center;">현재값</div>
      <div class="text-box-58" style="text-align:center;">승온</div>
      <div class="text-box-59" style="text-align:center;">침탄</div>
      <div class="text-box-60" style="text-align:center;">확산</div>
      <div class="text-box-61" style="text-align:center;">강온</div>
      <div class="text-box-62" style="text-align:center;">소입</div>
      <div class="text-box-63" style="text-align:center;">드레인</div>
      <div class="text-box-64" style="text-align:center;">시간(분)</div>
      <div class="text-box-65" style="text-align:center;">설정값</div>
      <div class="text-box-66" style="text-align:center;">현재값</div>
      <div class="text-box-67" style="text-align:center;">승온</div>
      <div class="text-box-68" style="text-align:center;">침탄</div>
      <div class="text-box-69" style="text-align:center;">확산</div>
      <div class="text-box-70" style="text-align:center;">강온</div>
      <div class="text-box-71" style="text-align:center;">소입</div>
      <div class="text-box-72" style="text-align:center;">드레인</div>
      <div class="text-box-73" style="text-align:center;">시간(분)</div>
      <div class="text-box-74" style="text-align:center;">설정값</div>
      <div class="text-box-75" style="text-align:center;">현재값</div>
      <div class="text-box-76" style="text-align:center;">1차냉각</div>
      <div class="text-box-77" style="text-align:center;">소려</div>
      <div class="text-box-78" style="text-align:center;">2차냉각</div>
      <div class="pro-text-6">
        1
        <br />
        호
        <br />
        기
      </div>
      <div class="pro-text-62">
        2
        <br />
        호
        <br />
        기
      </div>
      <div class="pro-text-63">
        3
        <br />
        호
        <br />
        기
      </div>
      <div class="pro-text-64">
        4
        <br />
        호
        <br />
        기
      </div>
      <div class="bcf-1-cf-sv"></div>
      <div class="bcf-1-cf-pv"></div>
      <div class="bcf-1-oil-sv"></div>
      <div class="bcf-1-oil-pv"></div>
      <div class="bcf-1-cp-sv"></div>
      <div class="bcf-1-cp-pv"></div>
      <div class="bcf-1-tf-sv"></div>
      <div class="bcf-1-tf-pv"></div>
      <div class="bcf-2-cf-sv"></div>
      <div class="bcf-2-cf-pv"></div>
      <div class="bcf-2-oil-sv"></div>
      <div class="bcf-2-oil-pv"></div>
      <div class="bcf-2-cp-sv"></div>
      <div class="bcf-2-cp-pv"></div>
      <div class="bcf-3-cf-sv"></div>
      <div class="bcf-3-cf-pv"></div>
      <div class="bcf-3-oil-sv"></div>
      <div class="bcf-3-oil-pv"></div>
      <div class="bcf-3-cp-sv"></div>
      <div class="bcf-3-cp-pv"></div>
      <div class="bcf-3-tf-sv"></div>
      <div class="bcf-3-tf-pv"></div>
      <div class="bcf-4-cf-sv"></div>
      <div class="bcf-4-cf-pv"></div>
      <div class="bcf-4-oil-sv"></div>
      <div class="bcf-4-oil-pv"></div>
      <div class="bcf-4-cp-sv"></div>
      <div class="bcf-4-cp-pv"></div>
      <div class="bcf-1-heat-sv"></div>
      <div class="bcf-1-heat-pv"></div>
      <div class="bcf-1-chim-sv"></div>
      <div class="bcf-1-chim-pv"></div>
      <div class="bcf-1-diff-sv"></div>
      <div class="bcf-1-diff-pv"></div>
      <div class="bcf-1-gang-sv"></div>
      <div class="bcf-1-gang-pv"></div>
      <div class="bcf-1-que-sv"></div>
      <div class="bcf-1-que-pv"></div>
      <div class="bcf-1-drain-sv"></div>
      <div class="bcf-1-drain-pv"></div>
      <div class="bcf-2-heat-sv"></div>
      <div class="bcf-2-heat-pv"></div>
      <div class="bcf-2-chim-sv"></div>
      <div class="bcf-2-chim-pv"></div>
      <div class="bcf-2-diff-sv"></div>
      <div class="bcf-2-diff-pv"></div>
      <div class="bcf-2-gang-sv"></div>
      <div class="bcf-2-gang-pv"></div>
      <div class="bcf-2-que-sv"></div>
      <div class="bcf-2-que-pv"></div>
      <div class="bcf-2-drain-sv"></div>
      <div class="bcf-2-drain-pv"></div>
      <div class="bcf-3-heat-sv"></div>
      <div class="bcf-3-heat-pv"></div>
      <div class="bcf-3-chim-sv"></div>
      <div class="bcf-3-chim-pv"></div>
      <div class="bcf-3-diff-sv"></div>
      <div class="bcf-3-diff-pv"></div>
      <div class="bcf-3-gang-sv"></div>
      <div class="bcf-3-gang-pv"></div>
      <div class="bcf-3-que-sv"></div>
      <div class="bcf-3-que-pv"></div>
      <div class="bcf-3-drain-sv"></div>
      <div class="bcf-3-drain-pv"></div>
      <div class="bcf-4-heat-sv"></div>
      <div class="bcf-4-heat-pv"></div>
      <div class="bcf-4-chim-sv"></div>
      <div class="bcf-4-chim-pv"></div>
      <div class="bcf-4-diff-sv"></div>
      <div class="bcf-4-diff-pv"></div>
      <div class="bcf-4-gang-sv"></div>
      <div class="bcf-4-gang-pv"></div>
      <div class="bcf-4-que-sv"></div>
      <div class="bcf-4-que-pv"></div>
      <div class="bcf-4-drain-sv"></div>
      <div class="bcf-4-drain-pv"></div>
      <div class="bcf-1-cool-1-sv"></div>
      <div class="bcf-1-cool-1-pv"></div>
      <div class="bcf-1-tem-sv"></div>
      <div class="bcf-1-tem-pv"></div>
      <div class="bcf-1-cool-2-sv"></div>
      <div class="bcf-1-cool-2-pv"></div>
      <div class="bcf-3-cool-1-sv"></div>
      <div class="bcf-3-cool-1-pv"></div>
      <div class="bcf-3-tem-sv"></div>
      <div class="bcf-3-tem-pv"></div>
      <div class="bcf-3-cool-2-sv"></div>
      <div class="bcf-3-cool-2-pv"></div>
    </div>
  </div>
	</main>





	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
<script>

    let now_page_code = "e04";

	//전역변수
    var cutumTable;	
    var isEditMode = false; //수정,최초저장 구분값

	//로드
	$(function(){
		//전체 거래처목록 조회
		getChimStandardList();
	});

    $(function(){	
        // 파일 선택시 이미지 띄우기
      $('.imgInputClass').change(function(event){
        var selectedFile = event.target.files[0];
      var reader = new FileReader();
      
      var img = $(this).parent().parent().find('img')[0];
      img.title = selectedFile.name;
      
      reader.onload = function(event) {
        img.src = event.target.result;
      };
      
      reader.readAsDataURL(selectedFile);
      });
    });

	//이벤트
	//함수
	function getChimStandardList(){
		userTable = new Tabulator("#tab1", {
		    height:"750px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    selectableRows:true,
		    reactiveData:true,
		    headerHozAlign:"center",
		    ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/management/chimStandardInsert/getChimStandardList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{
		    	/* "corp_name": $("#corp_name").val(),
                "prod_name": $("#prod_name").val(),
                "prod_no": $("#prod_no").val(),
                "fac_name": $("#fac_name").val(), */
			    },
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		        {title:"NO", field:"idx", sorter:"int", width:80,
		        	hozAlign:"center"},
		        {title:"고객명", field:"corp_name", sorter:"string", width:120,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"품명", field:"prod_name", sorter:"string", width:220,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"도번/품번", field:"prod_no", sorter:"string", width:200,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"기종", field:"prod_kijong", sorter:"string", width:100,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"재질", field:"prod_jai", sorter:"int", width:200,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"단가", field:"prod_dang", sorter:"int", width:200,
			        hozAlign:"center", headerFilter:"input"},
			    {title:"설비", field:"fac_name", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input"},
				{title:"공정", field:"tech_te", sorter:"int", width:150,
					hozAlign:"center", headerFilter:"input"},
					{title:"", field:"wstd_code", visible:false},
					/* {title:"단취사진", field:"wstd_chim_file_name1", width:100,
						hozAlign:"center", formatter:"image",
					    cssClass:"rp-img-popup",
				      	formatterParams:{
					      	height:"30px", width:"30px",
					      	urlPrefix:"/tkPrint/사진/침탄로작업표준/"
					      	}, 
					    cellMouseEnter:function(e, cell){ productImage(cell.getValue());} 
					    },
						{title:"사진-3", field:"wstd_chim_file_name2", width:100,
							hozAlign:"center", formatter:"image",
						    cssClass:"rp-img-popup",
					      	formatterParams:{
						      	height:"30px", width:"30px",
						      	urlPrefix:"/tkPrint/사진/침탄로작업표준/"
						      	}, 
						    cellMouseEnter:function(e, cell){ productImage(cell.getValue());} 
						    }, */
		    ],
		    rowFormatter:function(row){
			    var data = row.getData();
			    
			    row.getElement().style.fontWeight = "700";
				row.getElement().style.backgroundColor = "#FFFFFF";
			},
			rowClick:function(e, row){

				$("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").each(function(index, item){
						
					if($(this).hasClass("row_select")){							
						$(this).removeClass('row_select');
						row.getElement().className += " row_select";
					}else{
						$("#tab1 div.row_select").removeClass("row_select");
						row.getElement().className += " row_select";	
					}
				});

				var rowData = row.getData();
				
			},
			rowDblClick:function(e, row){

				var data = row.getData();
				selectedRowData = data;
				isEditMode = true;
				$('#chimStandardForm')[0].reset();

/*
				Object.keys(data).forEach(function (key) {
			        const field = $('#chimStandardForm [name="' + key + '"]');

			        if (field.length) {
			            field.val(data[key]);
			        }
				});
*/


				getChimStandardDetail(data.wstd_code);
				$("#btnSaveAs").show();
				$('.delete').show();
			},
		});		
	}
	

function getChimStandardDetail(wstd_code){
	$.ajax({
		url:"/tkheat/management/chimStandardInsert/getChimStandardDetail",
		type:"post",
		dataType:"json",
		data:{
			"wstd_code":wstd_code
		},
		success:function(result){
			console.log(result);
			var allData = result.data;
			
			for(let key in allData){
//				console.log(allData, key);	
				$("[name='"+key+"']").val(allData[key]);
			}

			// 이미지 초기화
			$("#prev_previewId1, #prev_previewId3, #prev_previewId7").attr("src", "/tkheat/css/image/no_image.png");

			// 단취사진
			if (allData.wstd_chim_file_name1) {
				console.log("원본 파일명:", allData.wstd_chim_file_name1);
				console.log("인코딩된 경로:", encodeURIComponent(allData.wstd_chim_file_name1));
				const path = "/tkPrint/사진/침탄로작업표준/" + allData.wstd_chim_file_name1;
				console.log("path: ", path);
				$("#prev_previewId1").attr("src", path);
				//$(".aphoto").attr("href", path).text(d.product_file_name);
			}
			// 사진-3
			if (allData.wstd_chim_file_name2) {
				console.log("원본 파일명:", allData.wstd_chim_file_name2);
				console.log("인코딩된 경로:", encodeURIComponent(allData.wstd_chim_file_name2));
				const path = "/tkPrint/사진/침탄로작업표준/" + allData.wstd_chim_file_name2;
				console.log("path: ", path);
				$("#prev_previewId3").attr("src", path);
				$("#prev_previewId7").attr("src", path);
				//$(".aphoto").attr("href", path).text(d.product_file_name);
			}

			$('.chimStandardModal').show().addClass('show');
		}
	});
}
	
    </script>
    
    
   <script>
		
 // 드래그 기능 추가
	const modal = document.querySelector('.chimStandardModal');
	const header = document.querySelector('.header'); // 헤더를 드래그할 요소로 사용

	header.addEventListener('mousedown', function(e) {
		// transform 제거를 위한 초기 위치 설정
		const rect = modal.getBoundingClientRect();
		modal.style.left = rect.left + 'px';
		modal.style.top = rect.top + 'px';
		modal.style.transform = 'none'; // 중앙 정렬 해제

		let offsetX = e.clientX - rect.left;
		let offsetY = e.clientY - rect.top;

		function moveModal(e) {
			modal.style.left = (e.clientX - offsetX) + 'px';
			modal.style.top = (e.clientY - offsetY) + 'px';
		}

		function stopMove() {
			window.removeEventListener('mousemove', moveModal);
			window.removeEventListener('mouseup', stopMove);
		}

		window.addEventListener('mousemove', moveModal);
		window.addEventListener('mouseup', stopMove);
	});
		

	// 모달 열기
	const insertButton = document.querySelector('.insert-button');
	const chimStandardModal = document.querySelector('.chimStandardModal');
	const closeButton = document.querySelector('.close');
	const headerCloseButton = document.querySelector('.header-close');

	insertButton.addEventListener('click', function() {
		isEditMode = false;  // 추가 모드
	    $('#chimStandardForm')[0].reset(); // 폼 초기화
	    chimStandardModal.style.display = 'block'; // 모달 표시

		$('.delete').hide();
		$("#btnSaveAs").hide();
	});

	closeButton.addEventListener('click', function() {
		chimStandardModal.style.display = 'none'; // 모달 숨김
	});

	headerCloseButton.addEventListener('click', function() {
		chimStandardModal.style.display = 'none';
	});





	//제품검색버튼 리스트 모달
    function openProductListModal() {
        document.getElementById('productListModal').style.display = 'flex';

        
        let productListTable = new Tabulator("#productListTabulator", {
            height:"450px",
            layout:"fitColumns",
            selectable:true,
            ajaxURL:"/tkheat/management/productInsert/productList",
            ajaxConfig:"POST",
            ajaxParams:{
                "corp_name": "",
                "prod_code": "",
                   
            },
		    ajaxResponse:function(url, params, response){
//				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
				console.log(response);
		        return response.data; //return the response data to tabulator
		    },    
            columns:[
                {title:"NO", field:"idx", width:80, hozAlign:"center"},
                {title:"거래처", field:"corp_name", width:120, hozAlign:"center"},
                {title:"품명", field:"prod_name", width:120, hozAlign:"center",visible:false},
                {title:"품번", field:"prod_no", width:150, hozAlign:"center"},
                {title:"규격", field:"prod_gyu", width:100, hozAlign:"center"},
                {title:"재질", field:"prod_jai", width:200, hozAlign:"center"},
                {title:"공정", field:"tech_te", width:200, hozAlign:"center"},
                {title:"표면경도", field:"prod_pg", width:200, hozAlign:"center"},
                {title:"심부경도", field:"prod_sg", width:200, hozAlign:"center"},
                {title:"경화깊이", field:"prod_gd2", width:200, hozAlign:"center"},
                {title:"경화깊이1", field:"prod_gd1", width:200, hozAlign:"center"},
                {title:"경화깊이2", field:"prod_gd3", width:200, hozAlign:"center"},
            ],
            rowDblClick:function(e, row){
                let data = row.getData();
                
                document.getElementById('corp_name').value = data.corp_name;
                document.getElementById('prod_code').value = data.prod_code;
                document.getElementById('prod_danj').value = data.prod_danj;
                document.getElementById('prod_no').value = data.prod_no;
                document.getElementById('prod_name').value = data.prod_name;
                document.getElementById('prod_jai').value = data.prod_jai;
                document.getElementById('prod_dang').value = data.prod_dang;
                document.getElementById('prod_pwsno').value = data.prod_pwsno;
                document.getElementById('tech_te').value = data.tech_te;
                document.getElementById('prod_do').value = data.prod_do;
                document.getElementById('prod_refno').value = data.prod_refno;
                document.getElementById('prod_gyu').value = data.prod_gyu;
                document.getElementById('prod_kijong').value = data.prod_kijong;
                document.getElementById('prod_pg').value = data.prod_pg;
                document.getElementById('prod_sg').value = data.prod_sg;
                document.getElementById('prod_e1').value = data.prod_e1;
                document.getElementById('prod_e3').value = data.prod_e3;
                document.getElementById('prod_khecd').value = data.prod_khecd;
                document.getElementById('prod_khtcd').value = data.prod_khtcd;
                document.getElementById('prod_gd1').value = data.prod_gd1;
                document.getElementById('prod_gd2').value = data.prod_gd2;
                document.getElementById('prod_gd5').value = data.prod_gd5;


                
                document.getElementById('productListModal').style.display = 'none';
            }
        });
    }

    function closeProductListModal() {
        document.getElementById('productListModal').style.display = 'none';
    }

    
  //침탄로작업표준 저장
    function save() {
	    var formData = new FormData($("#chimStandardForm")[0]);

	    let confirmMsg = "";

	    if (isEditMode && selectedRowData && selectedRowData.wstd_code) {
	        formData.append("mode", "update");
	        formData.append("wstd_code", selectedRowData.wstd_code);
	        confirmMsg = "수정하시겠습니까?";
	    } else {
	        formData.append("mode", "insert");
	        confirmMsg = "저장하시겠습니까?";
	    }

	    if (!confirm(confirmMsg)) {
	        return;
	    }

	    $.ajax({
	        url: "/tkheat/management/chimStandardInsert/chimStandardInsertSave",
	        type: "POST",
	        data: formData,
	        contentType: false,
	        processData: false,
	        dataType: "json",
	        success: function(result) {
	        	alert("저장 되었습니다.");
                $(".chimStandardModal").hide();
                getChimStandardList();
	        },
	        error: function(xhr, status, error) {
	            console.error("저장 오류:", error);
	        }
	    });
	}

    function saveAs() {
        var formData = new FormData($("#chimStandardForm")[0]);
        formData.append("mode", "insert");
        if (!confirm("다른 이름으로 저장하시겠습니까?")) return;

        $.ajax({
            url: "/tkheat/management/chimStandardInsert/chimStandardInsertSave",
            type: "POST",
            data: formData,
            contentType: false,
            processData: false,
            dataType: "json",
            success: function(result) {
                alert("다른 이름으로 저장되었습니다.");
                $(".chimStandardModal").hide();
                getChimStandardList();
            },
            error: function(xhr, status, error) {
                console.error("다른이름저장 오류:", error);
            }
        });
    }
    	


	function deleteChim() {
	    if (!selectedRowData || !selectedRowData.wstd_code) {
	        alert("삭제할 대상을 선택하세요.");
	        return;
	    }

	    if (!confirm("삭제하시겠습니까?")) {
	        return;
	    }

	    $.ajax({
	        url: "/tkheat/management/chimStandardInsert/chimStandardDelete",
	        type: "POST",
	        data: {
	        	wstd_code: selectedRowData.wstd_code
	        },
	        dataType: "json",
	        success: function(result) {
	            if (result.status === "success") {
	                alert("삭제되었습니다.");
	                $(".chimStandardModal").hide();
	                getChimStandardList();
	            } else {
	                alert("삭제 중 오류가 발생했습니다: " + result.message);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error("삭제 오류:", error);
	            alert("삭제 요청 중 오류가 발생했습니다.");
	        }
	    });
	}

    //엑셀 다운로드
	$(".excel-button").click(function () {
	    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
	    const filename = "침탄로작업표준_" + today + ".xlsx";
	    userTable.download("xlsx", filename, { sheetName: "침탄로작업표준" });
	});


	document.addEventListener("DOMContentLoaded", function() {
		console.log({
			  t32: wstd_t32.value,
			  t33: wstd_t33.value,
			  t41: wstd_t41.value,
			  t42: wstd_t42.value,
			  t44: wstd_t44.value,
			  t40: wstd_t40 ? wstd_t40.value : "없음",
			  t87: wstd_t87.value
			});
		  window.fn_Calc = function() {
		    var wstd_t32 = document.getElementById("wstd_t32");
		    var wstd_t33 = document.getElementById("wstd_t33");
		    var wstd_t41 = document.getElementById("wstd_t41");
		    var wstd_t42 = document.getElementById("wstd_t42");
		    var wstd_t44 = document.getElementById("wstd_t44");
		    var wstd_t40 = document.getElementById("wstd_t40"); 
		    var wstd_t43 = document.getElementById("wstd_t43");
		    var wstd_t51 = document.getElementById("wstd_t51");
		    var wstd_t52 = document.getElementById("wstd_t52");
		    var wstd_t87 = document.getElementById("wstd_t87");

		    // wstd_t40이 없으면 1로 기본처리 (옵션)
		    var wstd_t40_val = wstd_t40 ? Number(fn_rtnnumber(wstd_t40.value)) : 1;

		    if (
		      wstd_t32.value !== "" && wstd_t33.value !== "" &&
		      wstd_t41.value !== "" && wstd_t42.value !== "" &&
		      wstd_t44.value !== "" &&
		      wstd_t87.value !== ""
		    ) {
		      // 단취수량 계산
		      var calc_t43 = 
		        Number(fn_rtnnumber(wstd_t32.value)) *
		        Number(fn_rtnnumber(wstd_t33.value)) *
		        Number(fn_rtnnumber(wstd_t41.value)) *
		        Number(fn_rtnnumber(wstd_t42.value)) +
		        Number(fn_rtnnumber(wstd_t87.value));

		      wstd_t43.value = fn_addComma(calc_t43);

		      // 제품무게/ch 계산
		      var calc_t51 = calc_t43 * wstd_t40_val;
		      wstd_t51.value = fn_addComma(calc_t51.toFixed(2));

		      // 총단중/ch 계산
		      var calc_t52 = Number(fn_rtnnumber(wstd_t44.value)) + calc_t51;
		      wstd_t52.value = fn_addComma(calc_t52.toFixed(1));
		    } else {
		      // 입력값 부족 시 결과 초기화
		      wstd_t43.value = "";
		      wstd_t51.value = "";
		      wstd_t52.value = "";
		    }
		  };

		  window.fn_addComma = function(n) {
		    if (isNaN(n)) return 0;
		    var reg = /(^[+-]?\d+)(\d{3})/;
		    n = n.toString();
		    while (reg.test(n)) {
		      n = n.replace(reg, '$1' + ',' + '$2');
		    }
		    return n;
		  };

		  window.fn_rtnnumber = function(n) {
		    if (typeof n !== "string") return n;
		    return n.replace(/,/g, "");
		  };
		});

	

    </script>

	</body>
</html>
