<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
  ================================================
  Gemini 챗봇 플로팅 버튼 및 팝업창 (Include용)
  ================================================
--%>

<style>
    /* 플로팅 버튼 (FAB) */
    #gemini-fab {
        position: fixed;
        bottom: 30px;
        right: 30px;
        width: 60px;
        height: 60px;
        background-color: #ff6f61; /* 기존 테마 색상 */
        color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 2rem; /* 아이콘 크기 */
        cursor: pointer;
        box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        z-index: 1050;
        transition: transform 0.2s ease;
    }
    #gemini-fab:hover {
        transform: scale(1.1);
    }
    #gemini-fab i {
        transition: transform 0.3s ease;
    }

    /* 챗봇 창 (팝업) */
    #gemini-chat-window {
        position: fixed;
        bottom: 100px; /* FAB 버튼 바로 위 */
        right: 30px;
        width: 350px;
        height: 480px;
        background-color: white;
        border-radius: 12px;
        box-shadow: 0 6px 20px rgba(0,0,0,0.2);
        z-index: 1049;
        overflow: hidden;
        
        /* 숨기기/보이기 로직 */
        display: none; /* 기본 숨김 */
        flex-direction: column;
        
        /* 부드러운 등장 효과 */
        opacity: 0;
        transform: translateY(20px);
        transition: opacity 0.3s ease, transform 0.3s ease;
    }

    /* 챗봇 창이 보일 때의 스타일 */
    #gemini-chat-window.show {
        display: flex;
        opacity: 1;
        transform: translateY(0);
    }

    /* 챗봇 헤더 */
    .gemini-chat-header {
        background-color: #f5f5f5;
        padding: 15px 20px;
        font-size: 1.1rem;
        font-weight: 700;
        color: #333;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid #e0e0e0;
    }
    .gemini-chat-header span {
        color: #ff6f61;
    }
    #gemini-close-btn {
        font-size: 1.5rem;
        font-weight: 700;
        color: #aaa;
        cursor: pointer;
        border: none;
        background: none;
        padding: 0;
    }
    #gemini-close-btn:hover {
        color: #333;
    }

    /* 챗봇 대화 내용 */
    .gemini-chat-body {
        flex-grow: 1; /* 남은 공간 모두 차지 */
        padding: 20px;
        overflow-y: auto;
        background-color: #fffaf7; /* 기존 테마 배경색 */
    }
    .chat-message {
        margin-bottom: 15px;
        max-width: 85%;
        padding: 10px 15px;
        border-radius: 18px;
        line-height: 1.5;
    }
    .chat-message.gemini {
        background-color: #e8f0fe; /* Gemini 느낌의 파란색 */
        border-bottom-left-radius: 4px;
        align-self: flex-start;
    }
    .chat-message.user {
        background-color: #ffefeb; /* 사용자 메시지 색상 */
        border-bottom-right-radius: 4px;
        align-self: flex-end;
        margin-left: auto; /* 오른쪽 정렬 */
    }

    /* 챗봇 입력창 */
    .gemini-chat-input-area {
        display: flex;
        padding: 15px;
        border-top: 1px solid #e0e0e0;
        background-color: #f_f_f;
    }
    #gemini-input {
        flex-grow: 1;
        border: 1px solid #ddd;
        border-radius: 20px;
        padding: 10px 15px;
        font-size: 1rem;
        margin-right: 10px;
        outline-color: #ff6f61;
    }
    #gemini-send-btn {
        flex-shrink: 0;
        width: 45px;
        height: 45px;
        border-radius: 50%;
        border: none;
        background-color: #ff6f61;
        color: white;
        font-size: 1.2rem;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    #gemini-send-btn i {
        transform: translateX(1px);
    }
</style>


<div id="gemini-fab">
    <i class="bi bi-chat-dots-fill"></i>
</div>

<div id="gemini-chat-window">
    <div class="gemini-chat-header">
        <span>Gemini 챗봇</span>
        <button id="gemini-close-btn">&times;</button>
    </div>
    
    <div class="gemini-chat-body">
        <div class="chat-message gemini">
            안녕하세요! 요리조리 챗봇입니다. 무엇을 도와드릴까요?
        </div>
        </div>
    
    <div class="gemini-chat-input-area">
        <input type="text" id="gemini-input" placeholder="메시지 입력...">
        <button id="gemini-send-btn">
            <i class="bi bi-send-fill"></i>
        </button>
    </div>
</div>


<script>
    (function() {
        // --- 1. DOM 요소 캐싱 ---
        const fab = document.getElementById('gemini-fab');
        const chatWindow = document.getElementById('gemini-chat-window');
        const closeBtn = document.getElementById('gemini-close-btn');
        const chatBody = document.querySelector('.gemini-chat-body');
        const sendBtn = document.getElementById('gemini-send-btn');
        const input = document.getElementById('gemini-input');
        
        if (!fab) {
            console.error("Gemini FAB 버튼(#gemini-fab)을 찾을 수 없습니다.");
            return;
        }
        
        const fabIcon = fab.querySelector('i');

        // --- 2. 팝업창 열기/닫기 이벤트 (기존과 동일) ---
        fab.addEventListener('click', () => {
            chatWindow.classList.toggle('show');
            // ... (아이콘 변경 로직 동일) ...
            if (chatWindow.classList.contains('show')) {
                fabIcon.classList.remove('bi-chat-dots-fill');
                fabIcon.classList.add('bi-x-lg');
                fabIcon.style.transform = 'rotate(90deg)';
            } else {
                fabIcon.classList.remove('bi-x-lg');
                fabIcon.classList.add('bi-chat-dots-fill');
                fabIcon.style.transform = 'rotate(0deg)';
            }
        });
        closeBtn.addEventListener('click', () => {
            chatWindow.classList.remove('show');
            fabIcon.classList.remove('bi-x-lg');
            fabIcon.classList.add('bi-chat-dots-fill');
            fabIcon.style.transform = 'rotate(0deg)';
        });


        // --- 3. [추가] '전송' 버튼 이벤트 ---
        sendBtn.addEventListener('click', sendMessage);
        input.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                sendMessage();
            }
        });

        /**
         * 메시지 전송 함수
         */
        async function sendMessage() {
            const messageText = input.value.trim();
            if (messageText === '') return; // 빈 메시지 무시

            // 1. 사용자 메시지를 채팅창에 표시
            appendMessage(messageText, 'user');
            input.value = ''; // 입력창 비우기

            // 2. Gemini 응답 대기 메시지 표시
            appendMessage('생각 중...', 'gemini', true); // 'loading' 클래스 추가

            try {
                // 3. 백엔드(/gemini/chat)에 API 요청
                const response = await fetch('/gemini/chat', { // (중요) 컨트롤러 경로
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ message: messageText })
                });

                if (!response.ok) {
                    throw new Error('서버 응답 오류: ' + response.statusText);
                }

                const geminiText = await response.text();

                // 4. '생각 중...' 메시지를 실제 Gemini 응답으로 교체
                updateLoadingMessage(geminiText);

            } catch (error) {
                console.error('Error:', error);
                // 5. 오류 발생 시 '생각 중...' 메시지를 오류 메시지로 교체
                updateLoadingMessage('죄송합니다. 오류가 발생했어요.');
            }
        }

        /**
         * 채팅창에 메시지 DIV를 추가하는 함수
         * @param {string} text - 메시지 내용
         * @param {string} type - 'user' 또는 'gemini'
         * @param {boolean} [isLoading=false] - 로딩 메시지 여부 (ID 부여용)
         */
        function appendMessage(text, type, isLoading = false) {
            const messageDiv = document.createElement('div');
            messageDiv.classList.add('chat-message', type);
            
            if (isLoading) {
                messageDiv.id = 'gemini-loading-msg'; // 나중에 찾기 위한 ID
            }
            
            // (참고) \n을 <br>로 바꿔서 HTML에 삽입 (줄바꿈 처리)
            messageDiv.innerHTML = text.replace(/\n/g, '<br>');
            
            chatBody.appendChild(messageDiv);
            
            // 새 메시지 추가 시 스크롤을 맨 아래로 이동
            chatBody.scrollTop = chatBody.scrollHeight;
        }
        
        /**
         * '생각 중...' 메시지를 찾아 실제 응답으로 업데이트하는 함수
         * @param {string} text - Gemini의 실제 응답 또는 오류 메시지
         */
        function updateLoadingMessage(text) {
            const loadingDiv = document.getElementById('gemini-loading-msg');
            if (loadingDiv) {
                loadingDiv.innerHTML = text.replace(/\n/g, '<br>'); // 줄바꿈 처리
                loadingDiv.id = ''; // ID 제거
                chatBody.scrollTop = chatBody.scrollHeight;
            }
        }

    })();
</script>