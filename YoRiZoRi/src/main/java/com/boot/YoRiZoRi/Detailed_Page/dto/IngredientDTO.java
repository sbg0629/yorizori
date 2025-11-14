package com.boot.YoRiZoRi.Detailed_Page.dto;

import lombok.Data;

@Data 
public class IngredientDTO {
    private int recipeId; //  이 필드를 추가하세요.
    private int ingredientId;
    private String name;
    private String quantity;
}