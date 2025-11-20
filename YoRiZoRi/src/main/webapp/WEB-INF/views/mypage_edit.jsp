<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>마이페이지 수정 - 요리조리</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
		    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
			<link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css">
			<link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css">
			<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* 기본 스타일 */
        body {
            font-family: "Noto Sans KR", sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fffaf7;
            color: #333;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        a {
            text-decoration: none;
            color: inherit;
        }

        
        /* ---------------- 메인 영역 (정보 수정 폼 전용 스타일) ---------------- */
        main {
            flex-grow: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 50px 20px;
        }
        .edit-form-container {
            width: 100%;
            max-width: 800px;
            background-color: #fff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
        }
        .edit-form-container h2 {
            text-align: center;
            font-size: 2rem;
            color: #333;
            margin-bottom: 30px;
            border-bottom: 2px solid #ff6f61;
            padding-bottom: 15px;
        }
        .form-content {
            display: flex;
            gap: 40px;
        }
        .profile-image-section {
            flex-shrink: 0;
            text-align: center;
        }
        .profile-image-section img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid #fff;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 10px;
        }
        .form-fields {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        .form-group {
            display: flex;
            flex-direction: column;
        }
        .form-group label {
            font-weight: 600;
            color: #555;
            margin-bottom: 5px;
            font-size: 15px;
        }
        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="date"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
            box-sizing: border-box; /* padding이 너비에 포함되도록 설정 */
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        .form-group input:focus {
            outline: none;
            border-color: #2e7d32;
            box-shadow: 0 0 0 2px rgba(46, 125, 50, 0.2);
        }
  

        /* [추가] 이메일 인증 버튼용 스타일 */
        .input-group.with-button {
            display: flex;
            align-items: center;
        }
        .input-group.with-button .form-control {
            flex: 1; /* 남은 공간을 모두 차지 */
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
            /* 기존 form-group input 스타일과 맞춤 */
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
            box-sizing: border-box;
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
        }
        .input-group.with-button .form-control:focus {
            outline: none;
            border-color: #2e7d32;
            box-shadow: 0 0 0 2px rgba(46, 125, 50, 0.2);
        }
        .input-group.with-button .btn-inline {
            padding: 12px 15px;
            background-color: #6c757d; /* 회색 계열 */
            color: white;
            border: 1px solid #6c757d;
            border-left: none;
            border-top-right-radius: 8px;
            border-bottom-right-radius: 8px;
            cursor: pointer;
            font-size: 0.9rem;
            white-space: nowrap; 
            transition: background-color 0.3s;
            /* 높이를 input과 맞추기 위해 box-sizing 추가 */
            box-sizing: border-box; 
            height: 41px; /* input의 padding(12+12) + font-size(15) + border(2) 근사치 */
        }
        .input-group.with-button .btn-inline:hover { 
            background-color: #5a6268; 
        }
        .input-group.with-button .btn-inline:disabled {
            background-color: #ccc;
            border-color: #ccc;
            cursor: not-allowed;
        }
        /* [추가] Validation 메시지 (회원가입폼에서 복사) */
        .validation-msg { 
           font-size: 0.85em; 
           padding-left: 5px; 
           display: block; 
           min-height: 1.2em;
           margin-top: 4px;
        }
        .success { color: #28a745; }
        .fail { color: #dc3545; }



        .form-actions {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        .form-actions button, .form-actions input[type="submit"] {
            font-family: "Noto Sans KR", sans-serif;
            padding: 12px 25px;
            font-size: 16px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-submit { background-color: #2e7d32; color: white; }
        .btn-submit:hover { background-color: #1b5e20; }
        .btn-cancel { background-color: #f0f0f0; color: #333; }
        .btn-cancel:hover { background-color: #e0e0e0; }

      
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<main>
    <div class="edit-form-container">
        <h2>마이페이지 수정</h2>
        
        <%-- [수정] 모든 ${member.속성} 을 ${user.속성} 으로 변경 --%>
		<form action="<c:url value='/modify'/>" method="post" class="form-content" enctype="multipart/form-data">
		    <input type="hidden" name="memberId" value="${user.memberId}" />

		    <%-- ✅ [추가] 기존 파일명을 서버로 전송하여 파일 유지 또는 삭제의 기준으로 삼습니다. --%>
		    <input type="hidden" name="profileImage" id="existingProfileImage" value="${user.profileImage}" /> 

		    <div class="profile-image-section">
		        <%-- 이미지 미리보기가 표시될 <img> 태그입니다. --%>
		        <c:set var="imageSrc" value="${pageContext.request.contextPath}/images/기본프로필.png" />
		        <c:if test="${not empty user.profileImage}">
		            <%-- Spring Resource Handler 설정을 따르기 위해 '/images/' 경로를 사용합니다. --%>
		            <c:set var="imageSrc" value="/images/${user.profileImage}" />
		        </c:if>
		        
		        <%-- ✅ [수정] 이미지 로딩 시 미리보기 기능을 위한 id를 부여합니다. --%>
		        <img id="profileImagePreview" 
		             src="${imageSrc}" 
		             alt="프로필 이미지" 
		             style="width: 150px; height: 150px; object-fit: cover; border-radius: 50%;" />
		        
		        <div class="file-upload-controls" style="margin-top: 15px;">
		            <label for="profileImageFile" class="btn btn-sm btn-outline-secondary">
		                사진 변경
		            </label>
		            <%-- ✅ [추가] 파일 업로드를 위한 <input type="file"> 태그 --%>
		            <input type="file" 
		                   id="profileImageFile" 
		                   name="profileImageFile" 
		                   style="display: none;" 
		                   accept="image/*" />
		        </div>
		    </div>
            
            <div class="form-fields">
                <div class="form-group">
                    <label for="nickname">닉네임</label>
                    <input type="text" id="nickname" name="nickname" value="${user.nickname}" />
                </div>
                <div class="form-group">
                    <label for="name">이름</label>
                    <input type="text" id="name" name="name" value="${user.name}" />
                </div>
                <div class="form-group">
                    <label for="email">이메일</label>
                    <div class="input-group with-button">
                        <input type="email" id="email" name="email" class="form-control" value="${user.email}" />
                        <button type="button" id="btnSendEmail" class="btn-inline" style="display: none;">인증</button>
                    </div>
                    <div class="validation-msg" id="emailMsg"></div>
                    </div>

                    <div id="emailVerifyBox" style="display: none;">
                        <div class="form-group">
                            <label for="emailVerifyCode">이메일 인증번호</label>
                            <div class="input-group with-button">
                                <input type="text" id="emailVerifyCode" class="form-control" placeholder="인증번호 6자리">
                                <button type="button" id="btnCheckEmailCode" class="btn-inline">확인</button>
                            </div>
                            <div class="validation-msg" id="emailVerifyMsg"></div>
                        </div>
                    </div>
                <div class="form-group">
                    <label for="phoneNumber">전화번호</label>
                    <input type="text" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}" />
                </div>
                <div class="form-group">
                    <label for="birthdate">생년월일</label>
                    <input type="date" id="birthdate" name="birthdate" value="<fmt:formatDate value="${user.birthdate}" pattern="yyyy-MM-dd"/>" />
                </div>

                
                <div class="form-actions">
                    <input type="submit" value="수정 완료" class="btn-submit" />
                    <button type="button" class="btn-cancel" onclick="location.href='<c:url value="/list"/>'">취소</button>
                </div>
            </div>
        </form>
    </div>
</main>


<script>

    //             Email Verification Script

    // --- 1. 상태 변수 및 요소 캐싱 ---
    
    // (중요) 페이지 로드 시 원본 이메일 주소 저장
    const originalEmail = "${user.email}"; 
    
    let emailVerificationRequired = false; // 이메일이 변경되어 새 인증이 필요한가?
    let newEmailVerified = false; 		   // 새 이메일의 인증이 완료되었는가?

    // 중복검사 상태 (이메일만 사용)
    const validationStatus = {
        email: false 
    };

    // DOM 요소
    const emailForm = document.querySelector('.form-content'); // form 태그
    const emailInput = document.getElementById('email');
    const btnSendEmail = document.getElementById('btnSendEmail');
    const emailVerifyBox = document.getElementById('emailVerifyBox');
    const emailVerifyCodeInput = document.getElementById('emailVerifyCode');
    const btnCheckEmailCode = document.getElementById('btnCheckEmailCode');
    const emailMsg = document.getElementById('emailMsg');
    const emailVerifyMsg = document.getElementById('emailVerifyMsg');
	
	document.addEventListener('DOMContentLoaded', function() {
	        const fileInput = document.getElementById('profileImageFile');
	        const previewImg = document.getElementById('profileImagePreview');
	        const existingImg = document.getElementById('existingProfileImage');

	        fileInput.addEventListener('change', function() {
	            if (fileInput.files && fileInput.files[0]) {
	                // 새 파일이 선택된 경우: FileReader로 미리보기
	                const reader = new FileReader();
	                reader.onload = function(e) {
	                    previewImg.src = e.target.result;
	                };
	                reader.readAsDataURL(fileInput.files[0]);
	            } else {
	                // 파일 선택이 취소된 경우: 기존 이미지(hidden 필드 값)로 복원
	                const existingFileName = existingImg.value;
	                const defaultPath = '${pageContext.request.contextPath}/images/기본프로필.png';

	                if (existingFileName) {
	                    // 기존 파일명이 있다면 Spring Resource Handler 경로로 복원
	                    previewImg.src = '/images/' + existingFileName;
	                } else {
	                    // 기존 파일명이 없다면 기본 이미지 경로로 복원
	                    previewImg.src = defaultPath;
	                }
	            }
	        });
	    });
    
    
    // --- 2. 이메일 입력창 'blur' (포커스 아웃) 이벤트 리스너 ---
    emailInput.addEventListener('blur', (e) => {
        const currentEmail = e.target.value;

        // [Case 1] 이메일이 원본과 동일하게 복귀한 경우
        if (currentEmail === originalEmail) {
            emailVerificationRequired = false;
            newEmailVerified = false;
            validationStatus.email = false;
            
            // 모든 인증 UI 숨기기
            btnSendEmail.style.display = 'none';
            emailVerifyBox.style.display = 'none';
            emailMsg.textContent = '';
            emailVerifyMsg.textContent = '';
            
        // [Case 2] 이메일이 원본과 다른 (새) 주소인 경우
        } else {
            emailVerificationRequired = true; // 이제 인증이 필요함
            newEmailVerified = false; 		  // 인증 상태 초기화
            validationStatus.email = false;   // 중복검사 상태 초기화

            // 인증 버튼 표시 (중복검사 전까지 비활성화)
            btnSendEmail.style.display = 'block';
            btnSendEmail.disabled = true;
            btnSendEmail.textContent = '인증';
            
            // 인증번호 입력창 초기화 및 숨기기
            emailVerifyBox.style.display = 'none';
            emailVerifyCodeInput.value = '';
            emailVerifyCodeInput.readOnly = false;
            btnCheckEmailCode.disabled = false;
            btnCheckEmailCode.textContent = '확인';
            emailVerifyMsg.textContent = '';

            // (중요) 회원가입 때와 동일한 'checkDuplicate' 함수 실행
            checkDuplicate('email', currentEmail);
        }
    });

    /**
     * 3. 중복 검사 (회원가입 페이지의 함수 재사용)
     */
    async function checkDuplicate(fieldType, value) {
        // (이메일만 처리)
        if (fieldType !== 'email') return; 

        if (!value.trim()) {
            emailMsg.textContent = '';
            validationStatus.email = false;
            return;
        }
        
        btnSendEmail.disabled = true; // 확인 전까지 비활성화
        const formData = new URLSearchParams({ fieldType, value });

        try {
            const response = await fetch('checkDuplicate', { // <-- 기존 중복검사 API
                method: 'POST',
                body: formData
            });
            const result = await response.text();
            
            if (result === 'SUCCESS') {
                validationStatus.email = true;
                emailMsg.className = 'validation-msg success';
                emailMsg.textContent = '사용 가능한 이메일입니다. [인증] 버튼을 눌러주세요.';
                btnSendEmail.disabled = false; // 사용 가능할 때만 인증 버튼 활성화
            } else {
                validationStatus.email = false;
                emailMsg.className = 'validation-msg fail';
                emailMsg.textContent = '이미 등록된 이메일입니다.';
                btnSendEmail.disabled = true;
            }
        } catch (error) {
            console.error('Error:', error);
            emailMsg.className = 'validation-msg fail';
            emailMsg.textContent = '확인 중 오류가 발생했습니다.';
        }
    }

    // --- 4. 이메일 인증번호 발송 (회원가입과 동일) ---
    btnSendEmail.addEventListener('click', async () => {
        if (!validationStatus.email) {
            alert('사용할 수 없는 이메일입니다.');
            return;
        }
        
        btnSendEmail.disabled = true;
        btnSendEmail.textContent = '전송 중...';
        emailMsg.textContent = '인증번호를 전송 중입니다...';

        try {
            const response = await fetch('mail/send-verification', { // <-- 인증번호 발송 API
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: new URLSearchParams({ email: emailInput.value })
            });
            const result = await response.text();
            
            if (result === 'SUCCESS') {
                emailMsg.textContent = '인증번호가 발송되었습니다.';
                emailMsg.className = 'validation-msg success';
                emailVerifyBox.style.display = 'block'; 
                emailInput.readOnly = true; // 이메일 주소 변경 방지
                emailVerifyCodeInput.focus();
            } else {
                emailMsg.textContent = '인증번호 발송에 실패했습니다.';
                emailMsg.className = 'validation-msg fail';
                btnSendEmail.disabled = false;
                btnSendEmail.textContent = '인증';
            }
        } catch (error) {
            // ... (오류 처리) ...
        }
    });

    // --- 5. 이메일 인증번호 확인 (회원가입과 동일) ---
    btnCheckEmailCode.addEventListener('click', async () => {
        const code = emailVerifyCodeInput.value;
        if (!code) { /* ... (코드 입력 확인) ... */ return; }

        btnCheckEmailCode.disabled = true;
        btnCheckEmailCode.textContent = '확인 중...';

        try {
            const response = await fetch('mail/check-verification', { // <-- 인증번호 확인 API
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: new URLSearchParams({ 
                    email: emailInput.value, 
                    code: code 
                })
            });
            const result = await response.text();

            if (result === 'SUCCESS') {
                emailVerifyMsg.textContent = '이메일 인증이 완료되었습니다.';
                emailVerifyMsg.className = 'validation-msg success';
                
                newEmailVerified = true; // [중요] 새 이메일 인증 완료
                
                emailVerifyCodeInput.readOnly = true;
                btnCheckEmailCode.textContent = '인증완료';
                btnSendEmail.textContent = '인증완료';
            } else {
                emailVerifyMsg.textContent = '인증번호가 일치하지 않습니다.';
                emailVerifyMsg.className = 'validation-msg fail';
                newEmailVerified = false;
                btnCheckEmailCode.disabled = false;
                btnCheckEmailCode.textContent = '확인';
            }
        } catch (error) {
            // ... (오류 처리) ...
        }
    });


    // --- 6. 최종 '수정 완료' 폼 제출 이벤트 리스너 ---
    emailForm.addEventListener('submit', function(e) {
        // [조건] 이메일이 변경되었는데 (required=true)
        //        아직 인증이 완료되지 않았다면 (verified=false)
        if (emailVerificationRequired && !newEmailVerified) {
            
            e.preventDefault(); // 폼 제출 (submit) 중단
            
            alert('새로운 이메일 주소의 인증을 완료해주세요.');
            
            // 인증번호 입력창이 보이면 거기로, 아니면 이메일 입력창으로 포커스
            if (emailVerifyBox.style.display === 'block') {
                emailVerifyCodeInput.focus();
            } else {
                emailInput.focus();
            }
            return;
        }
        
        // [조건 통과]
        // (Case 1: 이메일이 변경되지 않았거나)
        // (Case 2: 이메일이 변경되었고 인증도 완료했거나)
        // -> 폼이 정상적으로 제출(submit)됩니다.
    });

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>