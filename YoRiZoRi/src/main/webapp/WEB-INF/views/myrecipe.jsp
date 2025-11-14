<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>내가 쓴 게시글 - 요리조리</title>
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

        /* ---------------- 메인 영역 (게시글 목록 전용 스타일) ---------------- */
        main {
            flex-grow: 1;
            display: flex;
            justify-content: center;
            align-items: flex-start; /* 컨텐츠가 길어질 것을 대비해 상단 정렬 */
            padding: 50px 20px;
        }
        .post-list-container {
            width: 100%;
            max-width: 800px;
            background-color: #fff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
        }
        .post-list-container h2 {
            text-align: center;
            font-size: 2rem;
            color: #333;
            margin-top: 0;
            margin-bottom: 30px;
            border-bottom: 2px solid #ff6f61;
            padding-bottom: 15px;
        }
        .post-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .post-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 15px;
            border-bottom: 1px solid #eee;
            transition: background-color 0.3s, transform 0.2s;
        }
        .post-item:hover {
            background-color: #f9f9f9;
            transform: translateX(5px);
        }
        .post-item:last-child {
            border-bottom: none;
        }
        .post-title {
            font-size: 1.1rem;
            font-weight: 500;
        }
        .post-item i {
            font-size: 1.2rem;
            color: #aaa;
        }
        .no-posts {
            text-align: center;
            padding: 50px 0;
            color: #888;
            font-size: 1.1rem;
        }

    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<main>
    <div class="post-list-container">
        <h2>내가 쓴 게시글</h2>
        
        <div class="post-list">
            <c:choose>
                <c:when test="${not empty recipe}">
                    <c:forEach var="recipe" items="${recipe}">
                        <a href="<c:url value='/detail.do?recipe_Id=${recipe.recipeId}'/>" class="post-item">
                            <span class="post-title">${recipe.title}</span>
                            <i class="bi bi-chevron-right"></i>
                        </a>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-posts">
                        작성한 게시글이 없습니다.
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</main>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>


</body>
</html>