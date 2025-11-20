package com.boot.YoRiZoRi.MY_Page.dto;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MyPageDTO {
    // [수정] 모든 필드를 자바 표준인 camelCase로 변경
    private String memberId;
    private String password;
    private String name;
    private String nickname;
    private String email;
    private String profileImage;
    private String phoneNumber;
    private Date birthdate;
//    private Integer gender;
    
    private MultipartFile profileImageFile;
}