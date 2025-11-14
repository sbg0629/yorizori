package com.boot.YoRiZoRi.Recipe.dao;

import java.util.List; // [추가]
import java.util.Map;  // [추가]

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.boot.YoRiZoRi.Recipe.dto.CategoryDTO;
import com.boot.YoRiZoRi.Recipe.dto.IngredientDTO;
import com.boot.YoRiZoRi.Recipe.dto.RecipeDTO;
import com.boot.YoRiZoRi.Recipe.dto.StepDTO;

@Repository
public class RecipeDAOImpl implements RecipeDAO {

    @Autowired
    private SqlSession sqlSession;

    // Mapper XML의 namespace와 일치해야 합니다.
    private static final String NAMESPACE = "com.boot.YoRiZoRi.Recipe.dao.RecipeDAO";

    @Override
    public void insertRecipe(RecipeDTO recipeDTO) {
        sqlSession.insert(NAMESPACE + ".insertRecipe", recipeDTO);
    }

    @Override
    public void insertStep(StepDTO stepDTO) {
        sqlSession.insert(NAMESPACE + ".insertStep", stepDTO);
    }

    @Override
    public void insertStepImage(StepDTO stepDTO) {
        sqlSession.insert(NAMESPACE + ".insertStepImage", stepDTO);
    }

    @Override
    public void insertIngredient(IngredientDTO ingredientDTO) {
        sqlSession.insert(NAMESPACE + ".insertIngredient", ingredientDTO);
    }

    @Override
    public void insertRecipeIngredient(IngredientDTO ingredientDTO) {
        sqlSession.insert(NAMESPACE + ".insertRecipeIngredient", ingredientDTO);
    }

    @Override
    public IngredientDTO findIngredientByName(String name) {
        return sqlSession.selectOne(NAMESPACE + ".findIngredientByName", name);
    }

    /**
     * [추가] 모든 카테고리 목록 조회 구현
     * mapper의 "findAllCategories" 쿼리를 호출합니다.
     */
    @Override
    public List<CategoryDTO> findAllCategories() {
        return sqlSession.selectList(NAMESPACE + ".findAllCategories");
    }

    /**
     * [추가] 레시피-카테고리 관계 정보 삽입 구현
     * mapper의 "insertRecipeCategory" 쿼리를 호출합니다.
     */
    @Override
    public void insertRecipeCategory(Map<String, Integer> params) {
        sqlSession.insert(NAMESPACE + ".insertRecipeCategory", params);
    }
}