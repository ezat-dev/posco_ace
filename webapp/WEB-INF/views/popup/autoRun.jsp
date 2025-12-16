<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%@include file="../include/pluginpage.jsp" %> 
<head>
<meta charset="utf-8" />
<title>운전선택</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<style>
  html,body{margin:0;padding:0;height:100%;font-family:Arial,Helvetica,sans-serif;background:#fff;}
  .container{box-sizing:border-box;width:100%;height:100%;display:flex;flex-direction:column;align-items:center;justify-content:center;padding:6px;}
  .header{width:100%;text-align:center;background:#33363d;color:#fff;padding:6px 0;font-size:16px;border-radius:4px;}
  .controls{
  margin-top:8px;
  display:flex;
  gap:10px;
  align-items:center;
  flex-direction:row;
}
  .btn{
    width:120px;height:36px;border-radius:4px;border:none;font-weight:700;cursor:pointer;
    display:inline-flex;align-items:center;justify-content:center;user-select:none;
  }
  .btn.off{background:#d9534f;color:#fff;}
  .btn.on{background:#5cb85c;color:#fff;}

  /* progress bar */
  .progress-wrap{width:85%;max-width:310px;height:10px;background:#eee;border-radius:6px;overflow:hidden;margin-top:10px;}
  .progress-bar{height:100%;width:0%;background:#4caf50;transition:width 0.05s linear;}

  /* toast */
  .toast{
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    bottom: 10px;
    background: rgba(0,0,0,0.8);
    color:#fff;padding:6px 12px;border-radius:6px;font-size:13px;display:none;
    z-index:999;
  }

  /* prevent text selection while long-press */
  .no-select { -webkit-user-select:none; -moz-user-select:none; -ms-user-select:none; user-select:none; }
  
.btn.active {
  border: 3px solid #00ff00 !important;
}

  
  
</style>
</head>
<body>
  <div class="container no-select">
    <div class="header">운전 선택</div>

    <div class="controls" style="margin-top:8px;">
      <button class="btn manual ctrl-btn" data-tag="manual-run-on">수동모드</button>
      <button class="btn auto ctrl-btn" data-tag="auto-run-on">자동모드</button>
      <button class="btn end ctrl-btn" data-tag="auto-end-on">즉시정지</button>
    </div>
    
     <div class="controls" style="margin-top:6px;">
	    <button class="btn n2 ctrl-btn" data-tag="auto-n2-on">질소공정</button>
	    <button class="btn nomal ctrl-btn" data-tag="auto-nomal-on">일반공정</button>
  	</div>

    <div class="progress-wrap" aria-hidden="true" title="길게 누르세요">
      <div id="progressBar" class="progress-bar"></div>
    </div>
  </div>

  <div id="toast" class="toast"></div>


<script>
(function(){
  console.log("### Trend Popup Script Loaded");

  const DURATION = 1000;
  let timerInterval = null;
  let startTime = 0;
  let activeButton = null;

  const progressBar = document.getElementById('progressBar');
  const toast = document.getElementById('toast');

  const ctrlButtons = document.querySelectorAll('.ctrl-btn');
  console.log("### ctrlButtons count:", ctrlButtons.length);

  if (!progressBar) console.error("❌ progressBar 요소를 찾을 수 없습니다.");
  if (!toast) console.error("❌ toast 요소를 찾을 수 없습니다.");
  if (ctrlButtons.length === 0) {
    console.error("❌ .ctrl-btn 버튼이 없습니다. HTML을 확인하세요.");
    return;
  }

  // ▼ 롱프레스 시작
  function startPress(btn, event){
    event.preventDefault();
    if (timerInterval) return;

    activeButton = btn;
    startTime = Date.now();
    progressBar.style.width = '0%';

    const tag = btn.dataset.tag || 'unknown';
    console.log("### LongPress START - tag:", tag, "time:", new Date().toISOString());

    timerInterval = setInterval(() => {
      const elapsed = Date.now() - startTime;
      const pct = Math.min(1, elapsed / DURATION);
      progressBar.style.width = (pct * 100) + '%';

      if (pct >= 1) {
        clearInterval(timerInterval);
        timerInterval = null;

        console.log("### LongPress COMPLETED - 실행 준비됨");
        completeAction(btn);
      }
    }, 20);
  }

  // ▼ 롱프레스 취소
  function cancelPress(){
    if (timerInterval) {
      clearInterval(timerInterval);
      timerInterval = null;
      console.log("### LongPress CANCELED - user stopped");
    }
    startTime = 0;
    activeButton = null;
    progressBar.style.width = '0%';
  }

  // ▼ 롱프레스 완료 → 실제 명령 실행
  function completeAction(btn){
    const tagName = btn.dataset.tag;

    console.log("### completeAction 실행됨 - tagName:", tagName, "time:", new Date().toISOString());

    showToast("명령 실행");

    console.log("### AJAX 호출: tag =", tagName, ", value=1");

    $.ajax({
      url: "/posco/monitoring/write",
      type: "post",
      data: { tagName: tagName, value: 1 },
      success: function(res){
        console.log("### PLC 쓰기 성공:", res);
      },
      error: function(err){
        console.error("### PLC 쓰기 실패:", err);
      }
    });

    try {
      if (window.opener && !window.opener.closed) {
        console.log("### opener 통신 시도");
        if (typeof window.opener.onPopupResult === 'function') {
          window.opener.onPopupResult({ target: tagName, action: "command", time: new Date().toISOString() });
        } else {
          window.opener.postMessage({ target: tagName, action: "command" }, '*');
        }
      }
    } catch(e) {
      console.warn('opener 통신 실패', e);
    }
  }


  
  function showToast(msg, duration = 1400){
    toast.textContent = msg;
    toast.style.display = 'block';
    setTimeout(()=> toast.style.opacity = '1', 20);
    setTimeout(()=> {
      toast.style.opacity = '0';
      setTimeout(()=> toast.style.display = 'none', 200);
    }, duration);
  }

  // ▼ 버튼 이벤트 바인딩
  ctrlButtons.forEach(btn => {
    btn.addEventListener('mousedown', (e) => startPress(btn, e));
    btn.addEventListener('mouseup', cancelPress);
    btn.addEventListener('mouseleave', cancelPress);

    btn.addEventListener('touchstart', (e) => startPress(btn, e), {passive:false});
    btn.addEventListener('touchend', cancelPress);
    btn.addEventListener('touchcancel', cancelPress);

    btn.addEventListener('keydown', (e) => {
      if (e.key === ' ' || e.key === 'Enter') {
        e.preventDefault();
        startPress(btn, e);
      }
    });
    btn.addEventListener('keyup', cancelPress);
  });

})();

//======================================
//PLC Lamp 상태 감시 (1초마다)
//======================================
function pollLampStatus() {

 const lampMap = [
     { tag: "manual-run-lamp-on", btn: "[data-tag='manual-run-on']" },
     { tag: "auto-run-lamp-on", btn: "[data-tag='auto-run-on']" },
     { tag: "auto-end-lamp-on", btn: "[data-tag='auto-end-on']" },
     { tag: "auto-n2-lamp-on", btn: "[data-tag='auto-n2-on']" },
     { tag: "auto-nomal-lamp-on", btn: "[data-tag='auto-nomal-on']" }
 ];

 lampMap.forEach(item => {
     $.ajax({
         url: "/posco/monitoring/read/bit",
         type: "get",
         data: { tagName: item.tag },
         success: function(res) {
             const btn = document.querySelector(item.btn);

             if (!btn) return;

             if (res.status === "OK" && res.value === true) {
                 btn.classList.add("active");
             } else {
                 btn.classList.remove("active");
             }
         }
     });
 });
}

//1초마다 반복
setInterval(pollLampStatus, 1000);
//즉시 1번 실행
pollLampStatus();

</script>



</body>
</html>