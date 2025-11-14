<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
	<link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css">

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
    <link href="${pageContext.request.contextPath}/css/notice.css" rel="stylesheet" type="text/css">
    
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    
    <div class="notice-container">
        <div class="notice-header">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h1>공지사항</h1>
          
                <c:choose>
                    <c:when test="${(sessionScope.admin != null && sessionScope.admin == 1) || (adminCheck != null && adminCheck == 1)}">
                        <a href="/notice/write" class="btn btn-primary btn-md">
                           <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16" style="margin-right: 8px; vertical-align: middle;">
                                <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                                <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
                            </svg>
                           공지사항 작성
                        </a>
                    </c:when>
                    <c:otherwise>
             
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="search-box mb-4">
                <form action="/notice" method="get" class="d-flex justify-content-end"> 
                    <input type="text" name="keyword" class="form-control me-2" 
                           placeholder="검색어를 입력하세요" value="${param.keyword}" style="max-width: 300px;">
                    <button type="submit" class="btn btn-secondary">검색</button>
                </form>
            </div>
        </div>

   
        <c:if test="${not empty fixedNotices}">
            <h3 class="mb-3" style="font-size: 1.3rem;">📌 고정 공지사항</h3>
            <c:forEach var="notice" items="${fixedNotices}">
                <div class="notice-item" onclick="location.href='/notice/detail?noticeId=${notice.noticeId}'" style="border-left: 5px solid #dc3545; background-color: #fff0f2;">
                    
                    <div class="title-content">
                        <span class="category-badge category-${notice.category}">${notice.category}</span>
                        <strong class="title_n">${notice.title}</strong>
                    </div>
                    
                    <div class="notice-info">
                        <span class="text-muted">${notice.createdAt}</span>
                        <span class="text-muted">조회수: ${notice.viewCount}</span>
                    </div>
                    
                </div>
            </c:forEach>
        </c:if>

        <h3 class="mb-3 mt-4" style="font-size: 1.3rem;">📋 일반 공지사항</h3>
        <c:choose>
            <c:when test="${not empty notices}">
                <c:forEach var="notice" items="${notices}">
  
                   <div class="notice-item" onclick="location.href='/notice/detail?noticeId=${notice.noticeId}'">
                        
                        <div class="title-content">
                            <span class="category-badge category-${notice.category}">${notice.category}</span>
                            <strong class="title_n">${notice.title}</strong>
                        </div>
                            
                        <div class="notice-info">
                            <span class="text-muted">${notice.createdAt}</span>
                            <span class="text-muted">조회수: ${notice.viewCount}</span>
                        </div>
          
                   </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="alert alert-info mt-3">
                    검색 결과 또는 등록된 일반 공지사항이 없습니다.
                </div>
            </c:otherwise>
        </c:choose>
        
        <div class="d-flex justify-content-center mt-5">
            </div>
    </div>
	
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>