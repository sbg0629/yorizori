// detailServiceImpl.java (Implementation)
package com.boot.YoRiZoRi.Detailed_Page.service;

import com.boot.YoRiZoRi.Detailed_Page.dao.detailDAO;
import com.boot.YoRiZoRi.Detailed_Page.dto.DetailDTO;
import com.boot.YoRiZoRi.Detailed_Page.dto.IngredientDTO;
import com.boot.YoRiZoRi.Detailed_Page.dto.ReviewDTO;
import com.boot.YoRiZoRi.Detailed_Page.dto.CommentDTO;
import com.boot.YoRiZoRi.Detailed_Page.dto.StepImageDTO;
import com.boot.YoRiZoRi.Recipe.dto.CategoryDTO;

import lombok.extern.slf4j.Slf4j;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;


@Slf4j
@Service
public class detailServiceImpl implements detailService {
    
    private final detailDAO detailedDAO;
    
    private final String UPLOAD_DIR = "C:\\dev\\test_img";

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
    
    private String saveFile(MultipartFile file) throws Exception {
        if (file == null || file.isEmpty()) { 
            return null; 
        }
        String originalFilename = file.getOriginalFilename();
        String savedFilename = UUID.randomUUID().toString() + "_" + originalFilename;
        File uploadDir = new File(UPLOAD_DIR);
        if (!uploadDir.exists()) { 
            uploadDir.mkdirs(); 
        }
        File dest = new File(UPLOAD_DIR, savedFilename);
        file.transferTo(dest);
        return savedFilename;
    }
    
    private void deleteFile(String fileName) {
        if (fileName != null && !fileName.isEmpty() && !fileName.equals("default_main.jpg")) {
            File file = new File(UPLOAD_DIR, fileName);
            if (file.exists()) {
                if (file.delete()) {
                    log.info("파일 삭제 성공: {}", fileName);
                } else {
                    log.warn("파일 삭제 실패: {}", fileName);
                }
            } else {
                log.warn("파일이 존재하지 않음: {}", fileName);
            }
        }
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
    
 // 업데이트 메서드 구현
    @Override
    @Transactional 
    public void updateRecipe(DetailDTO recipeDto) {
        
        // ==========================================================
        // ✅ [1단계] 메인 이미지 파일 처리 로직
        // ==========================================================
        try {
            // MultipartFile 필드명: mainImageFile
            MultipartFile newMainImage = recipeDto.getMainImageFile(); 
            
            if (newMainImage != null && !newMainImage.isEmpty()) {
                // 1. 새 파일이 업로드된 경우: 기존 파일 삭제
                String oldMainImageName = recipeDto.getMainImage();
                deleteFile(oldMainImageName); 
                
                // 2. 새 파일 저장
                String newMainImageName = saveFile(newMainImage);
                
                // 3. DTO에 새 파일명 설정 (DB 업데이트를 위해)
                recipeDto.setMainImage(newMainImageName);
                
            } else {
                // 새 파일이 없는 경우: 기존 파일명 유지 (JSP의 hidden 필드에서 이미 DTO에 설정되어 있음)
                log.info("메인 이미지 파일 변경 없음. 기존 파일명 유지: {}", recipeDto.getMainImage());
            }
        } catch (Exception e) {
            log.error("메인 이미지 파일 처리 중 오류 발생", e);
            throw new RuntimeException("메인 이미지 파일 처리 실패", e);
        }
        
        // 2단계: 레시피 기본 정보 업데이트 (RECIPE 테이블)
        detailedDAO.updateRecipeBase(recipeDto);
        log.info("레시피 기본 정보 업데이트 완료: {}", recipeDto.getRecipeId());


        // 3단계: 기존 재료, 순서, 카테고리 정보 모두 삭제 (새로운 정보로 대체하기 위함)
        detailedDAO.deleteIngredientsByRecipeId(recipeDto.getRecipeId());
        detailedDAO.deleteStepsByRecipeId(recipeDto.getRecipeId());
        detailedDAO.deleteRecipeCategoriesByRecipeId(recipeDto.getRecipeId());
        log.info("기존 재료/순서/카테고리 정보 삭제 완료.");


        // 4단계: 새로 제출된 재료 정보 다시 삽입
        // 필드명: ingredientList
        if (recipeDto.getIngredientList() != null) {
            for (IngredientDTO submittedIngredient : recipeDto.getIngredientList()) {
                
                IngredientDTO existingIngredient = detailedDAO.findIngredientByName(submittedIngredient.getName());
                int finalIngredientId;
                
                if (existingIngredient != null) {
                    finalIngredientId = existingIngredient.getIngredientId();
                } else {
                    detailedDAO.insertNewIngredient(submittedIngredient);
                    finalIngredientId = submittedIngredient.getIngredientId();
                }
                
                submittedIngredient.setIngredientId(finalIngredientId);
                submittedIngredient.setRecipeId(recipeDto.getRecipeId());
                
                detailedDAO.insertIngredient(submittedIngredient);
            }
            log.info("재료 {}개 삽입 완료.", recipeDto.getIngredientList().size());
        }
        
        // 5단계: 새로 제출된 카테고리 정보 다시 삽입
        // 필드명: categoryIds (List<Integer>)
        if (recipeDto.getCategoryIds() != null) {
            for (Integer categoryId : recipeDto.getCategoryIds()) {
                Map<String, Integer> params = new HashMap<>();
                params.put("recipeId", recipeDto.getRecipeId());
                params.put("categoryId", categoryId);
                
                // [수정] DAO 메서드가 인수를 Map으로 받는지 확인 필요. 
                // 현재는 DAO 메서드가 두 개의 Integer 인수를 받도록 가정하고 코드를 작성합니다.
                detailedDAO.insertRecipeCategory(recipeDto.getRecipeId(), categoryId); 
            }
            log.info("카테고리 {}개 삽입 완료.", recipeDto.getCategoryIds().size());
        }

        // 6단계: 새로 제출된 조리 순서 정보 다시 삽입 및 파일 처리
        // 필드명: stepList
        if (recipeDto.getStepList() != null) {
            for (StepImageDTO step : recipeDto.getStepList()) {
                
                try {
                    step.setRecipeId(recipeDto.getRecipeId());
                    
                    // MultipartFile 필드명: imageFile
                    MultipartFile newStepImage = step.getImageFile(); 
                    // String 필드명: imageUrl
                    String oldStepImageUrl = step.getImageUrl(); 
                    
                    // 1. 새 파일이 업로드되었는지 확인
                    if (newStepImage != null && !newStepImage.isEmpty()) {
                        // 1-A. 기존 파일이 있으면 삭제
                        deleteFile(oldStepImageUrl);
                        
                        // 1-B. 새 파일 저장
                        String newStepImageName = saveFile(newStepImage);
                        
                        // 1-C. DTO에 새 파일명 설정 (DB 삽입을 위해)
                        step.setImageUrl(newStepImageName);
                        
                    } else if (step.getImageUrl() != null && !step.getImageUrl().isEmpty()) {
                        // 2. 새 파일은 없지만 기존 파일명이 DTO에 남아있으면 (유지)
                        //    -> 별다른 DTO 변경 없이 DB에 삽입 로직 진행
                        
                    } else {
                        // 3. 새 파일도 없고 기존 파일명도 없으면 (삭제 요청 또는 원래 없었음)
                        step.setImageUrl(null); // DB에 null 값 삽입
                    }
                } catch (Exception e) {
                    log.error("조리 순서 이미지 파일 처리 중 오류 발생", e);
                    throw new RuntimeException("조리 순서 이미지 파일 처리 실패", e);
                }
                
                // 조리 순서 설명 삽입
                detailedDAO.insertStep(step);

                // 이미지가 있는 경우에만 이미지 정보 삽입 (새 파일명이든 기존 파일명이든)
                if (step.getImageUrl() != null && !step.getImageUrl().isEmpty()) {
                    detailedDAO.insertStepImage(step);
                }
            }
            log.info("조리 순서 {}개 삽입 완료.", recipeDto.getStepList().size());
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
    @Transactional
    @Override
    public boolean insertReview(ReviewDTO review) {
    	
    	if (review.getRecipe_Id() == 0 && review.getRecipeId() != 0) {
            review.setRecipe_Id(review.getRecipeId());
        }
    	// 2. ✅ [핵심] 파일 처리 로직
        try {
            MultipartFile imageFile = review.getImageFile();
            
            if (imageFile != null && !imageFile.isEmpty()) {
                String savedFileName = saveFile(imageFile);
                review.setImage(savedFileName); // DTO의 image 필드에 저장된 파일명 설정
            } else {
                review.setImage(null); // 파일이 없으면 DB에 NULL 저장
            }
        } catch (Exception e) {
            // [TODO] log.error("후기 이미지 파일 저장 실패", e);
            throw new RuntimeException("후기 이미지 파일 저장 실패", e); // 트랜잭션 롤백 유도
        }
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