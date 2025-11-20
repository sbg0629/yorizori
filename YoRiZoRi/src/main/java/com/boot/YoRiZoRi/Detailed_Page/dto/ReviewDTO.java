package com.boot.YoRiZoRi.Detailed_Page.dto;

import java.sql.Date;
import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
// [추가] 파일 업로드를 위한 import
import org.springframework.web.multipart.MultipartFile; 

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewDTO {
    // REVIEW 테이블 컬럼
    private int review_Id;
    
    // ✅ [수정 핵심] DTO에 폼에서 전송되는 이름(camelCase)을 추가하여 바인딩 오류를 해결합니다.
    private int recipeId; // JSP 폼 name="recipeId"와 매핑됨

    private int recipe_Id; // DB 컬럼명과 매핑됨 (MyBatis 설정에 따라 둘 중 하나만 사용할 수 있지만, 안전을 위해 추가)
    
    private String memberId;
    private String content;
    private int rating;     // 별점 (1~5)
    private String image;   // DB에 저장될 파일명/URL
    private Date createdat;
    private String nickname;
    
    // ✅ [추가] 이미지 파일 업로드용 필드
    private MultipartFile imageFile; 
}