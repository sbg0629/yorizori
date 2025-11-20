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
            height: 80vh; /* 높이 증가 */
            min-height: 650px;
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
            background: rgba(0, 0, 0, 0.45); /* 배경 오버레이 조금 더 진하게 */
        }

        .hero-section .slide img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            max-width: 1000px; /* 최대 너비를 늘려서 레시피 카드 수용 */
            padding: 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%;
        }

        .hero-content h2 {
            font-size: 3.5rem;
            font-weight: 800;
            color: white;
            margin-bottom: 30px;
            text-shadow: 0 4px 15px rgba(0, 0, 0, 0.7); /* 그림자 더 강조 */
            letter-spacing: -1px;
        }

        /* Search Bar */
        .main-search {
            display: flex;
            max-width: 650px;
            margin: 0 auto 50px; /* 레시피 목록과의 간격 확대 */
            background: #ffffff;
            border-radius: 50px;
            overflow: hidden;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
            border: 2px solid rgba(255, 107, 107, 0.3);
        }

        .main-search input {
            flex: 1;
            border: none;
            padding: 18px 30px;
            font-size: 16px;
            outline: none;
            &::placeholder {
                color: #aaa;
            }
        }

        .main-search button {
            border: none;
            background: linear-gradient(90deg, #ff6b6b 0%, #ff8e8e 100%);
            color: white;
            padding: 0 35px;
            cursor: pointer;
            font-size: 20px;
            transition: all 0.3s;
        }

        .main-search button:hover {
            background: linear-gradient(90deg, #ff5252 0%, #ff6b6b 100%);
            transform: scale(1.02);
        }
        
        /* --- New Hero Recipe Styles --- */

        .hero-recipe-scroller {
            width: 100%;
            padding: 25px;
            /* 반투명한 흰색 배경 */
            background: rgba(255, 255, 255, 0.15); 
            backdrop-filter: blur(5px); /* 배경 블러 처리로 가독성 향상 */
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3); /* 연한 테두리 */
            text-align: left;
        }

        .hero-section-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: white;
            margin-bottom: 20px;
            padding-left: 10px;
            text-shadow: 0 2px 5px rgba(0, 0, 0, 0.5);
        }

        .horizontal-recipe-grid {
            display: flex; /* 수평 배열 */
            overflow-x: auto; /* 수평 스크롤 허용 */
            gap: 20px;
            padding-bottom: 10px; /* 스크롤 바 공간 확보 */
            scrollbar-width: thin; /* Firefox */
            scrollbar-color: rgba(255, 255, 255, 0.5) transparent;
        }

        /* WebKit browsers (Chrome, Safari) scrollbar styling */
        .horizontal-recipe-grid::-webkit-scrollbar {
            height: 8px;
        }

        .horizontal-recipe-grid::-webkit-scrollbar-thumb {
            background-color: rgba(255, 255, 255, 0.5);
            border-radius: 10px;
        }

        .horizontal-recipe-grid::-webkit-scrollbar-track {
            background: transparent;
        }

        .recipe-card {
            min-width: 280px; /* 카드 최소 너비 설정 */
            max-width: 280px; /* 카드 최대 너비 설정 */
            background: white;
            border-radius: 12px; /* 둥근 모서리 */
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .recipe-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
        }
        
        .recipe-card img {
            width: 100%;
            height: 180px; /* 이미지 높이 조정 */
            object-fit: cover;
            transition: transform 0.5s;
        }

        .card-content {
            padding: 15px; /* 패딩 조정 */
        }

        .card-title {
            font-size: 1.1rem; /* 폰트 크기 조정 */
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 5px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .card-desc {
            font-size: 0.85rem;
            color: #7f8c8d;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .no-recipe-message {
            color: white;
            padding: 30px;
            text-align: center;
            width: 100%;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.5);
        }
        
        /* --- End New Hero Recipe Styles --- */

        /* Section Title (General) */
        .section-title {
            text-align: center;
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 40px;
            color: #2c3e50;
        }

        /* Recipe Grid (General, now used only for the part below hero) */
        .recipe-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
        }

		/* Chef Grid */
		.chef-grid {
		    display: grid;
		    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
		    gap: 30px;
		}

		.chef-card {
		    position: relative; /* 배지 위치 설정을 위해 추가 */
		    background: white;
		    border-radius: 16px;
		    overflow: hidden;
		    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); /* 그림자를 조금 더 깊게 */
		    transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1); /* 좀 더 부드러운 트랜지션 */
		    text-align: center;
		    border: 1px solid #eee; /* 은은한 테두리 추가 */
		}

		.chef-card:hover {
		    transform: translateY(-5px); /* 약간만 올라오도록 조정 */
		    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
		    border-color: #ff6b6b; /* 호버 시 테두리 색상 강조 */
		}

		/* 신규: 추천 배지 스타일 */
		.chef-badge {
		    position: absolute;
		    top: 10px;
		    right: 10px;
		    background: linear-gradient(45deg, #ff6b6b 0%, #ff8e8e 100%); /* 그라데이션 배경 */
		    color: white;
		    padding: 4px 10px;
		    border-radius: 20px;
		    font-size: 0.75rem;
		    font-weight: 700;
		    letter-spacing: 0.5px;
		    box-shadow: 0 2px 5px rgba(255, 107, 107, 0.4);
		    display: flex;
		    align-items: center;
		    gap: 4px;
		}

		.chef-image {
		    width: 120px;
		    height: 120px;
		    margin: 30px auto 15px; /* 상단 마진 조정 */
		    overflow: hidden;
		    background: #f0f0f0;
		    border-radius: 50%;
		    /* 그라데이션 테두리 효과를 위한 복합 배경 설정 */
		    border: 4px solid transparent; 
		    background-image: linear-gradient(white, white), linear-gradient(to right, #667eea 0%, #ff6b6b 100%);
		    background-origin: border-box;
		    background-clip: padding-box, border-box;
		    padding: 3px; /* 내부 공간 확보 */
		}

		.chef-image img {
		    width: 100%;
		    height: 100%;
		    object-fit: cover;
		    transition: transform 0.5s;
		    border-radius: 50%; /* 이미지 자체도 둥글게 */
		}

		.chef-card:hover .chef-image img {
		    transform: scale(1.05); /* 덜 과장된 호버 효과 */
		}

		.chef-info {
		    padding: 0 20px 25px; /* 하단 패딩 조정 */
		}

		.chef-name {
		    font-size: 1.2rem; /* 이름 폰트 크기 증가 */
		    font-weight: 700;
		    color: #2c3e50;
		    margin-bottom: 5px;
		}

		.chef-recipes { /* 레시피 정보 스타일 개선 */
		    font-size: 0.85rem;
		    color: #7f8c8d;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    gap: 5px;
		    font-weight: 500;
		}
		.chef-recipes i {
		    color: #ff6b6b; /* 아이콘 색상을 포인트 색상으로 */
		    font-size: 0.95rem;
		}

        /* Chat Button & Popup Styles (No change needed here) */
        /* ... (Keep the rest of the existing chat/responsive styles) */
        
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
                height: auto;
                min-height: 500px;
            }

            .hero-content h2 {
                font-size: 2rem;
            }

            .hero-recipe-scroller {
                padding: 15px;
            }

            .horizontal-recipe-grid {
                gap: 15px;
            }

            .recipe-card {
                min-width: 250px;
                max-width: 250px;
            }

            .chef-grid {
                grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
                gap: 20px;
            }

            .chat-popup {
                width: calc(100% - 40px);
                right: 20px;
                left: 20px;
                height: 450px;
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
	                    <img src="https://images.unsplash.com/photo-1543353071-10c8ba85a904?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8JUVDJTlEJThDJUVDJThCJTlEJTIwJUVCJUIwJUIwJUVBJUIyJUJEfGVufDB8fDB8fHww&fm=jpg&q=60&w=3000" alt="요리">
	                </div>
	            </div>
	        </div>
	        <div class="hero-content">
	            <h2>맛있는 레시피를 찾아보세요</h2>
	            <FORM ACTION="SEARCH_RESULT" METHOD="GET" CLASS="MAIN-SEARCH">
	                <BUTTON TYPE="SUBMIT"><I CLASS="BI BI-SEARCH"></I></BUTTON>
	            </FORM>

	            <div class="hero-recipe-scroller">
	                <h3 class="hero-section-title">오늘의 추천 레시피</h3>
	                <div class="horizontal-recipe-grid">
	                    <c:forEach var="recipe" items="${randomRecipes}">
	                        <a href="detail.do?recipe_Id=${recipe.recipeId}" class="recipe-card">
	                            <img src="/images/${recipe.mainImage}" alt="${recipe.title}">
	                            <div class="card-content">
	                                <h4 class="card-title">${recipe.title}</h4>
	                                <p class="card-desc">${recipe.description}</p>
	                            </div>
	                        </a>
	                    </c:forEach>
	                    <c:if test="${empty randomRecipes}">
	                        <p class="no-recipe-message">
	                            추천 레시피를 준비 중입니다. 🧑‍🍳
	                        </p>
	                    </c:if>
	                </div>
	            </div>
	        </div>
	    </section>

        <section class="container">
            <h2 class="section-title">추천 회원</h2>
            <div class="chef-grid">
                <c:forEach var="member" items="${randomMembers}">
                    <a href="member_profile?id=${member.memberId}" class="chef-card">
                        <div class="chef-image">
							
                            <c:choose>
								<c:when test="${not empty member.profileImage}"> 
					                <img src="${pageContext.request.contextPath}/images/${member.profileImage}" 
					                     alt="${member.nickname} 프로필 이미지" class="profile-img">
					            </c:when>
					            <c:otherwise>
					                <img src="${pageContext.request.contextPath}/images/기본프로필.png" 
					                     alt="기본 프로필 이미지" class="profile-img">
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

    <div class="chat-button" id="chatButton" onclick="toggleChatPopup()">
        <i class="bi bi-chat-dots-fill"></i>
        <span class="chat-badge" id="chatBadge">N</span>
    </div>

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