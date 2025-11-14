package com.boot.YoRiZoRi.Detailed_Page.dto;

import java.sql.Date;
import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewDTO {
    // REVIEW 테이블 컬럼
    private int review_Id;
    private int recipe_Id;
    private String memberId;
    private String content;
    private int rating;     // 별점 (1~5)
    private String image;   // CLOB 또는 URL (String으로 처리)
    private Date createdat;
}