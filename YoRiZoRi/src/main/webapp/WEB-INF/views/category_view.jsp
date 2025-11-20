<!--<%@ page language="java" contentType="text/html; charset=UTF-8"-->
<!--    pageEncoding="UTF-8"%>-->
<!--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>-->
<!--<!DOCTYPE html>-->
<!--<html lang="ko">-->
<!--<head>-->
<!--<meta charset="UTF-8">-->
<!--<meta name="viewport" content="width=device-width, initial-scale=1.0">-->
<!--<title>레시피 목록 | 요리조리</title>-->
<!--		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">-->
<!--	    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />-->
<!--		<link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css">-->
<!--		<link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css">-->
<!--		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">-->
<!--		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">-->
<!--		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">-->
<!--<style>-->
<!--    /* ====== 공통 스타일 ====== */-->
<!--    body {-->
<!--        font-family: "Noto Sans KR", sans-serif;-->
<!--        margin: 0;-->
<!--        padding: 0;-->
<!--        background-color: #fffaf7;-->
<!--        color: #333;-->
<!--    }-->

<!--    a {-->
<!--        text-decoration: none;-->
<!--        color: inherit;-->
<!--    }-->

<!--	   /* ====== 레시피 카드 그리드 ====== */-->
<!--		.grid-container {-->
<!--		    display: grid;-->
<!--		    grid-template-columns: repeat(3, 1fr); /* 3열 고정 */-->
<!--		    grid-auto-rows: auto; /* 카드 높이 자동 */-->
<!--		    gap: 20px;-->
<!--		    max-width: 1200px;-->
<!--		    margin: 40px auto;-->
<!--		    padding: 0 20px;-->
<!--		    /* overflow 제거 → 컨테이너가 자동으로 늘어나도록 */-->
<!--		}-->
		
<!--		.card {-->
<!--		    background: #fff;-->
<!--		    border-radius: 12px;-->
<!--		    box-shadow: 0 4px 15px rgba(0,0,0,0.1);-->
<!--		    overflow: hidden;-->
<!--		    display: flex;-->
<!--		    flex-direction: column;-->
<!--		    transition: transform 0.3s ease, box-shadow 0.3s ease;-->
<!--		    cursor: pointer;-->
<!--		}-->
		
<!--		.card img {-->
<!--		    width: 100%;-->
<!--		    height: 250px; /* 고정 */-->
<!--		    object-fit: cover;-->
<!--		}-->
		
<!--		.card-content {-->
<!--		    padding: 14px 16px;-->
<!--		    flex-grow: 1;-->
<!--		    display: flex;-->
<!--		    flex-direction: column;-->
<!--		}-->

<!--    .card-title {-->
<!--        font-weight: 700;-->
<!--        font-size: 1.1rem;-->
<!--        margin-bottom: 8px;-->
<!--        color: #ff6f61;-->
<!--    }-->

<!--    .card-info {-->
<!--        font-size: 0.9rem;-->
<!--        color: #555;-->
<!--        margin-bottom: 4px;-->
<!--    }-->

<!--    .card-info strong {-->
<!--        color: #333;-->
<!--    }-->

<!--    footer {-->
<!--        text-align: center;-->
<!--        padding: 20px 0;-->
<!--        margin-top: 50px;-->
<!--        border-top: 1px solid #eee;-->
<!--        color: #888;-->
<!--        font-size: 0.9rem;-->
<!--    }-->
<!--</style>-->
<!-- 아이콘 CDN -->
<!--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>-->
<!--</head>-->
<!--<body>-->
<!--	<jsp:include page="/WEB-INF/views/common/header.jsp"/>-->

<!--<div class="grid-container">-->
<!--    <c:forEach var="dto" items="${category_view}">-->
<!--        <%-- **수정된 부분: div에 onclick 이벤트 추가** --%>-->
<!--        <div class="card" -->
<!--             onclick="location.href='detail.do?recipe_Id=${dto.recipeId}'"-->
<!--             style="cursor: pointer;">-->
             
<!--            <img src="${dto.mainImage}" alt="${dto.title}">-->
<!--            <div class="card-content">-->
<!--                <div class="card-title">${dto.title}</div>-->
<!--                <div class="card-info"><strong>별점:</strong> ${dto.rating}</div>-->
<!--                <div class="card-info"><strong>조회수:</strong> ${dto.hit}</div>-->
<!--                <div class="card-info"><strong>조리 시간:</strong> ${dto.cookingTime}</div>-->
<!--                <div class="card-info"><strong>요리 양:</strong> ${dto.servingSize}인분</div>-->
<!--                <div class="card-info"><strong>난이도:</strong> ${dto.difficulty}</div>-->
<!--            </div>-->
<!--        </div>-->
<!--    </c:forEach>-->
<!--</div>-->


<!--<jsp:include page="/WEB-INF/views/common/footer.jsp"/>-->

<!--</body>-->
<!--</html>-->
