<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 | 요리조리</title>
    <!-- Bootstrap Icons -->
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
			<link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css">
			<link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css">
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        /* ====== Common Styles ====== */
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


        /* ====== Registration Form Area ====== */
        .register-container {
            flex: 1; display: flex; justify-content: center; align-items: center; padding: 50px 20px;
        }
        .register-box {
            background: white; padding: 40px 50px; border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1); width: 100%; max-width: 500px;
        }
        .register-box h2 {
            font-size: 2rem; font-weight: 800; color: #ff6f61; margin-bottom: 10px; text-align: center;
        }
        .required-info {
            text-align: right; font-size: 0.8rem; color: #888; margin-bottom: 25px;
        }
        .input-group {
            position: relative;
        }
        .input-group i {
            position: absolute; left: 15px; top: 50%; transform: translateY(-50%);
            color: #aaa; font-size: 1.1rem;
        }
        .form-control {
            width: 100%; padding: 12px 15px 12px 45px; border: 1px solid #ddd; border-radius: 8px;
            font-size: 1rem; box-sizing: border-box; transition: border-color 0.3s, box-shadow 0.3s;
        }
        .form-control:focus {
            border-color: #ff6f61; box-shadow: 0 0 0 3px rgba(255, 111, 97, 0.2); outline: none;
        }

        .input-group.with-button {
            display: flex;
            align-items: center;
        }
        .input-group.with-button .form-control {
            flex: 1; /* 남은 공간을 모두 차지 */
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
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
            white-space: nowrap; /* 버튼 글자 줄바꿈 방지 */
            transition: background-color 0.3s;
        }
        .input-group.with-button .btn-inline:hover { 
            background-color: #5a6268; 
        }
        .input-group.with-button .btn-inline:disabled {
            background-color: #ccc;
            border-color: #ccc;
            cursor: not-allowed;
        }


        
        /* Validation message and spacing styles */
        .validation-msg { 
            font-size: 0.85em; 
            padding-left: 5px; 
            display: block; 
            min-height: 1.2em; /* Reserve space for message */
            margin-top: 4px;
            margin-bottom: 14px; /* Consistent bottom margin for spacing */
        }
        .success { color: #28a745; }
        .fail { color: #dc3545; }
        
        .gender-group {
            text-align: left; padding: 10px 0;
            margin-bottom: 10px; /* Spacing for gender group */
        }
        .gender-group label {
            margin-right: 20px; font-size: 1rem; cursor: pointer;
        }
        .gender-group input[type="radio"] {
            margin-right: 6px; accent-color: #ff6f61; transform: scale(1.2); cursor: pointer;
        }
        .btn-register {
            width: 100%; background-color: #ff6f61; color: white; border: none; padding: 14px;
            font-size: 1.1rem; font-weight: 700; border-radius: 8px; cursor: pointer;
            transition: background-color 0.3s, transform 0.2s; margin-top: 15px;
        }
        .btn-register:hover {
            background-color: #e65a4c; transform: translateY(-2px);
        }
        .links-area {
            margin-top: 20px; font-size: 0.9rem; color: #777; text-align: center;
        }
        .links-area a {
            color: #555; margin: 0 10px; transition: color 0.2s;
        }
        .links-area a:hover { color: #ff6f61; }
        
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>

    

    <!-- Registration form -->
    <main class="register-container">
        <div class="register-box">
            <h2>회원가입</h2>
            <p class="required-info">* 표시된 항목은 필수 입력사항입니다.</p>
            <form id="registerForm" method="post" action="registerOk" enctype="multipart/form-data">
                <!-- 일반 사용자는 admin_ck = 0 -->
                <input type="hidden" name="ADMIN_CK" value="0">
                
                <div class="input-group">
                    <i class="bi bi-person-fill"></i>
                    <input type="text" id="memberId" class="form-control" name="MEMBER_ID" placeholder="아이디*" required>
                </div>
                <div class="validation-msg" id="idMsg"></div>

                <div class="input-group">
                    <i class="bi bi-person-badge"></i>
                    <input type="text" class="form-control" name="NAME" placeholder="이름*" required>
                </div>
                <div class="validation-msg"></div> <!-- Placeholder for spacing -->

                <div class="input-group">
                    <i class="bi bi-lock-fill"></i>
                    <input type="password" class="form-control" name="PASSWORD" placeholder="비밀번호*" required>
                </div>
                <div class="validation-msg"></div> <!-- Placeholder for spacing -->

                <div class="input-group">
                    <i class="bi bi-emoji-smile-fill"></i>
                    <input type="text" id="nickname" class="form-control" name="NICKNAME" placeholder="닉네임*" required>
                </div>
                <div class="validation-msg" id="nicknameMsg"></div>

                <div class="input-group with-button">
                    <i class="bi bi-envelope-fill"></i>
                    <input type="email" id="email" class="form-control" name="EMAIL" placeholder="이메일*" required>
                    <button type="button" id="btnSendEmail" class="btn-inline">인증</button>
                </div>
                <div class="validation-msg" id="emailMsg"></div>

                <div id="emailVerifyBox" style="display: none;">
                    <div class="input-group with-button">
                        <i class="bi bi-shield-check"></i>
                        <input type="text" id="emailVerifyCode" class="form-control" placeholder="인증번호 6자리">
                        <button type="button" id="btnCheckEmailCode" class="btn-inline">확인</button>
                    </div>
                    <div class="validation-msg" id="emailVerifyMsg"></div>
                </div>
                
                <div class="input-group">
                    <i class="bi bi-telephone-fill"></i>
                    <input type="tel" id="phoneNumber" class="form-control" name="PHONE_NUMBER" placeholder="휴대폰 번호 (- 없이 입력)*" required>
                </div>
                <div class="validation-msg" id="phoneMsg"></div>
                
                <div class="input-group">
                    <i class="bi bi-calendar-event-fill"></i>
                    <input type="date" class="form-control" name="BIRTHDATE" required>
                </div>
                <div class="validation-msg"></div> <!-- Placeholder for spacing -->
                
<!--                <div class="input-group">-->
<!--                    <i class="bi bi-image-fill"></i>-->
<!--                    <input type="file" class="form-control" name="PROFILE_IMAGE" accept="image/*">-->
<!--                </div>-->
                <div class="validation-msg"></div> <!-- Placeholder for spacing -->
                
<!--                <div class="gender-group">-->
<!--                    <strong>성별*</strong>&nbsp;&nbsp;&nbsp;-->
<!--                    <label><input type="radio" name="GENDER" value="1" required> 남성</label>-->
<!--                    <label><input type="radio" name="GENDER" value="2"> 여성</label>-->
<!--                </div>-->

                <button type="submit" class="btn-register">가입하기</button>
                
                <div class="links-area">
                    <a href="${pageContext.request.contextPath}/login">이미 회원이신가요?</a>
                </div>
            </form>
        </div>
    </main>

	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

<script>
    // [수정] DOM(HTML)이 모두 로드된 후 스크립트를 실행하도록 변경
    document.addEventListener('DOMContentLoaded', function() {

        //            Real-time Duplicate & Email Script
        // (헤더 관련 코드는 모두 삭제)

        // --- 검증 상태 객체 ---
        const validationStatus = {
            id: false,
            nickname: false,
            email: false,         // 이메일 중복 검사 통과 여부
            emailVerified: false, // 이메일 인증번호 확인 통과 여부
            phone: false
        };

        // --- DOM 요소 캐싱 ---
        const emailInput = document.getElementById('email');
        const btnSendEmail = document.getElementById('btnSendEmail');
        const emailVerifyBox = document.getElementById('emailVerifyBox');
        const emailVerifyCodeInput = document.getElementById('emailVerifyCode');
        const btnCheckEmailCode = document.getElementById('btnCheckEmailCode');
        
        const emailMsg = document.getElementById('emailMsg');
        const emailVerifyMsg = document.getElementById('emailVerifyMsg');

        /**
         * 필드 중복 검사 (기존 함수)
         */
        async function checkDuplicate(fieldType, value) {
            const msgElement = document.getElementById(fieldType + 'Msg');
            if (!value.trim()) {
                msgElement.textContent = '';
                validationStatus[fieldType] = false;
                return;
            }

            // 이메일인 경우, 인증 버튼 활성화/비활성화 처리
            if (fieldType === 'email') {
                btnSendEmail.disabled = true; // 확인 전까지 비활성화
                validationStatus.emailVerified = false; // 이메일 변경 시 인증 상태 초기화
                emailVerifyBox.style.display = 'none'; // 인증번호 입력창 숨김
                emailVerifyMsg.textContent = '';
                emailInput.readOnly = false; // (중요) 이메일 수정 가능하도록 초기화
                btnSendEmail.textContent = '인증';
            }

            const formData = new URLSearchParams({ fieldType, value });

            try {
                const response = await fetch('checkDuplicate', {
                    method: 'POST',
                    body: formData
                });
                const result = await response.text();
                
                let message = '';
                
                if (result === 'SUCCESS') {
                    validationStatus[fieldType] = true;
                    msgElement.className = 'validation-msg success';
                    if (fieldType === 'id') message = '사용 가능한 아이디입니다.';
                    else if (fieldType === 'nickname') message = '멋진 닉네임이네요!';
                    else if (fieldType === 'email') {
                        message = '사용 가능한 이메일입니다. [인증] 버튼을 눌러주세요.';
                        btnSendEmail.disabled = false; // 사용 가능할 때만 인증 버튼 활성화
                    }
                    else if (fieldType === 'phone') message = '사용 가능한 전화번호입니다.';
                } else {
                    validationStatus[fieldType] = false;
                    msgElement.className = 'validation-msg fail';
                    if (fieldType === 'id') message = '이미 사용 중인 아이디입니다.';
                    else if (fieldType === 'nickname') message = '이미 사용 중인 닉네임입니다.';
                    else if (fieldType === 'email') message = '이미 등록된 이메일입니다.';
                    else if (fieldType === 'phone') message = '이미 등록된 전화번호입니다.';
                }
                msgElement.textContent = message;

            } catch (error) {
                console.error('Error:', error);
                msgElement.className = 'validation-msg fail';
                msgElement.textContent = '확인 중 오류가 발생했습니다.';
            }
        }

        // --- 기존 중복 검사 이벤트 리스너 ---
        document.getElementById('memberId').addEventListener('blur', (e) => checkDuplicate('id', e.target.value));
        document.getElementById('nickname').addEventListener('blur', (e) => checkDuplicate('nickname', e.target.value));
        document.getElementById('email').addEventListener('blur', (e) => checkDuplicate('email', e.target.value)); // 이메일 'blur' 시 중복검사
        document.getElementById('phoneNumber').addEventListener('blur', (e) => checkDuplicate('phone', e.target.value));

        // --- [추가] 이메일 인증번호 발송 이벤트 리스너 ---
        btnSendEmail.addEventListener('click', async () => {
            // 1. 중복 검사 통과 여부 확인
            if (!validationStatus.email) {
                alert('이메일 중복 확인이 필요하거나 사용할 수 없는 이메일입니다.');
                emailInput.focus();
                return;
            }
            
            // 2. 버튼 비활성화 (중복 전송 방지)
            btnSendEmail.disabled = true;
            btnSendEmail.textContent = '전송 중...';
            emailMsg.textContent = '인증번호를 전송 중입니다...';
            emailMsg.className = 'validation-msg';

            try {
                // 3. 백엔드에 인증번호 발송 요청 (새로운 엔드포인트)
                const response = await fetch('mail/send-verification', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: new URLSearchParams({ email: emailInput.value })
                });
                const result = await response.text();
                
                if (result === 'SUCCESS') {
                    emailMsg.textContent = '인증번호가 발송되었습니다. 메일을 확인해주세요.';
                    emailMsg.className = 'validation-msg success';
                    emailVerifyBox.style.display = 'block'; // 인증번호 입력창 표시
                    emailInput.readOnly = true; // 이메일 주소 변경 방지
                    emailVerifyCodeInput.focus();
                } else {
                    emailMsg.textContent = '인증번호 발송에 실패했습니다. (서버 오류)';
                    emailMsg.className = 'validation-msg fail';
                    btnSendEmail.disabled = false; // 실패 시 다시 시도 가능하게
                    btnSendEmail.textContent = '인증';
                }
            } catch (error) {
                console.error('Error:', error);
                emailMsg.textContent = '인증번호 발송 중 오류가 발생했습니다.';
                emailMsg.className = 'validation-msg fail';
                btnSendEmail.disabled = false;
                btnSendEmail.textContent = '인증';
            }
        });

        // --- [추가] 이메일 인증번호 확인 이벤트 리스너 ---
        btnCheckEmailCode.addEventListener('click', async () => {
            const code = emailVerifyCodeInput.value;

            if (!code || code.trim().length === 0) {
                alert('인증번호를 입력해주세요.');
                return;
            }

            btnCheckEmailCode.disabled = true;
            btnCheckEmailCode.textContent = '확인 중...';

            try {
                // 3. 백엔드에 인증번호 확인 요청 (새로운 엔드포인트)
                const response = await fetch('mail/check-verification', {
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
                    validationStatus.emailVerified = true; // 최종 인증 성공 플래그
                    
                    // 모든 관련 필드 비활성화
                    emailVerifyCodeInput.readOnly = true;
                    btnCheckEmailCode.disabled = true;
                    btnCheckEmailCode.textContent = '인증완료';
                    btnSendEmail.textContent = '인증완료'; // 발송 버튼도 완료 처리
                } else {
                    emailVerifyMsg.textContent = '인증번호가 일치하지 않습니다. 다시 확인해주세요.';
                    emailVerifyMsg.className = 'validation-msg fail';
                    validationStatus.emailVerified = false;
                    btnCheckEmailCode.disabled = false; // 재시도 가능
                    btnCheckEmailCode.textContent = '확인';
                }
            } catch (error) {
                console.error('Error:', error);
                emailVerifyMsg.textContent = '인증 확인 중 오류가 발생했습니다.';
                emailVerifyMsg.className = 'validation-msg fail';
                btnCheckEmailCode.disabled = false;
                btnCheckEmailCode.textContent = '확인';
            }
        });


        // --- [수정] 최종 회원가입 폼 제출 이벤트 리스너 ---
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const checks = [
                {key: 'id', name: '아이디', element: 'memberId'}, 
                {key: 'nickname', name: '닉네임', element: 'nickname'},
                {key: 'email', name: '이메일', element: 'email'}, // 중복 검사 확인
                {key: 'phone', name: '전화번호', element: 'phoneNumber'}
            ];

            // 1. 기존 중복 검사 확인
            for (const check of checks) {
                if (!validationStatus[check.key]) {
                    e.preventDefault(); // 폼 제출 중단
                    alert(`${check.name} 중복 확인이 필요하거나, 사용할 수 없는 값입니다.`);
                    document.getElementById(check.element).focus();
                    return;
                }
            }
            
            // 2. [추가] 이메일 인증번호 확인 여부 검사
            if (!validationStatus.emailVerified) {
                e.preventDefault(); // 폼 제출 중단
                alert('이메일 인증을 완료해주세요.');
                
                // 인증번호 입력창이 보이면 거기로, 아니면 이메일 입력창으로 포커스
                if (emailVerifyBox.style.display === 'block') {
                    emailVerifyCodeInput.focus();
                } else {
                    emailInput.focus();
                }
                return;
            }
        });
        
    }); // <-- DOMContentLoaded 래퍼(wrapper) 닫기
</script>
</body>
</html>

