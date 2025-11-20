<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${memberInfo.nickname}님의 프로필 - 요리조리</title>
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

        /* Main Container */
        .profile-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 50px 30px;
            display: grid;
            grid-template-columns: 350px 1fr;
            gap: 40px;
        }

        /* 왼쪽 - 회원 정보 */
        .member-info-card {
            background: white;
            border-radius: 20px;
            padding: 40px 30px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
            height: fit-content;
            position: sticky;
            top: 30px;
        }

        .profile-image-wrapper {
            text-align: center;
            margin-bottom: 25px;
        }

        .profile-image {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #f0f0f0;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .member-nickname {
            font-size: 1.8rem;
            font-weight: 700;
            color: #2c3e50;
            text-align: center;
            margin-bottom: 10px;
        }

        .member-id {
            text-align: center;
            color: #7f8c8d;
            font-size: 0.95rem;
            margin-bottom: 25px;
        }

        .info-divider {
            height: 1px;
            background: #e0e0e0;
            margin: 25px 0;
        }

        .info-item {
            display: flex;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #f5f5f5;
        }

        .info-item:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: 600;
            color: #555;
            min-width: 80px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-label i {
            font-size: 1.1rem;
            color: #ff6b6b;
        }

        .info-value {
            color: #666;
        }

        .stats-container {
            display: grid;
            grid-template-columns: 1fr;
            gap: 15px;
            margin-top: 25px;
        }

        .stat-box {
            background: linear-gradient(135deg, #ff6b6b 0%, #898b0cdc 100%);
            padding: 20px;
            border-radius: 12px;
            text-align: center;
            color: white;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        /* 오른쪽 - 레시피 목록 */
        .recipe-section {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }

        .section-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: #2c3e50;
        }

        .recipe-count {
            background: #ff6b6b;
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .recipe-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
        }

        .recipe-card {
            background: white;
            border: 1px solid #e0e0e0;
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .recipe-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            border-color: #ff6b6b;
        }

        .recipe-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            transition: transform 0.5s;
        }

        .recipe-card:hover .recipe-image {
            transform: scale(1.05);
        }

        .recipe-content {
            padding: 20px;
        }

        .recipe-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .recipe-desc {
            font-size: 0.9rem;
            color: #7f8c8d;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            margin-bottom: 12px;
        }

        .recipe-meta {
            display: flex;
            gap: 15px;
            font-size: 0.85rem;
            color: #999;
        }

        .recipe-meta i {
            margin-right: 4px;
        }

        .no-recipes {
            text-align: center;
            padding: 80px 20px;
            color: #999;
        }

        .no-recipes i {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 20px;
        }

        .no-recipes p {
            font-size: 1.1rem;
            margin-top: 15px;
        }

        /* 반응형 */
        @media (max-width: 1024px) {
            .profile-container {
                grid-template-columns: 1fr;
                gap: 30px;
            }

            .member-info-card {
                position: static;
            }
        }

        @media (max-width: 768px) {
            .profile-container {
                padding: 30px 20px;
            }

            .recipe-section {
                padding: 30px 20px;
            }

            .recipe-grid {
                grid-template-columns: 1fr;
            }

            .member-nickname {
                font-size: 1.5rem;
            }

            .section-title {
                font-size: 1.5rem;
            }
        }
		/* ✅ [추가] 모달 배경 스타일 */
		        .modal-overlay {
		            position: fixed;
		            top: 0;
		            left: 0;
		            width: 100%;
		            height: 100%;
		            background: rgba(0, 0, 0, 0.6);
		            display: none; /* 초기에는 숨김 */
		            justify-content: center;
		            align-items: center;
		            z-index: 1050;
		        }

		        /* ✅ [추가] 모달 창 스타일 */
		        .message-modal-content {
		            background: white;
		            padding: 30px;
		            border-radius: 15px;
		            width: 90%;
		            max-width: 500px;
		            box-shadow: 0 5px 25px rgba(0, 0, 0, 0.2);
		            animation: fadeIn 0.3s ease-out;
		        }

		        .modal-header {
		            display: flex;
		            justify-content: space-between;
		            align-items: center;
		            border-bottom: 1px solid #eee;
		            padding-bottom: 15px;
		            margin-bottom: 20px;
		        }

		        .modal-header h4 {
		            margin: 0;
		            color: #ff6b6b;
		            font-weight: 700;
		        }
		        
		        .modal-header button {
		            background: none;
		            border: none;
		            font-size: 1.5rem;
		            cursor: pointer;
		            color: #aaa;
		        }
		        
		        .modal-body label {
		            display: block;
		            margin-bottom: 5px;
		            font-weight: 600;
		            color: #333;
		        }

		        .modal-body input[type="text"], 
		        .modal-body textarea {
		            width: 100%;
		            padding: 10px;
		            margin-bottom: 15px;
		            border: 1px solid #ddd;
		            border-radius: 8px;
		            box-sizing: border-box;
		            resize: vertical;
		        }

		        .btn-send-message {
		            width: 100%;
		            padding: 12px;
		            background: #ff6b6b;
		            color: white;
		            border: none;
		            border-radius: 8px;
		            font-weight: 600;
		            cursor: pointer;
		            transition: background-color 0.3s;
		        }

		        .btn-send-message:hover {
		            background: #e65a50;
		        }

		        @keyframes fadeIn {
		            from { opacity: 0; transform: scale(0.95); }
		            to { opacity: 1; transform: scale(1); }
		        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="profile-container">
        <!-- 왼쪽: 회원 정보 -->
        <aside class="member-info-card">
            <div class="profile-image-wrapper">
                <c:choose>
                    <c:when test="${not empty memberInfo.profileImage}">
                        <img src="/images/${memberInfo.profileImage}" alt="${memberInfo.nickname}" class="profile-image">
                    </c:when>
                    <c:otherwise>
                       <img src="${pageContext.request.contextPath}/images/기본프로필.png" alt="기본 프로필 이미지" />
                    </c:otherwise>
                </c:choose>
            </div>

            <h1 class="member-nickname">${memberInfo.nickname}</h1>
			
			<%-- ✅ [수정 핵심 1] 프로필 카드 ID 마스킹 --%>
            <c:set var="targetId" value="${memberInfo.memberId}" />
            <c:set var="idLen" value="${fn:length(targetId)}" />
            <c:set var="visibleLen" value="${idLen - fn:length(targetId) / 2}" />
			
            <p class="member-id">@<c:out value="${fn:substring(targetId, 0, visibleLen)}" /><c:forEach begin="1" end="${idLen - visibleLen}">*</c:forEach></p>

            <div class="info-divider"></div>

            <div class="info-item">
                <span class="info-label">
                    <i class="bi bi-person-fill"></i>
                    이름
                </span>
                <span class="info-value">${memberInfo.name}</span>
            </div>

            <div class="info-item">
                <span class="info-label">
                    <i class="bi bi-envelope-fill"></i>
                    이메일
                </span>
                <span class="info-value">${memberInfo.email}</span>
            </div>

            <div class="info-item">
                <span class="info-label">
                    <i class="bi bi-calendar-fill"></i>
                    가입일
                </span>
                <span class="info-value">
                    <c:choose>
                        <c:when test="${not empty memberInfo.joinDate}">
                            ${memberInfo.joinDate}
                        </c:when>
                        <c:otherwise>
                            정보 없음
                        </c:otherwise>
                    </c:choose>
                </span>
            </div>

            <div class="stats-container">
                <div class="stat-box">
                    <div class="stat-number">${recipeCount}</div>
                    <div class="stat-label">작성한 레시피</div>
                </div>
            </div>
			
			<%-- ✅ [추가] 쪽지 보내기 버튼 --%>
            <c:if test="${sessionScope.id != memberInfo.memberId and not empty sessionScope.id}">
            <div style="text-align: center; margin-top: 25px;">
                <button type="button" class="btn btn-warning" id="sendMessageBtn"
				onclick="openReplyModal('${memberInfo.memberId}', '${memberInfo.nickname}')" 
                        style="width: 80%; padding: 12px 0; font-weight: 600;">
                    <i class="bi bi-send-fill"></i> ${memberInfo.nickname}님께 쪽지 보내기
                </button>
            </div>
            </c:if>
        </aside>

        <!-- 오른쪽: 레시피 목록 -->
        <section class="recipe-section">
            <div class="section-header">
                <h2 class="section-title">${memberInfo.nickname}님의 레시피</h2>
                <span class="recipe-count">총 ${recipeCount}개</span>
            </div>

            <div class="recipe-grid">
                <c:choose>
                    <c:when test="${not empty recipes}">
                        <c:forEach var="recipe" items="${recipes}">
                            <a href="detail.do?recipe_Id=${recipe.recipeId}" class="recipe-card">
                                <img src="/images/${recipe.mainImage}" alt="${recipe.title}" class="recipe-image">
                                <div class="recipe-content">
                                    <h3 class="recipe-title">${recipe.title}</h3>
                                    <p class="recipe-desc">${recipe.description}</p>
                                    <div class="recipe-meta">
                                        <span><i class="bi bi-eye-fill"></i> ${recipe.hit}</span>
                                        <span><i class="bi bi-star-fill"></i> ${recipe.rating}</span>
                                    </div>
                                </div>
                            </a>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="no-recipes">
                            <i class="bi bi-journal-x"></i>
                            <p>아직 작성한 레시피가 없습니다.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </div>
	
	<%-- ========================================================== --%>
	    <%-- ✅ [추가] 쪽지 보내기 모달 (팝업) 구조 --%>
	    <%-- ========================================================== --%>
		<div class="modal-overlay" id="messageModal">
			        <div class="message-modal-content">
			            <div class="modal-header">
			                <h4 id="replyModalTitle"></h4> <button type="button" onclick="closeModal()">&times;</button>
			            </div>
			            
			            <div class="modal-body">
			                <form id="sendMessageForm" action="${pageContext.request.contextPath}/message/send" method="post">
			                    
			                    <label>받는 사람 (ID)</label>
			                    <div class="masked-id-display">
		                            <i class="bi bi-person-badge" style="margin-right: 5px;"></i> 
		                            <span id="maskedReceiverId"></span> 
		                        </div>

			                    <input type="hidden" id="modalReceiverId" name="receiverId" value="" required>

			                    <label for="modalContent">내용</label>
			                    <textarea id="modalContent" name="content" rows="6" required maxlength="2000"></textarea>

			                    <button type="submit" class="btn-send-message">쪽지 보내기</button>
			                </form>
			            </div>
			        </div>
			    </div>
	    <%-- ========================================================== --%>

    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
	<script>
	        document.addEventListener("DOMContentLoaded", function() {
	            const modal = document.getElementById('messageModal');
	            const sendMessageBtn = document.getElementById('sendMessageBtn');

	            // 쪽지 보내기 버튼 클릭 시 모달 열기
	            if (sendMessageBtn) {
	                sendMessageBtn.addEventListener('click', openModal);
	            }

	            // 모달 외부를 클릭했을 때 닫기
	            modal.addEventListener('click', (event) => {
	                if (event.target === modal) {
	                    closeModal();
	                }
	            });
	        });

	        function openModal() {
	            document.getElementById('messageModal').style.display = 'flex';
	        }

	        function closeModal() {
	            document.getElementById('messageModal').style.display = 'none';
	        }
			function openReplyModal(receiverId, receiverNickname) {
		            const hiddenReceiverIdInput = document.getElementById('modalReceiverId');
		            const maskedIdSpan = document.getElementById('maskedReceiverId');
		            const modalTitle = document.getElementById('replyModalTitle');

		            // 1. 모달의 제목과 입력 필드에 값 설정
		            modalTitle.textContent = receiverNickname + '님께 쪽지 보내기';
		            
		            // 2. 실제 ID와 마스킹된 ID 설정
		            hiddenReceiverIdInput.value = receiverId; // hidden 필드에 마스킹되지 않은 전체 ID 저장
		            maskedIdSpan.textContent = maskId(receiverId); // 화면 표시용 ID 설정
		            
		            // 3. 내용 입력란 초기화
		            document.getElementById('modalContent').value = '';

		            // 4. 모달 표시
		            document.getElementById('messageModal').style.display = 'flex';
		        }

		        function closeModal() {
		            document.getElementById('messageModal').style.display = 'none';
		        }
		        
		        document.addEventListener("DOMContentLoaded", function() {
		            const modal = document.getElementById('messageModal');
		            
		            // [주의] sendMessageBtn은 이미 onclick을 가지고 있으므로, 추가 리스너는 필요 없습니다.

		            // 모달 외부를 클릭했을 때 닫기
		            modal.addEventListener('click', (event) => {
		                // event.target === modal (검은 배경 자체)를 클릭했는지 확인
		                if (event.target === modal) {
		                    closeModal();
		                }
		            });
		        });
	        
	        // 폼 제출 후 알림 메시지 표시 (필요에 따라)
	        // Spring의 RedirectAttributes 메시지를 받아서 표시하는 로직이 필요할 수 있습니다.
	        // if ("${message}" != "") { alert("${message}"); }
			// ✅ [추가] ID 마스킹 함수
	        function maskId(id) {
	            if (!id) return '';
	            const length = id.length;
	            const visibleLength = Math.ceil(length / 2); // 절반은 보이게 (올림)
	            const visiblePart = id.substring(0, visibleLength);
	            const maskedPart = '*'.repeat(length - visibleLength);
	            return visiblePart + maskedPart;
	        }
	    </script>	
</body>
</html>