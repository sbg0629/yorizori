<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
        /* ✅ 수정: 이미지 스타일 통합 및 크기 조정 */
        .image-preview-container { margin-top: 10px; margin-bottom: 10px; display: flex; flex-direction: column; align-items: flex-start; }
        .recipe-image-preview { max-width: 150px; max-height: 150px; border-radius: 5px; object-fit: cover; border: 1px solid #ddd; }
        .step-image-group { display: flex; flex-direction: column; align-items: center; gap: 5px; }
        .step-image-preview { max-width: 100px; max-height: 100px; border-radius: 5px; object-fit: cover; border: 1px solid #ddd; margin-bottom: 5px; }

        .btn-submit { display: block; width: 100%; padding: 15px; font-size: 1.2rem; background-color: #ff6f61; color: white; margin-top: 20px; }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<main>
    <div class="form-container">
        <form action="${pageContext.request.contextPath}/updateRecipe" method="post" enctype="multipart/form-data">
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
                    <div class="image-preview-container">
                        <%-- ✅ 기존 이미지 표시 또는 미리보기용 이미지 --%>
                        <img id="mainImagePreview" 
                             class="recipe-image-preview" 
                             src="/images/${recipe.mainImage}" 
                             alt="현재 메인 이미지"
                             style="<c:if test="${empty recipe.mainImage}">display:none;</c:if>">
                        
                        <p style="margin-top: 10px; margin-bottom: 5px;">이미지 변경:</p>
                        <input type="file" id="mainImageFile" name="mainImageFile" accept="image/*">
                        
                        <%-- 기존 이미지 URL을 서버로 다시 보냅니다. 파일이 선택되지 않으면 이 값이 사용됩니다. --%>
                        <input type="hidden" name="mainImage" value="${recipe.mainImage}">
                    </div>
                </div>
            </fieldset>

            <%-- 카테고리 필드셋 (변경 없음) --%>
            <fieldset>
                <legend>카테고리</legend>
                <div class="form-group category-group">
                    <c:set var="selectedCategoryIds" value="${recipe.getCategoryIdsSet()}" /> 
                    <c:forEach items="${categories}" var="category">
                        <label>
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
                    <c:forEach var="ing" items="${recipe.ingredientList}" varStatus="loop">
                        <div class="ingredient dynamic-item">
                        	<input type="hidden" name="ingredientList[${loop.index}].ingredientId" value="${ing.ingredientId}">
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
                    <c:forEach var="step" items="${recipe.stepList}" varStatus="loop">
                        <div class="step dynamic-item">
                            <input type="text" name="stepList[${loop.index}].stepNumber" value="${step.stepNumber}" readonly size="3" style="flex-grow:0; text-align:center; background-color: #f8f9fa;">
                            <input type="text" name="stepList[${loop.index}].instruction" placeholder="설명" required value="${step.instruction}">
                            
                            <%-- ✅ 조리 순서 이미지 표시 및 새 파일 업로드 필드 --%>
                            <div class="step-image-group">
                                <img class="step-image-preview"
                                     src="/images/${step.imageUrl}" 
                                     alt="Step ${step.stepNumber} Image"
                                     style="<c:if test="${empty step.imageUrl}">display:none;</c:if>">
                                     
                                <input type="file" name="stepList[${loop.index}].imageFile" class="stepImageFile" style="flex-grow:0;" accept="image/*">
                                <input type="hidden" name="stepList[${loop.index}].imageUrl" value="${step.imageUrl}">
                            </div>
                            
                            <button type="button" class="removeStepBtn btn-remove">삭제</button>
                        </div>
                    </c:forEach>
                </div>
                <button type="button" id="addStepBtn" class="btn-add">조리 순서 추가</button>
            </fieldset>

            <button type="submit" class="btn-submit">수정하기</button>
        </form>
    </div>
</main>

<footer>...</footer>

<%-- 재료, 조리 순서 추가를 위한 템플릿 (step-template에 이미지 필드 추가) --%>
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
        
        <%-- ✅ 템플릿에도 이미지 미리보기/업로드 필드 추가 --%>
        <div class="step-image-group">
            <img class="step-image-preview" src="#" alt="순서 이미지 미리보기" style="display:none;">
            <input type="file" name="stepList[__INDEX__].imageFile" class="stepImageFile" style="flex-grow:0;" accept="image/*">
            <input type="hidden" name="stepList[__INDEX__].imageUrl" value="">
        </div>
        
        <button type="button" class="removeStepBtn btn-remove">삭제</button>
    </div>
</div>


<script>
    // ===========================================
    // ✅ 이미지 미리보기 공통 함수 (기존/신규 파일 처리 로직 포함)
    // ===========================================
    function previewImage(fileInput, previewElement) {
        if (fileInput.files && fileInput.files[0]) {
            // 1. 새 파일이 선택된 경우: FileReader로 미리보기
            const reader = new FileReader();
            reader.onload = function(e) {
                previewElement.attr('src', e.target.result).show();
            };
            reader.readAsDataURL(fileInput.files[0]);
        } else {
            // 2. 파일이 선택되지 않은 경우 (취소한 경우)
            //    2-1. 기존 이미지 URL hidden 필드 찾기
            const parent = fileInput.closest('.form-group, .step-image-group'); // 부모 컨테이너 찾기
            const existingUrlInput = parent.find('input[type="hidden"][name*="Image"], input[type="hidden"][name*="Url"]');
            const existingUrl = existingUrlInput.val();
            
            if (existingUrl && existingUrl !== '') {
                // 2-2. 기존 이미지 URL이 있으면 다시 표시
                previewElement.attr('src', '/images/' + existingUrl).show();
            } else {
                // 2-3. 기존 이미지도 없으면 숨김
                previewElement.attr('src', '#').hide();
            }
        }
    }

    $(document).ready(function() {
    
        // 1. 메인 이미지 미리보기 이벤트 핸들러
        // ===========================================
        $('#mainImageFile').change(function() {
            previewImage(this, $('#mainImagePreview'));
        });

        // 2. 조리 순서 추가 로직
        // ===========================================
        $('#addStepBtn').click(function () {
            const newIndex = $('#steps .step').length;
            const newStepNumber = newIndex + 1;
            const template = $('#step-template').html();
            let newHtml = template.replace(/__INDEX__/g, newIndex);
            newHtml = newHtml.replace(/__STEP_NUMBER__/g, newStepNumber);
            
            // ✅ 템플릿을 추가할 때, 새로 추가된 요소에 이미지가 없으므로 숨깁니다.
            const $newStep = $(newHtml);
            $newStep.find('.step-image-preview').hide();
            $('#steps').append($newStep);
        });

        // 3. 동적 생성/기존 조리 순서 이미지 미리보기 이벤트 핸들러
        // ===========================================
        $('#steps').on('change', '.stepImageFile', function() {
             const previewElement = $(this).siblings('.step-image-preview');
             previewImage(this, previewElement);
        });
        
        // --- (나머지 재료/순서 추가/삭제 로직, 카테고리 로직은 변경 없이 유지) ---
        // 재료 추가 로직
        $('#addIngredientBtn').click(function () {
            const newIndex = $('#ingredients .ingredient').length;
            const template = $('#ingredient-template').html();
            const newHtml = template.replace(/__INDEX__/g, newIndex);
            $('#ingredients').append(newHtml);
        });

        // 재료 삭제 로직
        $('#ingredients').on('click', '.removeIngredientBtn', function () {
            if ($('#ingredients .ingredient').length <= 1) {
                alert("최소 1개의 재료는 필요합니다.");
                return;
            }
            $(this).closest('.ingredient').remove();
            $('#ingredients .ingredient').each(function (index) {
                const inputs = $(this).find('> input');
                if (inputs.length >= 3) {
                    inputs.eq(0).attr('name', 'ingredientList[' + index + '].ingredientId');
                    inputs.eq(1).attr('name', 'ingredientList[' + index + '].name');
                    inputs.eq(2).attr('name', 'ingredientList[' + index + '].quantity');
                }
            });
        }); 

        // 조리 순서 삭제 로직
        $('#steps').on('click', '.removeStepBtn', function () {
            if ($('#steps .step').length <= 1) {
                alert("최소 1개의 조리 순서는 필요합니다.");
                return;
            }
            $(this).closest('.step').remove();
            $('#steps .step').each(function (index) {
                const stepNumber = index + 1;
                const inputs = $(this).find('input');

                if (inputs.length >= 4) {
                     inputs.eq(0).val(stepNumber);
                     inputs.eq(0).attr('name', 'stepList[' + index + '].stepNumber');
                     inputs.eq(1).attr('name', 'stepList[' + index + '].instruction');
                     // inputs.eq(2)는 file input 이므로 class로 찾는것보다 inputs의 index로 처리합니다.
                     inputs.eq(2).attr('name', 'stepList[' + index + '].imageFile');
                     inputs.eq(3).attr('name', 'stepList[' + index + '].imageUrl');
                }
            });
        }); 
        
        // 카테고리 체크박스 하나만 선택되도록 제한
        $('input[type="checkbox"][name="categoryIds"]').on('change', function() {
            if ($(this).is(':checked')) {
                $('input[type="checkbox"][name="categoryIds"]').not(this).each(function() {
                    $(this).prop('checked', false);
                });
            }
        });
        // --- (나머지 로직 끝) ---

    }); // $(document).ready 끝
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>