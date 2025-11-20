package com.boot.YoRiZoRi.Detailed_Page.dto;

import java.sql.Date;
import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommentDTO {
    // COMMENT_TB 테이블 컬럼
    private int comment_Id;
    private int ref_id;     // 원 댓글 ID (대댓글 처리용)
    private int cmt_step;   // 댓글 순서
    private int cmt_depth;  // 댓글 깊이
    private Integer recipe_Id; // RECIPE_ID (Integer 타입으로 null 허용 가능성 고려)
    private String memberId;
    private String content;
    private Date createdat;
    private String nickname;
}