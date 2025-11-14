package com.boot.YoRiZoRi.MY_Page.service;

import java.util.HashMap;
import java.util.List;

import com.boot.YoRiZoRi.MY_Page.dto.MyPageDTO;
import com.boot.YoRiZoRi.MY_Page.dto.MyRecipeDTO;

public interface MyPageService {

	 List<MyPageDTO> list();
	 MyPageDTO getUserById(String memberId); 
	List<MyRecipeDTO> getById(String memberId);
	public void modify(HashMap<String, String> param);
	public void delete(HashMap<String, String> param);
}