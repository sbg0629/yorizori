package com.boot.YoRiZoRi.login.dto;

import java.sql.Date;
import lombok.Data;

@Data
// @AllArgsConstructor, @NoArgsConstructor는 DTO에서 종종 문제를 일으킬 수 있어, 
// 명확성을 위해 @Data만 사용하는 것을 권장합니다.
public class MemDTO {
    // [수정] DB 컬럼과 매끄럽게 연동하고 자바 표준을 따르기 위해 모든 필드를 camelCase로 변경
    private String memberId;
    private String name;
    private String password;
    private String nickname;
    private String email;
    private String profileImage;
    private String phoneNumber;
    private Date birthdate;
    private Integer gender;
    private Date joinDate;
    private int Adminck;
    private String socialType;
    private String socialId;
    
}