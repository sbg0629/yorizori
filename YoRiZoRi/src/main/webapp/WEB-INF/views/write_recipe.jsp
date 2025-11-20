<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>레시피 등록 - 요리조리</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
		    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
			<link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css">
			<link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet" type="text/css">
			<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* 기본 스타일 */
        body {
            font-family: "Noto Sans KR", sans-serif; margin: 0; padding: 0;
            background-color: #fffaf7; color: #333;
        }
        a { text-decoration: none; color: inherit; }

      
        /* ---------------- 메인 & 폼 스타일 ---------------- */
        main { padding: 40px 20px; }
        .form-container { width: 90%; max-width: 800px; margin: 0 auto; padding: 40px; background-color: #fff; border-radius: 15px; box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08); }
        .form-container h2 { text-align: center; color: #ff6f61; margin-top: 0; margin-bottom: 40px; font-size: 2rem; }
        fieldset { border: none; padding: 0; margin: 0 0 35px 0; border-bottom: 1px solid #eee; padding-bottom: 25px; }
        fieldset:last-of-type { border-bottom: none; }
        legend { font-size: 1.4rem; font-weight: 600; color: #2e7d32; margin-bottom: 25px; width: 100%; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 500; font-size: 0.95rem; }
        input[type="text"], input[type="number"], textarea { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px; box-sizing: border-box; font-size: 1rem; transition: border-color 0.3s, box-shadow 0.3s; }
        input[type="text"]:focus, input[type="number"]:focus, textarea:focus { outline: none; border-color: #ff6f61; box-shadow: 0 0 0 3px rgba(255, 111, 97, 0.2); }
        textarea { resize: vertical; min-height: 120px; }
        input[type="file"] { font-size: 0.95rem; }
        .category-group label { display: inline-flex; align-items: center; margin-right: 20px; cursor: pointer; }
        .category-group input[type="checkbox"] { margin-right: 8px; }
        .dynamic-item { display: flex; gap: 10px; align-items: center; margin-bottom: 10px; }
        .dynamic-item input[type="text"] { flex-grow: 1; }
        button { padding: 12px 20px; border-radius: 8px; border: none; cursor: pointer; font-size: 1rem; font-weight: 600; transition: background-color 0.3s, transform 0.2s; }
        button:hover { transform: translateY(-2px); }
        .btn-add { background-color: #e0e0e0; color: #333; }
        .btn-add:hover { background-color: #d0d0d0; }
        .btn-remove { background-color: #fbe9e7; color: #ff6f61; padding: 8px 12px; font-size: 0.9rem; }
        .btn-remove:hover { background-color: #ffccbc; }
        .btn-submit { display: block; width: 100%; padding: 15px; font-size: 1.2rem; background-color: #ff6f61; color: white; margin-top: 20px; }
        .btn-submit:hover { background-color: #e65a50; }
        footer { text-align: center; padding: 20px 50px; margin-top: 20px; border-top: 1px solid #e0e0e0; color: #888; font-size: 14px; }
        /* ✅ 이미지 미리보기 스타일 */
        .image-preview-container { margin-top: 10px; margin-bottom: 10px; }
        .image-preview { max-width: 100%; max-height: 200px; border-radius: 8px; display: none; object-fit: cover; }
        .step-image-group { display: flex; flex-direction: column; align-items: center; gap: 5px; }
        .step-image-preview { max-width: 150px; max-height: 150px; border-radius: 8px; display: none; object-fit: cover; margin-bottom: 5px; }
    </style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    
<main>
    <div class="form-container">
        <form action="${pageContext.request.contextPath}/submit" method="post" enctype="multipart/form-data">
            <h2>레시피 등록</h2>

            <fieldset>
                <legend>레시피 정보</legend>
                <div class="form-group">
                    <label for="title">제목</label>
                    <input type="text" id="title" name="title" required>
                </div>
                <div class="form-group">
                    <label for="description">설명</label>
                    <textarea id="description" name="description" required></textarea>
                </div>
                <div class="form-group">
                    <label for="servingSize">인분 수</label>
                    <input type="number" id="servingSize" name="servingSize">
                </div>
                <div class="form-group">
                    <label for="difficulty">난이도 (1~5)</label>
                    <input type="number" id="difficulty" name="difficulty" min="1" max="5">
                </div>
                <div class="form-group">
                    <label for="cookingTime">조리 시간</label>
                    <input type="text" id="cookingTime" name="cookingTime">
                </div>
                <div class="form-group">
                    <label for="mainImageFile">메인 이미지</label>
                    <input type="file" id="mainImageFile" name="mainImageFile" accept="image/*">
                    <div class="image-preview-container">
                    	<img id="mainImagePreview" class="image-preview" src="#" alt="메인 이미지 미리보기" style="display:none;">
                    </div>
                </div>
            </fieldset>

            <fieldset>
          <legend>카테고리</legend>
	          <div class="form-group category-group">
	              <c:forEach items="${categories}" var="category">
	                  <label>
	                      <%-- type="radio", name="categoryId"로 변경 --%>
	                      <input type="radio" name="categoryId" value="${category.categoryId}"> ${category.name}
	                  </label>
	              </c:forEach>
	          </div>
	      </fieldset>

            <fieldset>
                <legend>재료</legend>
                <div id="ingredients">
                    <div class="ingredient dynamic-item">
                        <input type="text" name="ingredients[0].name" placeholder="재료명" required>
                        <input type="text" name="ingredients[0].quantity" placeholder="양" required>
                        <button type="button" class="removeIngredientBtn btn-remove">삭제</button>
                    </div>
                </div>
                <button type="button" id="addIngredientBtn" class="btn-add">재료 추가</button>
            </fieldset>

            <fieldset>
                <legend>조리 순서</legend>
                <div id="steps">
                    <div class="step dynamic-item">
                        <input type="text" name="steps[0].stepNumber" value="1" readonly size="3" style="flex-grow:0; text-align:center; background-color: #f8f9fa;">
                        <input type="text" name="steps[0].instruction" placeholder="설명" required>
                         <div class="step-image-group">
                           <img class="step-image-preview" src="#" alt="순서 이미지 미리보기" style="display:none;">
                           <input type="file" name="steps[0].imageFile" class="stepImageFile" style="flex-grow:0;" accept="image/*">
                        </div>
                        <button type="button" class="removeStepBtn btn-remove">삭제</button>
                    </div>
                </div>
                <button type="button" id="addStepBtn" class="btn-add">조리 순서 추가</button>
            </fieldset>

            <button type="submit" class="btn-submit">등록하기</button>
        </form>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

<div id="ingredient-template" style="display: none;">
    <div class="ingredient dynamic-item">
        <input type="text" name="ingredients[__INDEX__].name" placeholder="재료명" required>
        <input type="text" name="ingredients[__INDEX__].quantity" placeholder="양" required>
        <button type="button" class="removeIngredientBtn btn-remove">삭제</button>
    </div>
</div>
<div id="step-template" style="display: none;">
    <div class="step dynamic-item">
        <input type="text" name="steps[__INDEX__].stepNumber" value="__STEP_NUMBER__" readonly size="3" style="flex-grow:0; text-align:center; background-color: #f8f9fa;">
        <input type="text" name="steps[__INDEX__].instruction" placeholder="설명" required>
         <div class="step-image-group">
            <img class="step-image-preview" src="#" alt="순서 이미지 미리보기" style="display:none;">
            <input type="file" name="steps[__INDEX__].imageFile" class="stepImageFile" style="flex-grow:0;" accept="image/*">
         </div>
        <button type="button" class="removeStepBtn btn-remove">삭제</button>
    </div>
</div>

<script>
    // ✅ 이미지 미리보기 공통 함수
    function previewImage(input, previewElement) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                previewElement.attr('src', e.target.result).show();
            };
            reader.readAsDataURL(input.files[0]);
        } else {
            previewElement.attr('src', '#').hide();
        }
    }

    $(document).ready(function() {
        
        // 1. 메인 이미지 미리보기 이벤트 핸들러
        $('#mainImageFile').change(function() {
            previewImage(this, $('#mainImagePreview'));
        });

        // 2. 재료 추가/삭제 로직 (생략 - 변경 없음)
        $('#addIngredientBtn').click(function () {
            const newIndex = $('#ingredients .ingredient').length;
            const template = $('#ingredient-template').html();
            const newHtml = template.replace(/__INDEX__/g, newIndex);
            $('#ingredients').append(newHtml);
        });

        $('#ingredients').on('click', '.removeIngredientBtn', function () {
            if ($('#ingredients .ingredient').length <= 1) {
                 alert("최소 1개의 재료는 필요합니다.");
                 return;
            }
            $(this).closest('.ingredient').remove();
            $('#ingredients .ingredient').each(function (index) {
                const inputs = $(this).find('> input');
                if (inputs.length >= 2) {
                    inputs.eq(0).attr('name', 'ingredients[' + index + '].name');
                    inputs.eq(1).attr('name', 'ingredients[' + index + '].quantity');
                } else {
                     console.error("[오류] 재료 " + index + ": 예상과 달리 input이 " + inputs.length + "개 발견됨");
                }
            });
        });

        // 3. 조리 순서 추가 로직
        $('#addStepBtn').click(function () {
            const newIndex = $('#steps .step').length;
            const newStepNumber = newIndex + 1;
            const template = $('#step-template').html();
            let newHtml = template.replace(/__INDEX__/g, newIndex);
            newHtml = newHtml.replace(/__STEP_NUMBER__/g, newStepNumber);
            $('#steps').append(newHtml);
        });

        // 4. 조리 순서 삭제 로직
        $('#steps').on('click', '.removeStepBtn', function () {
            if ($('#steps .step').length <= 1) {
                alert("최소 1개의 조리 순서는 필요합니다.");
                return;
            }
            $(this).closest('.step').remove();
            $('#steps .step').each(function (index) {
                const step = $(this);
                const stepNumber = index + 1;
                const inputs = step.find('input'); // 모든 input
                const imageFile = step.find('.stepImageFile'); // 파일 input

                if (inputs.length >= 3 && imageFile.length === 1) {
                    inputs.eq(0).val(stepNumber);
                    inputs.eq(0).attr('name', 'steps[' + index + '].stepNumber');
                    inputs.eq(1).attr('name', 'steps[' + index + '].instruction');
                    // imageFile은 class 셀렉터로 찾아서 name을 재설정
                    imageFile.attr('name', 'steps[' + index + '].imageFile');
                } else {
                     console.error("[오류] 조리 순서 " + index + ": 예상과 달리 input이 " + inputs.length + "개, file이 " + imageFile.length + "개 발견됨");
                }
            });
        });

        // 5. 동적 생성된 조리 순서 이미지 미리보기 이벤트 핸들러
        // input[type=file] 중에서 class="stepImageFile"인 요소에 change 이벤트 바인딩
        $('#steps').on('change', '.stepImageFile', function() {
             const previewElement = $(this).closest('.step-image-group').find('.step-image-preview');
             previewImage(this, previewElement);
        });

    }); // $(document).ready 끝
</script>
</body>
</html>