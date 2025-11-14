<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>내 북마크 - 요리조리</title>
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
        }
        a {
            text-decoration: none;
            color: inherit;
        }


        .page-title {
            text-align: center;
            font-size: 2.5rem;
            color: #ff6f61;
            margin: 50px 0 30px 0;
            font-weight: 700;
        }

        .bookmark-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .grid-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 50px;
        }

        .card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            cursor: pointer;
        }

        .card-content {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .card-title {
            font-weight: 700;
            font-size: 1.2rem;
            margin-bottom: 12px;
            color: #ff6f61;
            cursor: pointer;
        }

        .card-title:hover {
            text-decoration: underline;
        }

        .card-info {
            font-size: 0.9rem;
            color: #555;
            margin-bottom: 6px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .card-info i {
            color: #ff6f61;
            font-size: 1rem;
        }

        .card-info strong {
            color: #333;
        }

        .bookmark-date {
            font-size: 0.85rem;
            color: #999;
            margin-top: auto;
            padding-top: 12px;
            border-top: 1px solid #eee;
        }

        .remove-bookmark-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: rgba(255, 255, 255, 0.9);
            border: none;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
        }

        .remove-bookmark-btn:hover {
            background-color: #ff6f61;
            color: white;
            transform: scale(1.1);
        }

        .remove-bookmark-btn i {
            font-size: 1.2rem;
            color: #ff6f61;
        }

        .remove-bookmark-btn:hover i {
            color: white;
        }

        .empty-message {
            text-align: center;
            padding: 100px 20px;
            color: #999;
        }

        .empty-message i {
            font-size: 5rem;
            color: #ddd;
            margin-bottom: 20px;
        }

        .empty-message h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        .empty-message a {
            color: #ff6f61;
            text-decoration: underline;
        }
 

        @media (max-width: 768px) {
            header { padding: 10px 30px; }
            .page-title { font-size: 2rem; }
            .grid-container {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            }
        }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>



<h1 class="page-title"><i class="bi bi-bookmark-fill"></i> 내 북마크</h1>

<div class="bookmark-container">
    <c:choose>
        <c:when test="${empty bookmarkList}">
            <div class="empty-message">
                <i class="bi bi-bookmark"></i>
                <h3>북마크한 레시피가 없습니다</h3>
                <p>마음에 드는 레시피를 북마크해보세요!</p>
                <p><a href="select_result">레시피 둘러보기 →</a></p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="grid-container">
                <c:forEach var="bookmark" items="${bookmarkList}">
                    <div class="card" id="card-${bookmark.recipeId}">
                        <button class="remove-bookmark-btn" onclick="removeBookmark(${bookmark.recipeId})" title="북마크 해제">
                            <i class="bi bi-bookmark-fill"></i>
                        </button>
                        
                        <img src="${bookmark.mainImage}" alt="${bookmark.title}" 
                             onclick="location.href='detail.do?recipe_Id=${bookmark.recipeId}'">
                        
                        <div class="card-content">
                            <div class="card-title" onclick="location.href='detail.do?recipe_Id=${bookmark.recipeId}'">
                                ${bookmark.title}
                            </div>
                            
                            <div class="card-info">
                                <i class="bi bi-star-fill"></i>
                                <span>평점: <strong><fmt:formatNumber value="${bookmark.average_rating}" pattern="0.0"/></strong></span>
                            </div>
                            
                            <div class="card-info">
                                <i class="bi bi-eye-fill"></i>
                                <span>조회수: <strong>${bookmark.hit}</strong></span>
                            </div>
                            
                            <div class="card-info">
                                <i class="bi bi-alarm-fill"></i>
                                <span>조리시간: <strong>${bookmark.cookingTime}</strong></span>
                            </div>
                            
                            <div class="card-info">
                                <i class="bi bi-speedometer2"></i>
                                <span>난이도: 
                                    <strong>
                                        <c:choose>
                                            <c:when test="${bookmark.difficulty == 1}">쉬움</c:when>
                                            <c:when test="${bookmark.difficulty == 2}">보통</c:when>
                                            <c:when test="${bookmark.difficulty == 3}">어려움</c:when>
                                            <c:otherwise>${bookmark.difficulty}</c:otherwise>
                                        </c:choose>
                                    </strong>
                                </span>
                            </div>
                            
                            <div class="card-info">
                                <i class="bi bi-person-badge-fill"></i>
                                <span>분량: <strong>${bookmark.servingSize}인분</strong></span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    // 북마크 제거
    function removeBookmark(recipeId) {
        if (!confirm('이 레시피를 북마크에서 제거하시겠습니까?')) {
            return;
        }
        
        fetch('${pageContext.request.contextPath}/bookmark/toggle', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'recipeId=' + recipeId
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // 카드 제거 애니메이션
                const card = document.getElementById('card-' + recipeId);
                card.style.transition = 'all 0.3s ease';
                card.style.opacity = '0';
                card.style.transform = 'scale(0.8)';
                
                setTimeout(() => {
                    card.remove();
                    
                    // 모든 카드가 제거되면 빈 메시지 표시
                    const remaining = document.querySelectorAll('.card').length;
                    if (remaining === 0) {
                        location.reload();
                    }
                }, 300);
                
                showToast(data.message);
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('북마크 제거 중 오류가 발생했습니다.');
        });
    }
    
    // 토스트 메시지
    function showToast(message) {
        const toast = document.createElement('div');
        toast.textContent = message;
        toast.style.cssText = `
            position: fixed;
            bottom: 30px;
            right: 30px;
            background-color: rgba(0, 0, 0, 0.8);
            color: white;
            padding: 15px 25px;
            border-radius: 8px;
            z-index: 9999;
            animation: fadeInOut 2.5s ease-in-out;
        `;
        
        document.body.appendChild(toast);
        
        setTimeout(() => {
            toast.remove();
        }, 2500);
    }
    
    // 애니메이션
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
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>