package com.boot.YoRiZoRi.Detailed_Page.dto;

import java.sql.Date;
import java.util.ArrayList; // 1. ArrayList를 import 합니다.
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.web.multipart.MultipartFile;

import com.boot.YoRiZoRi.Recipe.dto.CategoryDTO;

import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DetailDTO {
    // 1. Recipe 기본 정보
    private int recipeId;
    private String memberId;
    private String title;
    private String description;
    private int servingSize;
    private String mainImage;
    private Date createdat;
    private int difficulty;
    private String cookingTime;
    private int hit;
    private int comment_count;
    private double average_rating;
    private Date bookmarked_at;	
    private String nickname;

    // 추가: 폼에서 전송되는 카테고리 ID 목록을 받기 위한 필드
    private List<Integer> categoryIds;
    private Integer categoryId;
    private MultipartFile mainImageFile;

    // 2. 부가 정보 (목록)
    private List<CategoryDTO> categoryList = new ArrayList<>();
    private List<IngredientDTO> ingredientList = new ArrayList<>(); // 2. 리스트를 생성(초기화)합니다.
    private List<StepImageDTO> stepList = new ArrayList<>();       // 3. 리스트를 생성(초기화)합니다.
    private List<CommentDTO> commentList = new ArrayList<>();
    private List<ReviewDTO> reviewList = new ArrayList<>();
    
    public Set<Integer> getCategoryIdsSet() {
        Set<Integer> ids = new HashSet<Integer>();
        // categoryList가 null일 경우를 대비해 NullPointerException 방지
        if (this.categoryList != null) {
            for (CategoryDTO category : this.categoryList) {
                ids.add(category.getCategoryId());
            }
        }
        return ids;
    }
}