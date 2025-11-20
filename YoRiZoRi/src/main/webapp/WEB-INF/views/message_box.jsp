<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>쪽지함 - 받은 쪽지</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css">
    <style>
        body { background-color: #f7f7f7; font-family: 'Noto Sans KR', sans-serif; }
        .message-container {
            max-width: 900px;
            margin: 80px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
		/* ✅ [추가] 탭 컨테이너 스타일 */
		/* ✅ [수정 핵심 1] 탭 버튼 Wrapper: 목록과 붙도록 마진 제거 */
		        .tab-button-wrapper {
		            max-width: 900px;
		            margin: 80px auto 0; /* 상단 마진은 유지, 하단 마진 제거 */
		            padding: 0 30px;
		            /* box-shadow를 아래로 주어 컨테이너에 일체감 부여 (선택적) */
		        }

		        /* ✅ [수정 핵심 2] 메시지 컨테이너: 상단 마진 및 그림자 제거 */
		        .message-container {
		            max-width: 900px;
		            margin: 0 auto; /* 상단 마진 제거 */
		            padding: 30px;
		            background: white;
		            border-radius: 0 0 10px 10px; /* 상단 모서리 제거 */
		            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
		        }

		        /* ✅ [수정 핵심 3] 탭 버튼 스타일: 컨테이너 상단 라인과 일치하도록 조정 */
		        .message-tabs {
		            display: flex;
		            margin-bottom: 0;
		            margin-top: -10px; 
		            /* 탭 버튼 영역을 컨테이너 상단으로 당겨 올리는 효과를 낼 수 있음 */
		        }
		        .message-tabs a {
		            padding: 10px 20px;
		            text-decoration: none;
		            color: #555;
		            font-weight: 600;
		            border: 1px solid #ddd;
		            border-bottom: none;
		            background-color: #e9ecef;
		            margin-right: 5px;
		            border-top-left-radius: 8px;
		            border-top-right-radius: 8px;
		            transition: background-color 0.2s;
		        }
		        .message-tabs a.active {
		            color: #2e7d32;
		            border-color: #ff6f61;
		            border-bottom: 1px solid white; /* 아래 보더를 흰색으로 덮어 목록과 연결 */
		            background-color: white;
		            z-index: 1; 
		        }
        h2 { color: #2e7d32; border-bottom: 3px solid #ff6f61; padding-bottom: 10px; margin-bottom: 25px; }
        .message-list { list-style: none; padding: 0; }
        .message-item {
            padding: 15px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: background-color 0.3s;
            cursor: pointer;
        }
        .message-item:hover { background-color: #fcfcfc; }
        .message-item.unread { font-weight: bold; background-color: #fffaf0; }
        .message-sender { font-size: 1rem; color: #ff6f61; }
        .message-content { flex-grow: 1; margin: 0 20px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .message-date { font-size: 0.85rem; color: #999; }
        .no-messages { text-align: center; padding: 50px; color: #888; }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <main>
        <div class="tab-button-wrapper">
            <div class="message-tabs">
                <a href="${pageContext.request.contextPath}/message_box?box=received" 
                   class="${activeBox eq 'received' ? 'active' : ''}">
                   <i class="bi bi-inbox-fill"></i> 받은 쪽지함
                </a>
                
                <a href="${pageContext.request.contextPath}/message_box?box=sent" 
                   class="${activeBox eq 'sent' ? 'active' : ''}">
                   <i class="bi bi-send-fill"></i> 보낸 쪽지함
                </a>
            </div>
        </div>

        <div class="message-container">
            
            <div class="message-header-area">
                <h2>${boxTitle}</h2>
            </div>
            
            <%-- 쪽지 목록 데이터 --%>
            <c:choose>
                <c:when test="${not empty messageList}">
                    <ul class="message-list">
                        <c:forEach var="message" items="${messageList}">
							<%-- ✅ [수정] 보낸 쪽지함일 경우, 안 읽었으면 굵게 표시 (readStatus=0) --%>
	                        <li class="message-item ${message.readStatus == 0 ? 'unread' : ''}" 
	                            onclick="location.href='view_message?msgId=${message.msgId}&boxType=${activeBox}'">
	                            
	                            <span class="message-sender">
	                                <i class="bi bi-person-fill"></i> 
	                                
	                                <%-- ✅ [핵심] 받는 사람/보낸 사람 닉네임 표시 --%>
	                                <c:choose>
	                                    <c:when test="${activeBox eq 'received'}">
	                                        보낸 이: <strong>${message.senderNickname}</strong>
	                                    </c:when>
	                                    <c:otherwise>
	                                        받는 이: <strong>${message.receiverNickname}</strong>
	                                    </c:otherwise>
	                                </c:choose>
	                            </span>
	                            
								<span class="message-content">
	                                <c:if test="${activeBox eq 'sent'}">
	                                    <%-- 보낸 쪽지함 상태 표시 --%>
	                                    <c:choose>
	                                        <c:when test="${message.readStatus == 1}">
	                                            <span style="color: #2e7d32; font-weight: bold;">[읽음]</span> 
	                                        </c:when>
	                                        <c:otherwise>
	                                            <span style="color: #ff6b6b;">[읽지 않음]</span> 
	                                        </c:otherwise>
	                                    </c:choose>
	                                </c:if>
	                                
	                                <c:if test="${activeBox eq 'received'}">
	                                    <%-- ✅ [수정 핵심] 받은 쪽지함 상태 표시 --%>
	                                    <c:choose>
	                                        <c:when test="${message.readStatus == 1}">
	                                            <span style="color: #2e7d32; font-weight: bold;">[읽음]</span> 
	                                        </c:when>
	                                        <c:otherwise>
	                                            <span style="color: #ff6b6b;">[읽지 않음]</span> 
	                                        </c:otherwise>
	                                    </c:choose>
	                                </c:if>
	                                
	                                ${message.content} 
	                            </span>
	                            
	                            <span class="message-date">
	                                <fmt:formatDate value="${message.sentDate}" pattern="yy.MM.dd HH:mm"/>
	                            </span>
	                        </li>
                        </c:forEach>
                    </ul>
                </c:when>
                <c:otherwise>
                    <p class="no-messages">
                        <i class="bi bi-envelope-open" style="font-size: 2rem;"></i><br>
                        ${boxTitle}에 쪽지가 없습니다.
                    </p>
                </c:otherwise>
            </c:choose>
            
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>