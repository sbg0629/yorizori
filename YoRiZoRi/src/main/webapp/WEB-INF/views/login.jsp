<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 네이버 설정
    String naverClientId = ""; 
    String naverRedirectUri = "http://localhost:8484/login/oauth2/code/naver"; 
    String state = "RANDOM_STATE"; 
    
    // 카카오 설정 추가
	String kakaoClientId = "";  
		
	String kakaoRedirectUri = "http://localhost:8484/oauth2/callback/kakao";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 | 요리조리</title>
    
    <!-- 필수 아이콘 및 스타일 로드 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
	<link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css">
    
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


        /* ====== 로그인 폼 영역 ====== */
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
            box-sizing: border-box;
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
            padding-bottom: 20px; /* 로고와 구분선 추가 */
            border-bottom: 1px solid #eee;
            margin-bottom: 20px;
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
            height: 20px;
        }

        /* ====== 소셜 로그인 로고 버튼 스타일 (수정됨) ====== */
		.social-logo-container {
		    display: flex;
		    justify-content: center;
		    gap: 20px; /* 로고 간 간격 */
		    margin-top: 20px;
		}

		.social-logo-btn {
		    width: 50px; 
		    height: 50px;
		    /* 둥근 사각형 (스쿼클) 모양 */
		    border-radius: 12px; 
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    font-size: 24px;
		    text-decoration: none;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		    transition: all 0.3s ease;
		}

		.social-logo-btn:hover {
		    transform: scale(1.1);
		    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
		}

		/* 카카오 (노란색 배경, 어두운 아이콘) */
		.kakao-logo-btn {
		    background-color: #FEE500;
		    color: #3C1E1E; 
		}

		/* 구글 (흰색 배경, 이미지 로고) */
		.google-logo-btn {
		    background-color: white; 
            border: 1px solid #ddd; 
		}
        .google-logo-btn img {
            width: 70%; /* 이미지 크기 조정 */
            height: auto;
        }
        
        /* 네이버 (흰색 배경, 이미지 로고) */
		.naver-logo-btn {
		    background-color: white; 
            border: 1px solid #ddd;
		}
        .naver-logo-btn img {
            width: 70%; /* 이미지 크기 조정 */
            height: auto;
        }
  
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>

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
				<!-- 소셜 로그인 로고 버튼 컨테이너 -->
						<div class="social-logo-container">
						    
						    <!-- 카카오 로그인 (아이콘: Chat Bubble) -->
						    <a href="https://kauth.kakao.com/oauth/authorize?client_id=<%=kakaoClientId%>&redirect_uri=<%=kakaoRedirectUri%>&response_type=code" 
						       class="social-logo-btn kakao-logo-btn" title="카카오 로그인">
						        <!-- Font Awesome Chat Icon -->
						        <i class="fas fa-comment"></i>
						    </a>

						    <!-- 구글 로그인 (이미지 로고 사용) -->
						    <a href="https://accounts.google.com/o/oauth2/v2/auth?client_id=[[]][][][][][][][][[][][][][]&redirect_uri=http://localhost:8484/login/oauth2/code/google&response_type=code&scope=profile email openid" 
						       class="social-logo-btn google-logo-btn" title="Google 로그인">
				                <img src="https://recipe1.ezmember.co.kr/img/mobile/2022/icon_sns_g2.png?v.1" alt="Google 로고">
						    </a>

						    <!-- 네이버 로그인 (이미지 로고 사용) -->
						    <a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=<%=naverClientId%>&redirect_uri=<%=naverRedirectUri%>&state=<%=state%>" 
						       class="social-logo-btn naver-logo-btn" title="Naver 로그인">
						        <!-- 네이버 로고 이미지 -->
						        <img src="https://recipe1.ezmember.co.kr/img/mobile/2022/icon_sns_n3.png?v.1" alt="Naver 로고">
						    </a>
						</div>

                
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