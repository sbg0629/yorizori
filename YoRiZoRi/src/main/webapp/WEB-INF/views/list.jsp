<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>마이페이지 - 요리조리</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
		    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
			<link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css">
			<link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css">
			<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
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

        
        main {
            flex-grow: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 50px 20px;
        }
        .mypage-container {
            width: 100%;
            max-width: 800px;
            background-color: #fff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
        }
        .mypage-container h2 {
            text-align: center;
            font-size: 2rem;
            color: #333;
            margin-bottom: 30px;
            border-bottom: 2px solid #ff6f61;
            padding-bottom: 15px;
        }
        .profile-content {
            display: flex;
            align-items: center;
            gap: 40px;
        }
        .profile-image-section {
            flex-shrink: 0;
        }
        .profile-image-section img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid #fff;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        .profile-details {
            flex-grow: 1;
        }
        .info-list .info-item {
            display: flex;
            margin-bottom: 12px;
            font-size: 16px;
            border-bottom: 1px solid #eee;
            padding-bottom: 12px;
        }
        .info-list .info-item:last-child {
            border-bottom: none;
        }
        .info-list .label {
            width: 100px;
            font-weight: 600;
            color: #555;
        }
        .info-list .value {
            color: #333;
        }

        .action-buttons {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: center;
            gap: 15px;
            flex-wrap: wrap;
        }
        .action-buttons button, .action-buttons input[type="submit"] {
            font-family: "Noto Sans KR", sans-serif;
            padding: 10px 20px;
            font-size: 15px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-primary {
            background-color: #2e7d32;
            color: white;
        }
        .btn-primary:hover {
            background-color: #1b5e20;
        }
        .btn-secondary {
            background-color: #f0f0f0;
            color: #333;
        }
        .btn-secondary:hover {
            background-color: #e0e0e0;
        }
        .btn-bookmark {
            background-color: #ffa726;
            color: white;
        }
        .btn-bookmark:hover {
            background-color: #fb8c00;
        }
        .btn-danger {
            background-color: #d32f2f;
            color: white;
        }
        .btn-danger:hover {
            background-color: #c62828;
        }
        
        
        /* ⭐️ 내 게시물 보기와 아이콘이 겹치므로 아이콘 변경 */
        .btn-secondary i {
            margin-right: 8px; /* 아이콘과 텍스트 간격 조정 */
        }
        .btn-com i {
            margin-right: 8px; /* 아이콘과 텍스트 간격 조정 */
        }


        footer {
            text-align: center;
            padding: 20px 50px;
            margin-top: auto;
            border-top: 1px solid #e0e0e0;
            color: #888;
            font-size: 14px;
        }

        @media (max-width: 768px) {
            header { padding: 10px 30px; }
            .header-right i { font-size: 1.2rem; }
            .profile-content { flex-direction: column; }
            .action-buttons { flex-direction: column; }
        }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>


<main>
    <div class="mypage-container">
        <h2>마이페이지</h2>
        
        <div class="profile-content">
            <div class="profile-image-section">
                <c:choose>
                    <c:when test="${not empty user.profileImage}">
                        <img src="/images/${user.profileImage}" alt="프로필 이미지"/>
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/images/기본프로필.png" alt="기본 프로필 이미지"/>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="profile-details">
                <div class="info-list">
                    <div class="info-item">
                        <span class="label">닉네임</span>
                        <span class="value">${user.nickname}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">이름</span>
                        <span class="value">${user.name}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">아이디</span>
                        <span class="value">${user.memberId}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">이메일</span>
                        <span class="value">${user.email}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">전화번호</span>
                        <span class="value">${user.phoneNumber}</span>
                    </div>

                </div>
            </div>
        </div>

        <div class="action-buttons">
            <button type="button" class="btn-primary" onclick="location.href='mypage_edit?member_Id=${user.memberId}'">
                <i class="bi bi-pencil-square"></i> 정보 수정
            </button>
            <button type="button" class="btn-secondary" onclick="location.href='myrecipe?member_Id=${user.memberId}'">
                <i class="bi bi-file-text"></i> 내 게시물 보기
            </button>
            <button type="button" class="btn-bookmark" onclick="location.href='mybookmark?member_Id=${user.memberId}'">
                <i class="bi bi-bookmark-fill"></i> 북마크 목록
            </button>
            <form action="delete" method="post" style="margin:0;">
                <input type="hidden" name="memberId" value="${user.memberId}" />
                <input type="submit" class="btn-danger" value="회원 탈퇴" onclick="return confirm('정말 탈퇴하시겠습니까?');" />
            </form>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	

   

</body>
</html>