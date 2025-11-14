package com.boot.YoRiZoRi.Detailed_Page.service;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.YoRiZoRi.Detailed_Page.dao.DeleteDAO;

@Service
public class DeleteServiceImpl implements DeleteService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void deleteReview(HashMap<String, String> param) {
		DeleteDAO dao = sqlSession.getMapper(DeleteDAO.class);
		dao.deleteReview(param);
	}

	@Override
	public void deleteComment(HashMap<String, String> param) {
		DeleteDAO dao = sqlSession.getMapper(DeleteDAO.class);
		dao.deleteComment(param);
		
	}
	
}
