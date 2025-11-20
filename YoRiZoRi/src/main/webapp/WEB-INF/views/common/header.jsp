<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko"> 
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="${pageContext.request.contextPath}/css/Header.css" rel="stylesheet" type="text/css">
</head>
<body>

	<header>
		<div class="header-left">
		    <a href="${pageContext.request.contextPath}/home" class="logo-link-content">
		        <i class="bi bi-egg-fried" style="color: #FF7043; font-size: 1.8rem;"></i>
		        <h1>요리조리</h1>
		    </a>
		</div>
		    <nav class="header-center">
		        <a href="${pageContext.request.contextPath}/home"><i class="bi bi-house-door-fill"></i> 메인화면</a>
		        <a href="${pageContext.request.contextPath}/select_result"><i class="bi bi-book-fill"></i> 레시피 보기</a>
		        <a href="${pageContext.request.contextPath}/notice"><i class="bi bi-megaphone-fill"></i> 공지 사항</a>
		        <a href="${pageContext.request.contextPath}/board"><i class="bi bi-chat-left-text-fill"></i> 자유 게시판</a>
		    </nav>
			<div class="header-right">
				<a href="${pageContext.request.contextPath}/message_box" 
				   class="message-box-icon" 
				   id="message-box-icon-container"> 
				    
				    <i class="bi bi-chat-dots-fill" id="message-icon" title="쪽지함"></i>
				    
				    <%-- 
				         [유지]: Interceptor를 통해 초기 페이지 로드 시 카운트를 표시합니다. 
				         [추가]: JavaScript가 이 요소를 쉽게 찾을 수 있도록 id를 부여합니다.
				    --%>
				    <c:if test="${unreadCount > 0}">
				        <span class="message-badge" id="message-badge-count">${unreadCount}</span>
				    </c:if>
				</a>
			    <i class="bi bi-person-circle" id="menu-toggle" title="사용자 메뉴"></i>
			</div>
		</header>

		<div class="login-menu" id="login-menu">
		    <c:choose>
		        <c:when test="${empty sessionScope.id}">
		            <button type="button" class="menu-btn" onclick="location.href='${pageContext.request.contextPath}/login'">로그인</button>
		            <button type="button" class="menu-btn" onclick="location.href='${pageContext.request.contextPath}/register'">회원가입</button>
		        </c:when>

		        <c:otherwise>
		            <p>
		                ${sessionScope.name}님 환영합니다!
		            </p>
		            <button type="button" class="menu-btn" onclick="location.href='<c:url value="/list"/>'">마이페이지</button>
		            <form method="post" action="${pageContext.request.contextPath}/logout" style="margin: 0;">
		                <button type="submit" class="menu-btn">로그아웃</button>
		            </form>
		        </c:otherwise>
		    </c:choose>
		    
		    <c:if test="${sessionScope.admin == 1}">
		        <form method="get" action="write_recipe" class="menu-form">
		            <button type="submit" class="menu-btn admin-btn">레시피 등록</button>
		        </form>
		        <form method="get" action="role" class="menu-form">
		            <button type="submit" class="menu-btn admin-btn">관리자페이지</button>
		        </form>
		    </c:if>
		    
		    <c:if test="${sessionScope.admin == 0}">
		        <form method="get" action="write_recipe" class="menu-form">
		            <button type="submit" class="menu-btn user-btn">레시피 등록</button>
		        </form>
		    </c:if>
		</div>

		<script>
		    document.addEventListener("DOMContentLoaded", function() {
		        const menuToggle = document.getElementById('menu-toggle');
		        const loginMenu = document.getElementById('login-menu');

		        // 1. 메뉴 토글 기능
		        if (menuToggle && loginMenu) {
		            menuToggle.addEventListener('click', (event) => {
		                // 클릭 시 이벤트 버블링을 막아, 드롭다운이 바로 닫히는 것을 방지
		                event.stopPropagation(); 
		                loginMenu.classList.toggle('show');
		            });

		            // 2. 외부 클릭 시 닫는 기능 (자동 닫힘)
		            window.addEventListener('click', (event) => {
		                // 메뉴 토글 버튼이나 드롭다운 메뉴 자체가 아닌 곳을 클릭했을 경우 닫기
		                if (loginMenu.classList.contains('show') && 
		                    !menuToggle.contains(event.target) && 
		                    !loginMenu.contains(event.target)) {
		                    
		                    loginMenu.classList.remove('show');
		                }
		            });
		        }
		    });
		</script>
		<script>
		    // ✅ 뱃지 업데이트 함수
		    function updateMessageBadge(count) {
		        const badge = document.getElementById('message-badge-count');
		        const iconContainer = document.getElementById('message-box-icon-container'); // 헤더 <a> 태그의 ID
		        
		        // 1. 기존 뱃지 제거
		        if (badge) {
		            badge.remove();
		        }

		        // 2. 카운트가 0보다 클 때 새 뱃지 생성 및 추가
		        if (count > 0 && iconContainer) {
		            const newBadge = document.createElement('span');
		            newBadge.id = 'message-badge-count';
		            newBadge.className = 'message-badge'; // CSS 클래스는 header.jsp에 정의되어 있어야 함
		            newBadge.textContent = count;
		            iconContainer.appendChild(newBadge);
		        }
		    }

		    // ✅ Polling 함수
		    function checkUnreadMessages() {
		        const contextPath = '${pageContext.request.contextPath}';
		        
		        // 로그인 상태인지 확인 (세션 ID 존재 여부로 간접 확인)
		        if ('${sessionScope.id}' !== '') { 
		            fetch(contextPath + '/message/unread/count')
		                .then(response => response.json())
		                .then(data => {
		                    if (data.success) {
		                        updateMessageBadge(data.count);
		                    }
		                })
		                .catch(error => console.error('실시간 쪽지 카운트 오류:', error));
		        }
		    }

		    // 페이지 로드 시 및 10초마다 폴링 시작
		    document.addEventListener("DOMContentLoaded", function() {
		        // 즉시 한 번 실행
		        checkUnreadMessages();
		        
		        // 10초(10000ms)마다 반복 실행
		        setInterval(checkUnreadMessages, 10000); 
		    });
		</script>

</body>
</html>