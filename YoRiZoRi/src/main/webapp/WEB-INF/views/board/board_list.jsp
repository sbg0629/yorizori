<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자유게시판</title>
	<link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css">

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">

    <link href="${pageContext.request.contextPath}/css/board.css" rel="stylesheet" type="text/css">

</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    
    <div class="board-container">
        <div class="board-header">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h1>자유게시판</h1>
                <c:if test="${not empty sessionScope.id}">
                    <a href="${pageContext.request.contextPath}/board/write" class="btn btn-primary btn-md btn-board-write">
                        <i class="fa fa-pencil" style="margin-right: 8px;"></i> 글쓰기
                    </a>
                </c:if>
            </div>
            <div class="search-box">
                <form id="boardSearchForm" action="${pageContext.request.contextPath}/board" method="get" class="d-flex justify-content-end">
                    <input type="text" name="keyword" class="form-control me-2" 
                           placeholder="검색어를 입력하세요" value="${param.keyword}" style="max-width: 300px;">
                    <input type="hidden" name="page" id="boardPageInput" value="${pageDTO != null ? pageDTO.currentPage : 1}">
                    <button type="submit" class="btn btn-secondary">검색</button>
                </form>
            </div>
        </div>

        <c:choose>
        
            <c:when test="${not empty boards}">
                <c:forEach var="board" items="${boards}">
                    <c:url var="detailUrl" value="/board/detail">
                        <c:param name="boardId" value="${board.boardId}" />
                        <c:if test="${pageDTO != null}">
                            <c:param name="page" value="${pageDTO.currentPage}" />
                        </c:if>
                        <c:if test="${not empty param.keyword}">
                            <c:param name="keyword" value="${param.keyword}" />
                        </c:if>
                    </c:url>
                    <div class="board-item" onclick="location.href='${detailUrl}'">
                        
                        <div class="board-title-area">
                            <div class="board-title">${board.title}</div>
                        </div>

                        <div class="board-meta-info">
                            <span class="text-muted">작성자: ${board.nickname}</span>
                            <span class="text-muted">${board.createdAt} | 조회수: ${board.viewCount}</span>
                        </div>
               
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="alert alert-info">
                    게시글이 없습니다.
                </div>
            </c:otherwise>
        </c:choose>
        
        <c:if test="${not empty pageDTO && pageDTO.totalPage > 0}">
            <nav class="mt-4">
                <ul class="pagination justify-content-center">
                    <li class="page-item ${pageDTO.hasPrev ? '' : 'disabled'}">
                        <a class="page-link" href="javascript:void(0);" onclick="changeBoardPage(${pageDTO.prevPage});">이전</a>
                    </li>
                    <c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}">
                        <li class="page-item ${i == pageDTO.currentPage ? 'active' : ''}">
                            <a class="page-link" href="javascript:void(0);" onclick="changeBoardPage(${i});">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${pageDTO.hasNext ? '' : 'disabled'}">
                        <a class="page-link" href="javascript:void(0);" onclick="changeBoardPage(${pageDTO.nextPage});">다음</a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>
	
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        var boardSearchForm = document.getElementById('boardSearchForm');
        var boardPageInput = document.getElementById('boardPageInput');
        
        function changeBoardPage(page) {
            if (!boardPageInput || !boardSearchForm) {
                return;
            }
            boardPageInput.value = page;
            boardSearchForm.dataset.pageChange = 'true';
            boardSearchForm.submit();
        }
        
        if (boardSearchForm) {
            boardSearchForm.addEventListener('submit', function() {
                if (boardSearchForm.dataset.pageChange === 'true') {
                    boardSearchForm.dataset.pageChange = '';
                    return;
                }
                if (boardPageInput) {
                    boardPageInput.value = 1;
                }
            });
        }
    </script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>