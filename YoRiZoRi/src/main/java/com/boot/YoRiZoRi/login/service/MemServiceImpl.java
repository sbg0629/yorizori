package com.boot.YoRiZoRi.login.service;

import java.util.ArrayList;
import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.boot.YoRiZoRi.login.dao.MemDAO;
import com.boot.YoRiZoRi.login.dto.MemDTO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemServiceImpl implements MemService {

    @Autowired
    private MemDAO memDAO;
    
    @Override
    public ArrayList<MemDTO> loginYn(HashMap<String, String> param) {
        log.info("@# MemServiceImpl.loginYn() start");
        return memDAO.loginYn(param);
    }
    
    @Override
    public void write(HashMap<String, String> param) {
        log.info("@# MemServiceImpl.write() start");
        param.putIfAbsent("PROFILE_IMAGE", "default_profile.jpg");
        memDAO.write(param);
    }

    @Override
    public MemDTO getMemberInfo(String memberId) {
        log.info("@# MemServiceImpl.getMemberInfo() start for ID: " + memberId);
        return memDAO.getMemberInfo(memberId);
    }
    
    @Override
    public int idCheck(String memberId) {
        log.info("@# MemServiceImpl.idCheck() for ID: " + memberId);
        return memDAO.idCheck(memberId);
    }

    @Override
    public int nicknameCheck(String nickname) {
        log.info("@# MemServiceImpl.nicknameCheck() for Nickname: " + nickname);
        return memDAO.nicknameCheck(nickname);
    }

    @Override
    public int emailCheck(String email) {
        log.info("@# MemServiceImpl.emailCheck() for Email: " + email);
        return memDAO.emailCheck(email);
    }

    @Override
    public int phoneCheck(String phoneNumber) {
        log.info("@# MemServiceImpl.phoneCheck() for Phone: " + phoneNumber);
        return memDAO.phoneCheck(phoneNumber);
    }
    
    @Override
    public int checkIdAndEmail(HashMap<String, String> param) {
        return memDAO.checkIdAndEmail(param);
    }
    
    @Override
    public void updatePassword(HashMap<String, String> param) {
        memDAO.updatePassword(param);
    }
    
    @Override
    public ArrayList<MemDTO> getRandomMembers() {
        log.info("@# MemServiceImpl.getRandomMembers() start");
        return memDAO.getRandomMembers();
    }
}