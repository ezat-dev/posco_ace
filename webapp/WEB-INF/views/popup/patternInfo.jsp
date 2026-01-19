<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>패턴관리</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<%@include file="../include/pluginpage.jsp" %> 
<style>
html, body {
    margin: 0;
    padding: 0;
    height: 100%;
    font-family: "Noto Sans KR", "맑은 고딕", Arial, Helvetica, sans-serif;
    background: #f5f5f5;
    overflow: hidden;
}

.container {
    display: flex;
    height: 100vh;
    background: white;
}

/* 헤더 */
.header {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    background: linear-gradient(135deg, #33363d, #4a4d57);
    color: white;
    padding: 20px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    z-index: 1000;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
}

.header-title {
    font-size: 24px;
    font-weight: bold;
    display: flex;
    align-items: center;
    gap: 12px;
}

.header-title::before {
    content: "📁";
    font-size: 28px;
}

.close-btn {
    background: rgba(255, 255, 255, 0.2);
    border: none;
    color: white;
    padding: 10px 20px;
    border-radius: 8px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s ease;
}

.close-btn:hover {
    background: rgba(255, 255, 255, 0.3);
}

/* 상태 표시 영역 */
.status-bar {
    position: fixed;
    top: 80px;
    left: 0;
    right: 0;
    background: white;
    padding: 15px 30px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    z-index: 999;
    display: flex;
    justify-content: center;
    align-items: center;
}

.status-display {
    display: flex;
    align-items: center;
    gap: 15px;
}

.status-label {
    font-size: 16px;
    font-weight: bold;
    color: #33363d;
    display: flex;
    align-items: center;
    gap: 8px;
}

.status-label::before {
    content: "📊";
    font-size: 20px;
}

#patternStatus {
    background: linear-gradient(135deg, #33363d, #4a4d57);
    color: white;
    padding: 8px 20px;
    border-radius: 6px;
    font-size: 15px;
    font-weight: bold;
    box-shadow: 0 2px 8px rgba(51, 54, 61, 0.3);
    min-width: 120px;
    text-align: center;
}

#patternStatus.reading {
    background: linear-gradient(135deg, #2563eb, #3b82f6);
    animation: pulse 1.5s infinite;
}

#patternStatus.writing {
    background: linear-gradient(135deg, #f59e0b, #f97316);
    animation: pulse 1.5s infinite;
}

#patternStatus.read-complete {
    background: linear-gradient(135deg, #10b981, #059669);
}

#patternStatus.write-complete {
    background: linear-gradient(135deg, #10b981, #059669);
}

@keyframes pulse {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.7; }
}

/* 좌측 패턴 트리 */
.pattern-tree {
    width: 250px;
    background: #f8f9fa;
    border-right: 2px solid #e0e0e0;
    overflow-y: auto;
    padding: 20px;
    margin-top: 140px;
}

.pattern-tree-item {
    background: white;
    padding: 15px 20px;
    margin-bottom: 10px;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.3s ease;
    font-weight: bold;
    color: #33363d;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    display: flex;
    align-items: center;
    gap: 10px;
}

.pattern-tree-item::before {
    content: "📄";
    font-size: 18px;
}

.pattern-tree-item:hover {
    background: #e8f0fe;
    transform: translateX(5px);
}

.pattern-tree-item.active {
    background: linear-gradient(135deg, #2563eb, #3b82f6);
    color: white;
}

/* 우측 컨텐츠 영역 */
.pattern-content {
    flex: 1;
    padding: 30px;
    overflow-y: auto;
    margin-top: 140px;
}

.pattern-detail {
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    overflow: hidden;
}

.pattern-detail-header {
    background: linear-gradient(135deg, #33363d, #4a4d57);
    color: white;
    padding: 20px;
    font-size: 20px;
    font-weight: bold;
}

.pattern-detail-body {
    padding: 20px;
}

.pattern-table-container {
    overflow-x: auto;
    margin-bottom: 20px;
}

.pattern-detail-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    border-radius: 8px;
    overflow: hidden;
}

.pattern-detail-table th {
    background: linear-gradient(135deg, #33363d, #4a4d57);
    color: white;
    padding: 12px 8px;
    text-align: center;
    font-weight: bold;
    font-size: 14px;
    border: 1px solid rgba(255, 255, 255, 0.2);
}

.pattern-detail-table td {
    padding: 10px 8px;
    text-align: center;
    font-size: 13px;
    font-weight: 600;
    color: #333;
    border: 1px solid #e0e0e0;
    background: white;
}

.pattern-detail-table td.label {
    background: #f8f9fa;
    font-weight: bold;
}

.pattern-action-buttons {
    display: flex;
    gap: 12px;
    justify-content: center;
    padding-top: 10px;
}

.pattern-action-btn {
    padding: 12px 30px;
    border: none;
    border-radius: 8px;
    font-size: 15px;
    font-weight: bold;
    color: white;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 3px 12px rgba(0, 0, 0, 0.2);
    display: flex;
    align-items: center;
    gap: 8px;
}

.pattern-action-btn.read {
    background: linear-gradient(135deg, #33363d, #4a4d57);
}

.pattern-action-btn.read::before {
    content: "📖";
}

.pattern-action-btn.edit {
    background: linear-gradient(135deg, #f59e0b, #f97316);
}

.pattern-action-btn.edit::before {
    content: "✏️";
}

.pattern-action-btn.apply {
    background: linear-gradient(135deg, #10b981, #059669);
}

.pattern-action-btn.apply::before {
    content: "✓";
}

.pattern-action-btn.rename {
    background: linear-gradient(135deg, #8b5cf6, #7c3aed);
}

.pattern-action-btn.rename::before {
    content: "🏷️";
}

.pattern-action-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
}

.empty-state {
    text-align: center;
    padding: 60px 20px;
    color: #999;
    font-size: 18px;
}

.empty-state::before {
    content: "📋";
    display: block;
    font-size: 60px;
    margin-bottom: 20px;
}

/* 반응형 */
@media (max-width: 768px) {
    .container {
        flex-direction: column;
    }
    
    .pattern-tree {
        width: 100%;
        max-height: 200px;
    }
    
    .header-title {
        font-size: 18px;
    }
}
</style>
</head>
<body>

<div class="header">
    <div class="header-title">패턴 관리</div>
    <button class="close-btn" onclick="window.close()">닫기</button>
</div>

<!-- 상태 표시 바 -->
<div class="status-bar">
    <div class="status-display">
        <span class="status-label">현재 운전 상태</span>
        <div id="patternStatus">-</div>
    </div>
</div>

<div class="container">
    <div class="pattern-tree" id="patternTree">
        <!--동적 생성 -->
    </div>
    
    <div class="pattern-content" id="patternContent">
        <div class="empty-state">
            좌측에서 패턴을 선택하세요
        </div>
    </div>
</div>

<script>

//상태 표시 함수
function setPatternStatus(text, statusClass) {
    const statusEl = document.getElementById("patternStatus");
    if (statusEl) {
        statusEl.textContent = text;
        statusEl.className = '';
        if (statusClass) {
            statusEl.classList.add(statusClass);
        }
    }
}

//비트값 ON 체크용 헬퍼
function isBitOn(value) {
    return value === true || value === 1;
}

//읽기중 / 쓰기중 상태 체크 (순차 실행)
function pollPatternWaitStatus() {
    $.ajax({
        url: "/posco/monitoring/read/waitbit",
        type: "get",
        data: { tagName: "pattern-wait-read" },
        success: function (res) {
            if (res.status === "OK" && isBitOn(res.value)) {
                setPatternStatus("읽기중...", "reading");
            } else {
                checkWriteStatus();
            }
        },
        error: function() {
            checkWriteStatus();
        }
    });
}

function checkWriteStatus() {
    $.ajax({
        url: "/posco/monitoring/read/waitbit",
        type: "get",
        data: { tagName: "pattern-wait-write" },
        success: function (res) {
            if (res.status === "OK" && isBitOn(res.value)) {
                setPatternStatus("쓰기중...", "writing");
            } else {
                pollPatternDoneLamp();
            }
        },
        error: function() {
            pollPatternDoneLamp();
        }
    });
}

function pollPatternDoneLamp() {
    $.ajax({
        url: "/posco/monitoring/read/waitbit",
        type: "get",
        data: { tagName: "pattern-read-lamp" },
        success: function (res) {
            if (res.status === "OK" && isBitOn(res.value)) {
                setPatternStatus("읽기 완료", "read-complete");
            } else {
                checkWriteComplete();
            }
        },
        error: function() {
            checkWriteComplete();
        }
    });
}

function checkWriteComplete() {
    $.ajax({
        url: "/posco/monitoring/read/waitbit",
        type: "get",
        data: { tagName: "pattern-write-lamp" },
        success: function (res) {
            if (res.status === "OK" && isBitOn(res.value)) {
                setPatternStatus("쓰기 완료", "write-complete");
            } else {
                setPatternStatus("-");
            }
        },
        error: function() {
            setPatternStatus("-");
        }
    });
}

// 페이지 로드시 실행
$(document).ready(function() {
    console.log("✅ 페이지 로드 완료");
    
    initPatternTree();
    
    // ✅ 3초로 늘리기 (2초 → 3초)
    setInterval(function() {
        updateAllPatternData();
    }, 3000);
    
    // ✅ 2초로 늘리기 (1초 → 2초)
    setInterval(function() {
        pollPatternWaitStatus();
    }, 2000);
});

// 전체 패턴 데이터 갱신
function updateAllPatternData() {
    $.ajax({
        url: "/posco/monitoring/read/patternInfoAnalog",
        type: "post",
        data: {},
        success: function(res) {
            if (res.status === "NG") {
                console.warn("⚠️ PLC 연결 끊김:", res.error);
                return;
            }
            
            const opcDatas = res.multiValues;
            
            for (let rows in opcDatas) {
                for (let row in opcDatas[rows]) {
                    const d = opcDatas[rows];
                    
                    if (d[row].action == "value") {
                        const elements = document.querySelectorAll('.' + row);
                        elements.forEach(el => {
                            el.textContent = d[row].value;
                        });
                    }
                }
            }
        },
        error: function(err) {
            console.error("❌ 패턴 데이터 읽기 실패:", err);
        }
    });
}

// 패턴 트리 초기화 (DB에서 이름 가져오기)
function initPatternTree() {
    console.log("🔄 패턴 트리 초기화 시작");
    
    $.ajax({
        url: "/posco/monitoring/pattern/names",
        type: "get",
        success: function(res) {
            console.log("✅ 패턴 이름 조회 성공:", res);
            
            if (res.status === "OK") {
                const treeContainer = document.getElementById('patternTree');
                treeContainer.innerHTML = '';
                
                const patternNames = res.patternNames;
                
                for (let i = 1; i <= 14; i++) {
                    const item = document.createElement('div');
                    item.className = 'pattern-tree-item';
                    
                    // DB에서 가져온 이름 사용
                    const patternData = patternNames.find(p => p.pattern_no === i);
                    const displayName = patternData ? patternData.pattern_name : ('패턴 ' + i);
                    
                    item.textContent = displayName;
                    item.dataset.pattern = i;
                    
                    item.addEventListener('click', function() {
                        document.querySelectorAll('.pattern-tree-item').forEach(el => {
                            el.classList.remove('active');
                        });
                        this.classList.add('active');
                        showPatternDetail(i);
                    });
                    
                    treeContainer.appendChild(item);
                }
            } else {
                console.warn("⚠️ 패턴 이름 조회 실패, 기본 이름 사용");
                initPatternTreeDefault();
            }
        },
        error: function(err) {
            console.error("❌ 패턴 이름 조회 에러:", err);
            initPatternTreeDefault();
        }
    });
}

// 기본 패턴 트리 (에러 시 사용)
function initPatternTreeDefault() {
    console.log("🔄 기본 패턴 트리 생성");
    
    const treeContainer = document.getElementById('patternTree');
    treeContainer.innerHTML = '';
    
    for (let i = 1; i <= 14; i++) {
        const item = document.createElement('div');
        item.className = 'pattern-tree-item';
        item.textContent = '패턴 ' + i;
        item.dataset.pattern = i;
        
        item.addEventListener('click', function() {
            document.querySelectorAll('.pattern-tree-item').forEach(el => {
                el.classList.remove('active');
            });
            this.classList.add('active');
            showPatternDetail(i);
        });
        
        treeContainer.appendChild(item);
    }
}

// 패턴 상세 정보 표시
function showPatternDetail(patternNum) {
    const contentContainer = document.getElementById('patternContent');
    
    const detailDiv = document.createElement('div');
    detailDiv.className = 'pattern-detail';
    
    const headerDiv = document.createElement('div');
    headerDiv.className = 'pattern-detail-header';
    headerDiv.textContent = '패턴 ' + patternNum + ' 상세 정보';
    
    const bodyDiv = document.createElement('div');
    bodyDiv.className = 'pattern-detail-body';
    
    const tableContainer = document.createElement('div');
    tableContainer.className = 'pattern-table-container';
    
    const table = document.createElement('table');
    table.className = 'pattern-detail-table';
    
    const colgroup = document.createElement('colgroup');
    const firstCol = document.createElement('col');
    firstCol.style.width = '80px';
    colgroup.appendChild(firstCol);
    for (let i = 0; i < 20; i++) {
        colgroup.appendChild(document.createElement('col'));
    }
    table.appendChild(colgroup);
    
    // Seg 행
    const segRow = document.createElement('tr');
    const segLabel = document.createElement('td');
    segLabel.className = 'label';
    segLabel.textContent = 'Seg';
    segRow.appendChild(segLabel);
    for (let i = 1; i <= 20; i++) {
        const td = document.createElement('td');
        const strong = document.createElement('strong');
        strong.textContent = i;
        td.appendChild(strong);
        segRow.appendChild(td);
    }
    table.appendChild(segRow);
    
    // 시간 행
    const timeRow = document.createElement('tr');
    const timeLabel = document.createElement('td');
    timeLabel.className = 'label';
    timeLabel.textContent = '시간(분)';
    timeRow.appendChild(timeLabel);
    for (let i = 1; i <= 20; i++) {
        const td = document.createElement('td');
        td.className = 'info-pattern-' + patternNum + '-time-' + i;
        td.textContent = '-';
        timeRow.appendChild(td);
    }
    table.appendChild(timeRow);
    
    // 온도 행
    const tempRow = document.createElement('tr');
    const tempLabel = document.createElement('td');
    tempLabel.className = 'label';
    tempLabel.textContent = '온도(℃)';
    tempRow.appendChild(tempLabel);
    for (let i = 1; i <= 20; i++) {
        const td = document.createElement('td');
        td.className = 'info-pattern-' + patternNum + '-temp-' + i;
        td.textContent = '-';
        tempRow.appendChild(td);
    }
    table.appendChild(tempRow);
    
    tableContainer.appendChild(table);
    bodyDiv.appendChild(tableContainer);
    
    // 버튼 영역
    const buttonDiv = document.createElement('div');
    buttonDiv.className = 'pattern-action-buttons';
    
    const readBtn = document.createElement('button');
    readBtn.className = 'pattern-action-btn read';
    readBtn.textContent = '읽기';
    readBtn.onclick = function() { readPattern(patternNum); };
    
    const editBtn = document.createElement('button');
    editBtn.className = 'pattern-action-btn edit';
    editBtn.textContent = '수정';
    editBtn.onclick = function() { editPattern(patternNum); };
    
    const applyBtn = document.createElement('button');
    applyBtn.className = 'pattern-action-btn apply';
    applyBtn.textContent = '적용';
    applyBtn.onclick = function() { applyPattern(patternNum); };
    
    const renameBtn = document.createElement('button');
    renameBtn.className = 'pattern-action-btn rename';
    renameBtn.textContent = '이름변경';
    renameBtn.onclick = function() { renamePattern(patternNum); };
    
    buttonDiv.appendChild(readBtn);
    buttonDiv.appendChild(editBtn);
    buttonDiv.appendChild(applyBtn);
    buttonDiv.appendChild(renameBtn);
    
    bodyDiv.appendChild(buttonDiv);
    
    detailDiv.appendChild(headerDiv);
    detailDiv.appendChild(bodyDiv);
    
    contentContainer.innerHTML = '';
    contentContainer.appendChild(detailDiv);
}

// 패턴 읽기
function readPattern(patternNum) {
    console.log('패턴 ' + patternNum + ' 읽기');
    
    $.ajax({
        url: "/posco/monitoring/write/patternInfoRead",
        type: "post",
        data: { 
            patternNo: patternNum,
            tagName: "pattern-read-" + patternNum
        },
        success: function() {
            console.log("✅ 패턴 " + patternNum + " 읽기 트리거 완료");
            alert("패턴 " + patternNum + " 정보를 읽기를 시작합니다.");
        },
        error: function(err) {
            console.error("❌ 패턴 읽기 실패:", err);
            alert("패턴 읽기 실패");
        }
    });
}

// 패턴 수정
function editPattern(patternNum) {
    console.log('패턴 ' + patternNum + ' 수정 팝업 열기');
    openPopup("/posco/popup/patternWrite?patternNo=" + patternNum, 1250, 300);
}

// 팝업 열기
function openPopup(url, w, h) {
    const left = (window.screen.width - w) / 2;
    const top = (window.screen.height - h) / 2;
    const options = "width=" + w + ",height=" + h + ",left=" + left + ",top=" + top + ",resizable=yes,scrollbars=yes";
    window.open(url, "_blank", options);
}

// 패턴 적용
function applyPattern(patternNum) {
    if (!confirm('패턴 ' + patternNum + '을 운전 패턴으로 적용하시겠습니까?')) {
        return;
    }
    
    console.log('패턴 ' + patternNum + ' 쓰기를 시작합니다.');
    
    $.ajax({
        url: "/posco/monitoring/write/patternInfoAnalogOnly",
        type: "post",
        data: {
            tagName: "pattern-run",
            value: patternNum
        },
        success: function(res) {
            if(res.alert) {
                alert(res.alert);
                return;
            }
            
            console.log("✅ 운전 패턴번호 설정 완료");
            
            $.ajax({
                url: "/posco/monitoring/write/patternInfoApplyBit",
                type: "post",
                data: {
                    tagName: "pattern-on-" + patternNum,
                    value: 1
                },
                success: function() {
                    console.log("✅ 패턴 적용 완료");
                    alert("패턴 " + patternNum + "이 운전 패턴으로 적용되었습니다.");
                },
                error: function(err) {
                    console.error("❌ 패턴 적용 비트 실패:", err);
                    alert("패턴 적용 실패");
                }
            });
        },
        error: function(err) {
            console.error("❌ 패턴번호 설정 실패:", err);
            alert("패턴번호 설정 실패");
        }
    });
}

// 패턴 이름 변경
function renamePattern(patternNum) {
    const newName = prompt('새 패턴 이름을 입력하세요:', '패턴 ' + patternNum);
    
    if (newName === null || newName.trim() === '') {
        return;
    }
    
    $.ajax({
        url: "/posco/monitoring/pattern/name/update",
        type: "post",
        data: {
            pattern_no: patternNum,
            pattern_name: newName.trim()
        },
        success: function(res) {
            if (res.status === "OK") {
                alert(res.message);
                initPatternTree(); // 트리 새로고침
                showPatternDetail(patternNum); // 상세 화면 새로고침
            } else {
                alert(res.message);
            }
        },
        error: function(err) {
            console.error("❌ 이름 변경 실패:", err);
            alert("이름 변경에 실패했습니다.");
        }
    });
}

</script>
</body>
</html>