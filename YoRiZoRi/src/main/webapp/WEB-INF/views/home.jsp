<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>요리조리 - 세상의 모든 레시피</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
    <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background: #f8f9fa;
            color: #333;
            line-height: 1.6;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 50px 30px;
        }

        /* Hero Section */
		.hero-section {
		            position: relative;
		            height: 65vh;
		            min-height: 500px;
		            display: flex;
		            align-items: center;
		            justify-content: center;
		            text-align: center;
		            overflow: hidden;
		            margin-bottom: 60px;
		        }

        .hero-section .slider {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1;
        }

        .hero-section .slides {
            display: flex;
            height: 100%;
            transition: transform 1s ease-in-out;
        }

        .hero-section .slide {
            min-width: 100%;
            height: 100%;
            position: relative;
        }

        .hero-section .slide::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.4);
        }

        .hero-section .slide img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

		.hero-content {
		            position: relative;
		            z-index: 2;
		            max-width: 800px; /* 최대 너비를 늘려서 제목이 더 잘 보이도록 */
		            padding: 30px;
		        }

		        .hero-content h2 {
		            font-size: 3.5rem; /* 폰트 크기 확대 */
		            font-weight: 800; /* 폰트 굵기 강조 */
		            color: white;
		            margin-bottom: 40px; /* 검색 바와의 간격 확대 */
		            /* 더 깊은 그림자 효과로 제목 강조 */
		            text-shadow: 0 4px 15px rgba(0, 0, 0, 0.5); 
		            letter-spacing: -1px; /* 글자 간격 조정 */
		        }

        /* Search Bar */
		.main-search {
		            display: flex;
		            max-width: 650px; /* 검색 바 너비 확대 */
		            margin: 0 auto 25px;
		            background: #ffffff; /* 배경을 흰색으로 고정 */
		            border-radius: 50px;
		            overflow: hidden;
		            /* 더 부드러운 그림자 */
		            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2); 
		            border: 2px solid rgba(255, 107, 107, 0.3); /* 연한 테두리 추가 */
		        }

		        .main-search input {
		            flex: 1;
		            border: none;
		            padding: 18px 30px; /* 패딩 확대 */
		            font-size: 16px;
		            outline: none;
		            /* placeholder 스타일링 */
		            &::placeholder {
		                color: #aaa;
		            }
		        }

		        .main-search button {
		            border: none;
		            /* 그라데이션 배경으로 변경 */
		            background: linear-gradient(90deg, #ff6b6b 0%, #ff8e8e 100%); 
		            color: white;
		            padding: 0 35px; /* 패딩 확대 */
		            cursor: pointer;
		            font-size: 20px;
		            transition: all 0.3s;
		        }

		        .main-search button:hover {
		            /* hover 시 배경을 더 어둡고 강하게 */
		            background: linear-gradient(90deg, #ff5252 0%, #ff6b6b 100%);
		            transform: scale(1.02); /* 버튼 클릭 유도 효과 */
		        }

        /* Quick Tags */
        .quick-tags {
            display: none;
        }

        /* Section Title */
        .section-title {
            text-align: center;
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 40px;
            color: #2c3e50;
        }

        /* Recipe Grid */
        .recipe-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
        }

        .recipe-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
        }

        .recipe-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .recipe-card img {
            width: 100%;
            height: 220px;
            object-fit: cover;
            transition: transform 0.5s;
        }

        .recipe-card:hover img {
            transform: scale(1.05);
        }

        .card-content {
            padding: 24px;
        }

        .card-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 10px;
            color: #2c3e50;
        }

        .card-desc {
            font-size: 0.95rem;
            color: #7f8c8d;
            line-height: 1.5;
        }

		/* Chef Grid */
		        .chef-grid {
		            display: grid;
		            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
		            gap: 30px;
		        }

		        .chef-card {
		            background: white;
		            border-radius: 16px;
		            overflow: hidden;
		            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
		            transition: all 0.3s ease;
		            text-align: center;
		        }

		        .chef-card:hover {
		            transform: translateY(-8px);
		            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
		        }

		        .chef-image {
		            width: 120px; /* Adjust size as needed */
		            height: 120px; /* Adjust size as needed */
		            margin: 20px auto 10px; /* Center the image and add space */
		            overflow: hidden;
		            background: #f0f0f0;
		            border-radius: 50%; /* Make it circular */
		            border: 3px solid #ff6b6b; /* Optional: add a border */
		        }

		        .chef-image img {
		            width: 100%;
		            height: 100%;
		            object-fit: cover;
		            transition: transform 0.5s;
		        }

		        .chef-card:hover .chef-image img {
		            transform: scale(1.1);
		        }

		        .chef-info {
		            padding: 0 20px 20px; /* Adjust padding for info */
		        }

		        .chef-name {
		            font-size: 1.1rem;
		            font-weight: 600;
		            color: #2c3e50;
		            margin-bottom: 8px;
		        }

		        .chef-recipes {
		            font-size: 0.9rem;
		            color: #7f8c8d;
		        }

        /* Chat Button */
        .chat-button {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
            transition: all 0.3s;
            z-index: 1000;
        }

        .chat-button:hover {
            transform: scale(1.1);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
        }

        .chat-button i {
            font-size: 28px;
            color: white;
        }

        .chat-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #ff4444;
            color: white;
            border-radius: 50%;
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: bold;
        }

        /* Chat Popup */
        .chat-popup {
            position: fixed;
            bottom: 100px;
            right: 30px;
            width: 380px;
            height: 550px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            display: none;
            flex-direction: column;
            z-index: 999;
            overflow: hidden;
        }

        .chat-popup.show {
            display: flex;
            animation: slideUp 0.3s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .chat-popup-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 18px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .chat-popup-header h3 {
            margin: 0;
            font-size: 17px;
            font-weight: 600;
        }

        .chat-popup-controls {
            display: flex;
            gap: 5px;
        }

        .chat-popup-controls button {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            color: white;
            width: 30px;
            height: 30px;
            border-radius: 6px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background 0.2s;
        }

        .chat-popup-controls button:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        .chat-popup-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        .chat-login-required {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 20px;
            padding: 40px;
            text-align: center;
        }

        .chat-login-required i {
            font-size: 3rem;
            color: #ccc;
        }

        .chat-login-required p {
            color: #666;
            font-size: 15px;
        }

        .chat-login-btn {
            padding: 12px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
            transition: transform 0.2s;
        }

        .chat-login-btn:hover {
            transform: scale(1.05);
        }

        .chat-messages-mini {
            flex: 1;
            padding: 15px;
            overflow-y: auto;
            background: #f8f9fa;
        }

        .message-mini {
            margin-bottom: 12px;
        }

        .message-mini.enter, .message-mini.leave {
            text-align: center;
            color: #999;
            font-size: 12px;
            font-style: italic;
        }

        .message-mini.talk {
            display: flex;
            flex-direction: column;
        }

        .message-mini.my-message {
            align-items: flex-end;
        }

        .message-content-mini {
            max-width: 70%;
            padding: 10px 15px;
            border-radius: 16px;
            word-wrap: break-word;
            font-size: 14px;
        }

        .message-mini.talk:not(.my-message) .message-content-mini {
            background: white;
            border: 1px solid #e0e0e0;
        }

        .message-mini.my-message .message-content-mini {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .message-sender-mini {
            font-size: 11px;
            color: #666;
            margin-bottom: 4px;
            font-weight: 600;
        }

        .message-time-mini {
            font-size: 10px;
            color: #999;
            margin-top: 4px;
        }

        .chat-input-mini {
            padding: 15px;
            background: white;
            border-top: 1px solid #e0e0e0;
            display: flex;
            gap: 10px;
        }

        .chat-input-mini input {
            flex: 1;
            padding: 10px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 20px;
            font-size: 13px;
            outline: none;
            transition: border 0.2s;
        }

        .chat-input-mini input:focus {
            border-color: #667eea;
        }

        .chat-input-mini button {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: transform 0.2s;
        }

        .chat-input-mini button:hover {
            transform: scale(1.1);
        }

        /* Scrollbar */
        .chat-messages-mini::-webkit-scrollbar {
            width: 6px;
        }

        .chat-messages-mini::-webkit-scrollbar-thumb {
            background: #ccc;
            border-radius: 10px;
        }

        .chat-messages-mini::-webkit-scrollbar-thumb:hover {
            background: #999;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 40px 20px;
            }

            .hero-section {
                height: 60vh;
            }

            .hero-content h2 {
                font-size: 2rem;
            }

            .recipe-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 20px;
            }

            .category-grid {
                grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
            }

            .chef-grid {
                grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
                gap: 20px;
            }

            .chat-popup {
                width: calc(100% - 40px);
                right: 20px;
                left: 20px;
            }

            .chat-button {
                bottom: 20px;
                right: 20px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    
	<main>
	        <section class="hero-section">
	            <div class="slider">
	                <div class="slides">
	                    <div class="slide">
	                        <img src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=1200" alt="요리">
	                    </div>
	                </div>
	            </div>
	            <div class="hero-content">
	                <h2>맛있는 레시피를 찾아보세요</h2>
	                <form action="search_result" method="get" class="main-search">
	                    <input type="text" name="query" placeholder="요리, 재료, 테마로 검색해보세요">
	                    <button type="submit"><i class="bi bi-search"></i></button>
	                </form>
	            </div>
	        </section>

        <!-- 오늘의 추천 레시피 -->
        <section class="container">
            <h2 class="section-title">오늘의 추천 레시피</h2>
            <div class="recipe-grid">
                <c:forEach var="recipe" items="${randomRecipes}">
                    <a href="detail.do?recipe_Id=${recipe.recipeId}" class="recipe-card">
                        <img src="${recipe.mainImage}" alt="${recipe.title}">
                        <div class="card-content">
                            <h3 class="card-title">${recipe.title}</h3>
                            <p class="card-desc">${recipe.description}</p>
                        </div>
                    </a>
                </c:forEach>

                <c:if test="${empty randomRecipes}">
                    <p style="text-align: center; grid-column: 1 / -1; color: #999;">
                        추천 레시피를 준비 중입니다. 🧑‍🍳
                    </p>
                </c:if>
            </div>
        </section>

        <!-- 인기 회원 -->
        <section class="container">
            <h2 class="section-title">추천 회원</h2>
            <div class="chef-grid">
                <c:forEach var="member" items="${randomMembers}">
                    <a href="member_profile?id=${member.memberId}" class="chef-card">
                        <div class="chef-image">
                            <c:choose>
                                <c:when test="${not empty member.profileImage}">
                                    <img src="${member.profileImage}" alt="${member.nickname}">
                                </c:when>
                                <c:otherwise>
                                    <img src="https://via.placeholder.com/200x200/667eea/ffffff?text=${member.nickname}" alt="${member.nickname}">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="chef-info">
                            <h3 class="chef-name">${member.nickname}</h3>
                        </div>
                    </a>
                </c:forEach>

                <c:if test="${empty randomMembers}">
                    <p style="text-align: center; grid-column: 1 / -1; color: #999;">
                        회원 정보를 불러오는 중입니다. 👨‍🍳
                    </p>
                </c:if>
            </div>
        </section>
    </main>

    <!-- Chat Button -->
    <div class="chat-button" id="chatButton" onclick="toggleChatPopup()">
        <i class="bi bi-chat-dots-fill"></i>
        <span class="chat-badge" id="chatBadge">N</span>
    </div>

    <!-- Chat Popup -->
    <div class="chat-popup" id="chatPopup">
        <div class="chat-popup-header">
            <h3><i class="fa-solid fa-message"></i> 전체 채팅방</h3>
            <div class="chat-popup-controls">
                <button onclick="minimizeChatPopup()" title="최소화">
                    <i class="bi bi-dash"></i>
                </button>
                <button onclick="toggleChatPopup()" title="닫기">
                    <i class="bi bi-x"></i>
                </button>
            </div>
        </div>
        
        <div class="chat-popup-content">
            <c:choose>
                <c:when test="${empty sessionScope.id}">
                    <div class="chat-login-required">
                        <i class="bi bi-lock-fill"></i>
                        <p>로그인이 필요합니다</p>
                        <button onclick="location.href='${pageContext.request.contextPath}/login'" class="chat-login-btn">
                            로그인하기
                        </button>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="chat-messages-mini" id="chatMessagesPopup"></div>
                    <div class="chat-input-mini">
                        <input type="text" id="messageInputPopup" placeholder="메시지 입력..." maxlength="1000">
                        <button onclick="sendMessagePopup()">
                            <i class="bi bi-send-fill"></i>
                        </button>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <c:if test="${not empty sessionScope.id}">
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
    <script>
    let stompClientPopup = null;
    let currentUserIdPopup = '${sessionScope.id}';
    let currentUsernamePopup = '${sessionScope.name}';
    let isPopupConnected = false;

    function toggleChatPopup() {
        const popup = document.getElementById('chatPopup');
        popup.classList.toggle('show');
        if (popup.classList.contains('show') && !isPopupConnected) {
            connectWebSocketPopup();
        }
    }

    function minimizeChatPopup() {
        document.getElementById('chatPopup').classList.remove('show');
    }

    function connectWebSocketPopup() {
        const socket = new SockJS('${pageContext.request.contextPath}/ws-chat');
        stompClientPopup = Stomp.over(socket);
        
        stompClientPopup.connect({}, function() {
            isPopupConnected = true;
            stompClientPopup.subscribe('/topic/public', function(payload) {
                const message = JSON.parse(payload.body);
                displayMessagePopup(message);
            });
            stompClientPopup.send("${pageContext.request.contextPath}/app/chat.addUser", {},
                JSON.stringify({
                    senderId: currentUserIdPopup,
                    senderNickname: currentUsernamePopup,
                    type: 'ENTER'
                })
            );
            loadRecentMessagesPopup();
        }, function(error) {
            console.error('WebSocket 연결 오류:', error);
            isPopupConnected = false;
        });
    }

    function sendMessagePopup() {
        const messageInput = document.getElementById('messageInputPopup');
        const messageContent = messageInput.value.trim();
        
        if (messageContent && stompClientPopup && isPopupConnected) {
            const chatMessage = {
                senderId: currentUserIdPopup,
                senderNickname: currentUsernamePopup,
                message: messageContent,
                type: 'TALK'
            };
            stompClientPopup.send("${pageContext.request.contextPath}/app/chat.sendMessage", {}, JSON.stringify(chatMessage));
            messageInput.value = '';
        }
    }

    function displayMessagePopup(message) {
        const messagesDiv = document.getElementById('chatMessagesPopup');
        const messageElement = document.createElement('div');
        messageElement.classList.add('message-mini');
        
        if (message.type === 'ENTER' || message.type === 'LEAVE') {
            messageElement.classList.add(message.type.toLowerCase());
            messageElement.textContent = message.message;
        } else {
            messageElement.classList.add('talk');
            if (message.senderId === currentUserIdPopup) {
                messageElement.classList.add('my-message');
            }
            
            const time = message.sentAt ? new Date(message.sentAt).toLocaleTimeString('ko-KR', {
                hour: '2-digit', minute: '2-digit'
            }) : new Date().toLocaleTimeString('ko-KR', {
                hour: '2-digit', minute: '2-digit'
            });
            
            messageElement.innerHTML = 
                (message.senderId !== currentUserIdPopup ? '<div class="message-sender-mini">' + escapeHtml(message.senderNickname) + '</div>' : '') +
                '<div class="message-content-mini">' + escapeHtml(message.message) + '</div>' +
                '<div class="message-time-mini">' + time + '</div>';
        }
        
        messagesDiv.appendChild(messageElement);
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
    }

    function loadRecentMessagesPopup() {
        fetch('${pageContext.request.contextPath}/api/chat/recent?limit=30')
            .then(response => response.json())
            .then(messages => {
                messages.reverse().forEach(message => {
                    message.type = 'TALK';
                    displayMessagePopup(message);
                });
            })
            .catch(error => console.error('메시지 로드 실패:', error));
    }

    function escapeHtml(text) {
        const map = {'&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;'};
        return text.replace(/[&<>"']/g, m => map[m]);
    }

    document.addEventListener('DOMContentLoaded', function() {
        const input = document.getElementById('messageInputPopup');
        if (input) {
            input.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') sendMessagePopup();
            });
        }
    });

    window.addEventListener('beforeunload', () => {
        if (stompClientPopup !== null) {
            stompClientPopup.disconnect();
        }
    });
    </script>
    </c:if>

    <script>
    // Slider
    const slides = document.querySelector('.slides');
    const slideCount = document.querySelectorAll('.hero-section .slide').length;
    let currentIndex = 0;
    
    function showNextSlide() {
        currentIndex = (currentIndex + 1) % slideCount;
        slides.style.transform = `translateX(-${currentIndex * 100}%)`;
    }
    setInterval(showNextSlide, 4000);
    </script>

    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>