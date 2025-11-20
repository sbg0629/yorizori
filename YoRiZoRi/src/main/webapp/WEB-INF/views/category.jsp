<!--<%@ page language="java" contentType="text/html; charset=UTF-8"-->
<!--    pageEncoding="UTF-8"%>-->
<!--    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>-->
<!--<!DOCTYPE html>-->
<!--<html lang="ko">-->
<!--<head>-->
<!--<meta charset="UTF-8" />-->
<!--<meta name="viewport" content="width=device-width, initial-scale=1.0" />-->
<!--<title>요리조리 | 레시피 분류</title>-->
<!--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">-->
<!--	    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />-->
<!--		<link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css">-->
<!--		<link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css">-->
<!--		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">-->
<!--		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">-->
<!--		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">-->
<!--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>-->
<!--<style>-->
<!--  /* ====== 공통 스타일 ====== */-->
<!--  body {-->
<!--    font-family: "Noto Sans KR", sans-serif;-->
<!--    margin: 0;-->
<!--    padding: 0;-->
<!--    background-color: #fffaf7;-->
<!--    color: #333;-->
<!--  }-->
<!--  a { text-decoration: none; color: inherit; }-->


<!--  /* ====== 레시피 폼 영역 (디자인 개선) ====== */-->
<!--  .container {-->
<!--    display: flex; justify-content: center; align-items: center; min-height: calc(100vh - 150px);-->
<!--  }-->
<!--  .form-box {-->
<!--    background-color: #ffffff; border-radius: 16px;-->
<!--    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);-->
<!--    padding: 40px 50px; width: 100%; max-width: 550px; /* 너비 확장 */-->
<!--    transition: transform 0.3s ease;-->
<!--  }-->
<!--  .form-box:hover { transform: translateY(-5px); }-->
<!--  .form-box h2 {-->
<!--    font-size: 2rem; font-weight: 800; margin-bottom: 35px;-->
<!--    color: #ff6f61; text-align: center;-->
<!--  }-->

<!--  .form-group {-->
<!--    display: flex;-->
<!--    align-items: flex-start; /* 상단 정렬 */-->
<!--    margin-bottom: 30px;-->
<!--  }-->
<!--  .group-label {-->
<!--    font-weight: 700;-->
<!--    width: 100px;-->
<!--    color: #444;-->
<!--    flex-shrink: 0;-->
<!--    padding-top: 5px; /* 체크박스와 높이 맞춤 */-->
<!--    font-size: 1.1rem;-->
<!--  }-->
<!--  .category-options {-->
<!--    display: grid;-->
<!--    grid-template-columns: repeat(3, 1fr); /* 3열 그리드 */-->
<!--    gap: 15px 20px; /* 행, 열 간격 */-->
<!--    width: 100%;-->
<!--  }-->
<!--  .sort-options {-->
<!--    display: flex;-->
<!--    gap: 20px;-->
<!--    align-items: center;-->
<!--    padding-top: 5px;-->
<!--  }-->
<!--  .category-options label, .sort-options label {-->
<!--    margin: 0;-->
<!--    font-size: 1rem;-->
<!--    cursor: pointer;-->
<!--    display: flex;-->
<!--    align-items: center;-->
<!--    transition: color 0.2s;-->
<!--  }-->
<!--   .category-options label:hover, .sort-options label:hover {-->
<!--     color: #ff6f61;-->
<!--   }-->

<!--  input[type="checkbox"], input[type="radio"] {-->
<!--    margin-right: 8px;-->
<!--    accent-color: #ff6f61;-->
<!--    transform: scale(1.2);-->
<!--    cursor: pointer;-->
<!--  }-->
<!--  .btn-area {-->
<!--    text-align: center;-->
<!--    margin-top: 30px;-->
<!--    border-top: 1px solid #eee;-->
<!--    padding-top: 30px;-->
<!--  }-->
<!--  input[type="submit"], input[type="reset"] {-->
<!--    background-color: #ff6f61; border: none; color: white;-->
<!--    font-weight: 700; font-size: 1.1rem; padding: 12px 35px;-->
<!--    border-radius: 8px; cursor: pointer; transition: 0.25s ease;-->
<!--    margin: 0 10px;-->
<!--  }-->
<!--  input[type="submit"]:hover, input[type="reset"]:hover {-->
<!--    background-color: #e85c4c;-->
<!--    transform: translateY(-2px);-->
<!--  }-->
<!--   input[type="reset"] {-->
<!--     background-color: #e0e0e0;-->
<!--     color: #333;-->
<!--   }-->
<!--   input[type="reset"]:hover {-->
<!--     background-color: #bdbdbd;-->
<!--   }-->

  
<!--</style>-->
<!--</head>-->
<!--<body>-->

<!--	<jsp:include page="/WEB-INF/views/common/header.jsp"/>-->

<!--<div class="container">-->
<!--  <div class="form-box">-->
<!--    <h2>레시피 상세 검색</h2>-->
<!--    <form method="post" action="select_result" id="categoryForm">-->
      
<!--       카테고리 선택 (Grid 레이아웃으로 변경) -->
<!--      <div class="form-group">-->
<!--        <label class="group-label">카테고리</label>-->
<!--        <div class="category-options">-->
<!--          <label><input type="checkbox" name="category" value="1" />한식</label>-->
<!--          <label><input type="checkbox" name="category" value="2" />일식</label>-->
<!--          <label><input type="checkbox" name="category" value="3" />중식</label>-->
<!--          <label><input type="checkbox" name="category" value="4" />양식</label>-->
<!--          <label><input type="checkbox" name="category" value="5" />디저트</label>-->
<!--          <label><input type="checkbox" name="category" value="6" />분식</label>  예시 항목 추가 -->
<!--        </div>-->
<!--      </div>-->
      
<!--       정렬 방법 -->
<!--      <div class="form-group">-->
<!--        <label class="group-label">정렬 방법</label>-->
<!--        <div class="sort-options">-->
<!--          <label><input type="radio" name="order" value="hit" checked />인기순</label>-->
<!--          <label><input type="radio" name="order" value="rating" />평점순</label>-->
<!--          <label><input type="radio" name="order" value="latest" />최신순</label>-->
<!--        </div>-->
<!--      </div>-->
      
<!--      <div class="btn-area">-->
<!--        <input type="submit" value="레시피 찾기" />-->
<!--        <input type="reset" value="초기화" />-->
<!--      </div>-->

<!--    </form>-->
<!--  </div>-->
<!--</div>-->
<!--<jsp:include page="/WEB-INF/views/common/footer.jsp"/>-->


<!--</body>-->
<!--</html>-->
