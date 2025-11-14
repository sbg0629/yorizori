<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <%-- (1) 제목 변경 --%>
    <title>레시피 수정 - ${recipe.title}</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
		    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
			<link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css">
			<link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css">
			<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <%-- 스타일은 등록 페이지와 동일하게 사용 --%>
    <style>
        /* 등록 페이지와 동일한 스타일... (생략) */
        body { font-family: "Noto Sans KR", sans-serif; margin: 0; padding: 0; background-color: #fffaf7; color: #333; }
        a { text-decoration: none; color: inherit; }
        header { display: flex; align-items: center; justify-content: space-between; padding: 15px 60px; background-color: #fff; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); position: sticky; top: 0; z-index: 1000; }
        .header-left h1 { font-size: 1.5rem; color: #ff6f61; font-weight: 800; margin: 0; white-space: nowrap; }
        .header-center { display: flex; justify-content: center; align-items: center; flex-wrap: wrap; gap: 15px; flex: 1; }
        .header-center a { padding: 8px 14px; border-radius: 20px; font-size: 14px; background-color: #f3f3f3; transition: background-color 0.3s, color 0.3s; white-space: nowrap; }
        .header-center a:hover { background-color: #2e7d32; color: white; }
        .header-right { display: flex; align-items: center; gap: 18px; }
        .header-right i { font-size: 1.5rem; cursor: pointer; color: #333; transition: color 0.2s ease; }
        main { padding: 40px 20px; }
        .form-container { width: 90%; max-width: 800px; margin: 0 auto; padding: 40px; background-color: #fff; border-radius: 15px; box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08); }
        .form-container h2 { text-align: center; color: #ff6f61; margin-top: 0; margin-bottom: 40px; font-size: 2rem; }
        fieldset { border: none; padding: 0; margin: 0 0 35px 0; border-bottom: 1px solid #eee; padding-bottom: 25px; }
        legend { font-size: 1.4rem; font-weight: 600; color: #2e7d32; margin-bottom: 25px; width: 100%; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 500; font-size: 0.95rem; }
        input[type="text"], input[type="number"], textarea { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px; box-sizing: border-box; font-size: 1rem; }
        textarea { resize: vertical; min-height: 120px; }
        .dynamic-item { display: flex; gap: 10px; align-items: center; margin-bottom: 10px; }
        .dynamic-item input[type="text"] { flex-grow: 1; }
        button { padding: 12px 20px; border-radius: 8px; border: none; cursor: pointer; font-size: 1rem; font-weight: 600; }
        .btn-add { background-color: #e0e0e0; color: #333; }
        .btn-remove { background-color: #fbe9e7; color: #ff6f61; padding: 8px 12px; font-size: 0.9rem; }
        .btn-submit { display: block; width: 100%; padding: 15px; font-size: 1.2rem; background-color: #ff6f61; color: white; margin-top: 20px; }
        .current-image { max-width: 100px; max-height: 100px; margin-right: 10px; border-radius: 5px; }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<main>
    <div class="form-container">
        <%-- (2) form 태그 action 경로 변경 --%>
        <form action="${pageContext.request.contextPath}/updateRecipe" method="post" enctype="multipart/form-data">
            <%-- (3) 어떤 레시피를 수정할지 알려주기 위한 hidden input 추가 --%>
            <input type="hidden" name="recipeId" value="${recipe.recipeId}">
            
            <h2>레시피 수정</h2>
                  

            <fieldset>
                <legend>레시피 정보</legend>
                <div class="form-group">
                    <label for="title">제목</label>
                    <input type="text" id="title" name="title" required value="${recipe.title}">
                </div>
                <div class="form-group">
                    <label for="description">설명</label>
                    <%-- textarea는 value 속성이 없으므로 태그 사이에 값을 넣어줍니다. --%>
                    <textarea id="description" name="description" required>${recipe.description}</textarea>
                </div>
                <div class="form-group">
                    <label for="servingSize">인분 수</label>
                    <input type="number" id="servingSize" name="servingSize" value="${recipe.servingSize}">
                </div>
                <div class="form-group">
                    <label for="difficulty">난이도 (1~5)</label>
                    <input type="number" id="difficulty" name="difficulty" min="1" max="5" value="${recipe.difficulty}">
                </div>
                <div class="form-group">
                    <label for="cookingTime">조리 시간</label>
                    <input type="text" id="cookingTime" name="cookingTime" value="${recipe.cookingTime}">
                </div>
                <div class="form-group">
                    <label for="mainImageFile">메인 이미지</label>
                    <div>
                        <p>현재 이미지:</p>
                        <img src="${recipe.mainImage}" alt="현재 메인 이미지" class="current-image">
                        <p>새 이미지로 변경하려면 아래에서 파일을 선택하세요.</p>
                        <input type="file" id="mainImageFile" name="mainImageFile">
                        <%-- 기존 이미지 URL을 보내서, 새 파일이 없으면 유지하도록 서버에서 처리 --%>
                        <input type="hidden" name="mainImage" value="${recipe.mainImage}">
                    </div>
                </div>
            </fieldset>

            <%-- 카테고리는 등록 페이지와 동일하게 가져온다고 가정 --%>
            <fieldset>
    <legend>카테고리</legend>
    <div class="form-group category-group">
        <%-- recipe 객체에 categoryList가 있다고 가정합니다. 없다면 Controller에서 따로 넘겨줘야 합니다. --%>
        <%-- 현재 레시피가 속한 카테고리 ID들을 Set으로 만들어 빠른 조회를 준비합니다. --%>
        <c:set var="selectedCategoryIds" value="${recipe.getCategoryIdsSet()}" /> 

        <c:forEach items="${categories}" var="category">
            <label>
                <%-- Set에 현재 카테고리 ID가 포함되어 있으면 checked 속성을 추가합니다. --%>
                <input type="checkbox" name="categoryIds" value="${category.categoryId}" 
                       <c:if test="${selectedCategoryIds.contains(category.categoryId)}">checked</c:if>>
                ${category.name}
            </label>
        </c:forEach>
    </div>
</fieldset>

            <fieldset>
                <legend>재료</legend>
                <div id="ingredients">
                    <%-- (4) 기존 재료 목록을 c:forEach로 출력 --%>
                    <c:forEach var="ing" items="${recipe.ingredientList}" varStatus="loop">
                        <div class="ingredient dynamic-item">
                        	<input type="hidden" name="ingredientList[${loop.index}].ingredientId" value="${ing.ingredientId}">
                            <%-- name 속성의 인덱스를 loop.index로 동적 할당 --%>
                            <input type="text" name="ingredientList[${loop.index}].name" placeholder="재료명" required value="${ing.name}">
                            <input type="text" name="ingredientList[${loop.index}].quantity" placeholder="양" required value="${ing.quantity}">
                            <button type="button" class="removeIngredientBtn btn-remove">삭제</button>
                        </div>
                    </c:forEach>
                </div>
                <button type="button" id="addIngredientBtn" class="btn-add">재료 추가</button>
            </fieldset>

            <fieldset>
                <legend>조리 순서</legend>
                <div id="steps">
                    <%-- (5) 기존 조리 순서 목록을 c:forEach로 출력 --%>
                    <c:forEach var="step" items="${recipe.stepList}" varStatus="loop">
                        <div class="step dynamic-item">
                            <input type="text" name="stepList[${loop.index}].stepNumber" value="${step.stepNumber}" readonly size="3" style="flex-grow:0; text-align:center; background-color: #f8f9fa;">
                            <input type="text" name="stepList[${loop.index}].instruction" placeholder="설명" required value="${step.instruction}">
                            
                            <%-- 기존 이미지 표시 및 새 파일 업로드 필드 --%>
                            <div>
                                <c:if test="${not empty step.imageUrl}">
                                    <img src="${step.imageUrl}" alt="Step ${step.stepNumber} Image" class="current-image">
                                </c:if>
                                <input type="file" name="stepList[${loop.index}].imageFile" style="flex-grow:0;">
                                <input type="hidden" name="stepList[${loop.index}].imageUrl" value="${step.imageUrl}">
                            </div>
                            
                            <button type="button" class="removeStepBtn btn-remove">삭제</button>
                        </div>
                    </c:forEach>
                </div>
                <button type="button" id="addStepBtn" class="btn-add">조리 순서 추가</button>
            </fieldset>

            <%-- (6) 버튼 텍스트 변경 --%>
            <button type="submit" class="btn-submit">수정하기</button>
        </form>
    </div>
</main>

<footer>...</footer>

<%-- 재료, 조리 순서 추가를 위한 템플릿 (등록 페이지와 동일) --%>
<div id="ingredient-template" style="display: none;">
    <div class="ingredient dynamic-item">
    	<input type="hidden" name="ingredientList[__INDEX__].ingredientId" value="0">
        <input type="text" name="ingredientList[__INDEX__].name" placeholder="재료명" required>
        <input type="text" name="ingredientList[__INDEX__].quantity" placeholder="양" required>
        <button type="button" class="removeIngredientBtn btn-remove">삭제</button>
    </div>
</div>
<div id="step-template" style="display: none;">
    <div class="step dynamic-item">
        <input type="text" name="stepList[__INDEX__].stepNumber" value="__STEP_NUMBER__" readonly size="3" style="flex-grow:0; text-align:center; background-color: #f8f9fa;">
        <input type="text" name="stepList[__INDEX__].instruction" placeholder="설명" required>
        <input type="file" name="stepList[__INDEX__].imageFile" style="flex-grow:0;">
        <input type="hidden" name="stepList[__INDEX__].imageUrl" value="">
        <button type="button" class="removeStepBtn btn-remove">삭제</button>
    </div>
</div>


<%-- [최종 해결 v4] 디버깅 로그 제거한 최종본 --%>
<script>
$(document).ready(function() {
    // ========== 헤더 기능 Javascript ==========
    // (이하 생략 - 기존과 동일)
    $('#search-icon').on('click', function(e) {
        $('.search-box').toggleClass('active');
        if ($('.search-box').hasClass('active')) {
            $('.search-input').focus();
        }
        e.stopPropagation(); 
    });
    $('#menu-toggle').on('click', function(e) {
        $('#login-menu').toggleClass('show');
        $(this).toggleClass('bi-list bi-x');
        e.stopPropagation();
    });
    $(document).on('click', function() {
        if ($('.search-box').hasClass('active')) {
            $('.search-box').removeClass('active');
        }
        if ($('#login-menu').hasClass('show')) {
            $('#login-menu').removeClass('show');
            $('#menu-toggle').removeClass('bi-x').addClass('bi-list');
        }
    });
    $('#login-menu, .search-box').on('click', function(e) {
        e.stopPropagation();
    });
    // (헤더 기능 끝)
    // ===========================================
	
 
    // 1. 재료 추가 로직 (기존과 동일)
    // ===========================================
    $('#addIngredientBtn').click(function () {
        const newIndex = $('#ingredients .ingredient').length;
        const template = $('#ingredient-template').html();
        const newHtml = template.replace(/__INDEX__/g, newIndex);
        $('#ingredients').append(newHtml);
    });

    // ===========================================
    // 2. 재료 삭제 로직 (✅ [수정됨] EL 충돌 제거)
    // ===========================================
    $('#ingredients').on('click', '.removeIngredientBtn', function () {
        if ($('#ingredients .ingredient').length <= 1) {
            alert("최소 1개의 재료는 필요합니다.");
            return;
        }

        $(this).closest('.ingredient').remove();

        // console.log("--- [v6] 재료 삭제 후 인덱스 재정렬 시작 ---"); // 로그 제거
        $('#ingredients .ingredient').each(function (index) {
            // console.log("[v6 재료 " + index + "] 처리 시작"); // 로그 제거
            const inputs = $(this).find('> input');

            if (inputs.length >= 3) {
                const idInput = inputs.eq(0);
                const nameInput = inputs.eq(1);
                const quantityInput = inputs.eq(2);

                idInput.attr('name', 'ingredientList[' + index + '].ingredientId');
                // console.log("  ID 실제 값: " + idInput.attr('name')); // 로그 제거

                nameInput.attr('name', 'ingredientList[' + index + '].name');
                // console.log("  Name 실제 값: " + nameInput.attr('name')); // 로그 제거

                quantityInput.attr('name', 'ingredientList[' + index + '].quantity');
                // console.log("  Quantity 실제 값: " + quantityInput.attr('name')); // 로그 제거
            } else {
                 // console.error("[오류 v6] 재료 " + index + ": 예상과 달리 input이 " + inputs.length + "개 발견됨"); // 로그 제거
            }
        });
        // console.log("--- [v6] 재료 삭제 후 인덱스 재정렬 완료 ---"); // 로그 제거
    }); // 재료 삭제 로직 끝

    // ===========================================
    // 3. 조리 순서 추가 로직 (기존과 동일)
    // ===========================================
    $('#addStepBtn').click(function () {
        const newIndex = $('#steps .step').length;
        const newStepNumber = newIndex + 1;
        const template = $('#step-template').html();
        let newHtml = template.replace(/__INDEX__/g, newIndex);
        newHtml = newHtml.replace(/__STEP_NUMBER__/g, newStepNumber);
        $('#steps').append(newHtml);
    });

    // ===========================================
    // 4. 조리 순서 삭제 로직 (✅ [수정됨] EL 충돌 제거)
    // ===========================================
    $('#steps').on('click', '.removeStepBtn', function () {
        if ($('#steps .step').length <= 1) {
            alert("최소 1개의 조리 순서는 필요합니다.");
            return;
        }

        $(this).closest('.step').remove();

        // console.log("--- [v6] 조리 순서 삭제 후 인덱스 재정렬 시작 ---"); // 로그 제거
        $('#steps .step').each(function (index) {
            // console.log("[v6 순서 " + index + "] 처리 시작"); // 로그 제거
            const stepNumber = index + 1;
            const inputs = $(this).find('input');

            if (inputs.length >= 4) {
                 const numberInput = inputs.eq(0);
                 const instructionInput = inputs.eq(1);
                 const fileInput = inputs.eq(2);
                 const urlInput = inputs.eq(3);

                 numberInput.val(stepNumber);
                 numberInput.attr('name', 'stepList[' + index + '].stepNumber');
                 // console.log("  Number 실제 값: " + numberInput.attr('name')); // 로그 제거

                 instructionInput.attr('name', 'stepList[' + index + '].instruction');
                 // console.log("  Instruction 실제 값: " + instructionInput.attr('name')); // 로그 제거

                 fileInput.attr('name', 'stepList[' + index + '].imageFile');
                 // console.log("  File 실제 값: " + fileInput.attr('name')); // 로그 제거

                 urlInput.attr('name', 'stepList[' + index + '].imageUrl');
                 // console.log("  Url 실제 값: " + urlInput.attr('name')); // 로그 제거
            } else {
                 // console.error("[오류 v6] 조리 순서 " + index + ": 예상과 달리 input이 " + inputs.length + "개 발견됨"); // 로그 제거
            }
        });
        // console.log("--- [v6] 조리 순서 삭제 후 인덱스 재정렬 완료 ---"); // 로그 제거
    }); // 조리 순서 삭제 로직 끝
 // ===========================================
    // ✅ [추가] 카테고리 체크박스 하나만 선택되도록 제한
    // ===========================================
    // name이 "categoryIds"인 체크박스들의 'change' 이벤트를 감지합니다.
    $('input[type="checkbox"][name="categoryIds"]').on('change', function() {
        // 1. 현재 클릭된 체크박스가 '체크된' 상태인지 확인합니다.
        if ($(this).is(':checked')) {
            // 2. 만약 체크되었다면, '다른' 체크박스들을 모두 찾아서
            //    (name이 같지만 현재 클릭된 것은 제외)
            $('input[type="checkbox"][name="categoryIds"]').not(this).each(function() {
                // 3. 체크를 해제합니다.
                $(this).prop('checked', false);
            });
        }
        // 만약 체크를 '해제'한 경우에는 아무것도 하지 않습니다.
        // (즉, 마지막으로 체크된 것을 해제하면 모두 해제된 상태가 됩니다.)
    });


    // ===========================================
    // 폼 제출 직전 데이터 검사 (로그 제거됨)
    // ===========================================
    /*
    $('form').on('submit', function(event) {
        console.log("\n--- [v6] 폼 제출 직전 데이터 검사 ---");
        // ... (로그 출력 코드) ...
        event.preventDefault();
        alert("폼 제출이 중단되었습니다. 개발자 도구 콘솔을 확인하세요.");
    });
    */

}); // $(document).ready 끝
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>