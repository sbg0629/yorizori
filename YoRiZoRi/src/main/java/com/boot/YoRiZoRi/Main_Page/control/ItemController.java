package com.boot.YoRiZoRi.Main_Page.control;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.YoRiZoRi.MY_Page.dto.MyPageDTO;
import com.boot.YoRiZoRi.MY_Page.service.MyPageService;
import com.boot.YoRiZoRi.Main_Page.dto.ItemDTO;
import com.boot.YoRiZoRi.Main_Page.service.ItemService;
import com.boot.YoRiZoRi.common.dto.PageDTO;
import com.boot.YoRiZoRi.login.dto.MemDTO;
import com.boot.YoRiZoRi.login.service.MemService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ItemController {
	
	@Autowired // [추가] MyPageService 의존성 주입 (객체 생성)
    private MyPageService myPageService;
	
	@Autowired
	private ItemService service;
	
	@Autowired
	private MemService memService;	// 멤버 서비스 추가
	
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
	        
	        // [추가 1] 화면에서 보낸 검색어를 받는 파라미터 추가
	        @RequestParam(required = false) String keyword,
	        
	        Model model) {

	    log.info("order param: " + order);
	    log.info("category list: " + category);
	    log.info("page param: " + page);
	    log.info("keyword param: " + keyword); // 로그 확인용

	    Map<String, Object> paramMap = new HashMap<String, Object>();
	    paramMap.put("order", order);

	    if (category != null && !category.isEmpty()) {
	        paramMap.put("categoryList", category);
	    }

	    // [추가 2] 검색어가 있을 경우 맵에 담아줌 (XML의 #{keyword}로 전달됨)
	    if (keyword != null && !keyword.isEmpty()) {
	        paramMap.put("keyword", keyword);
	    }

	    // 페이징 처리를 위한 레시피 개수 조회 (검색어 조건 포함해서 계산됨)
	    int totalCount = service.getRecipeCount(paramMap);
	    
	    // 페이징 정보 생성 (16개씩, 4x4)
	    PageDTO pageDTO = new PageDTO(page, totalCount, 16, 10);
	    
	    // 페이징 파라미터 추가
	    paramMap.put("startRow", pageDTO.getStartRow());
	    paramMap.put("endRow", pageDTO.getEndRow());
	    
	    // 페이징된 레시피 목록 조회 (검색어 조건 포함해서 조회됨)
	    ArrayList<ItemDTO> dtoList = service.list_rating_paged(paramMap);
	    
	    model.addAttribute("recipeList", dtoList);
	    model.addAttribute("selectedCategories", category);
	    model.addAttribute("selectedOrder", order);
	    model.addAttribute("pageDTO", pageDTO);
	    
	    // [추가 3] 검색 후에도 입력창에 검색어가 남아있도록 모델에 추가
	    model.addAttribute("keyword", keyword);

	    return "recipe_list";
	}

	/**
	 * 메인 페이지 검색 처리
	 * 1. 검색 결과가 1개일 경우 -> 레시피 상세 페이지로 리다이렉트
	 * 2. 검색 결과가 0개 또는 2개 이상일 경우 -> 검색 결과 목록 페이지로 이동
	 */
//	@GetMapping("/search_result")
//	public String searchResult(@RequestParam("query") String query, Model model) {
//	    log.info("@# GET /search_result query={}", query);
//
//	    // 1. ItemService를 통해 레시피를 검색합니다.
//	    List<ItemDTO> results = service.searchRecipesByQuery(query); 
//
//	    if (results == null || results.isEmpty()) {
//	        // 2. 검색 결과가 없을 경우
//	        model.addAttribute("query", query);
//	        model.addAttribute("recipeList", new ArrayList<ItemDTO>());
//	        return "search_result"; // 빈 검색 결과 목록 페이지로 이동
//	        
//	    } else if (results.size() == 1) {
//	        // 3. 검색 결과가 정확히 1개일 경우, 상세 페이지로 리다이렉트
//	        ItemDTO singleResult = results.get(0);
//	        
//	        // ItemDTO에서 레시피 ID를 가져와야 합니다. 
//	        // getItemId() 대신 getRecipeId()를 사용하도록 수정합니다. 
//	        int recipeId = singleResult.getRecipeId(); // <-- 이 부분이 수정되었습니다.
//	        
//	        // 상세 페이지 URL로 리다이렉트
//	        // URL 파라미터는 itemId 대신 recipeId로 변경하는 것이 일관성에 맞을 수 있습니다.
//	        // 기존 Controller에서 recipe/detail?itemId=... 형식을 썼다면 그대로 유지하고,
//	        // JSP에서 recipe.recipeId를 사용했으므로, 여기서는 recipeId 변수명을 사용했습니다.
//	        return "redirect:/recipe/detail?itemId=" + recipeId;
//	        
//	    } else {
//	        // 4. 검색 결과가 2개 이상일 경우, 검색 결과 목록 페이지로 이동
//	        model.addAttribute("query", query);
//	        model.addAttribute("recipeList", results);
//	        return "search_result"; 
//	    }
//	}
	
	@RequestMapping("main_page")
	public String main_view() {
		return "page_main";
	}
	
	@RequestMapping("login_view")
	public String login_view() {
		return "login";
	}
	
    @RequestMapping("home")
    public String home(Model model, HttpSession session) {
        log.info("@# home() with random recipes and members");
        
     // ✅ [핵심 추가] 1. 로그인된 사용자 정보 조회 및 Model에 추가
        String memberId = (String) session.getAttribute("id");
        if (memberId != null) {
            // MyPageService를 사용하여 사용자 정보(profileImage 포함) 조회
            MyPageDTO userData = myPageService.getUserById(memberId); 
            
            // JSP에서 ${user.profileImage}로 접근할 수 있도록 Model에 추가
            model.addAttribute("user", userData); 
            log.info("@# Logged-in user profile loaded for HOME: {}", memberId);
        }

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