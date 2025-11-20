package com.boot.YoRiZoRi.MY_Page.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.transaction.Transactional;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.boot.YoRiZoRi.MY_Page.dao.MyPageDAO;
import com.boot.YoRiZoRi.MY_Page.dto.MyPageDTO;
import com.boot.YoRiZoRi.MY_Page.dto.MyRecipeDTO;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class MyPageServiceImpl implements MyPageService {
	@Autowired
	private SqlSession sqlSession;
	
	private final String UPLOAD_DIR = "C:\\dev\\test_img";
	
	
	   @Override
	    public List<MyPageDTO> list() {
	        MyPageDAO dao = sqlSession.getMapper(MyPageDAO.class);
	        return dao.list();
	    }
	
	   
	   private String saveFile(MultipartFile file) throws Exception {
	        if (file == null || file.isEmpty()) { 
	            return null; 
	        }
	        String originalFilename = file.getOriginalFilename();
	        String savedFilename = UUID.randomUUID().toString() + "_" + originalFilename;
	        File uploadDir = new File(UPLOAD_DIR);
	        if (!uploadDir.exists()) { 
	            uploadDir.mkdirs(); 
	        }
	        File dest = new File(UPLOAD_DIR, savedFilename);
	        file.transferTo(dest);
	        return savedFilename;
	    }
	    
	    /**
	     * 기존 파일을 삭제합니다. (기본 이미지는 삭제하지 않음)
	     */
	    private void deleteFile(String fileName) {
	        // 기본 프로필 이미지 이름이 'default_profile.png'라고 가정
	        if (fileName != null && !fileName.isEmpty() && !fileName.equals("default_profile.png")) {
	            File file = new File(UPLOAD_DIR, fileName);
	            if (file.exists()) {
	                if (file.delete()) {
	                    log.info("프로필 파일 삭제 성공: {}", fileName);
	                } else {
	                    log.warn("프로필 파일 삭제 실패: {}", fileName);
	                }
	            } else {
	                log.warn("프로필 파일이 존재하지 않음: {}", fileName);
	            }
	        }
	    }
	    @Override
		@Transactional 
		public void modify(MyPageDTO myPageDTO) {
			MyPageDAO dao = sqlSession.getMapper(MyPageDAO.class);
			
			// 1. 프로필 이미지 파일 처리 로직
			try {
			    MultipartFile newProfileImage = myPageDTO.getProfileImageFile();
			    
			    if (newProfileImage != null && !newProfileImage.isEmpty()) {
			        // 1-A. 새 파일이 업로드된 경우: 기존 파일 삭제
			        // profileImage 필드에 기존 파일명이 담겨있다고 가정 (hidden 필드 사용)
			        String oldProfileImageName = myPageDTO.getProfileImage();
			        deleteFile(oldProfileImageName); 
			        
			        // 1-B. 새 파일 저장
			        String newProfileImageName = saveFile(newProfileImage);
			        
			        // 1-C. DTO에 새 파일명 설정 (DB 업데이트를 위해)
			        myPageDTO.setProfileImage(newProfileImageName);
			        log.info("새 프로필 이미지 저장 완료: {}", newProfileImageName);
			    } else {
			        // 새 파일이 없는 경우: 기존 파일명 유지
			        log.info("프로필 이미지 파일 변경 없음. 기존 파일명 유지: {}", myPageDTO.getProfileImage());
			    }
			} catch (Exception e) {
			    log.error("프로필 이미지 파일 처리 중 오류 발생", e);
			    throw new RuntimeException("프로필 이미지 파일 처리 실패", e);
			}
			
			// 2. DB 정보 업데이트 (DAO 호출)
			dao.modify(myPageDTO);
		}

	@Override
	public void delete(HashMap<String, String> param) {
		MyPageDAO dao = sqlSession.getMapper(MyPageDAO.class);
//		dao.delete(request.getParameter("boardNo"));
		dao.delete(param);
	}

	@Override
	public MyPageDTO getUserById(String memberId) {
	    MyPageDAO dao = sqlSession.getMapper(MyPageDAO.class);
	    return dao.getUserById(memberId);
	}

	@Override
	public List<MyRecipeDTO> getById(String memberId) {
		MyPageDAO dao = sqlSession.getMapper(MyPageDAO.class);
		    return dao.getById(memberId);
	}

}