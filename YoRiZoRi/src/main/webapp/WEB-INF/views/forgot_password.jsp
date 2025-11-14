<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기 | 요리조리</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
		    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
			<link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css">
			<link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css">
			<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">


    <style>
        /* ====== Common Styles ====== */
        body {
            font-family: "Noto Sans KR", sans-serif; margin: 0; padding: 0;
            background-color: #fffaf7; color: #333; display: flex;
            flex-direction: column; min-height: 100vh;
        }
        a { text-decoration: none; color: inherit; }


        /* ====== Forgot Password Form Area ====== */
        .form-container {
            flex: 1; display: flex; justify-content: center; align-items: center; padding: 50px 20px;
        }
        .form-box {
            background: white; padding: 40px 50px; border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1); width: 100%; max-width: 500px;
        }
        .form-box h2 {
            font-size: 2rem; font-weight: 800; color: #ff6f61; margin-bottom: 30px; text-align: center;
        }
        
        /* 1, 2단계 공통 */
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
        
        /* 이메일 + 인증 버튼 */
        .input-group.with-button {
            display: flex;
            align-items: center;
        }
        .input-group.with-button .form-control {
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
        }
        .input-group.with-button .btn-inline {
            padding: 12px 15px; background-color: #6c757d; color: white;
            border: 1px solid #6c757d; border-left: none;
            border-top-right-radius: 8px; border-bottom-right-radius: 8px;
            cursor: pointer; font-size: 0.9rem; white-space: nowrap; 
            transition: background-color 0.3s;
        }
        .input-group.with-button .btn-inline:hover { background-color: #5a6268; }
        .input-group.with-button .btn-inline:disabled {
            background-color: #ccc; border-color: #ccc; cursor: not-allowed;
        }

        /* Validation 메시지 */
        .validation-msg { 
            font-size: 0.85em; padding-left: 5px; display: block; 
            min-height: 1.2em; margin-top: 4px; margin-bottom: 14px;
        }
        .success { color: #28a745; }
        .fail { color: #dc3545; }

        /* 2단계 (인증 + 새 비번) 영역 - 처음엔 숨겨짐 */
        #step2 {
            display: none;
        }
        
        /* 최종 제출 버튼 */
        .btn-submit {
            width: 100%; background-color: #ff6f61; color: white; border: none; padding: 14px;
            font-size: 1.1rem; font-weight: 700; border-radius: 8px; cursor: pointer;
            transition: background-color 0.3s, transform 0.2s; margin-top: 15px;
        }
        .btn-submit:hover {
            background-color: #e65a4c; transform: translateY(-2px);
        }

    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>


    <main class="form-container">
        <div class="form-box">
            <h2>비밀번호 찾기</h2>
            
            <form id="resetForm">
                <div id="step1">
                        <div class="input-group">
                            <i class="bi bi-person-fill"></i>
                            <input type="text" id="memberId" class="form-control" name="memberId" placeholder="아이디*" required>
                        </div>
                        <div class="validation-msg"></div> <div class="input-group with-button">
                            <i class="bi bi-envelope-fill"></i>
                            <input type="email" id="email" class="form-control" name="email" placeholder="가입 시 사용한 이메일*" required>
                            <button type="button" id="btnSendCode" class="btn-inline">인증번호 발송</button>
                        </div>
                        <div class="validation-msg" id="emailMsg"></div>
                    </div>

                <div id="step2">
                    <div class="input-group">
                        <i class="bi bi-shield-check"></i>
                        <input type="text" id="verifyCode" class="form-control" name="code" placeholder="인증번호 6자리*" required>
                    </div>
                    <div class="validation-msg" id="codeMsg"></div>
                    
                    <div class="input-group">
                        <i class="bi bi-lock-fill"></i>
                        <input type="password" id="newPassword" class="form-control" name="newPassword" placeholder="새 비밀번호*" required>
                    </div>
                    <div class="validation-msg"></div> <div class="input-group">
                        <i class="bi bi-lock-fill"></i>
                        <input type="password" id="newPasswordConfirm" class="form-control" placeholder="새 비밀번호 확인*" required>
                    </div>
                    <div class="validation-msg" id="passwordMsg"></div>

                    <button type="submit" class="btn-submit">비밀번호 변경하기</button>
                </div>
            </form>
        </div>
    </main>

   
    <script>
    
// ===================================================
        //            비밀번호 찾기 스크립트 (수정됨)
        // ===================================================

        // --- DOM 요소 캐싱 ---
        const step1 = document.getElementById('step1');
        const step2 = document.getElementById('step2');
        const resetForm = document.getElementById('resetForm');
        
        const idInput = document.getElementById('memberId'); // [추가]
        const emailInput = document.getElementById('email');
        const btnSendCode = document.getElementById('btnSendCode');
        const emailMsg = document.getElementById('emailMsg');
        
        const verifyCodeInput = document.getElementById('verifyCode');
        const codeMsg = document.getElementById('codeMsg');
        const newPasswordInput = document.getElementById('newPassword');
        const newPasswordConfirmInput = document.getElementById('newPasswordConfirm');
        const passwordMsg = document.getElementById('passwordMsg');

        
        /**
         * 1. '인증번호 발송' 버튼 클릭 이벤트 (수정)
         */
        btnSendCode.addEventListener('click', async () => {
            const memberId = idInput.value; // [수정]
            const email = emailInput.value;
            
            if (!memberId || !email) { // [수정]
                alert('아이디와 이메일을 모두 입력해주세요.');
                return;
            }

            btnSendCode.disabled = true;
            btnSendCode.textContent = '확인 중...';
            emailMsg.className = 'validation-msg';

            try {
                // [API 1] : 아이디+이메일 일치 확인 + 인증번호 발송 요청
                const response = await fetch('find/send-reset-code', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: new URLSearchParams({ 
                        id: memberId,  // [수정]
                        email: email 
                    })
                });
                const result = await response.text();

                if (result === 'SUCCESS') {
                    emailMsg.textContent = '인증번호가 발송되었습니다. 메일을 확인해주세요.';
                    emailMsg.className = 'validation-msg success';
                    idInput.readOnly = true;    // [추가] 아이디 수정 방지
                    emailInput.readOnly = true; // 이메일 수정 방지
                    btnSendCode.textContent = '재전송';
                    btnSendCode.disabled = false;
                    step2.style.display = 'block'; 
                    verifyCodeInput.focus();
                } else if (result === 'FAIL_NOT_FOUND') {
                    emailMsg.textContent = '일치하는 회원 정보가 없습니다. 아이디와 이메일을 확인해주세요.'; // [수정]
                    emailMsg.className = 'validation-msg fail';
                    btnSendCode.disabled = false;
                    btnSendCode.textContent = '인증번호 발송';
                } else {
                    emailMsg.textContent = '인증번호 발송에 실패했습니다. (서버 오류)';
                    emailMsg.className = 'validation-msg fail';
                    btnSendCode.disabled = false;
                    btnSendCode.textContent = '인증번호 발송';
                }
            } catch (error) {
                console.error('Error:', error);
                emailMsg.textContent = '요청 중 오류가 발생했습니다.';
                emailMsg.className = 'validation-msg fail';
                btnSendCode.disabled = false;
                btnSendCode.textContent = '인증번호 발송';
            }
        });

        /**
         * 2. '비밀번호 변경하기' 폼 제출(submit) 이벤트 (수정)
         */
        resetForm.addEventListener('submit', async (e) => {
            e.preventDefault(); 

            // ... (비밀번호 일치 확인은 동일) ...
            const newPassword = newPasswordInput.value;
            const newPasswordConfirm = newPasswordConfirmInput.value;
            if (newPassword !== newPasswordConfirm) {
                // ... (오류 처리) ...
                return;
            }
            passwordMsg.textContent = '';
            codeMsg.textContent = '';

            // [API 2] : 최종 변경 요청 (수정)
            // FormData는 form 안의 모든 input(id, email 포함)을 자동으로 수집함
            const formData = new FormData(resetForm);
            
            try {
                const response = await fetch('find/reset-password', {
                    method: 'POST',
                    body: new URLSearchParams(formData) // [수정] 폼데이터 전체 전송
                });
                const result = await response.text();

                if (result === 'SUCCESS') {
                    alert('비밀번호가 성공적으로 변경되었습니다. 로그인 페이지로 이동합니다.');
                    location.href = '<c:url value="/login"/>'; // 로그인 페이지 경로
                } else if (result === 'FAIL_CODE') {
                    codeMsg.textContent = '인증번호가 일치하지 않거나 만료되었습니다.';
                    codeMsg.className = 'validation-msg fail';
                    verifyCodeInput.focus();
                } else if (result === 'FAIL_SESSION') {
                    codeMsg.textContent = '인증 시간이 만료되었습니다. 인증번호를 다시 받아주세요.';
                    codeMsg.className = 'validation-msg fail';
                } else {
                    alert('알 수 없는 오류로 비밀번호 변경에 실패했습니다.');
                }
                
            } catch (error) {
                console.error('Error:', error);
                alert('비밀번호 변경 중 오류가 발생했습니다.');
            }
        });
    </script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>