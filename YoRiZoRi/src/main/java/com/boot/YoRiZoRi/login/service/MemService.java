package com.boot.YoRiZoRi.login.service;

import java.util.ArrayList;
import java.util.HashMap;
import com.boot.YoRiZoRi.login.dto.MemDTO;

public interface MemService {
    
    // 기존 메소드
    ArrayList<MemDTO> loginYn(HashMap<String, String> param);
    MemDTO loginCheck(String memberId, String rawPassword);
    MemDTO getMemberInfo(String memberId); 
    
    void write(HashMap<String, String> param);
    // 중복 확인 서비스 메소드 추가
    int idCheck(String memberId);
    int nicknameCheck(String nickname);
    int emailCheck(String email);
    int phoneCheck(String phoneNumber);
    
    // 비밀번호 찾기
    int checkIdAndEmail(HashMap<String, String> param);
    void updatePassword(HashMap<String, String> param);
    
    // 랜덤 멤버 5명 조회
    ArrayList<MemDTO> getRandomMembers();
    
    
    
    MemDTO findOrCreateMember(HashMap<String, String> socialUserInfo);
}