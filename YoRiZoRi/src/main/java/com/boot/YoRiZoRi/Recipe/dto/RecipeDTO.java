package com.boot.YoRiZoRi.Recipe.dto;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RecipeDTO {
    
    // DB 테이블과 매칭되는 필드들
    private Integer id;
    private String memberId;
    private String title;
    private String description;
    private Integer servingSize;
    private Integer difficulty;
    private String cookingTime;
    private String mainImage; // DB에 저장될 '파일명'

    // 폼으로부터 '파일 데이터'를 받기 위한 필드
    private MultipartFile mainImageFile; 

    // 1:N 관계의 다른 DTO 리스트
    private List<IngredientDTO> ingredients;
    private List<StepDTO> steps;
    
    // [추가] 폼에서 선택된 카테고리 ID들을 받을 필드
    private Integer categoryId;
}