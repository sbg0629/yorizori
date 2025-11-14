package com.boot.YoRiZoRi.MY_Page.dto;

import java.sql.Date;
import lombok.Data;

@Data
public class MyRecipeDTO {
    // [수정] 모든 필드를 자바 표준인 camelCase로 변경
    private int recipeId;
    private String memberId;
    private String title;
    private String description;
    private String servingSize;
    private String mainImage;
    private Date createAt;
    private String cookingTime;
    private int difficulty;
    private int hit;
    private int commentCount;
}