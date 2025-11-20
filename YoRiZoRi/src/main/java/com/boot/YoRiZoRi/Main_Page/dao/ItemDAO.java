package com.boot.YoRiZoRi.Main_Page.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.boot.YoRiZoRi.Main_Page.dto.ItemDTO;


public interface ItemDAO {
	public ArrayList<ItemDTO> list_rating(Map<String, Object> param);
	public ArrayList<ItemDTO> list();
	public void write(HashMap<String, String> param);
	
	public ArrayList<ItemDTO> getRandomRecipes();
	
	// 특정 회원이 작성한 레시피 조회
	ArrayList<ItemDTO> getRecipesByMemberId(String memberId);

	// 특정 회원의 레시피 개수 조회
	int getRecipeCountByMemberId(String memberId);
	
	public ItemDTO findRecipeByName(String title);
	
	// 페이징 처리를 위한 레시피 목록 조회
	ArrayList<ItemDTO> list_rating_paged(Map<String, Object> param);
	
	// 페이징 처리를 위한 레시피 개수 조회
	int getRecipeCount(Map<String, Object> param);
	
//	//검색
//	public List<ItemDTO> searchRecipesByQuery(String query);
}
