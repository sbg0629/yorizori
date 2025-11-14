<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${memberInfo.nickname}님의 프로필 - 요리조리</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
    <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background: #f8f9fa;
            color: #333;
            line-height: 1.6;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        /* Main Container */
        .profile-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 50px 30px;
            display: grid;
            grid-template-columns: 350px 1fr;
            gap: 40px;
        }

        /* 왼쪽 - 회원 정보 */
        .member-info-card {
            background: white;
            border-radius: 20px;
            padding: 40px 30px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
            height: fit-content;
            position: sticky;
            top: 30px;
        }

        .profile-image-wrapper {
            text-align: center;
            margin-bottom: 25px;
        }

        .profile-image {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #f0f0f0;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .member-nickname {
            font-size: 1.8rem;
            font-weight: 700;
            color: #2c3e50;
            text-align: center;
            margin-bottom: 10px;
        }

        .member-id {
            text-align: center;
            color: #7f8c8d;
            font-size: 0.95rem;
            margin-bottom: 25px;
        }

        .info-divider {
            height: 1px;
            background: #e0e0e0;
            margin: 25px 0;
        }

        .info-item {
            display: flex;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #f5f5f5;
        }

        .info-item:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: 600;
            color: #555;
            min-width: 80px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-label i {
            font-size: 1.1rem;
            color: #ff6b6b;
        }

        .info-value {
            color: #666;
        }

        .stats-container {
            display: grid;
            grid-template-columns: 1fr;
            gap: 15px;
            margin-top: 25px;
        }

        .stat-box {
            background: linear-gradient(135deg, #ff6b6b 0%, #898b0cdc 100%);
            padding: 20px;
            border-radius: 12px;
            text-align: center;
            color: white;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        /* 오른쪽 - 레시피 목록 */
        .recipe-section {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }

        .section-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: #2c3e50;
        }

        .recipe-count {
            background: #ff6b6b;
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .recipe-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
        }

        .recipe-card {
            background: white;
            border: 1px solid #e0e0e0;
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .recipe-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            border-color: #ff6b6b;
        }

        .recipe-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            transition: transform 0.5s;
        }

        .recipe-card:hover .recipe-image {
            transform: scale(1.05);
        }

        .recipe-content {
            padding: 20px;
        }

        .recipe-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .recipe-desc {
            font-size: 0.9rem;
            color: #7f8c8d;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            margin-bottom: 12px;
        }

        .recipe-meta {
            display: flex;
            gap: 15px;
            font-size: 0.85rem;
            color: #999;
        }

        .recipe-meta i {
            margin-right: 4px;
        }

        .no-recipes {
            text-align: center;
            padding: 80px 20px;
            color: #999;
        }

        .no-recipes i {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 20px;
        }

        .no-recipes p {
            font-size: 1.1rem;
            margin-top: 15px;
        }

        /* 반응형 */
        @media (max-width: 1024px) {
            .profile-container {
                grid-template-columns: 1fr;
                gap: 30px;
            }

            .member-info-card {
                position: static;
            }
        }

        @media (max-width: 768px) {
            .profile-container {
                padding: 30px 20px;
            }

            .recipe-section {
                padding: 30px 20px;
            }

            .recipe-grid {
                grid-template-columns: 1fr;
            }

            .member-nickname {
                font-size: 1.5rem;
            }

            .section-title {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="profile-container">
        <!-- 왼쪽: 회원 정보 -->
        <aside class="member-info-card">
            <div class="profile-image-wrapper">
                <c:choose>
                    <c:when test="${not empty memberInfo.profileImage}">
                        <img src="${memberInfo.profileImage}" alt="${memberInfo.nickname}" class="profile-image">
                    </c:when>
                    <c:otherwise>
                        <img src="https://via.placeholder.com/150/667eea/ffffff?text=${memberInfo.nickname}" 
                             alt="${memberInfo.nickname}" class="profile-image">
                    </c:otherwise>
                </c:choose>
            </div>

            <h1 class="member-nickname">${memberInfo.nickname}</h1>
            <p class="member-id">@${memberInfo.memberId}</p>

            <div class="info-divider"></div>

            <div class="info-item">
                <span class="info-label">
                    <i class="bi bi-person-fill"></i>
                    이름
                </span>
                <span class="info-value">${memberInfo.name}</span>
            </div>

            <div class="info-item">
                <span class="info-label">
                    <i class="bi bi-envelope-fill"></i>
                    이메일
                </span>
                <span class="info-value">${memberInfo.email}</span>
            </div>

            <div class="info-item">
                <span class="info-label">
                    <i class="bi bi-calendar-fill"></i>
                    가입일
                </span>
                <span class="info-value">
                    <c:choose>
                        <c:when test="${not empty memberInfo.joinDate}">
                            ${memberInfo.joinDate}
                        </c:when>
                        <c:otherwise>
                            정보 없음
                        </c:otherwise>
                    </c:choose>
                </span>
            </div>

            <div class="stats-container">
                <div class="stat-box">
                    <div class="stat-number">${recipeCount}</div>
                    <div class="stat-label">작성한 레시피</div>
                </div>
            </div>
        </aside>

        <!-- 오른쪽: 레시피 목록 -->
        <section class="recipe-section">
            <div class="section-header">
                <h2 class="section-title">${memberInfo.nickname}님의 레시피</h2>
                <span class="recipe-count">총 ${recipeCount}개</span>
            </div>

            <div class="recipe-grid">
                <c:choose>
                    <c:when test="${not empty recipes}">
                        <c:forEach var="recipe" items="${recipes}">
                            <a href="detail.do?recipe_Id=${recipe.recipeId}" class="recipe-card">
                                <img src="${recipe.mainImage}" alt="${recipe.title}" class="recipe-image">
                                <div class="recipe-content">
                                    <h3 class="recipe-title">${recipe.title}</h3>
                                    <p class="recipe-desc">${recipe.description}</p>
                                    <div class="recipe-meta">
                                        <span><i class="bi bi-eye-fill"></i> ${recipe.hit}</span>
                                        <span><i class="bi bi-star-fill"></i> ${recipe.rating}</span>
                                    </div>
                                </div>
                            </a>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="no-recipes">
                            <i class="bi bi-journal-x"></i>
                            <p>아직 작성한 레시피가 없습니다.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>