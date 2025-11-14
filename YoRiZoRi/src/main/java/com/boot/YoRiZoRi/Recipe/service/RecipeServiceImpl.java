package com.boot.YoRiZoRi.Recipe.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import com.boot.YoRiZoRi.Recipe.dao.RecipeDAO;
import com.boot.YoRiZoRi.Recipe.dto.CategoryDTO;
import com.boot.YoRiZoRi.Recipe.dto.IngredientDTO;
import com.boot.YoRiZoRi.Recipe.dto.RecipeDTO;
import com.boot.YoRiZoRi.Recipe.dto.StepDTO;

@Service
public class RecipeServiceImpl implements RecipeService {

    private static final Logger log = LoggerFactory.getLogger(RecipeServiceImpl.class);

    @Autowired
    private RecipeDAO recipeDAO;

    private String saveFile(MultipartFile file, String uploadPath) throws Exception {
        if (file == null || file.isEmpty()) { return null; }
        String originalFilename = file.getOriginalFilename();
        String savedFilename = UUID.randomUUID().toString() + "_" + originalFilename;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) { uploadDir.mkdirs(); }
        File dest = new File(uploadPath, savedFilename);
        file.transferTo(dest);
        return savedFilename;
    }

    @Override
    @Transactional
    public void registerRecipe(RecipeDTO recipeDTO, String uploadPath) throws Exception {
        log.info("레시피 등록 시작: " + recipeDTO.getTitle());

        // 1. 레시피 기본 정보 저장
        String mainImageName = saveFile(recipeDTO.getMainImageFile(), uploadPath);
        recipeDTO.setMainImage(mainImageName != null ? mainImageName : "default_main.jpg");
        recipeDAO.insertRecipe(recipeDTO);
        log.info("레시피 정보 저장 완료. 생성된 ID: " + recipeDTO.getId());

        // 2. 조리 순서 저장
        if (recipeDTO.getSteps() != null) {
            for (StepDTO step : recipeDTO.getSteps()) {
                step.setRecipeId(recipeDTO.getId());
                recipeDAO.insertStep(step);
                String stepImageName = saveFile(step.getImageFile(), uploadPath);
                if (stepImageName != null) {
                    step.setImage(stepImageName);
                    recipeDAO.insertStepImage(step);
                }
            }
            log.info("조리 순서 " + recipeDTO.getSteps().size() + "개 저장 완료.");
        }
        
        // 3. 재료 저장 로직
        if (recipeDTO.getIngredients() != null) {
            for (IngredientDTO currentIngredient : recipeDTO.getIngredients()) {
                // 3-1. DB에 해당 이름의 재료가 있는지 먼저 '조회'합니다.
                IngredientDTO foundIngredient = recipeDAO.findIngredientByName(currentIngredient.getName());
                
                if (foundIngredient == null) {
                    // 3-2. 조회 결과가 없으면(null), '신규' 재료이므로 DB에 INSERT 합니다.
                    recipeDAO.insertIngredient(currentIngredient);
                    log.info("신규 재료 등록: " + currentIngredient.getName() + ", 생성된 ID: " + currentIngredient.getIngredientId());
                } else {
                    // 3-3. 조회 결과가 있으면, '기존' 재료이므로 조회된 ID를 DTO에 설정합니다.
                    currentIngredient.setIngredientId(foundIngredient.getIngredientId());
                    log.info("기존 재료 사용: " + currentIngredient.getName() + ", ID: " + currentIngredient.getIngredientId());
                }
                
                // 3-4. DTO에 현재 레시피의 ID를 설정합니다.
                currentIngredient.setRecipeId(recipeDTO.getId());
                
                // 3-5. 'recipe_ingredient' 테이블에 최종 연결 정보를 저장합니다.
                recipeDAO.insertRecipeIngredient(currentIngredient);
            }
            log.info("재료 " + recipeDTO.getIngredients().size() + "개 연결 완료.");
        }

     // 4. [수정] 카테고리 저장 로직
        // 'getCategoryIds'를 'getCategoryId'로 변경하고, 반복문을 제거합니다.
        if (recipeDTO.getCategoryId() != null) { 
            
            // 반복문이 필요 없어졌습니다.
            // for (Integer categoryId : recipeDTO.getCategoryIds()) { // (이전 코드)
            
            Map<String, Integer> params = new HashMap<String, Integer>();
            params.put("recipeId", recipeDTO.getId());
            params.put("categoryId", recipeDTO.getCategoryId()); // DTO에서 단일 ID를 가져옵니다.
            recipeDAO.insertRecipeCategory(params);
            
            // } // (이전 코드)
            
            // 로그 메시지도 단일 ID를 찍도록 변경합니다.
            log.info("카테고리 ID: " + recipeDTO.getCategoryId() + " 연결 완료.");
        }

        log.info("레시피 등록 성공!");
    }

    /**
     * [추가] 모든 카테고리 목록을 조회합니다.
     * @return 카테고리 DTO 리스트
     */
    @Override
    public List<CategoryDTO> getAllCategories() {
        log.info("모든 카테고리 목록을 조회합니다.");
        return recipeDAO.findAllCategories();
    }
}