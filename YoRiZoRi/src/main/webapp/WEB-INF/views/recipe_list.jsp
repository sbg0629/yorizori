<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>레시피 목록 | 요리조리</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
	<link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">


<style>
    /* ======================================= */
    /* 1. 공통 스타일 */
    /* ======================================= */
    body {
        font-family: "Noto Sans KR", sans-serif;
        margin: 0; padding: 0;
        /* 배경색을 따뜻한 살구색으로 통일 */
        background-color: #FFF5EE; 
        color: #333;
    }
    a { text-decoration: none; color: inherit; }


    /* ======================================= */
    /* 2. 레시피 상세 검색 (필터) 영역 */
    /* ======================================= */
    .filter-container { 
        display: flex;
        justify-content: center; align-items: center;
        padding: 50px 20px 30px 20px; 
    }
    .form-box {
        background-color: #ffffff;
        border-radius: 16px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15); 
        padding: 35px 45px;
        width: 100%; max-width: 950px; /* 너비 확장 */
    }
    .form-box h2 {
        font-size: 2rem; 
        font-weight: 700; 
        margin-top: 0; margin-bottom: 30px;
        color: #FF7043; /* 테마색 오렌지 */
        text-align: center;
        border-bottom: 2px solid #FF704333; 
        padding-bottom: 15px;
    }
    .form-group {
        display: flex; align-items: flex-start; margin-bottom: 25px; 
    }
    .group-label {
        font-weight: 700; width: 120px; 
        color: #444;
        flex-shrink: 0; padding-top: 8px; font-size: 1.15rem; 
    }
    .category-options {
        /* 항목당 최소 너비 증가 */
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(130px, 1fr)); 
        gap: 15px 30px; 
        width: 100%;
    }
    .sort-options {
        display: flex; gap: 30px; align-items: center;
        padding-top: 8px;
    }
    .category-options label, .sort-options label {
        margin: 0;
        font-size: 1.05rem; 
        cursor: pointer;
        display: flex; align-items: center; transition: color 0.2s;
    }
    .category-options label:hover, .sort-options label:hover { 
        color: #FF7043; /* 호버 시 테마색 오렌지 */
    }
    input[type="checkbox"], input[type="radio"] {
        margin-right: 8px; 
        /* 체크박스/라디오 버튼 색상을 신선한 녹색으로 변경 */
        accent-color: #4CAF50; 
        transform: scale(1.3);
        cursor: pointer;
    }

    /* 버튼 영역 */
    .btn-area {
        text-align: center; margin-top: 30px;
        border-top: 1px solid #eee; padding-top: 25px;
    }
    /* 레시피 찾기 버튼 (Primary: 오렌지) */
    input[type="submit"] {
        background-color: #FF7043; 
        border: none; color: white;
        font-weight: 700; font-size: 1.15rem; padding: 12px 40px;
        border-radius: 8px; cursor: pointer; transition: 0.25s ease;
        margin: 0 10px;
    }
    input[type="submit"]:hover {
        background-color: #E64A19;
        transform: translateY(-2px);
    }
    /* 초기화 버튼 (Secondary: 녹색) */
    input[type="reset"] { 
        background-color: #4CAF50; 
        color: white; 
        border: none; 
        font-weight: 700; font-size: 1.15rem; padding: 12px 40px;
        border-radius: 8px; cursor: pointer; transition: 0.25s ease;
        margin: 0 10px;
    }
    input[type="reset"]:hover { 
        background-color: #388E3C;
        transform: translateY(-2px);
    }


    /* ======================================= */
    /* 3. 레시피 카드 그리드 영역 */
    /* ======================================= */
    .grid-container {
        display: grid;
        /* 4열 반응형 그리드로 변경 */
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); 
        grid-auto-rows: auto;
        gap: 30px; 
        max-width: 1400px; /* 최대 너비 확장 */
        margin: 40px auto 60px auto; 
        padding: 0 30px;
    }
    .card {
        background: #fff; border-radius: 12px;
        box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        overflow: hidden; display: flex; flex-direction: column;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        cursor: pointer;
    }
    .card:hover {
        transform: translateY(-5px); 
        box-shadow: 0 15px 30px rgba(0,0,0,0.2);
    }
    .card img {
        width: 100%; height: 220px; 
        object-fit: cover;
    }
    .card-content {
        padding: 16px 20px; flex-grow: 1;
        display: flex; flex-direction: column;
        /* 정보를 구분하는 테두리 추가 */
        border-top: 3px solid #FF7043; 
    }
    .card-title {
        font-weight: 800; font-size: 1.25rem; 
        margin-bottom: 10px; color: #444; 
        border-bottom: 1px dashed #eee; 
        padding-bottom: 8px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    .card-info {
        font-size: 0.95rem; 
        color: #777; margin-bottom: 5px;
        display: flex; justify-content: space-between;
    }
    .card-info strong { 
        color: #333; font-weight: 600;
    }
    .card-info span {
        color: #FF7043; /* 값에 오렌지색 강조 */
        font-weight: 600;
    }
    /* 레시피가 없을 때 메시지 스타일 */
    .grid-container p {
        color: #A1887F !important; 
        font-weight: 500;
        grid-column: 1 / -1; 
        font-size: 1.2rem;
    }

    /* ======================================= */
    /* 4. 미디어 쿼리 (반응형) */
    /* ======================================= */
    @media (max-width: 992px) {
        .grid-container {
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
        }
    }
    @media (max-width: 768px) {
        .form-box {
            padding: 25px;
        }
        .form-group {
            flex-direction: column;
            align-items: flex-start;
        }
        .group-label {
            width: 100%; /* 모바일에서 라벨 전체 너비 사용 */
            margin-bottom: 10px;
        }
        .category-options {
            grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
        }
        .sort-options {
            gap: 15px;
        }
    }
	
	/* [추가] type="reset" 대신 id="btnResetFilters"에 스타일 적용 */
	    #btnResetFilters {
	        background-color: #e0e0e0; color: #333;
	        font-weight: 700; font-size: 1.1rem; padding: 12px 35px;
	        border-radius: 8px; cursor: pointer; transition: 0.25s ease;
	        margin: 0 10px; border: none;
	        /* (input 태그는 font-family 상속이 안될 수 있으니 명시) */
	        font-family: "Noto Sans KR", sans-serif; 
	    }
	    #btnResetFilters:hover {
	        background-color: #bdbdbd;
	        transform: translateY(-2px);
	    }
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp"/>


<div class="filter-container">
  <div class="form-box">
    <h2>레시피 상세 검색</h2>
    
<form method="get" action="select_result" id="categoryForm">
  
  <div class="form-group">
    <label class="group-label">카테고리</label>
    <div class="category-options">
      
      <label><input type="checkbox" name="category" value="1" 
          <c:if test="${not empty selectedCategories && selectedCategories.contains('1')}">checked</c:if>
      />한식</label>
      
      <label><input type="checkbox" name="category" value="2" 
          <c:if test="${not empty selectedCategories && selectedCategories.contains('2')}">checked</c:if>
      />일식</label>
      
      <label><input type="checkbox" name="category" value="3" 
          <c:if test="${not empty selectedCategories && selectedCategories.contains('3')}">checked</c:if>
      />중식</label>
      
      <label><input type="checkbox" name="category" value="4" 
          <c:if test="${not empty selectedCategories && selectedCategories.contains('4')}">checked</c:if>
      />양식</label>
      
      <label><input type="checkbox" name="category" value="5" 
          <c:if test="${not empty selectedCategories && selectedCategories.contains('5')}">checked</c:if>
      />디저트</label>
      
      <label><input type="checkbox" name="category" value="6" 
          <c:if test="${not empty selectedCategories && selectedCategories.contains('6')}">checked</c:if>
      />분식</label>
      
    </div>
  </div>
  
  <div class="form-group">
    <label class="group-label">정렬 방법</label>
    <div class="sort-options">
      
      <label><input type="radio" name="order" 
        value="hit" 
          <c:if test="${selectedOrder == 'hit'}">checked</c:if> 
      />인기순</label>
      
      <label><input type="radio" name="order" value="rating" 
          <c:if test="${selectedOrder == 'rating'}">checked</c:if> 
      />평점순</label>
      
      <label><input type="radio" name="order" value="latest" 
          <c:if test="${selectedOrder == 'latest'}">checked</c:if> 
      />최신순</label>
      
    </div>
  </div>
  
  <input type="hidden" name="page" id="recipePageInput" value="${pageDTO != null ? pageDTO.currentPage : 1}" />
  <div class="btn-area">
      <input type="submit" value="레시피 찾기" />
      <%-- [수정] type="button"으로 변경하고 id="btnResetFilters" 추가 --%>
      <input type="button" id="btnResetFilters" value="초기화" />
  </div>


</form>
  </div>
</div>

<div class="grid-container">
    <c:forEach var="dto" items="${recipeList}">
        <div class="card" 
             onclick="location.href='detail.do?recipe_Id=${dto.recipeId}'"
             style="cursor: pointer;">
            
            <img src="${dto.mainImage}" alt="${dto.title}">
 
            <div class="card-content">
                <div class="card-title">${dto.title}</div>
                
                <div class="card-info"><strong>별점:</strong> <span>${dto.rating}</span></div>
                <div class="card-info"><strong>조회수:</strong> <span>${dto.hit}</span></div>
                <div class="card-info"><strong>조리 시간:</strong> <span>${dto.cookingTime}</span></div>
                
                <div class="card-info"><strong>요리 양:</strong> <span>${dto.servingSize}인분</span></div>
                <div class="card-info"><strong>난이도:</strong> <span>${dto.difficulty}</span></div>
            </div>
        </div>
    </c:forEach>
    
    <c:if test="${empty recipeList}">
        <p>
            해당 조건의 레시피가 없습니다.
        </p>
    </c:if>
</div>

<c:if test="${not empty pageDTO && pageDTO.totalPage > 0}">
    <div class="d-flex justify-content-center mb-5">
        <ul class="pagination">
            <li class="page-item ${pageDTO.hasPrev ? '' : 'disabled'}">
                <a class="page-link" href="javascript:void(0);" onclick="changeRecipePage(${pageDTO.prevPage});">이전</a>
            </li>
            <c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}">
                <li class="page-item ${i == pageDTO.currentPage ? 'active' : ''}">
                    <a class="page-link" href="javascript:void(0);" onclick="changeRecipePage(${i});">${i}</a>
                </li>
            </c:forEach>
            <li class="page-item ${pageDTO.hasNext ? '' : 'disabled'}">
                <a class="page-link" href="javascript:void(0);" onclick="changeRecipePage(${pageDTO.nextPage});">다음</a>
            </li>
        </ul>
    </div>
</c:if>

<jsp:include page="/WEB-INF/views/gemini_chat.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

<script>
    function changeRecipePage(page) {
        var pageInput = document.getElementById('recipePageInput');
        var form = document.getElementById('categoryForm');
        if (!pageInput || !form) {
            return;
        }
        pageInput.value = page;
        form.dataset.pageChange = 'true';
        form.submit();
    }
    
    var categoryForm = document.getElementById('categoryForm');
    if (categoryForm) {
        categoryForm.addEventListener('reset', function() {
            var pageInput = document.getElementById('recipePageInput');
            if (pageInput) {
                pageInput.value = 1;
            }
        });
        
        categoryForm.addEventListener('submit', function() {
            if (categoryForm.dataset.pageChange === 'true') {
                categoryForm.dataset.pageChange = '';
                return;
            }
            var pageInput = document.getElementById('recipePageInput');
            if (pageInput) {
                pageInput.value = 1;
            }
        });
    }
	
	
	    // DOM(HTML)이 모두 로드된 후 스크립트를 실행합니다.
	    document.addEventListener('DOMContentLoaded', function() {
	        
	        // 1. 새로 만든 '초기화' 버튼을 찾습니다.
	        const resetButton = document.getElementById('btnResetFilters');
	        
	        if (resetButton) {
	            // 2. 버튼에 클릭 이벤트를 추가합니다.
	            resetButton.addEventListener('click', function() {
	                
	                // 3. 모든 카테고리 체크박스를 찾습니다.
	                const checkboxes = document.querySelectorAll('input[name="category"]');
	                checkboxes.forEach(function(checkbox) {
	                    checkbox.checked = false; // 강제로 'checked'를 해제합니다.
	                });

	                // 4. 모든 정렬 라디오 버튼을 찾습니다.
	                const radios = document.querySelectorAll('input[name="order"]');
	                if (radios.length > 0) {
	                    // 5. 첫 번째 옵션('인기순')을 강제로 'checked'로 설정합니다.
	                    radios[0].checked = true; 
	                }
	            });
	        }

	    });
</script>

</body>
</html>