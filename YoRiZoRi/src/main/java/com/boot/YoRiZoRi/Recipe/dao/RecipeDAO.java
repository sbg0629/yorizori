package com.boot.YoRiZoRi.Recipe.dao;

import java.util.List; // [추가]
import java.util.Map;  // [추가]

import org.apache.ibatis.annotations.Mapper;

import com.boot.YoRiZoRi.Recipe.dto.CategoryDTO;
import com.boot.YoRiZoRi.Recipe.dto.IngredientDTO;
import com.boot.YoRiZoRi.Recipe.dto.RecipeDTO;
import com.boot.YoRiZoRi.Recipe.dto.StepDTO;

@Mapper
public interface RecipeDAO {
    // 레시피 기본 정보
    void insertRecipe(RecipeDTO recipeDTO);

    // 조리 순서
    void insertStep(StepDTO stepDTO);
    void insertStepImage(StepDTO stepDTO);
    
    // 재료
    void insertIngredient(IngredientDTO ingredientDTO);
    void insertRecipeIngredient(IngredientDTO ingredientDTO);
    IngredientDTO findIngredientByName(String name);
    
    // [추가] 모든 카테고리 목록을 조회하는 메소드 선언
    List<CategoryDTO> findAllCategories();

    // [추가] recipe_category 테이블에 데이터를 삽입하는 메소드 선언
    void insertRecipeCategory(Map<String, Integer> params);
}