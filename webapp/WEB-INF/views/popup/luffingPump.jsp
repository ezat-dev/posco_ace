<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>러핑펌프</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<style>
  html,body{margin:0;padding:0;height:100%;font-family:Arial,Helvetica,sans-serif;background:#fff;}
  .container{box-sizing:border-box;width:100%;height:100%;display:flex;flex-direction:column;align-items:center;justify-content:center;padding:6px;}
  .header{width:100%;text-align:center;background:#33363d;color:#fff;padding:6px 0;font-size:16px;border-radius:4px;}
  .controls{margin-top:8px;display:flex;gap:10px;align-items:center;flex-direction:row;}
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
</style>
</head>
<body>
  <div class="container no-select">
    <div class="header">러핑펌프</div>

    <div class="controls" style="margin-top:8px;">
      <button id="btnOff" class="btn off">OFF</button>
      <button id="btnOn" class="btn on">ON</button>
    </div>

    <div class="progress-wrap" aria-hidden="true" title="길게 누르세요">
      <div id="progressBar" class="progress-bar"></div>
    </div>
  </div>

  <div id="toast" class="toast"></div>

<script>
(function(){
  const DURATION = 2000; // 3초
  let timerInterval = null;
  let startTime = 0;
  let activeButton = null;

  const progressBar = document.getElementById('progressBar');
  const toast = document.getElementById('toast');

  
  const btnOff = document.getElementById('btnOff');
  const btnOn = document.getElementById('btnOn');

  
  function startPress(btn, event){
    event.preventDefault(); 
    if (timerInterval) return; 
    activeButton = btn;
    startTime = Date.now();
    progressBar.style.width = '0%';

    
    timerInterval = setInterval(() => {
      const elapsed = Date.now() - startTime;
      const pct = Math.min(1, elapsed / DURATION);
      progressBar.style.width = (pct * 100) + '%';

      if (pct >= 1) {
        completeAction(btn);
        clearInterval(timerInterval);
        timerInterval = null;
      }
    }, 20);
  }

  
  function cancelPress(){
    if (timerInterval) {
      clearInterval(timerInterval);
      timerInterval = null;
    }
    startTime = 0;
    activeButton = null;
    progressBar.style.width = '0%';
  }

  
  function completeAction(btn){
    const label = btn.id === 'btnOff' ? 'OFF' : 'ON';
    showToast(label + ' 작업 완료');

    
    try {
      if (window.opener && !window.opener.closed) {
        
        if (typeof window.opener.onPopupResult === 'function') {
          window.opener.onPopupResult({ target: 'luffingPump', action: label, time: new Date().toISOString() });
        } else {
          
          window.opener.postMessage({ target: 'luffingPump', action: label }, '*');
        }
      }
    } catch(e) {
      
      console.warn('opener 통신 실패', e);
    }
  }

 
  function showToast(msg, duration = 1400){
    toast.textContent = msg;
    toast.style.display = 'block';
    setTimeout(()=> {
      toast.style.opacity = '1';
    }, 20);
    setTimeout(()=> {
      toast.style.opacity = '0';
      setTimeout(()=> toast.style.display = 'none', 200);
    }, duration);
  }

 
  function bindLongPress(el){
    // mouse
    el.addEventListener('mousedown', (e)=> startPress(el, e));
    el.addEventListener('mouseup', cancelPress);
    el.addEventListener('mouseleave', cancelPress);

    // touch
    el.addEventListener('touchstart', (e)=> startPress(el, e), {passive:false});
    el.addEventListener('touchend', cancelPress);
    el.addEventListener('touchcancel', cancelPress);
  }

  bindLongPress(btnOff);
  bindLongPress(btnOn);

  
  [btnOff, btnOn].forEach(btn=>{
    btn.addEventListener('keydown', (e)=>{
      if (e.key === ' ' || e.key === 'Enter') {
        e.preventDefault();
        startPress(btn, e);
      }
    });
    btn.addEventListener('keyup', (e)=>{
      if (e.key === ' ' || e.key === 'Enter') {
        cancelPress();
      }
    });
  });

})();
</script>
</body>
</html>
