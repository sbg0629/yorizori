package com.boot.YoRiZoRi.Main_Page.control;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.YoRiZoRi.Main_Page.dto.ItemDTO;
import com.boot.YoRiZoRi.Main_Page.service.ItemService;
import com.boot.YoRiZoRi.common.dto.PageDTO;
import com.boot.YoRiZoRi.login.dto.MemDTO;
import com.boot.YoRiZoRi.login.service.MemService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ItemController {
	
	@Autowired
	private ItemService service;
	
	@Autowired
	private MemService memService;  // 멤버 서비스 추가
	
	// 상품 목록 조회
	@RequestMapping("/content_view")
	public String list(Model model) {
		log.info("@# content_view()");
		
		ArrayList<ItemDTO> dto = service.list();
		model.addAttribute("content_view", dto);
		
		return "content_view";
	}
	
	// 상품 등록
	@RequestMapping("/write_result")
	public String write_result(@RequestParam HashMap<String, String> param, Model model) {
		log.info("@# write_result()");
		service.write(param);
		
		return "write_result";
	}
	
	@RequestMapping("/write_view")
	public String write_view() {
		log.info("@# write_view()");
		
		return "item_write";
	}
	
	// 카테고리 jsp 이동
	@RequestMapping("/category_view")
	public String category_view() {
		log.info("@# category_view()");
		
		return "category";
	}
	
	@GetMapping("/select_result") 
	public String select_view(
	        @RequestParam(required = false) List<String> category,
	        @RequestParam(required = false, defaultValue = "hit") String order,
	        @RequestParam(required = false, defaultValue = "1") int page,
	        Model model) {

	    log.info("order param: " + order);
	    log.info("category list: " + category);
	    log.info("page param: " + page);

	    Map<String, Object> paramMap = new HashMap<String, Object>();
	    paramMap.put("order", order);

	    if (category != null && !category.isEmpty()) {
	        paramMap.put("categoryList", category);
	    }

	    // 페이징 처리를 위한 레시피 개수 조회
	    int totalCount = service.getRecipeCount(paramMap);
	    
	    // 페이징 정보 생성 (16개씩, 4x4)
	    PageDTO pageDTO = new PageDTO(page, totalCount, 16, 10);
	    
	    // 페이징 파라미터 추가
	    paramMap.put("startRow", pageDTO.getStartRow());
	    paramMap.put("endRow", pageDTO.getEndRow());
	    
	    // 페이징된 레시피 목록 조회
	    ArrayList<ItemDTO> dtoList = service.list_rating_paged(paramMap);
	    
	    model.addAttribute("recipeList", dtoList);
	    model.addAttribute("selectedCategories", category);
	    model.addAttribute("selectedOrder", order);
	    model.addAttribute("pageDTO", pageDTO);

	    return "recipe_list";
	}
	
	@RequestMapping("main_page")
	public String main_view() {
		return "page_main";
	}
	
	@RequestMapping("login_view")
	public String login_view() {
		return "login";
	}
	
    @RequestMapping("home")
    public String home(Model model) {
        log.info("@# home() with random recipes and members");

        // 1. 랜덤 레시피 조회
        ArrayList<ItemDTO> randomList = service.getRandomRecipes(); 
        
        if (randomList == null) {
            log.info("@# [ERROR] randomList is NULL");
        } else {
            log.info("@# Found random recipes (size): " + randomList.size());
        }
        
        model.addAttribute("randomRecipes", randomList);
        
        // 2. 랜덤 멤버 5명 조회 (추가)
        ArrayList<MemDTO> randomMembers = memService.getRandomMembers();
        
        if (randomMembers == null) {
            log.info("@# [ERROR] randomMembers is NULL");
        } else {
            log.info("@# Found random members (size): " + randomMembers.size());
        }
        
        model.addAttribute("randomMembers", randomMembers);
        
        return "home";
    }
}