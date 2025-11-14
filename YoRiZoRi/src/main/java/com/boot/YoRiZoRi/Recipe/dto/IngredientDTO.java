package com.boot.YoRiZoRi.Recipe.dto;

import lombok.Data;

@Data
public class IngredientDTO {
    
    private Integer ingredientId; 
    
    private Integer recipeId;
    
    private String name;
    private String quantity;
}