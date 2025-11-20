<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>관리자 | 전체 회원 목록 - 요리조리</title>
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
			  
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }
		a {
			       text-decoration: none;
			       color: inherit;
			   }

		/* ====== Common Styles ====== */
		
        /* 제목 스타일 */
        h2 {
            font-size: 2rem;
            color: #ff6f61; /* 포인트 컬러 */
            font-weight: 700;
            margin-bottom: 30px;
            border-left: 6px solid #ff6f61;
            padding-left: 15px;
            line-height: 1;
        }

        /* 테이블 스타일 */
        .member-table {
            width: 100%;
            border-collapse: collapse; /* 테이블 경계선 합치기 */
            text-align: left;
            font-size: 0.95rem;
        }

        .member-table thead th {
            background-color: #2e7d32; /* 헤더 메뉴바의 hover 색상 활용 */
            color: white;
            padding: 15px 10px;
            border-bottom: 2px solid #1a5e1e;
            font-weight: 600;
            white-space: nowrap; /* 컬럼명이 줄바꿈되지 않도록 */
        }

        .member-table tbody tr {
            border-bottom: 1px solid #eee;
            transition: background-color 0.3s;
        }
        .member-table tbody tr:hover {
            background-color: #fffaf7; /* 메인 페이지 배경색 활용 */
        }
        .member-table tbody td {
            padding: 12px 10px;
            vertical-align: middle;
        }

        /* 특정 컬럼 강조/스타일링 */
        .member-table td:first-child { 
            font-weight: 600; 
            color: #444;
        }
        
        /* 삭제 버튼 스타일 */
        .delete-form {
            margin: 0;
            display: inline-block; /* 버튼 정렬을 위해 */
        }
        .delete-button {
            background-color: #ff6f61;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9rem;
            transition: background-color 0.2s;
        }
        .delete-button:hover {
            background-color: #e65a4c;
        }
        
        /* 반응형 디자인 (필요 시) */
        @media (max-width: 1024px) {
            .container { padding: 20px; }
            .member-table { font-size: 0.9rem; }
            .member-table thead th, .member-table tbody td { padding: 10px 8px; }
        }
    </style>
</head>
<body>


	<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="container">
    <h2><i class="bi bi-people-fill" style="margin-right: 10px;"></i> 전체 회원 목록</h2>

    <table class="member-table">
        <thead>
            <tr>
                <th>회원 ID</th>
                <th>닉네임</th>
                <th>이름</th>
                <th>이메일</th>
                <th>전화번호</th>
                <th>생년월일</th>
                <th>성별</th>
                <th>회원 삭제</th>
            </tr>
        </thead>
        <tbody>
           <c:forEach var="user" items="${userData}">
                <tr>
                    <td>${user.memberId}</td> 
                    <td>${user.nickname}</td>
                    <td>${user.name}</td>
                    <td>${user.email}</td>
                    <td>${user.phoneNumber}</td>
                    <td>${user.birthdate}</td>

                    <td>
                        <form action="delete2" method="post" class="delete-form">
                            <input type="hidden" name="memberId" value="${user.memberId}" />
                            <input type="submit" value="삭제" class="delete-button" 
                                   onclick="return confirm('${user.memberId} 님을 정말 삭제하시겠습니까?');" />
                        </form>
                    </td>
                </tr>
           </c:forEach>
        </tbody>
    </table>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>