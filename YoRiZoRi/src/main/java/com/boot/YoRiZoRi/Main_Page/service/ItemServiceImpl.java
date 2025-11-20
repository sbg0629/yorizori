package com.boot.YoRiZoRi.Main_Page.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.YoRiZoRi.Main_Page.dao.ItemDAO;
import com.boot.YoRiZoRi.Main_Page.dto.ItemDTO;


@Service
public class ItemServiceImpl implements ItemService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<ItemDTO> list() {
		ItemDAO dao = sqlSession.getMapper(ItemDAO.class);
		ArrayList<ItemDTO> dto = dao.list();
		
		return dto;
	}

	@Override
	public void write(HashMap<String, String> param) {
		ItemDAO dao = sqlSession.getMapper(ItemDAO.class);
		dao.write(param);
		
	}

//	@Override
//	public ArrayList<ItemDTO> list_rating(HashMap<String, String> param) {
//		ItemDAO dao = sqlSession.getMapper(ItemDAO.class);
//		ArrayList<ItemDTO> dto = dao.list
//				
//				return dto;
//	}
	@Override
	public ArrayList<ItemDTO> list_rating(Map<String, Object> param) {
	    String order = (String) param.get("order");
	    if (!("hit".equals(order) || "rating".equals(order))) {
	        order = "hit";
	        param.put("order", order);
	    }
	    // categoryList는 MyBatis에서 바로 사용하므로 따로 처리할 필요 없음

	    ItemDAO dao = sqlSession.getMapper(ItemDAO.class);
	    return dao.list_rating(param);
	}

	@Override
    public ArrayList<ItemDTO> getRandomRecipes() {
        // log.info("@# getRandomRecipes()"); // 로그 사용시
        ItemDAO dao = sqlSession.getMapper(ItemDAO.class);
        return dao.getRandomRecipes();
    }
	@Override
	public ArrayList<ItemDTO> getRecipesByMemberId(String memberId) {
		ItemDAO dao = sqlSession.getMapper(ItemDAO.class);
	    return dao.getRecipesByMemberId(memberId);
	}

	@Override
	public int getRecipeCountByMemberId(String memberId) {
		ItemDAO dao = sqlSession.getMapper(ItemDAO.class);
	    return dao.getRecipeCountByMemberId(memberId);
	}
	
	@Override
    public ItemDTO findRecipeByName(String title) {
        ItemDAO dao = sqlSession.getMapper(ItemDAO.class);
        return dao.findRecipeByName(title);
    }
	
	@Override
	public ArrayList<ItemDTO> list_rating_paged(Map<String, Object> param) {
		String order = (String) param.get("order");
		if (!("hit".equals(order) || "rating".equals(order) || "latest".equals(order))) {
			order = "hit";
			param.put("order", order);
		}
		ItemDAO dao = sqlSession.getMapper(ItemDAO.class);
		return dao.list_rating_paged(param);
	}
	
	@Override
	public int getRecipeCount(Map<String, Object> param) {
		ItemDAO dao = sqlSession.getMapper(ItemDAO.class);
		return dao.getRecipeCount(param);
	}

//	@Override
//	public List<ItemDTO> searchRecipesByQuery(String query) {
//		ItemDAO dao = sqlSession.getMapper(ItemDAO.class);
//		// ItemDAO를 통해 데이터베이스 검색 메서드를 호출하고 결과를 반환합니다.
//		return dao.searchRecipesByQuery(query);
//	}
}
