<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>작업현황</title>
   <%@include file="../include/pluginpage.jsp" %>    
    <jsp:include page="../include/tabBar.jsp"/>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<style>

    /* 기본 레이아웃 (테이블 높이/패딩 축소 적용) */
    body{ background:#fff; font-family:"Noto Sans KR", "맑은 고딕", sans-serif; color:#222; margin:0; padding:0; overflow: hidden; }
   .main {
    max-width:1800px;
    margin:18px auto;
    padding:16px;
    height: 100%;
    overflow: hidden; /* 내부 카드 스크롤만 허용 */
}

/* 카드 내부 테이블 래퍼 스크롤 */
.card.fixed-height #tableHeatTopWrapper,
.card.fixed-height #tableAlarmWrapper,
.card.fixed-height #tableHeatWrapper {
    flex: 1; /* 남은 공간 모두 차지 */
    overflow-y: auto;
    height: 100px;
}
body, html {
    height: 100%;
    overflow: hidden; /* 화면 전체 스크롤 제거 */
}
    .header{ display:flex; justify-content:space-between; align-items:center; margin-bottom:14px; }
    .title{ font-size:20px; font-weight:700; }
    .subtitle{ font-size:13px; color:#6b7280; }

    .grid{ display:flex; gap:18px; margin-bottom:18px; }
    .card{
        background:#fff;
        border-radius:10px;
        padding:16px; /* 기존 12 -> 10 */
        box-shadow:0 6px 18px rgba(2,6,23,0.06);
        border:1px solid rgba(2,6,23,0.04);
        flex:1;
        min-width:330px;
    }
    .card .card-header{ display:flex; justify-content:space-between; align-items:center; margin-bottom:8px; }
    .card-title{ font-weight:700; font-size:14px; }
    .card-sub{ font-size:12px; color:#6b7280; }

    /* 테이블 공통: 패딩/행높이 축소 */
    table { width:100%; border-collapse:collapse; font-size:13px; }
    thead th {
        text-align:center;
        padding:6px 6px; /* 기존 10px -> 6px */
        background:#f3f6fb;
        border-bottom:1px solid #e6eefc;
        font-weight:700;
        height:34px; /* 헤더 높이 약간 축소 */
    }
    tbody td {
        padding:6px 6px; /* 기존 10px -> 6px */
        border-bottom:1px solid #f1f5f9;
        text-align:center;
        height:36px; /* 각 행 높이 고정 */
        line-height:18px;
        white-space:nowrap;
        overflow:hidden;
        text-overflow:ellipsis;
    }
    tbody tr:hover { background:#fbfdff; cursor:pointer; }
    tbody tr.selected { background: linear-gradient(90deg, rgba(11,99,206,0.06), rgba(11,99,206,0.02)); font-weight:700; }

    .kpi { display:flex; gap:8px; }
    .kpi .item{ flex:1; background:#fbfcff; padding:6px; border-radius:8px; text-align:center; } /* padding 축소 */
    .kpi .label{ font-size:12px; color:#6b7280; }
    .kpi .value{ font-size:16px; font-weight:800; color:#111827; } /* 숫자 크기 약간 축소 */

    .btn{ display:inline-flex; align-items:center; gap:8px; padding:8px 12px; border-radius:8px; border:0; cursor:pointer; font-weight:700; }
    .btn.primary{ background:#0b63ce; color:#fff; }
    .btn.work{ background:#A566FF; color:#fff; }
    .btn.ghost{ background:#fff; color:#111; border:1px solid rgba(2,6,23,0.06); }



    .small-input{ padding:6px 8px; border-radius:6px; border:1px solid #e6eefc; }

    .muted{ color:#6b7280; font-size:12px; }

    /* 강조 셀 (온도, CP) */
    .temp { color:#e63946; font-weight:800; }
    .cp { color:#0b63ce; font-weight:800; }

    /* 개별 테이블 최대 높이 — 줄여서 스크롤 생기도록 설정 */
    #tableHeatTopWrapper { height:120px; overflow:auto; }   /* 요약 상단 테이블 (작게) */
   #tableHeatWrapper { 
    height: 220px;  /* 기존 330px → 250px */
    overflow:auto; 
}

    #tableAlarm { } /* 테이블 element 자체는 사용 안함 */
    #tableAlarm tbody { } 
   #tableAlarmWrapper { 
    height: 600px;  
    overflow:auto; 
}

    /* 온도표는 한 줄이라 높이 조절 필요 없음 — 셀 패딩만 작게 */
    .temp-table thead th{ padding:6px 6px; font-size:12px; color:#6b7280; }
    .temp-table tbody td{ padding:8px 6px; font-size:16px; height:36px; }

    @media (max-width:1100px){
        .grid{ flex-direction:column; }
    }
    
/*바코드스캔 모달용 css*/
  #lotModal .form-section {
    margin-bottom: 15px;
    padding: 10px;
    border-radius: 10px;
    background: #f9fafb;
    box-shadow: 0 1px 4px rgba(0,0,0,0.05);
  }

  #lotModal .form-section h3 {
    margin-bottom: 8px;
    font-size: 14px;
    color: #333;
    border-left: 4px solid #007bff;
    padding-left: 6px;
  }

  #lotModal .grid {
    display: grid;
    gap: 8px;
  }

  #lotModal .grid-3 { grid-template-columns: repeat(3, 1fr); }
  #lotModal .grid-7 { grid-template-columns: repeat(7, 1fr); }
  #lotModal .grid-6 { grid-template-columns: repeat(6, 1fr); }

  #lotModal .form-group {
    display: flex;
    flex-direction: column;
  }

  #lotModal .form-group label {
    font-size: 12px;
    margin-bottom: 3px;
    color: #555;
  }

  #lotModal .form-group input {
    padding: 4px 6px;
    border: 1px solid #ccc;
    border-radius: 6px;
    outline: none;
    font-size: 12px;
  }

  #lotModal .form-group input:focus {
    border-color: #007bff;
    background: #f0f7ff;
  }

  #lotModal .modal-footer {
    display: flex;
    justify-content: flex-end;
    gap: 8px;
    margin-top: 10px;
  }

  #lotModal .btn {
    padding: 6px 12px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 13px;
  }

  #lotModal .btn-primary {
    background-color: #007bff;
    color: white;
  }

  #lotModal .btn-secondary {
    background-color: #e0e0e0;
    color: #333;
  }
</style>

</head>
<body>
<main class="main">
    <div class="header">
        <div>
  

        </div>
        <div style="text-align:right;">
            <div class="muted">최종 갱신: <span id="lastUpdated">--:--:--</span></div>
            <div style="margin-top:6px;">
                <button class="btn work" id="openModal">작업스캔</button>
                <button class="btn primary" id="btnRefresh">즉시갱신</button>
                <button class="btn ghost" id="btnRefreshAll">전체갱신</button>
            </div>
        </div>
    </div>

    <!-- 상단: 요약(왼) + 알람(오) (위치 변경: 알람을 상단 오른쪽에 배치) -->
    <div class="grid">
        <div class="card card" style="flex:0.45; fon">
            <div class="card-header">
                <div>
                    <div class="card-title">작업 진행</div>
                    <div class="card-sub"></div>
                </div>
               
            </div>

            <div class="kpi" style="margin-bottom:10px;">
                <div class="item">
                    <div class="label">작업LOT</div>
                    <div id="kpi_lot" class="value">-</div>
                </div>
                <div class="item">
                    <div class="label">현재  작업 진행 시간</div>
                    <div id="kpi_time" class="value kpi_time">-</div>
                </div>
                <div class="item">
                    <div class="label">전체 통 수</div>
                    <div id="tong_count" class="value tong_count">-</div>
                </div>
            </div>
            
            <div id="tableHeatTopWrapper">
                <table id="tableHeatTop">
                    <thead>
                        <tr>
                            <th>작업 시작 시간</th>
                            <th>품명</th>
                            <th>품번</th>
                            <th>소입온도(℃)</th>
                            <th>CP(%)</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
            
               <div id="tableHeatTopWrapper">
                <table id="tableHeatTop2">
                    <thead>
                        <tr>
                            <th>다음 작업 시간</th>
                            <th>품명</th>
                            <th>품번</th>
                            <th>소입온도(℃)</th>
                            <th>CP(%)</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
            
            <div class="card card fixed-height"">
            <div class="card-header">
                <div>
                    <div class="card-title">온도별 현재 PV</div>
                    <div class="card-sub"></div>
                </div>
                <div>
                    <button class="btn ghost" id="btnToggleAuto">자동(10s)</button>
                </div>
            </div>

<div style="min-height:200px; overflow:auto; padding:8px;">
    <table id="tableTempCurrent" style="width:100%; text-align:center; border-collapse: collapse; font-size:15px;">

        <!-- 첫 번째 줄: 7개 컬럼 -->
        <thead>
            <tr>
                <th>F_WASH</th><th>IN_WASH</th><th>M_WASH</th><th>IN_M_WASH</th><th>OIL</th>
                <th>QF1</th><th>QF2</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="temp">-</td><td class="temp">-</td><td class="temp">-</td><td class="temp">-</td><td class="temp">-</td>
                <td class="temp">-</td><td class="temp">-</td>
            </tr>
        </tbody>

        <!-- 두 번째 줄: 7개 컬럼 -->
        <thead>
            <tr>
                <th>QF3</th><th>QF4</th><th>QF5</th><th>IN_Q</th><th>IN_OIL</th>
                <th>IN_DATA</th><th>IN_T</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="temp">-</td><td class="temp">-</td><td class="temp">-</td><td class="temp">-</td><td class="temp">-</td>
                <td class="temp">-</td><td class="temp">-</td>
            </tr>
        </tbody>

        <!-- 세 번째 줄: 나머지 컬럼 (T1~T5 + CP A, CP B) -->
        <thead>
            <tr>
                <th>T1</th><th>T2</th><th>T3</th><th>T4</th><th>T5</th><th>CP A</th><th>CP B</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="temp">-</td><td class="temp">-</td><td class="temp">-</td><td class="temp">-</td><td class="temp">-</td>
                <td class="cp">-</td><td class="cp">-</td>
            </tr>
        </tbody>
    </table>
</div>

        </div>
        </div>

        <!-- 오른쪽 상단: 알람 카드로 변경 (위치 변경 적용) -->
        <div class="card card" style="flex:0.55;">
            <div class="card-header">
                <div>
                    <div class="card-title">최신 알람 이력</div>
                    <div class="card-sub"></div>
                </div>
                <div>
       <!--              <input type="date" id="s_sdate" class="small-input">
                    <input type="date" id="s_edate" class="small-input"> -->
                    <button class="btn ghost" id="btnLoadAlarm">조회</button>
                </div>
            </div>

            <div id="tableAlarmWrapper"  overflow:auto;">
                <table id="tableAlarm">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>PLC주소</th>
                            <th>알람내용</th>
                            <th>발생시간</th>
                            <th>해제시간</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- 하단: 최신 작업 목록 (전체 너비로 이동) -->
    <div class="grid">
        <div class="card" style="flex:1;">
            <div class="card-header">
                <div>
                    <div class="card-title">최신 작업 목록</div>
   
                </div>
                <div>
                
                </div>
            </div>

            <div id="tableHeatWrapper" style="max-height:320px; overflow:auto;">
                <table id="tableHeat">
                    <thead>
                        <tr>
                            <th>작업일자</th>
                            <th>작업LOT</th>
                             <th>회사명</th>
                            <th>품번</th>
                            <th>품명</th>
                            <th>투입시작시간</th>
                            <th>투입종료시간</th>
                            <th>투입시간(분)</th>
                            <th>소입온도(℃)</th>
                            <th>소려온도(℃)</th>
                            <th>CP(%)</th>
                            <th>작업완료시간</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
    </div>

<!-- 스캔한 바코드의 정보 표현할 모달 -->
<div id="lotModal" title="레시피 입력" style="display:none;">

  <!-- 로트번호 -->
  <div class="form-section">
    <h3>로트번호</h3>
    <div class="form-group">
      <input type="text" id="lotNumber">
    </div>
  </div>

  <!-- 기본 정보 -->
  <div class="form-section">
    <h3>기본 정보</h3>
    <div class="grid grid-3">
      <div class="form-group"><label>로트번호</label>
      <input type="text" name="w_ci_lot" class="w_ci_lot"></div>
      
      <div class="form-group"><label>업체명</label>
      <input type="text" name="cust_name" class="cust_name"></div>
      <div class="form-group"><label>품번</label>
      <input type="text" name="item_no" class="item_no"></div>
      <div class="form-group"><label>품명</label>
      <input type="text" name="item_name" class="item_name"></div>
      <div class="form-group"><label>규격</label>
      <input type="text" name="spec" class="spec"></div>
      <div class="form-group"><label>장입량</label>
      <input type="text" name="charge_weight" class="charge_weight"></div>
      <div class="form-group"><label>계획통수</label>
      <input type="text" name="w_plan_cnt" class="w_plan_cnt"></div>
      <div class="form-group"><label>투입통수</label>
      <input type="text" name="wd_in_cnt" class="wd_in_cnt"></div>
    </div>
  </div>

  <!-- 소입 존 -->
  <div class="form-section">
    <h3>소입 존</h3>
    <div class="grid grid-7">
      <div class="form-group"><label>소입1존</label>
      <input type="text" name="q1_zone" class="q1_zone"></div>
      <div class="form-group"><label>소입2존</label>
      <input type="text" name="q2_zone" class="q2_zone"></div>
      <div class="form-group"><label>소입3존</label>
      <input type="text" name="q3_4_zone" class="q3_4_zone"></div>
      <div class="form-group"><label>소입4존</label>
      <input type="text" class="q3_4_zone" readonly="readonly"></div>
      <div class="form-group"><label>소입5존</label>
      <input type="text" name="q5_zone" class="q5_zone"></div>
      <div class="form-group"><label>소입인버터</label>
      <input type="text" name="q_speed" class="q_speed"></div>
      <div class="form-group"><label>CP</label>
      <input type="text" name="cp" class="cp"></div>
    </div>
  </div>

  <!-- 소려 존 -->
  <div class="form-section">
    <h3>소려 존</h3>
    <div class="grid grid-6">
      <div class="form-group"><label>소려1존</label>
      <input type="text" name="t1_zone" class="t1_zone"></div>
      <div class="form-group"><label>소려2존</label>
      <input type="text" name="t2_5_zone" class="t2_5_zone"></div>
      <div class="form-group"><label>소려3존</label>
      <input type="text" class="t2_5_zone" readonly="readonly"></div>
      <div class="form-group"><label>소려4존</label>
      <input type="text" class="t2_5_zone" readonly="readonly"></div>
      <div class="form-group"><label>소려5존</label>
      <input type="text" class="t2_5_zone" readonly="readonly"></div>
      <div class="form-group"><label>소려인버터</label>
      <input type="text" name="t_speed" class="t_speed"></div>
    </div>
  </div>

  		<div class="view">
            <div id="dataTable"></div>
        </div>



  <!-- 버튼 -->
  <div class="modal-footer">
    <button type="button" id="applyBtn" class="btn btn-primary">레시피 적용</button>
    <button type="button" id="cancelBtn" class="btn btn-secondary">닫기</button>
  </div>
</div><!-- 모달 열기 버튼 -->
<!--  <button id="openModal">모달 열기</button>-->


</main>


<script>
    // jQuery 존재확인 (pluginpage.jsp에 포함되어있을 것으로 가정)
/*
    if(!window.jQuery){
        document.write('<script src="https://code.jquery.com/jquery-3.6.0.min.js"><\/script>');
    }
*/

/*전역변수*/
var opcInterval;
var selectedRowData = null;
var tempAuto = true;
var tempTimer = null;
var dataTable;


/*바코드스캔 모달*/
$(function() {

    // 초기 로드
    fetchHeatTop();
    fetchHeatTop2();
    fetchHeatList();
    fetchAlarm();
    fetchTempCurrent();

    // 자동 갱신 설정
    tempTimer = setInterval(function(){
        if(tempAuto) fetchTempCurrent();
    }, 10000); // 10s

    setInterval(fetchAlarm, 30000); // 알람 30s
    setInterval(fetchHeatList, 60000); // 작업목록 60s

    // 버튼 이벤트
    $("#btnRefresh").on("click", function(){ fetchHeatTop(); fetchTempCurrent(); updateLastUpdated(); });
    $("#btnRefreshAll").on("click", function(){ refreshAll(); });
    $("#btnLoadAlarm").on("click", function(){ fetchAlarm(); });
    $("#btnToggleAuto").on("click", function(){
        tempAuto = !tempAuto;
        $(this).text(tempAuto ? "자동(10s)" : "정지");
    });

    // 행 클릭 (테이블 바디에 이벤트 위임)
    $("#tableHeat tbody").on("click","tr", function(){
        $("#tableHeat tbody tr").removeClass("selected");
        $(this).addClass("selected");
        selectedRowData = $(this).data("rowdata");
    });
    $("#tableAlarm tbody").on("click","tr", function(){
        $("#tableAlarm tbody tr").removeClass("selected");
        $(this).addClass("selected");
        selectedRowData = $(this).data("rowdata");
    });
    $("#tableHeatTop tbody").on("click","tr", function(){
        $("#tableHeatTop tbody tr").removeClass("selected");
        $(this).addClass("selected");
        selectedRowData = $(this).data("rowdata");
    });
	
  $("#lotModal").dialog({
	    autoOpen: false,
	    modal: true,
	    width: 1300,  // 넓게 해서 스크롤 없음
	    height: "auto",
	    resizable: false
  });
  
});

/*바코드 스캔모달 이벤트*/
$("#openModal").click(function() {
  $("#lotModal").dialog("open");
  $("#lotNumber").focus();
  
});

$("#cancelBtn, #closeBtn").click(function() {
  $("#lotModal").dialog("close");
});

$("#applyBtn").click(function() {
    let allData = heatListTable.getData();
    let incomplete = allData.some(row => row.wd_state !== 1);
    let w_msg = ""; // 사용자가 입력한 메세지

    if (incomplete) {
        if (!confirm("스캔 완료되지 않은 항목이 있습니다. 계속 진행하시겠습니까?")) {
            return;
        }

        // ✅ 메세지 입력 받기
        w_msg = prompt("스캔 미완료 사유 또는 메모를 입력해주세요.", "");
        if (w_msg === null) {
            return;
        }
    }

    // wd_state == 0 또는 99 인 항목만 업데이트 대상
    let toUpdate = allData.filter(row => row.wd_state === 0 || row.wd_state === 99);

    // Ajax 요청
    let ajaxCalls = toUpdate.map(row => {
        return $.ajax({
            url: "/chunil/productionManagement/heatTreatment/barcodeScan",
            type: "post",
            dataType: "json",
            data: {
                w_ci_lot: row.w_ci_lot,
                tong_num: row.wd_tong_num,
                wd_state: 2,
                w_msg: w_msg   // ✅ 이 부분 이름 변경됨
            }
        });
    });

    // 모든 Ajax 완료 후 처리
    $.when.apply($, ajaxCalls).done(function() {
        alert("레시피 적용 로직 실행 및 대기중(2) 상태 업데이트 완료");
        heatListTable.replaceData(allData); 
        tongListInit();

        // ✅ 마지막 D500 호출
        $.ajax({
            url: "/chunil/productionManagement/heatTreatment/barcodeScanD500",
            type: "post",
            dataType: "json",
            success: function(res) {
                console.log("D500 btSet 호출 완료:", res);
            },
            error: function(err) {
                console.error("D500 호출 실패:", err);
            }
        });
    });
});




let heatListTable; 
let scanTimer;

// 🔹 테이블 초기화 (최초 1회만)

function tongListInit() {
  heatListTable = new Tabulator('#dataTable', {
    height: '220px',
    layout: 'fitColumns',
    headerSort: false,
    reactiveData: true,
    columnHeaderVertAlign: "middle",
    rowVertAlign: "middle",
    headerHozAlign: 'center',
    ajaxConfig: { method: 'POST' },
    renderHorizontal: "virtual",
    selectable: true,
    selectableRangeMode: "click",
    placeholder: "조회된 데이터가 없습니다.",
    rowFormatter: function(row) {
      let data = row.getData();
      if(data.wd_state === 0 || data.wd_state === 99){
        row.getElement().style.backgroundColor = "#fffacd"; // 연노랑
      } else if(data.wd_state === 1){
        row.getElement().style.backgroundColor = "#d4edda"; // 연초록
      } else {
        row.getElement().style.backgroundColor = "";
      }
    },
    columns: [
      { title: "No", formatter: "rownum", hozAlign: "center", width: 70 },
      { title: "통 번호", field: "wd_tong_num", width: 220, hozAlign: "center" },
      { 
        title: "상태", 
        field: "wd_state",
        hozAlign: "center",
        formatter: function(cell) {
          let value = cell.getValue();
          if (value === 0) return "스캔 대기";
          if (value === 1) return "스캔 완료";
          if (value === 2) return "미적용";
          return value;
        },
        // width 제거 → 남은 공간을 자동으로 채움
      },
    ],
  });
}


// 🔹 테이블 데이터 새로 불러오기 (w_ci_lot 포함)
function refreshTongList(w_ci_lot) {
  console.log("테이블 갱신 요청:", w_ci_lot);
  heatListTable.setData("/chunil/productionManagement/heatTreatment/tongList", { w_ci_lot: w_ci_lot });
}

// 🔹 바코드 입력 이벤트
$("#lotNumber").on("input", function () {
  clearTimeout(scanTimer);
  let self = this;

  scanTimer = setTimeout(function () {
    if (self.value) {
      let lotValue = self.value.trim();

      console.log("w_ci_lot보내는 값:", { "w_ci_lot": lotValue });
      console.log("tong_num보내는 값:", { "tong_num": lotValue });

      $.ajax({
        url: "/chunil/productionManagement/heatTreatment/barcodeScan",
        type: "post",
        dataType: "json",
        data: {
          "w_ci_lot": lotValue,
          "tong_num": lotValue
        },
        success: function (result) {
          console.log("응답 결과:", result);

          if (result.gb == 1) {
            var data = result.data;
            for (var d in data) {
              $("." + d).val(data[d]);
            }

            // ✅ barcodeScan 성공 후 테이블 갱신 (w_ci_lot 포함)
            refreshTongList(lotValue);

            $("#lotNumber").val("");
            $("#lotNumber").focus();

          } else if (result.gb == 2) {
            alert(result.data);
            $("#lotNumber").val("").focus();
            refreshTongList(lotValue);
          } else {
            alert(result.data);
            $("#lotNumber").val("").focus();
            refreshTongList(lotValue);
          }
        },
        error: function (xhr, status, error) {
          console.error("barcodeScan 요청 실패:", error);
        }
      });
    }
  }, 1000);
});

// 🔹 페이지 로드 시 테이블 초기화
$(document).ready(function () {
  tongListInit();
});






/*작업현황 그 외 함수*/




        function updateLastUpdated(){
            var d = new Date();
            var hh = String(d.getHours()).padStart(2,'0');
            var mm = String(d.getMinutes()).padStart(2,'0');
            var ss = String(d.getSeconds()).padStart(2,'0');
            $("#lastUpdated").text(hh+":"+mm+":"+ss);
        }

        function refreshAll(){
            fetchHeatTop();
            fetchHeatList();
            fetchAlarm();
            fetchTempCurrent();
            updateLastUpdated();
        }

        /* ---------- getHeatList_1 (요약) ---------- */
        function fetchHeatTop(){
        	   // 오늘 날짜 yyyy-MM-dd 형식
            var today = new Date();
            var yyyy = today.getFullYear();
            var mm = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0~11이므로 +1
            var dd = String(today.getDate()).padStart(2, '0');
            var todayStr = yyyy + '-' + mm + '-' + dd;
            $.ajax({
                url: "/chunil/productionManagement/heatTreatment/list_1",
                method: "POST",
                data: { w_date: todayStr },
                dataType: "json",
                success: function(resp){
                    updateLastUpdated();
                    // resp가 배열인지 객체인지 유연하게 처리
                    var arr = Array.isArray(resp) ? resp : (resp.data || resp.rows || (resp ? [resp] : []));
                    var $tbody = $("#tableHeatTop tbody").empty();
                    if(!arr || arr.length===0){
                        $tbody.append('<tr><td colspan="5">조회된 데이터가 없습니다.</td></tr>');
                        $("#kpi_lot").text("-");
                        $("#kpi_qf").text("-");
                        $("#tong_count").text("-");
                        return;
                    }
                    arr.forEach(function(r, idx){
                        var tr = $("<tr></tr>");
                        tr.append("<td>"+(r.w_sdatetime || "")+"</td>");
                        tr.append("<td>"+(r.item_name || "")+"</td>");
                        tr.append("<td>"+(r.item_no || "")+"</td>");
                        tr.append("<td class='temp'>"+(r.t1_zone != null ? r.t1_zone : "")+"</td>");
                        tr.append("<td class='cp'>"+(r.cp != null ? r.cp : "")+"</td>");
                        tr.data("rowdata", r);
                        $tbody.append(tr);
                    });
                    // KPI에는 첫 행 표시
                 // KPI 표시
                    var first = arr[0];
                    $("#kpi_lot").text(first.w_ci_lot || "-");
                    $("#kpi_qf").text(first.t1_zone != null ? first.t1_zone : "-");
                    $("#kpi_cp").text(first.cp != null ? first.cp : "-");
                    $("#tong_count").text(first.tong_count != null ? first.tong_count : "-");

                    // 실시간 KPI 시간 시작
                    startKpiTimer(first.w_sdatetime);


                    
                },
                error: function(xhr){
                    console.error("getHeatList_1 error", xhr);
                }
            });
        }







        /* ---------- getHeatList_2 (다음 작업) ---------- */
        function fetchHeatTop2(){
            // 오늘 날짜 yyyy-MM-dd 형식
            var today = new Date();
            var yyyy = today.getFullYear();
            var mm = String(today.getMonth() + 1).padStart(2, '0');
            var dd = String(today.getDate()).padStart(2, '0');
            var todayStr = yyyy + '-' + mm + '-' + dd;

            $.ajax({
                url: "/chunil/productionManagement/heatTreatment/list_next",
                method: "POST",
                data: { w_date: todayStr },
                dataType: "json",
                success: function(resp){
                    updateLastUpdated();
                    var arr = Array.isArray(resp) ? resp : (resp.data || resp.rows || (resp ? [resp] : []));
                    var $tbody = $("#tableHeatTop2 tbody").empty();

                    if(!arr || arr.length === 0){
                        $tbody.append('<tr><td colspan="5">조회된 데이터가 없습니다.</td></tr>');
                        return;
                    }

                    arr.forEach(function(r){
                        var tr = $("<tr></tr>");
                        tr.append("<td>"+(r.w_sdatetime || "")+"</td>");
                        tr.append("<td>"+(r.item_name || "")+"</td>");
                        tr.append("<td>"+(r.item_no || "")+"</td>");
                        tr.append("<td class='temp'>"+(r.t1_zone != null ? r.t1_zone : "")+"</td>");
                        tr.append("<td class='cp'>"+(r.cp != null ? r.cp : "")+"</td>");
                        tr.data("rowdata", r);
                        $tbody.append(tr);
                    });
                },
                error: function(xhr){
                    console.error("getHeatList_2 (list_next) error", xhr);
                }
            });
        }












        


        var startTime = null; // 진행 중 작업 시작 시간

        function startKpiTimer(w_sdatetime){
            if(!w_sdatetime){
                $("#kpi_time").text("-");
                return;
            }

            // 문자열 → Date 객체
            startTime = new Date(w_sdatetime.replace(/-/g, '/'));

            // 기존 타이머가 있으면 제거
            if(window.kpiTimer) clearInterval(window.kpiTimer);

            // 1초마다 업데이트
            window.kpiTimer = setInterval(function(){
                var now = new Date();
                var diffMs = now - startTime;

                var diffH = Math.floor(diffMs / 1000 / 60 / 60);
                var diffM = Math.floor(diffMs / 1000 / 60) % 60;
                var diffS = Math.floor(diffMs / 1000) % 60;

                var timeStr = diffH.toString().padStart(2,'0') + ":" +
                              diffM.toString().padStart(2,'0') + ":" +
                              diffS.toString().padStart(2,'0');
                $("#kpi_time").text(timeStr);
            }, 1000);
        }









        

        /* ---------- getHeatList (상세 목록) ---------- */
        function fetchHeatList(){
            // 오늘 날짜 yyyy-MM-dd 형식
            var today = new Date();
            var yyyy = today.getFullYear();
            var mm = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0~11이므로 +1
            var dd = String(today.getDate()).padStart(2, '0');
            var todayStr = yyyy + '-' + mm + '-' + dd;

            $.ajax({
                url: "/chunil/productionManagement/heatTreatment/list_10",
                method: "POST",
                data: { w_date: todayStr },
                dataType: "json",
                success: function(resp){
                   // console.log("fetchHeatList resp:", resp);

                    updateLastUpdated();
                    var arr = Array.isArray(resp) ? resp : (resp.data || resp.rows || (resp ? [resp] : []));
                    var $tbody = $("#tableHeat tbody").empty();
                    if(!arr || arr.length===0){
                        $tbody.append('<tr><td colspan="12">조회된 데이터가 없습니다.</td></tr>');
                        return;
                    }
                    arr.forEach(function(r){
                        var tr = $("<tr></tr>");
                        tr.append("<td>"+(r.w_date || "")+"</td>");
                        tr.append("<td>"+(r.w_ci_lot  || "")+"</td>");
                        tr.append("<td>"+(r.cust_name || "")+"</td>");
                        tr.append("<td>"+(r.item_no || "")+"</td>");
                        tr.append("<td>"+(r.item_name || "")+"</td>");
                        tr.append("<td>"+(r.regtime  || "")+"</td>");
                        tr.append("<td>"+(r.w_in_edatetime || "")+"</td>");
                        tr.append("<td>"+(r.w_intime!=null?r.w_intime:"")+"</td>");
                        tr.append("<td class='temp'>"+(r.q1_zone != null ? r.q1_zone : "")+"</td>");
                        tr.append("<td class='temp'>"+(r.t1_zone != null ? r.t1_zone : "")+"</td>");
                        tr.append("<td class='cp'>"+(r.cp != null ? r.cp : "")+"</td>");

                        tr.append("<td>"+(r.w_edatetime || "")+"</td>");
                        tr.data("rowdata", r);
                        $tbody.append(tr);
                    });
                },
                error: function(xhr){
                    console.error("getHeatList error", xhr);
                }
            });
        }


        /* ---------- Alarm ---------- */
        function fetchAlarm(){
            $.ajax({
                url: "/chunil/productionManagement/alarmRecord/list",
                method: "POST",
                dataType: "json",
                success: function(resp){
                    updateLastUpdated();
                    var arr = Array.isArray(resp) ? resp : (resp.data || resp.rows || (resp ? [resp] : []));
                    var $tbody = $("#tableAlarm tbody").empty();
                    if(!arr || arr.length === 0){
                        $tbody.append('<tr><td colspan="5">조회된 데이터가 없습니다.</td></tr>');
                        return;
                    }

                    arr.forEach(function(r, idx){
                        var tr = $("<tr></tr>");
                        tr.append("<td>"+(r.idx!=null?r.idx:"")+"</td>");
                        tr.append("<td>"+(r.a_addr || "")+"</td>");
                        tr.append("<td style='text-align:left;padding-left:12px;'>"+(r.a_desc || "")+"</td>");
                        tr.append("<td>"+(r.a_stime || "")+"</td>");
                        tr.append("<td>"+(r.a_etime || "")+"</td>");
                        tr.data("rowdata", r);

                        // ✅ 진행 중인 알람 시각적 강조
                        if(!r.a_etime || r.a_etime === ""){
                            tr.css({
                                "background": "linear-gradient(90deg, rgba(255,230,0,0.2), rgba(255,255,255,0))",
                                "font-weight": "bold",
                                "color": "#b30000"  // 빨간색 글씨
                            });
                            tr.append("<td style='color:#b30000; font-weight:bold;'>진행 중</td>");
                        } else {
                            tr.append("<td>-</td>");
                        }

                        $tbody.append(tr);
                    });
                },
                error: function(xhr){
                    console.error("fetchAlarm error", xhr);
                }
            });
        }








        /* ---------- Temp Current (getLatestTrend but 온도값 표시) ---------- */
      function fetchTempCurrent(){
    var today = new Date();
    var yyyy = today.getFullYear();
    var mm = String(today.getMonth() + 1).padStart(2,'0');
    var dd = String(today.getDate()).padStart(2,'0');
    var todayStr = yyyy + '-' + mm + '-' + dd;

    $.ajax({
        url: "/chunil/monitoring/trend/getLatestTrend",
        method: "POST",
        data: { w_date: todayStr },
        dataType: "json",
        success: function(resp){
            updateLastUpdated();

            var obj = Array.isArray(resp) ? (resp[0] || null) : resp || null;

            if(!obj){
                $("#tableTempCurrent td").text("-");
                return;
            }

            // === 첫 번째 줄: F_WASH, IN_WASH, M_WASH, IN_M_WASH, OIL + QF1, QF2 ===
            $("#tableTempCurrent tbody tr").eq(0).find("td").eq(0).text(obj.f_wash_pv != null ? obj.f_wash_pv : "-");
            $("#tableTempCurrent tbody tr").eq(0).find("td").eq(1).text(obj.in_wash_pv != null ? obj.in_wash_pv : "-");
            $("#tableTempCurrent tbody tr").eq(0).find("td").eq(2).text(obj.m_wash_pv != null ? obj.m_wash_pv : "-");
            $("#tableTempCurrent tbody tr").eq(0).find("td").eq(3).text(obj.in_m_wash_pv != null ? obj.in_m_wash_pv : "-");
            $("#tableTempCurrent tbody tr").eq(0).find("td").eq(4).text(obj.oil_pv != null ? obj.oil_pv : "-");
            $("#tableTempCurrent tbody tr").eq(0).find("td").eq(5).text(obj.q_pv_1 != null ? obj.q_pv_1 : "-");
            $("#tableTempCurrent tbody tr").eq(0).find("td").eq(6).text(obj.q_pv_2 != null ? obj.q_pv_2 : "-");

            // === 두 번째 줄: QF3~QF5, IN_Q, IN_OIL, IN_DATA, IN_T ===
            $("#tableTempCurrent tbody tr").eq(1).find("td").eq(0).text(obj.q_pv_3 != null ? obj.q_pv_3 : "-");
            $("#tableTempCurrent tbody tr").eq(1).find("td").eq(1).text(obj.q_pv_4 != null ? obj.q_pv_4 : "-");
            $("#tableTempCurrent tbody tr").eq(1).find("td").eq(2).text(obj.q_pv_5 != null ? obj.q_pv_5 : "-");
            $("#tableTempCurrent tbody tr").eq(1).find("td").eq(3).text(obj.in_q_pv != null ? obj.in_q_pv : "-");
            $("#tableTempCurrent tbody tr").eq(1).find("td").eq(4).text(obj.in_oil_pv != null ? obj.in_oil_pv : "-");
            $("#tableTempCurrent tbody tr").eq(1).find("td").eq(5).text(obj.in_data_pv != null ? obj.in_data_pv : "-");
            $("#tableTempCurrent tbody tr").eq(1).find("td").eq(6).text(obj.in_t_pv != null ? obj.in_t_pv : "-");

            // === 세 번째 줄: T1~T5, CP A/B ===
            $("#tableTempCurrent tbody tr").eq(2).find("td").eq(0).text(obj.t_pv_1 != null ? obj.t_pv_1 : "-");
            $("#tableTempCurrent tbody tr").eq(2).find("td").eq(1).text(obj.t_pv_2 != null ? obj.t_pv_2 : "-");
            $("#tableTempCurrent tbody tr").eq(2).find("td").eq(2).text(obj.t_pv_3 != null ? obj.t_pv_3 : "-");
            $("#tableTempCurrent tbody tr").eq(2).find("td").eq(3).text(obj.t_pv_4 != null ? obj.t_pv_4 : "-");
            $("#tableTempCurrent tbody tr").eq(2).find("td").eq(4).text(obj.t_pv_5 != null ? obj.t_pv_5 : "-");
            $("#tableTempCurrent tbody tr").eq(2).find("td").eq(5).text(obj.cp_pv_1 != null ? obj.cp_pv_1 : "-");
            $("#tableTempCurrent tbody tr").eq(2).find("td").eq(6).text(obj.cp_pv_2 != null ? obj.cp_pv_2 : "-");
        },
        error: function(xhr){
            console.error("fetchTempCurrent error", xhr);
        }
    });
}



</script>
</body>
</html>
