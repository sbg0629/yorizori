<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 | 요리조리</title>
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
		    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
			<link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css">
			<link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css">
			<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <style>
        /* ====== 공통 스타일 ====== */
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


        /* ====== 로그인 폼 영역 (새롭게 디자인) ====== */
        .login-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }
        .login-box {
            background: white;
            padding: 40px 50px;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 420px;
            text-align: center;
        }
        .login-box h2 {
            font-size: 2rem;
            font-weight: 800;
            color: #ff6f61;
            margin-bottom: 30px;
        }
        .input-group {
            position: relative;
            margin-bottom: 20px;
        }
        .input-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #aaa;
            font-size: 1.1rem;
        }
        .form-control {
            width: 100%;
            padding: 12px 15px 12px 45px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            box-sizing: border-box; /* 패딩 포함해서 너비 계산 */
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        .form-control:focus {
            border-color: #ff6f61;
            box-shadow: 0 0 0 3px rgba(255, 111, 97, 0.2);
            outline: none;
        }
        .btn-login {
            width: 100%;
            background-color: #ff6f61;
            color: white;
            border: none;
            padding: 14px;
            font-size: 1.1rem;
            font-weight: 700;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }
        .btn-login:hover {
            background-color: #e65a4c;
            transform: translateY(-2px);
        }
        .links-area {
            margin-top: 20px;
            font-size: 0.9rem;
            color: #777;
        }
        .links-area a {
            color: #555;
            margin: 0 10px;
            transition: color 0.2s;
        }
        .links-area a:hover {
            color: #ff6f61;
        }
        .msg {
            color: #e74c3c;
            margin-top: 15px;
            font-weight: 600;
            height: 20px; /* 메시지 영역 항상 확보 */
        }

  
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <!-- 새롭게 디자인된 로그인 폼 -->
    <main class="login-container">
        <div class="login-box">
            <h2>로그인</h2>
            <form method="post" action="${pageContext.request.contextPath}/login_yn">
                <div class="input-group">
                    <i class="bi bi-person-fill"></i>
                    <input type="text" class="form-control" id="MEMBER_ID" name="MEMBER_ID" placeholder="아이디" required>
                </div>
                <div class="input-group">
                    <i class="bi bi-lock-fill"></i>
                    <input type="password" class="form-control" id="PASSWORD" name="PASSWORD" placeholder="비밀번호" required>
                </div>
                
                <div class="msg">${msg}</div>

                <button type="submit" class="btn-login">로그인</button>
                
                <div class="links-area">
                    <a href="${pageContext.request.contextPath}/register">회원가입</a> |
                    <a href="${pageContext.request.contextPath}/forgot_password">비밀번호 찾기</a> |
                    <a href="javascript:history.back()">뒤로가기</a>
                </div>
            </form>
        </div>
    </main>

  
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
