package com.boot.YoRiZoRi.Detailed_Page.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class StepImageDTO {
    private int recipeId;
    
    // [수정] step_number -> stepNumber
    private int stepNumber; 
    
    private String instruction;
    
    // [수정] image_url -> imageUrl
    private String imageUrl; 
    
    private MultipartFile ImageFile;
}