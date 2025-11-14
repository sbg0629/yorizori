<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>요리조리 | ${recipe.title} - 요리조리</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
		    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
			<link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css">
			<link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css">
			<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        /* ====== 기본 & 헤더 스타일 (메인 페이지와 동일) ====== */
        body {
            font-family: "Noto Sans KR", sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f7f7f7;
            color: #333;
        }
        a { text-decoration: none; color: inherit; }
        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        /* ====== 레시피 컨텐츠 스타일 ====== */
        .recipe-container { 
            max-width: 900px; 
            margin: 30px auto; 
            padding: 40px; 
            background-color: white; 
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.1); 
        }
        
        .recipe-title {
            font-size: 2.5rem; 
            color: #333; 
            font-weight: 700;
            padding-bottom: 10px;
            margin-bottom: 20px;
            border-bottom: 2px solid #ff6f61;
        }
        
        .recipe-meta { 
            background-color: #fff8f7;
            padding: 15px 25px; 
            margin-bottom: 30px; 
            border-radius: 10px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center;
            font-size: 0.95rem;
            border: 1px solid #ffe0d5;
        }
        .meta-item { 
            display: flex; 
            align-items: center; 
            gap: 5px;
            color: #555;
        }
        .meta-item strong { color: #ff6f61; font-weight: 600; }
        .meta-icon { color: #ff6f61; font-size: 1.2rem; }

        .main-image { 
            width: 100%; 
            max-height: 400px;
            object-fit: cover; 
            border-radius: 10px; 
            margin-bottom: 30px; 
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }
        
        .section-header { 
            font-size: 1.6rem; 
            font-weight: 700;
            color: #2e7d32;
            margin-top: 40px; 
            margin-bottom: 20px;
            padding-left: 10px;
            border-left: 5px solid #ff6f61;
        }

        .recipe-description {
            background-color: #f0f8ff;
            padding: 20px;
            border-radius: 8px;
            line-height: 1.6;
            margin-bottom: 30px;
            border: 1px dashed #c0e0ff;
        }
        
        .ingredient-list {
            list-style: none;
            padding: 0;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 10px 20px;
        }
        .ingredient-list li {
            background-color: #fff;
            padding: 10px 15px;
            border-radius: 5px;
            border-left: 4px solid #2e7d32;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        .ingredient-list li strong { color: #2e7d32; }

        .step-item { 
            background: #fff; 
            border: 1px solid #e0e0e0; 
            padding: 20px; 
            margin-bottom: 25px; 
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        .step-item h3 {
            font-size: 1.3rem;
            color: #ff6f61;
            margin-top: 0;
            margin-bottom: 15px;
            border-bottom: 1px dashed #ff6f6130;
            padding-bottom: 5px;
        }
        .step-img { 
            max-width: 100%; 
            height: auto; 
            margin-top: 15px; 
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        /* 댓글 및 후기 */
        .comment-review-box { 
            padding-top: 30px; 
            margin-top: 40px; 
            border-top: 2px solid #eee; 
        }
        .review-item, .comment-item {
            margin-bottom: 20px; 
            padding: 15px; 
            border: 1px solid #f0f0f0; 
            border-radius: 8px;
            background-color: #fafafa;
            position: relative;
            padding-bottom: 45px;
        }

        .review-rating { 
            color: gold; 
            font-size: 1.2em; 
            letter-spacing: 2px;
        }
        .review-header, .comment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 5px;
        }
        .review-header strong, .comment-header strong {
            font-size: 1.1rem;
            color: #333;
        }
        .review-content, .comment-content {
            margin-top: 10px;
            line-height: 1.5;
        }
        .comment-item {
            margin-bottom: 10px;
        }
        .reply-item {
            margin-left: 30px;
            border-left: 3px solid #2e7d32;
            padding-left: 15px;
            background-color: #fcfcfc;
            margin-top: 10px;
        }

        /* 액션 버튼 (수정/삭제) */
        .action-buttons {
            text-align: right;
            margin: 10px 0 20px 0;
        }
        
        .action-buttons a, .action-btn {
            display: inline-block;
            padding: 8px 18px;
            border-radius: 5px;
            font-size: 0.9rem;
            font-weight: 500;
            color: #fff;
            text-decoration: none;
            margin-left: 10px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }
        
        .btn-modify {
            background-color: #2e7d32;
        }
        .btn-modify:hover {
            background-color: #246b28;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        
        .btn-delete {
            background-color: #d32f2f;
        }
        .btn-delete:hover {
            background-color: #b71c1c;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        
        /* 북마크 버튼 */
        .btn-bookmark {
            background-color: #ffa726;
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
            z-index: 999;
            transition: all 0.3s ease;
            cursor: pointer;
            border: none;
        }
        .btn-bookmark:hover {
            background-color: #fb8c00;
            transform: translateY(-3px);
            box-shadow: 0 6px 16px rgba(0,0,0,0.4);
        }
        .btn-bookmark.bookmarked {
            background-color: #ff6f61;
        }
        .btn-bookmark.bookmarked:hover {
            background-color: #e85b50;
        }
        
        .btn-reply {
            background-color: #1976d2;
            font-size: 0.85rem;
            padding: 5px 12px;
        }
        .btn-reply:hover {
            background-color: #1565c0;
        }

        .buy-btn {
            margin-left: 10px;
            padding: 5px 10px;
            background-color: #ff6f61;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 0.85rem;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }
        .buy-btn:hover {
            background-color: #e85b50;
            transform: translateY(-2px);
        }
        
        /* 별점 입력 스타일 */
        .rating-input {
            display: flex;
            flex-direction: row-reverse;
            gap: 5px;
            justify-content: flex-end;
        }
        .rating-input input[type="radio"] {
            display: none;
        }
        .rating-input label {
            font-size: 2rem;
            color: #ddd;
            cursor: pointer;
            transition: color 0.2s;
        }
        .rating-input input[type="radio"]:checked ~ label,
        .rating-input label:hover,
        .rating-input label:hover ~ label {
            color: #ffc107;
        }

        /* 수정 폼 스타일 */
        .edit-form {
            margin-top: 10px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }
        .edit-form textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            resize: vertical;
            margin-bottom: 10px;
        }
        .edit-form button {
            padding: 8px 15px;
            margin-right: 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9rem;
        }
        .edit-form .btn-save {
            background-color: #2e7d32;
            color: white;
        }
        .edit-form .btn-cancel {
            background-color: #757575;
            color: white;
        }

        /* 대댓글 작성 폼 */
        .reply-form {
            margin-top: 10px;
            padding: 15px;
            background-color: #e8f5e9;
            border-radius: 5px;
        }

        footer {
            text-align: center; padding: 30px 50px; margin-top: 40px;
            border-top: 1px solid #e0e0e0; color: #888; font-size: 14px;
        }

        @media (max-width: 768px) {
            header { padding: 10px 30px; }
            .header-right i { font-size: 1.2rem; }
        }

        @media (max-width: 600px) {
            .recipe-container { padding: 20px; margin: 20px auto; }
            .recipe-title { font-size: 2rem; }
            .recipe-meta { flex-direction: column; gap: 10px; align-items: flex-start; }
            .section-header { font-size: 1.4rem; }
            .reply-item { margin-left: 15px; }
        }

                /* [추가] 후기/댓글용 작은 삭제 버튼 */
        .btn-delete-comment {
            background-color: #eee;
            color: #888;
            font-size: 0.8rem; /* 작은 폰트 */
            padding: 3px 10px; /* 작은 패딩 */
            border-radius: 4px;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.2s, color 0.2s;
            border: 1px solid #ddd;
        }
        .btn-delete-comment:hover {
            background-color: #d32f2f; /* 기존 삭제 버튼(빨강)과 통일 */
            color: white;
            border-color: #d32f2f;
        }

        .delete-button-container {
            position: absolute; /* [핵심 3] 다른 요소와 상관없이 독립 */
            bottom: 15px;       /* 부모 박스 맨 아래에서 15px 위 */
            right: 15px;        /* 부모 박스 맨 오른쪽에서 15px 안쪽 */
        }
		
		/* [추가] 작성자 닉네임 링크 스타일 */
		.recipe-meta a,
		.review-header a,
		.comment-header a {
		    text-decoration: none; /* 1. 평소에는 밑줄을 제거합니다. */
		    color: inherit;        /* 2. 부모 태그(strong)의 색상을 그대로 사용합니다. */
		    transition: color 0.2s ease, text-decoration 0.2s ease; /* 3. 부드러운 효과를 줍니다. */
		}

		/* [추가] 닉네임에 마우스를 올렸을 때(hover) 스타일 */
		.recipe-meta a:hover,
		.review-header a:hover,
		.comment-header a:hover {
		    text-decoration: underline; /* 4. 밑줄을 표시합니다. */
		    color: #ff6f61;             /* 5. (선택) 사이트 테마 색상으로 변경합니다. */
		}
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="recipe-container">

    <c:if test="${sessionScope.id == recipe.memberId}">
        <div class="action-buttons">
            <a href="<c:url value='/modifyRecipe?recipeId=${recipe.recipeId}'/>" class="btn-modify">수정</a>
            <a href="<c:url value='/deleteRecipe?recipeId=${recipe.recipeId}'/>" class="btn-delete" onclick="return confirm('정말로 이 레시피를 삭제하시겠습니까?');">삭제</a>
        </div>
    </c:if>
    
    <!-- 모든 로그인 사용자용 북마크 버튼 -->
    <c:if test="${not empty sessionScope.id}">
        <div style="text-align: right; margin-bottom: 20px;">
            <button id="bookmarkBtn" class="action-btn" onclick="toggleBookmark()" 
                    style="background-color: #ffa726; display: inline-flex; align-items: center; gap: 5px;">
                <i class="bi bi-bookmark" id="bookmarkIcon"></i>
                <span id="bookmarkText">즐겨찾기</span>
            </button>
        </div>
    </c:if>

    <h1 class="recipe-title">${recipe.title}</h1>
    
    <div class="recipe-meta">
        <span class="meta-item"><i class="bi bi-person-fill meta-icon"></i> 작성자: <a href="member_profile?id=${recipe.memberId}"><strong>${recipe.memberId}</strong></a></span>
        <span class="meta-item"><i class="bi bi-eye-fill meta-icon"></i> 조회수: <strong>${recipe.hit}</strong></span>
        <span class="meta-item"><i class="bi bi-star-fill meta-icon"></i> 평균 별점: <strong><c:out value="${recipe.average_rating}" default="0.0"/>점</strong></span>
        <span class="meta-item"><i class="bi bi-chat-dots-fill meta-icon"></i> 댓글: <strong>${recipe.commentList.size()}개</strong></span>
        <span class="meta-item"><i class="bi bi-calendar-check meta-icon"></i> 작성일: <strong><fmt:formatDate value="${recipe.createdat}" pattern="yyyy.MM.dd"/></strong></span>
    </div>
    
    <img src="${recipe.mainImage}" alt="${recipe.title}" class="main-image">

    <h2 class="section-header"><i class="bi bi-book"></i> 레시피 요약</h2>
    <p class="recipe-description">${recipe.description}</p>
    
    <div class="recipe-meta" style="justify-content: space-evenly; background-color: #f5fcf5; border-color: #d8f5d8;">
        <span class="meta-item"><i class="bi bi-speedometer2 meta-icon"></i> 난이도: <strong>${recipe.difficulty}</strong></span>
        <span class="meta-item"><i class="bi bi-alarm-fill meta-icon"></i> 조리 시간: <strong>${recipe.cookingTime}</strong></span>
        <span class="meta-item"><i class="bi bi-person-badge-fill meta-icon"></i> 요리 양: <strong>${recipe.servingSize}인분</strong></span>
    </div>

    <h2 class="section-header"><i class="bi bi-basket-fill"></i> 필요한 재료 (${recipe.servingSize}인분 기준)</h2>
    <ul class="ingredient-list">
        <c:choose>
            <c:when test="${empty recipe.ingredientList}">
                <li>등록된 재료가 없습니다.</li>
            </c:when>
            <c:otherwise>
                <c:forEach var="ing" items="${recipe.ingredientList}">
                    <li>
                        ${ing.name}: <strong>${ing.quantity}</strong>
                        <button class="buy-btn" type="button" data-name="${ing.name}" onclick="buyIngredient(this)">구매하기</button>
                    </li>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </ul>
    
    <h2 class="section-header"><i class="bi bi-tools"></i> 조리 순서</h2>
    <c:choose>
        <c:when test="${empty recipe.stepList}">
            <p>등록된 조리 단계가 없습니다.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="step" items="${recipe.stepList}" varStatus="loop">
                <div class="step-item">
                    <h3>STEP ${loop.count}</h3> 
                    <p>${step.instruction}</p>
                    <c:if test="${not empty step.imageUrl}">
                        <img src="<c:url value='/${step.imageUrl}'/>" alt="조리 단계 이미지" class="step-img">
                    </c:if>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
    
    <!-- 후기 섹션 -->
    <div class="comment-review-box">
        <h2 class="section-header" style="margin-top: 0;"><i class="bi bi-pencil-square"></i> 사용자 후기 및 평점 (${recipe.reviewList.size()}개)</h2>
        
        <c:choose>
            <c:when test="${empty recipe.reviewList}">
                <p>아직 등록된 후기가 없습니다. 첫 후기를 남기고 별점을 평가해주세요!</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="rvw" items="${recipe.reviewList}">
                    <div class="review-item">
                        <div class="review-header">
                            <a href="member_profile?id=${rvw.memberId}"><strong>${rvw.memberId}</strong></a> 
                            <span class="review-rating">
                                <c:forEach begin="1" end="${rvw.rating}">★</c:forEach>
                                <c:forEach begin="${rvw.rating + 1}" end="5">☆</c:forEach>
                                (${rvw.rating}점)
                            </span>

                        </div>
                        <p style="font-size: 0.85rem; color: #999; margin-bottom: 10px;">
                            <fmt:formatDate value="${rvw.createdat}" pattern="yy.MM.dd"/> 작성
                        </p>
                        <p class="review-content">${rvw.content}</p>
                        <c:if test="${not empty rvw.image}">
                            <img src="${rvw.image}" alt="후기 이미지" style="max-width: 200px; border-radius: 5px; margin-top: 10px;">
                        </c:if>

                        <div class="delete-button-container">
                            <%-- [수정] 로그인 ID와 후기 작성자 ID가 같을 때만 버튼 표시 --%>
                            <c:if test="${sessionScope.id == rvw.memberId}">
                                <a href="<c:url value='/deleteReview?review_Id=${rvw.review_Id}&recipe_Id=${recipe.recipeId}'/>"
                                class="btn-delete-comment" 
                                onclick="return confirm('정말 이 후기를 삭제하시겠습니까?');">삭제</a>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        
        <!-- 후기 작성 폼 -->
        <c:if test="${not empty sessionScope.id}">
            <div class="write-form" style="background-color: #f8f9fa; padding: 20px; border-radius: 10px; margin-top: 20px;">
                <h4 style="margin-top: 0; color: #2e7d32;">후기 작성</h4>
                <form id="reviewForm">
                    <input type="hidden" name="recipeId" value="${recipe.recipeId}">
                    <div style="margin-bottom: 15px;">
                        <label style="display: block; margin-bottom: 5px; font-weight: bold;">평점:</label>
                        <div class="rating-input">
                            <input type="radio" name="rating" value="5" id="star5">
                            <label for="star5">★</label>
                            <input type="radio" name="rating" value="4" id="star4">
                            <label for="star4">★</label>
                            <input type="radio" name="rating" value="3" id="star3">
                            <label for="star3">★</label>
                            <input type="radio" name="rating" value="2" id="star2">
                            <label for="star2">★</label>
                            <input type="radio" name="rating" value="1" id="star1">
                            <label for="star1">★</label>
                        </div>
                    </div>
                    <div style="margin-bottom: 15px;">
                        <label style="display: block; margin-bottom: 5px; font-weight: bold;">후기 내용:</label>
                        <textarea name="content" rows="4" style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; resize: vertical;" placeholder="후기를 작성해주세요..."></textarea>
                    </div>
                    <div style="margin-bottom: 15px;">
                        <label style="display: block; margin-bottom: 5px; font-weight: bold;">이미지 URL (선택사항):</label>
                        <input type="text" name="image" style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px;" placeholder="이미지 URL을 입력해주세요...">
                    </div>
                    <button type="submit" style="background-color: #2e7d32; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;">후기 작성</button>
                </form>
            </div>
        </c:if>
    </div>

    <!-- 댓글 섹션 -->
    <div class="comment-review-box">
        <h2 class="section-header" style="margin-top: 0;"><i class="bi bi-chat-left-text-fill"></i> 댓글 (${recipe.commentList.size()}개)</h2>
        
        <div id="commentList">
        <c:choose>
            <c:when test="${empty recipe.commentList}">
                <p>아직 등록된 댓글이 없습니다. 첫 댓글을 남겨보세요!</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="cmt" items="${recipe.commentList}">
                    <div class="comment-item">
                        <div class="comment-header">
                            <a href="member_profile?id=${cmt.memberId}"><strong>${cmt.memberId}</strong></a> 
                            <span style="font-size: 0.8rem; color: #999;"><fmt:formatDate value="${cmt.createdat}" pattern="yy.MM.dd HH:mm"/></span>
                        </div>
                        <p class="comment-content" style="margin-top: 5px;">${cmt.content}</p>
                        <div class="delete-button-container">
                            <c:if test="${sessionScope.id == cmt.memberId && cmt.content != '삭제된 댓글입니다.'}">

                                <%-- [수정] URL과 파라미터 이름을 댓글에 맞게 변경 --%>
                                <a href="<c:url value='/deleteComment?comment_Id=${cmt.comment_Id}&recipe_Id=${recipe.recipeId}'/>" 
                                class="btn-delete-comment" 
                                onclick="return confirm('정말 이 댓글을 삭제하시겠습니까?');">삭제</a>

                            </c:if>
                        </div>
                        
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        </div>
        
        <!-- 댓글 작성 폼 -->
        <c:if test="${not empty sessionScope.id}">
            <div class="write-form" style="background-color: #f8f9fa; padding: 20px; border-radius: 10px; margin-top: 20px;">
                <h4 style="margin-top: 0; color: #2e7d32;">댓글 작성</h4>
                <form id="commentForm">
                    <input type="hidden" name="recipeId" value="${recipe.recipeId}">
                    <div style="margin-bottom: 15px;">
                        <label style="display: block; margin-bottom: 5px; font-weight: bold;">댓글 내용:</label>
                        <textarea name="content" rows="3" style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; resize: vertical;" placeholder="댓글을 작성해주세요..."></textarea>
                    </div>
                    <button type="submit" style="background-color: #2e7d32; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;">댓글 작성</button>
                </form>
            </div>
        </c:if>
    </div>

</div>

<!-- 북마크 버튼 (로그인한 사용자만) -->
<c:if test="${not empty sessionScope.id}">
    <button id="bookmarkBtn" class="btn-bookmark" onclick="toggleBookmark()" title="즐겨찾기">
        <i class="bi bi-bookmark" id="bookmarkIcon"></i>
    </button>
</c:if>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<script>
    

    // 댓글 작성
    document.getElementById('commentForm').addEventListener('submit', function(e) {
        e.preventDefault();
        
        const formData = new FormData(this);
        const recipeId = formData.get('recipeId');
        const content = formData.get('content');
        
        if (!content.trim()) {
            alert('댓글 내용을 입력해주세요.');
            return;
        }
        
        fetch('${pageContext.request.contextPath}/comment/write', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'recipeId=' + recipeId + '&content=' + encodeURIComponent(content)
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(data.message);
                location.reload();
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('댓글 작성 중 오류가 발생했습니다.');
        });
    });

    // 후기 작성
    document.getElementById('reviewForm').addEventListener('submit', function(e) {
        e.preventDefault();
        
        const formData = new FormData(this);
        const recipeId = formData.get('recipeId');
        const content = formData.get('content');
        const rating = formData.get('rating');
        const image = formData.get('image');
        
        if (!content.trim()) {
            alert('후기 내용을 입력해주세요.');
            return;
        }
        
        if (!rating) {
            alert('평점을 선택해주세요.');
            return;
        }
        
        fetch('${pageContext.request.contextPath}/review/write', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'recipeId=' + recipeId + '&content=' + encodeURIComponent(content) + '&rating=' + rating + '&image=' + encodeURIComponent(image)
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(data.message);
                location.reload();
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('후기 작성 중 오류가 발생했습니다.');
        });
    });

    // 댓글 수정 폼 표시
    function showEditCommentForm(commentId, content) {
        const commentDiv = document.getElementById('comment-' + commentId);
        const contentWrapper = commentDiv.querySelector('.comment-content-wrapper');
        
        // 이미 수정 폼이 있으면 제거
        const existingForm = contentWrapper.querySelector('.edit-form');
        if (existingForm) {
            existingForm.remove();
            return;
        }
        
        const editForm = document.createElement('div');
        editForm.className = 'edit-form';
        editForm.innerHTML = `
            <textarea id="edit-content-${commentId}" rows="3">${content}</textarea>
            <button class="btn-save" onclick="updateComment(${commentId})">저장</button>
            <button class="btn-cancel" onclick="cancelEdit(${commentId})">취소</button>
        `;
        
        contentWrapper.appendChild(editForm);
    }

    // 댓글 수정 취소
    function cancelEdit(commentId) {
        const commentDiv = document.getElementById('comment-' + commentId);
        const editForm = commentDiv.querySelector('.edit-form');
        if (editForm) {
            editForm.remove();
        }
    }

    // 댓글 수정 저장
    function updateComment(commentId) {
        const content = document.getElementById('edit-content-' + commentId).value;
        
        if (!content.trim()) {
            alert('댓글 내용을 입력해주세요.');
            return;
        }
        
        fetch('${pageContext.request.contextPath}/comment/update', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'commentId=' + commentId + '&content=' + encodeURIComponent(content)
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(data.message);
                location.reload();
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('댓글 수정 중 오류가 발생했습니다.');
        });
    }

    // 댓글 삭제
    function deleteComment(commentId) {
        if (!confirm('정말로 이 댓글을 삭제하시겠습니까?')) {
            return;
        }
        
        fetch('${pageContext.request.contextPath}/comment/delete', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'commentId=' + commentId
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(data.message);
                location.reload();
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('댓글 삭제 중 오류가 발생했습니다.');
        });
    }

    // 대댓글 작성 폼 표시
    function showReplyForm(parentCommentId) {
        const commentDiv = document.getElementById('comment-' + parentCommentId);
        
        // 이미 대댓글 폼이 있으면 제거
        const existingForm = commentDiv.querySelector('.reply-form');
        if (existingForm) {
            existingForm.remove();
            return;
        }
        
        const replyForm = document.createElement('div');
        replyForm.className = 'reply-form';
        replyForm.innerHTML = `
            <h5 style="margin-top: 0; color: #2e7d32;">답글 작성</h5>
            <textarea id="reply-content-${parentCommentId}" rows="3" placeholder="답글을 입력해주세요..." style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; margin-bottom: 10px;"></textarea>
            <button onclick="submitReply(${parentCommentId})" style="background-color: #1976d2; color: white; padding: 8px 15px; border: none; border-radius: 5px; cursor: pointer; margin-right: 5px;">답글 작성</button>
            <button onclick="cancelReply(${parentCommentId})" style="background-color: #757575; color: white; padding: 8px 15px; border: none; border-radius: 5px; cursor: pointer;">취소</button>
        `;
        
        commentDiv.appendChild(replyForm);
    }

    // 대댓글 작성 취소
    function cancelReply(parentCommentId) {
        const commentDiv = document.getElementById('comment-' + parentCommentId);
        const replyForm = commentDiv.querySelector('.reply-form');
        if (replyForm) {
            replyForm.remove();
        }
    }

    // 대댓글 제출
    function submitReply(parentCommentId) {
        const content = document.getElementById('reply-content-' + parentCommentId).value;
        
        if (!content.trim()) {
            alert('답글 내용을 입력해주세요.');
            return;
        }
        
        fetch('${pageContext.request.contextPath}/comment/reply', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'recipeId=${recipe.recipeId}&parentCommentId=' + parentCommentId + '&content=' + encodeURIComponent(content)
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(data.message);
                location.reload();
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('답글 작성 중 오류가 발생했습니다.');
        });
    }

    // 후기 수정 폼 표시
    function showEditReviewForm(reviewId, content, rating) {
        const reviewDiv = document.getElementById('review-' + reviewId);
        const contentWrapper = reviewDiv.querySelector('.review-content-wrapper');
        
        // 이미 수정 폼이 있으면 제거
        const existingForm = contentWrapper.querySelector('.edit-form');
        if (existingForm) {
            existingForm.remove();
            return;
        }
        
        const editForm = document.createElement('div');
        editForm.className = 'edit-form';
        editForm.innerHTML = `
            <label style="display: block; margin-bottom: 5px; font-weight: bold;">평점:</label>
            <div class="rating-input" style="margin-bottom: 10px;">
                <input type="radio" name="edit-rating-${reviewId}" value="5" id="edit-star5-${reviewId}" ${rating == 5 ? 'checked' : ''}>
                <label for="edit-star5-${reviewId}">★</label>
                <input type="radio" name="edit-rating-${reviewId}" value="4" id="edit-star4-${reviewId}" ${rating == 4 ? 'checked' : ''}>
                <label for="edit-star4-${reviewId}">★</label>
                <input type="radio" name="edit-rating-${reviewId}" value="3" id="edit-star3-${reviewId}" ${rating == 3 ? 'checked' : ''}>
                <label for="edit-star3-${reviewId}">★</label>
                <input type="radio" name="edit-rating-${reviewId}" value="2" id="edit-star2-${reviewId}" ${rating == 2 ? 'checked' : ''}>
                <label for="edit-star2-${reviewId}">★</label>
                <input type="radio" name="edit-rating-${reviewId}" value="1" id="edit-star1-${reviewId}" ${rating == 1 ? 'checked' : ''}>
                <label for="edit-star1-${reviewId}">★</label>
            </div>
            <textarea id="edit-review-content-${reviewId}" rows="4">${content}</textarea>
            <button class="btn-save" onclick="updateReview(${reviewId})">저장</button>
            <button class="btn-cancel" onclick="cancelEditReview(${reviewId})">취소</button>
        `;
        
        contentWrapper.appendChild(editForm);
    }

    // 후기 수정 취소
    function cancelEditReview(reviewId) {
        const reviewDiv = document.getElementById('review-' + reviewId);
        const editForm = reviewDiv.querySelector('.edit-form');
        if (editForm) {
            editForm.remove();
        }
    }

    // 후기 수정 저장
    function updateReview(reviewId) {
        const content = document.getElementById('edit-review-content-' + reviewId).value;
        const rating = document.querySelector('input[name="edit-rating-' + reviewId + '"]:checked');
        
        if (!content.trim()) {
            alert('후기 내용을 입력해주세요.');
            return;
        }
        
        if (!rating) {
            alert('평점을 선택해주세요.');
            return;
        }
        
        fetch('${pageContext.request.contextPath}/review/update', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'reviewId=' + reviewId + '&content=' + encodeURIComponent(content) + '&rating=' + rating.value + '&image='
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(data.message);
                location.reload();
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('후기 수정 중 오류가 발생했습니다.');
        });
    }

    // 후기 삭제
    function deleteReview(reviewId) {
        if (!confirm('정말로 이 후기를 삭제하시겠습니까?')) {
            return;
        }
        
        fetch('${pageContext.request.contextPath}/review/delete', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'reviewId=' + reviewId
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(data.message);
                location.reload();
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('후기 삭제 중 오류가 발생했습니다.');
        });
    }

    // 재료 구매 링크
    function buyIngredient(button) {
        const ingredientName = button.dataset.name;
        console.log("가져온 재료 이름:", ingredientName);

        if (!ingredientName || ingredientName.trim() === '') {
            alert("⚠️ 재료 이름을 불러오지 못했습니다.");
            return;
        }

        if (confirm("'" + ingredientName + "'를(을) 구매하시겠습니까?")) {
            const query = encodeURIComponent(ingredientName);
            window.open("https://www.coupang.com/np/search?q=" + query, "_blank");
        }
    }

    // ==================== 북마크 기능 ====================
    
    // 페이지 로드 시 북마크 상태 확인
    window.addEventListener('DOMContentLoaded', function() {
        checkBookmarkStatus();
    });
    
    // 북마크 상태 확인
    function checkBookmarkStatus() {
        const bookmarkBtn = document.getElementById('bookmarkBtn');
        if (!bookmarkBtn) return; // 로그인하지 않은 경우
        
        fetch('${pageContext.request.contextPath}/bookmark/status?recipeId=${recipe.recipeId}')
            .then(response => response.json())
            .then(data => {
                if (data.success && data.bookmarked) {
                    bookmarkBtn.classList.add('bookmarked');
                    document.getElementById('bookmarkIcon').className = 'bi bi-bookmark-fill';
                } else {
                    bookmarkBtn.classList.remove('bookmarked');
                    document.getElementById('bookmarkIcon').className = 'bi bi-bookmark';
                }
            })
            .catch(error => {
                console.error('북마크 상태 확인 오류:', error);
            });
    }
    
    // 북마크 토글
    function toggleBookmark() {
        fetch('${pageContext.request.contextPath}/bookmark/toggle', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'recipeId=${recipe.recipeId}'
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                const bookmarkBtn = document.getElementById('bookmarkBtn');
                const bookmarkIcon = document.getElementById('bookmarkIcon');
                
                if (data.bookmarked) {
                    bookmarkBtn.classList.add('bookmarked');
                    bookmarkIcon.className = 'bi bi-bookmark-fill';
                } else {
                    bookmarkBtn.classList.remove('bookmarked');
                    bookmarkIcon.className = 'bi bi-bookmark';
                }
                
                // 간단한 알림
                showToast(data.message);
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            console.error('북마크 토글 오류:', error);
            alert('북마크 처리 중 오류가 발생했습니다.');
        });
    }
    
    // 토스트 메시지 표시 (선택적)
    function showToast(message) {
        const toast = document.createElement('div');
        toast.textContent = message;
        toast.style.cssText = `
            position: fixed;
            bottom: 100px;
            right: 30px;
            background-color: rgba(0, 0, 0, 0.8);
            color: white;
            padding: 12px 20px;
            border-radius: 5px;
            z-index: 9999;
            animation: fadeInOut 2s ease-in-out;
        `;
        
        document.body.appendChild(toast);
        
        setTimeout(() => {
            toast.remove();
        }, 2000);
    }
    
    // 토스트 애니메이션
    const style = document.createElement('style');
    style.textContent = `
        @keyframes fadeInOut {
            0% { opacity: 0; transform: translateY(10px); }
            15% { opacity: 1; transform: translateY(0); }
            85% { opacity: 1; transform: translateY(0); }
            100% { opacity: 0; transform: translateY(-10px); }
        }
    `;
    document.head.appendChild(style);
</script>

</body>
</html>