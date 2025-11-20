<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	/* [추가] 검색 입력창 스타일 */
    .search-input {
        width: 100%;
        max-width: 400px; /* 너무 길어지지 않게 제한 */
        padding: 10px 15px;
        border: 1px solid #ddd;
        border-radius: 8px;
        font-size: 1rem;
        transition: border-color 0.3s;
    }
    .search-input:focus {
        border-color: #FF7043; /* 포커스 시 테마색 */
        outline: none;
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
        .pagination-container {
				    margin-top: 60px;
				    padding-top: 40px;
				    border-top: 2px solid #f0f0f0;
				    animation: fadeIn 0.5s ease-out;
				}

				.pagination {
				    display: flex;
				    justify-content: center;
				    align-items: center;
				    gap: 10px;
				    margin-bottom: 25px;
				    background: white;
				    padding: 15px 20px;
				    border-radius: 16px;
				    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
				}

				.page-btn, .page-number {
				    display: inline-flex;
				    align-items: center;
				    justify-content: center;
				    min-width: 42px;
				    height: 42px;
				    padding: 0 14px;
				    border-radius: 10px;
				    font-size: 0.95rem;
				    font-weight: 600;
				    text-decoration: none;
				    transition: all 0.3s ease;
				    cursor: pointer;
				    background: white;
				    border: 2px solid #e0e0e0;
				    color: #555;
				}

				.page-btn {
				    background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
				}

				.page-btn:hover {
				    background: linear-gradient(135deg, #ff6b6b 0%, #ee5a6f 100%);
				    border-color: #ff6b6b;
				    color: white;
				    transform: translateY(-2px);
				    box-shadow: 0 4px 12px rgba(255, 107, 107, 0.3);
				}

				.page-btn:disabled {
				    background: #f5f5f5;
				    border-color: #e0e0e0;
				    color: #ccc;
				    cursor: not-allowed;
				    opacity: 0.5;
				}

				.page-number {
				    font-size: 0.9rem;
				}

				.page-number:hover {
				    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
				    border-color: #ff6b6b;
				    color: #ff6b6b;
				    transform: translateY(-2px);
				}

				.page-number.active {
				    background: linear-gradient(135deg, #ff6b6b 0%, #ee5a6f 100%);
				    border-color: #ff6b6b;
				    color: white;
				    box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
				    cursor: default;
				    pointer-events: none;
				}

				.page-info {
				    text-align: center;
				    padding: 15px 20px;
				    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
				    border-radius: 12px;
				    font-size: 0.95rem;
				    color: #666;
				    font-weight: 600;
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
      />양식</label>
      
      <label><input type="checkbox" name="category" value="3" 
          <c:if test="${not empty selectedCategories && selectedCategories.contains('3')}">checked</c:if>
      />중식</label>
      
      <label><input type="checkbox" name="category" value="4" 
          <c:if test="${not empty selectedCategories && selectedCategories.contains('4')}">checked</c:if>
      />일식</label>
      
      <label><input type="checkbox" name="category" value="5" 
          <c:if test="${not empty selectedCategories && selectedCategories.contains('5')}">checked</c:if>
      />분식</label>
      
      <label><input type="checkbox" name="category" value="6" 
          <c:if test="${not empty selectedCategories && selectedCategories.contains('6')}">checked</c:if>
      />디저트</label>
      
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

    <div class="form-group">
        <label class="group-label">검색어</label>
        <div style="flex-grow: 1;"> <input type="text" name="keyword" class="search-input" 
                   placeholder="요리명 또는 재료를 입력하세요" 
                   value="${keyword}" /> 
        </div>
    </div>
    
    <input type="hidden" name="page" id="recipePageInput" value="${pageDTO != null ? pageDTO.currentPage : 1}" />
    
    <div class="btn-area">
        <input type="submit" value="레시피 찾기" />
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
            
             <img src="${pageContext.request.contextPath}/images/${dto.mainImage}" alt="${dto.title}">
 
            <div class="card-content">
                <div class="card-title">${dto.title}</div>
                
				<div class="card-info"><strong>별점:</strong> 
				                    <span>
				                       <c:choose>
				                           <c:when test="${not empty dto.rating && dto.rating > 0}">
				                               <fmt:formatNumber value="${dto.rating}" pattern="0.0" />
				                           </c:when>
				                           <c:otherwise>
				                               0.0
				                           </c:otherwise>
				                       </c:choose>
				                    </span>
				               </div>
                <div class="card-info"><strong>조회수:</strong> <span>${dto.hit}</span></div>
                <div class="card-info"><strong>조리 시간:</strong> <span>${dto.cookingTime}</span></div>
                
                <div class="card-info"><strong>요리 양:</strong> <span>${dto.servingSize}인분</span></div>
				<div class="card-info"><strong>난이도:</strong> 
				    <span>
				        <c:choose>
				            <c:when test="${dto.difficulty == 1}">하</c:when>
				            <c:when test="${dto.difficulty == 2}">중</c:when>
				            <c:when test="${dto.difficulty == 3}">상</c:when>
				            <c:otherwise>기타</c:otherwise>
				        </c:choose>
				    </span>
				</div>
            </div>
        </div>
    </c:forEach>
    
    <c:if test="${empty recipeList}">
        <p>
            해당 조건의 레시피가 없습니다.
        </p>
    </c:if>
</div>

<c:if test="${not empty pageDTO && pageDTO.totalCount > 0}">
            <div class="pagination-container">
                <div class="pagination">
                    <!-- 이전 페이지 -->
                    <c:choose>
                        <c:when test="${pageDTO.hasPrev}">
                            <a href="?page=${pageDTO.prevPage}<c:if test='${not empty category}'>&category=${category}</c:if><c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>" 
                               class="page-btn">
                                <i class="bi bi-chevron-left"></i>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <button class="page-btn" disabled>
                                <i class="bi bi-chevron-left"></i>
                            </button>
                        </c:otherwise>
                    </c:choose>
                    
                    <!-- 페이지 번호 -->
                    <c:forEach begin="${pageDTO.startPage}" end="${pageDTO.endPage}" var="pageNum">
                        <c:choose>
                            <c:when test="${pageNum == pageDTO.currentPage}">
                                <span class="page-number active">${pageNum}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="?page=${pageNum}<c:if test='${not empty category}'>&category=${category}</c:if><c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>" 
                                   class="page-number">${pageNum}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    
                    <!-- 다음 페이지 -->
                    <c:choose>
                        <c:when test="${pageDTO.hasNext}">
                            <a href="?page=${pageDTO.nextPage}<c:if test='${not empty category}'>&category=${category}</c:if><c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>" 
                               class="page-btn">
                                <i class="bi bi-chevron-right"></i>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <button class="page-btn" disabled>
                                <i class="bi bi-chevron-right"></i>
                            </button>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- 페이지 정보 -->
                <div class="page-info">
                    <span>총 ${pageDTO.totalCount}개 | ${pageDTO.currentPage} / ${pageDTO.totalPage} 페이지</span>
                </div>
            </div>
        </c:if>
    </div>

<jsp:include page="/WEB-INF/views/gemini_chat.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

<script>
	// ===================================================
	    // 1. AJAX로 레시피 목록을 가져오는 핵심 함수 ($.ajax 버전)
	    // ===================================================
		function fetchRecipes(page) {
		        console.log("----- fetchRecipes 시작 (page: " + page + ") -----");
		        
		        const form = document.getElementById('categoryForm');
		        const pageInput = document.getElementById('recipePageInput');
		        
		        if (!form || !pageInput) return;
		        
		        // 1. 페이지 설정
		        pageInput.value = page;

		        // 2. 정렬 값 가져오기
		        const checkedRadio = document.querySelector('input[name="order"]:checked');
		        let orderValue = checkedRadio ? checkedRadio.value : 'hit';

		        // 3. 카테고리 값들 가져오기
		        const categories = [];
		        document.querySelectorAll('input[name="category"]:checked').forEach(function(box) {
		            categories.push(box.value);
		        });

		        // 4. [추가] 검색어 값 가져오기
		        const keywordInput = document.querySelector('input[name="keyword"]');
		        const keywordValue = keywordInput ? keywordInput.value : '';

		        // 5. URL 파라미터 생성
		        const params = new URLSearchParams();
		        params.append('order', orderValue);
		        params.append('page', pageInput.value); // pageValue 대신 직접 참조
		        if(keywordValue) {
		             params.append('keyword', keywordValue); // 검색어가 있을 때만 추가
		        }
		        categories.forEach(function(cat) {
		            params.append('category', cat);
		        });
		        
		        const url = `select_result?${params.toString()}`;
		        console.log("최종 Fetching URL:", url);

		        // 6. AJAX 요청
		        $.ajax({
		            type: "GET",
		            url: url,
		            success: function(htmlText) {
		                const parser = new DOMParser();
		                const doc = parser.parseFromString(htmlText, 'text/html');
		                
		                const newGrid = doc.querySelector('.grid-container');
		                const newPagination = doc.querySelector('.pagination-container'); // 클래스로 찾는 것이 더 안전할 수 있음

		                const currentGrid = document.querySelector('.grid-container');
		                const currentPagination = document.querySelector('.pagination-container');

		                if (newGrid && currentGrid) {
		                    currentGrid.innerHTML = newGrid.innerHTML;
		                }
		                
		                // 페이징 영역 교체 (상위 div 자체를 교체하거나 내용만 교체)
		                if (currentPagination && newPagination) {
		                     currentPagination.innerHTML = newPagination.innerHTML;
		                } else if (currentPagination && !newPagination) {
		                     currentPagination.innerHTML = ""; // 결과가 없으면 페이징 삭제
		                }
		            },
		            error: function(xhr, status, error) {
		                console.error('Error:', error);
		                alert('레시피를 불러오는 중 오류가 발생했습니다.');
		            }
		        });
		    }

	    // ===================================================
	    // 2. 기존 이벤트 리스너 (변경 없음)
	    // ===================================================

	    // 페이지 번호 클릭 시
	    function changeRecipePage(page) {
	        fetchRecipes(page); // (이름은 fetchRecipes지만, 실제론 $.ajax가 실행됨)
	    }
	    
	
	    		// DOM(HTML)이 모두 로드된 후 스크립트를 실행합니다.
	document.addEventListener('DOMContentLoaded', function() {
	        
	        const resetButton = document.getElementById('btnResetFilters');
	        const form = document.getElementById('categoryForm');
	        
	        if (resetButton) {
	            resetButton.addEventListener('click', function() {
	                
	                // 1. 카테고리 체크박스 해제
	                document.querySelectorAll('input[name="category"]').forEach(box => box.checked = false);

	                // 2. 정렬 라디오 버튼 초기화 (인기순)
	                const radios = document.querySelectorAll('input[name="order"]');
	                if (radios.length > 0) radios[0].checked = true; 
	                
	                // 3. [추가] 검색어 입력창 비우기
	                const keywordInput = document.querySelector('input[name="keyword"]');
	                if (keywordInput) keywordInput.value = "";

	                // 4. 페이지 번호 초기화
	                const pageInput = document.getElementById('recipePageInput');
	                if (pageInput) pageInput.value = 1;

	                // 5. 폼 제출 (새로고침 방식)
	                form.submit(); 
	            });
	        }
	    });
</script>

</body>
</html>