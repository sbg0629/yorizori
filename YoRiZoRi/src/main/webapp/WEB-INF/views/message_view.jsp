<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>쪽지 보기</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css">
    <style>
        body { background-color: #f7f7f7; font-family: 'Noto Sans KR', sans-serif; }
        .view-container {
            max-width: 700px;
            margin: 80px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        h2 { color: #2e7d32; border-bottom: 3px solid #ff6f61; padding-bottom: 10px; margin-bottom: 25px; }
        .view-meta {
            padding: 15px 0;
            border-bottom: 1px dashed #ddd;
            display: flex;
            justify-content: space-between;
            font-size: 0.9rem;
            color: #555;
            margin-bottom: 20px;
        }
        .message-body {
            min-height: 150px;
            padding: 20px;
            background-color: #f9f9f9;
            border: 1px solid #eee;
            border-radius: 5px;
            line-height: 1.8;
            white-space: pre-wrap; /* 줄바꿈 유지 */
        }
        .action-btns {
            margin-top: 30px;
            text-align: center;
        }
        .action-btns button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            margin: 0 10px;
            transition: background-color 0.2s;
        }
        .btn-reply { background-color: #2e7d32; color: white; }
        .btn-reply:hover { background-color: #26642a; }
        .btn-delete { background-color: #f44336; color: white; }
        .btn-delete:hover { background-color: #d32f2f; }
		
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

    <main>
        <div class="view-container">
            <h2><i class="bi bi-chat-text-fill"></i> 쪽지 상세 내용</h2>
            
            <div class="view-meta">
                <%-- 받은 쪽지함에서 열었을 경우: 보낸 사람 정보 --%>
                
                <%-- ✅ [추가 핵심] ID 마스킹 로직 --%>
                <c:set var="senderId" value="${message.senderId}" />
                <c:set var="idLength" value="${fn:length(senderId)}" />
                <c:set var="visibleLength" value="${idLength - fn:length(senderId) / 2}" />
                
                <span>보낸 사람: 
                    <strong>${message.senderNickname}</strong> 
                    (<c:out value="${fn:substring(senderId, 0, visibleLength)}" />
                    <c:forEach begin="1" end="${idLength - visibleLength}">*</c:forEach>)
                </span>
                
                <span>수신일: 
                    <fmt:formatDate value="${message.sentDate}" pattern="yyyy.MM.dd HH:mm"/>
                </span>
            </div>
            
            <div class="message-body">
                ${message.content}
            </div>

            <div class="action-btns">
                <%-- ... (버튼 로직 유지) ... --%>
                
                <%-- ✅ 답장 버튼: onclick 함수 호출에 변경 없음 --%>
                <c:if test="${message.receiverId == sessionScope.id}">
                    <button class="btn-reply" 
                            onclick="openReplyModal('${message.senderId}', '${message.senderNickname}')">
                        <i class="bi bi-reply-fill"></i> 답장하기
                    </button>
                </c:if>
                
				<button class="btn-delete" 
				        onclick="deleteMessage(${message.msgId})">
				    <i class="bi bi-trash-fill"></i> 삭제
				</button>
                
				<button onclick="location.href='message_box?box=${currentBoxType}'" class="btn-back" style="background-color: #ccc;">
                    목록으로
                </button>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    
	<div class="modal-overlay" id="messageModal">
	    <div class="message-modal-content">
	        <div class="modal-header">
	            <h4 id="replyModalTitle"></h4>
	            <button type="button" onclick="closeModal()">&times;</button>
	        </div>
	        
	        <div class="modal-body">
	            <form id="sendMessageForm" action="${pageContext.request.contextPath}/message/send" method="post">
	                
	                <label>받는 사람 (ID)</label>
	                <div class="masked-id-display" style="margin-bottom: 15px; background: #f0f0f0; padding: 10px; border-radius: 5px; font-weight: 600;">
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
    <script>
		function deleteMessage(msgId) {
		    if (!confirm('정말로 이 쪽지를 삭제하시겠습니까?')) return;

		    const formData = new URLSearchParams();
		    formData.append('msgId', msgId);

		    fetch('${pageContext.request.contextPath}/message/delete', {
		        method: 'POST',
		        headers: {
		            'Content-Type': 'application/x-www-form-urlencoded'
		        },
		        body: formData
		    })
		    .then(res => res.json())
		    .then(data => {
		        if (data.success) {
		            alert(data.message);
		            location.href = `${pageContext.request.contextPath}/message_box?box=${currentBoxType}`;
		        } else {
		            alert('삭제 실패: ' + data.message);
		        }
		    })
		    .catch(err => console.error('삭제 오류', err));
		}
        
		function maskId(id) {
            if (!id) return '';
            const length = id.length;
            const visibleLength = Math.ceil(length / 2); // 절반은 보이게 (올림)
            const visiblePart = id.substring(0, visibleLength);
            const maskedPart = '*'.repeat(length - visibleLength);
            return visiblePart + maskedPart;
        }

        // ✅ [수정] 모달을 열고 값을 설정하는 함수
		function openReplyModal(senderId, senderNickname) {
            // const modal = document.getElementById('messageModal'); // modal 변수는 바로 아래에서 사용하지 않아 제거
            const hiddenReceiverIdInput = document.getElementById('modalReceiverId');
            const maskedIdSpan = document.getElementById('maskedReceiverId'); // 🚨 이제 이 ID가 HTML에 존재함
            const modalTitle = document.getElementById('replyModalTitle');

            // 1. 모달의 제목과 입력 필드에 값 설정
            modalTitle.textContent = senderNickname + '님께 답장하기';
            
            // 2. ✅ [핵심] 실제 ID와 마스킹된 ID 설정
            hiddenReceiverIdInput.value = senderId; // DB 전송용 ID (hidden)
            maskedIdSpan.textContent = maskId(senderId); // 화면 표시용 ID (마스킹)
            
            // 3. 내용 입력란 초기화
            document.getElementById('modalContent').value = '';

            // 4. 모달 표시
            document.getElementById('messageModal').style.display = 'flex';
        }
        
		document.addEventListener("DOMContentLoaded", function() {
            const modal = document.getElementById('messageModal');
            
            // 🚨 [수정 핵심] 답장 버튼에 이벤트 리스너 연결
            const replyButton = document.querySelector('.btn-reply'); 

            if (replyButton) {
                replyButton.addEventListener('click', () => {
                    // 쪽지 객체에서 보낸 사람 ID와 닉네임을 직접 가져와 함수에 전달합니다.
                    // 이 값들은 JSP 렌더링 시점에 이미 문자열로 확정되어 있습니다.
                    const senderId = '${message.senderId}';
                    const senderNickname = '${message.senderNickname}';
                    
                    openReplyModal(senderId, senderNickname);
                });
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
    </script>
</body>
</html>