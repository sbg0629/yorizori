package com.boot.YoRiZoRi.Detailed_Page.dao;

import com.boot.YoRiZoRi.Detailed_Page.dto.CommentDTO;
import com.boot.YoRiZoRi.Detailed_Page.dto.DetailDTO;
import com.boot.YoRiZoRi.Detailed_Page.dto.IngredientDTO;
import com.boot.YoRiZoRi.Detailed_Page.dto.ReviewDTO;
import com.boot.YoRiZoRi.Detailed_Page.dto.StepImageDTO;
import com.boot.YoRiZoRi.Recipe.dto.CategoryDTO;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface detailDAO {

    // ## (1) 레시피 상세 보기 & 데이터 조회 관련 메서드 ##
    
    // 레시피 기본 정보 조회
    DetailDTO getRecipeBaseInfo(@Param("recipeId") int id);

    // 재료 목록 조회
    List<IngredientDTO> getIngredientList(@Param("recipeId") int id);
    
    // 조리 순서 및 이미지 목록 조회
    List<StepImageDTO> getStepImageList(@Param("recipeId") int id);
    
    // 댓글 목록 조회
    List<CommentDTO> getCommentList(@Param("recipeId") int id);
    
    // 후기 목록 조회
    List<ReviewDTO> getReviewList(@Param("recipeId") int id);

    List<CategoryDTO> getAllCategories();
    List<CategoryDTO> getRecipeCategories(@Param("recipeId") int id);
    // 조회수 1 증가
    void incrementHit(@Param("recipeId") int id);
    void deleteRecipeById(@Param("recipeId") int recipeId);

    
    // ## (2) 레시피 수정 관련 메서드 ##

    // 1단계: 레시피 기본 정보 UPDATE
    void updateRecipeBase(DetailDTO recipeDto);

    // 2단계: 기존 자식 데이터 DELETE
    void deleteIngredientsByRecipeId(@Param("recipeId") int recipeId);
    void deleteStepsByRecipeId(@Param("recipeId") int recipeId);

    // 추가: 특정 레시피의 모든 카테고리 연결을 삭제
    void deleteRecipeCategoriesByRecipeId(@Param("recipeId") int recipeId);

    // 3단계: 새로운 자식 데이터 INSERT
    void insertIngredient(IngredientDTO ingredient);

    // 추가: 레시피와 카테고리를 연결 (새로운 카테고리 삽입)
    void insertRecipeCategory(@Param("recipeId") int recipeId, @Param("categoryId") int categoryId);
    void insertStep(StepImageDTO step);
    void insertStepImage(StepImageDTO step);
    
    IngredientDTO findIngredientByName(String name);
    
    // 새로운 재료를 INGREDIENT 테이블에 삽입
    // useGeneratedKeys와 keyProperty를 사용해 새로 생성된 ID를 DTO에 다시 담아옵니다.
    void insertNewIngredient(IngredientDTO ingredient);
    
    // ## (3) 댓글 관련 메서드 ##
    
    // 댓글 작성
    void insertComment(CommentDTO comment);
    
    // 댓글 수정
    void updateComment(CommentDTO comment);
    
    // 댓글 삭제
    void deleteComment(@Param("commentId") int commentId);
    
    // 대댓글 작성
    void insertReply(CommentDTO comment);
    
    // 댓글 ID로 댓글 조회
    CommentDTO getCommentById(@Param("commentId") int commentId);
    
    // ## (4) 후기 관련 메서드 ##
    
    // 후기 작성
    void insertReview(ReviewDTO review);
    
    // 후기 수정
    void updateReview(ReviewDTO review);
    
    // 후기 삭제
    void deleteReview(@Param("reviewId") int reviewId);
    
    // 후기 ID로 후기 조회
    ReviewDTO getReviewById(@Param("reviewId") int reviewId);
    
    // 특정 레시피의 평균 평점 조회
    double getAverageRating(@Param("recipeId") int recipeId);
    
    // 특정 레시피의 후기 개수 조회
    int getReviewCount(@Param("recipeId") int recipeId);
    
    //북마크 기능 
    Integer checkBookmark(String memberId, int recipeId);
    void insertBookmark(String memberId, int recipeId);
    void deleteBookmark(String memberId, int recipeId);
    
    List<DetailDTO> getBookmarkList(String memberId);
}