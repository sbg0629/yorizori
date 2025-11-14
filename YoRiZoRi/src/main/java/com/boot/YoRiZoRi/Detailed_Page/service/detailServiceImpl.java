// detailServiceImpl.java (Implementation)
package com.boot.YoRiZoRi.Detailed_Page.service;

import com.boot.YoRiZoRi.Detailed_Page.dao.detailDAO;
import com.boot.YoRiZoRi.Detailed_Page.dto.DetailDTO;
import com.boot.YoRiZoRi.Detailed_Page.dto.IngredientDTO;
import com.boot.YoRiZoRi.Detailed_Page.dto.ReviewDTO;
import com.boot.YoRiZoRi.Detailed_Page.dto.CommentDTO;
import com.boot.YoRiZoRi.Detailed_Page.dto.StepImageDTO;
import com.boot.YoRiZoRi.Recipe.dto.CategoryDTO;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class detailServiceImpl implements detailService {
    
    private final detailDAO detailedDAO;

    public detailServiceImpl(detailDAO detailedDAO) {
        this.detailedDAO = detailedDAO;
    }
    @Override
    @Transactional // 데이터베이스 변경 작업이므로 트랜잭션 처리
    public void deleteRecipe(int recipeId) {
        // DAO에 삭제 작업을 그대로 전달
        detailedDAO.deleteRecipeById(recipeId);
    }
    @Override
    public List<CategoryDTO> getAllCategories() {
        return detailedDAO.getAllCategories();
    }

    // 기존에 있던 메서드
    @Override
    @Transactional
    public DetailDTO getRecipeDetailWithHit(int id) {
        detailedDAO.incrementHit(id);
        DetailDTO detail = detailedDAO.getRecipeBaseInfo(id);
        if (detail != null) {
            detail.setIngredientList(detailedDAO.getIngredientList(id));
            detail.setStepList(detailedDAO.getStepImageList(id));
            detail.setCommentList(detailedDAO.getCommentList(id));
            detail.setReviewList(detailedDAO.getReviewList(id));

            // 평균 별점 계산
            double averageRating = detailedDAO.getAverageRating(id);
            detail.setAverage_rating(averageRating);
        }
        return detail;
    }

    // 아래 메서드 구현을 클래스 내부에 추가해주세요.
    // getRecipeDetailWithHit 메서드와 거의 동일하지만, 조회수 증가(incrementHit) 로직만 빠져있습니다.
    @Override
    public DetailDTO getRecipeDetailForUpdate(int id) {
        // 1. 조회수 증가 없이 기본 정보 조회
        DetailDTO detail = detailedDAO.getRecipeBaseInfo(id);
        
        if (detail != null) {
            // 2. 각 목록 데이터 조회 및 DetailDTO에 설정
            detail.setIngredientList(detailedDAO.getIngredientList(id));
            detail.setStepList(detailedDAO.getStepImageList(id));
            // (필요하다면) 댓글, 리뷰 목록도 여기서 가져올 수 있습니다.
        
            //  추가: 레시피에 연결된 카테고리 목록을 조회하여 DetailDTO에 설정
            detail.setCategoryList(detailedDAO.getRecipeCategories(id));
        }
        
        return detail;
    }
    
    // 업데이트 메서드 구현도 미리 추가해두세요. (다음 단계에서 사용됩니다)
    @Override
    @Transactional // 여러 DB 작업을 하나의 단위로 묶어 안전하게 처리
    public void updateRecipe(DetailDTO recipeDto) {
        // 이미지 파일 처리 로직은 여기에 추가해야 합니다.
        // 예를 들어, 새로운 mainImageFile이 업로드되었다면 서버에 저장하고
        // 그 경로를 recipeDto.setMainImage("새로운/경로.jpg")로 설정해줘야 합니다.
        // 새 파일이 없다면 기존 이미지 경로를 그대로 사용합니다.

        // 1단계: 레시피 기본 정보 업데이트 (RECIPE 테이블)
        detailedDAO.updateRecipeBase(recipeDto);

        // 2단계: 기존 재료 및 조리 순서 정보 모두 삭제
        detailedDAO.deleteIngredientsByRecipeId(recipeDto.getRecipeId());
        detailedDAO.deleteStepsByRecipeId(recipeDto.getRecipeId());
        
        //  추가: 기존 레시피 카테고리 정보 삭제
        detailedDAO.deleteRecipeCategoriesByRecipeId(recipeDto.getRecipeId());

        // Debugging: Log the received category IDs
        System.out.println("Received category IDs for update: " + recipeDto.getCategoryIds());

        // 3단계: 새로 제출된 재료 정보 다시 삽입 (RECIPE_INGREDIENT 테이블)
        if (recipeDto.getIngredientList() != null) {
            for (IngredientDTO submittedIngredient : recipeDto.getIngredientList()) {
                
                // 1. 재료 이름으로 DB에서 검색
                IngredientDTO existingIngredient = detailedDAO.findIngredientByName(submittedIngredient.getName());
                
                int finalIngredientId;
                
                if (existingIngredient != null) {
                    // 2-A. 있으면 그 ID 사용
                    finalIngredientId = existingIngredient.getIngredientId();
                } else {
                    // 2-B. 없으면 INGREDIENT 테이블에 새로 추가
                    detailedDAO.insertNewIngredient(submittedIngredient);
                    // 새로 추가 후 생성된 ID를 가져옴
                    finalIngredientId = submittedIngredient.getIngredientId();
                }
                
                // 3. 올바른 ID를 DTO에 설정
                submittedIngredient.setIngredientId(finalIngredientId);
                submittedIngredient.setRecipeId(recipeDto.getRecipeId());
                
                // 4. RECIPE_INGREDIENT 테이블에 최종 삽입
                detailedDAO.insertIngredient(submittedIngredient);
            }
        }
        
        //  추가: 새로 제출된 카테고리 정보 다시 삽입 (RECIPE_CATEGORY 테이블)
        if (recipeDto.getCategoryIds() != null) {
            for (Integer categoryId : recipeDto.getCategoryIds()) {
                detailedDAO.insertRecipeCategory(recipeDto.getRecipeId(), categoryId);
            }
        }

        // 4단계: 새로 제출된 조리 순서 정보 다시 삽입 (RECIPE_STEP 테이블)
        if (recipeDto.getStepList() != null) {
            for (StepImageDTO step : recipeDto.getStepList()) {
                // 각 조리 순서에 레시피 ID를 설정해줍니다.
                step.setRecipeId(recipeDto.getRecipeId());
                
                // 조리 순서 설명 삽입
                detailedDAO.insertStep(step);

                // 이미지가 있는 경우에만 이미지 정보 삽입
                if (step.getImageUrl() != null && !step.getImageUrl().isEmpty()) {
                    detailedDAO.insertStepImage(step);
                }
            }
        }
    }
    
    // ## 댓글 관련 메서드 구현 ##
    
    @Override
    public boolean insertComment(CommentDTO comment) {
        try {
            detailedDAO.insertComment(comment);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean updateComment(CommentDTO comment) {
        try {
            detailedDAO.updateComment(comment);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean deleteComment(int commentId) {
        try {
            detailedDAO.deleteComment(commentId);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean insertReply(CommentDTO comment) {
        try {
            detailedDAO.insertReply(comment);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public CommentDTO getCommentById(int commentId) {
        return detailedDAO.getCommentById(commentId);
    }
    
    // ## 후기 관련 메서드 구현 ##
    
    @Override
    public boolean insertReview(ReviewDTO review) {
        try {
            detailedDAO.insertReview(review);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean updateReview(ReviewDTO review) {
        try {
            detailedDAO.updateReview(review);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean deleteReview(int reviewId) {
        try {
            detailedDAO.deleteReview(reviewId);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public ReviewDTO getReviewById(int reviewId) {
        return detailedDAO.getReviewById(reviewId);
    }
    
    @Override
    public double getAverageRating(int recipeId) {
        return detailedDAO.getAverageRating(recipeId);
    }
    
    @Override
    public int getReviewCount(int recipeId) {
        return detailedDAO.getReviewCount(recipeId);
    }
    
    @Override
    public boolean isBookmarked(String memberId, int recipeId) {
        try {
            // detailMapper -> detailedDAO로 수정
            Integer count = detailedDAO.checkBookmark(memberId, recipeId);
            return count != null && count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean addBookmark(String memberId, int recipeId) {
        try {
            // detailMapper -> detailedDAO로 수정
            detailedDAO.insertBookmark(memberId, recipeId);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean removeBookmark(String memberId, int recipeId) {
        try {
            // detailMapper -> detailedDAO로 수정
            detailedDAO.deleteBookmark(memberId, recipeId);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    @Override
    public List<DetailDTO> getBookmarkList(String memberId) {
        return detailedDAO.getBookmarkList(memberId);
    }
}