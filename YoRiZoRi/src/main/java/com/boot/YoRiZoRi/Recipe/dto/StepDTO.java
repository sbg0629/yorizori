package com.boot.YoRiZoRi.Recipe.dto;

import org.springframework.web.multipart.MultipartFile;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StepDTO {

    // DB 테이블과 매칭되는 필드들
    private Integer id;          // 스텝 자체의 PK (현재 테이블 구조에는 없음)
    private Integer recipeId;    // 외래키 (recipe.recipe_id)
    private Integer stepNumber;
    private String instruction;
    private String image;       // DB에 저장될 '파일명'

    // 폼으로부터 '파일 데이터'를 받기 위한 필드
    private MultipartFile imageFile;
}