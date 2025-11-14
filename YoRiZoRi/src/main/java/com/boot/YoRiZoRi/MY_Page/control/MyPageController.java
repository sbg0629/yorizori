package com.boot.YoRiZoRi.MY_Page.control;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.YoRiZoRi.MY_Page.dto.MyPageDTO;
import com.boot.YoRiZoRi.MY_Page.dto.MyRecipeDTO;
import com.boot.YoRiZoRi.MY_Page.service.MyPageService;


import lombok.extern.slf4j.Slf4j;
@Controller
@Slf4j
public class MyPageController {
	
	@Autowired
	private MyPageService service;
	
	
	@RequestMapping("/role")
	public String role(HttpServletRequest request,Model model) {
		log.info("@# role()");
	    HttpSession session = request.getSession(false); // false: 세션 없으면 null 반환
	    if(session == null || session.getAttribute("id") == null) {
	        // 로그인 안 되어 있으면 로그인 페이지로
	        return "redirect:login_view";
	    }
		
//		service = new ItemContentService();
//		service.execute(model);
//		ItemDAO dao = sqlSession.getMapper(ItemDAO.class);
		List<MyPageDTO> userData = service.list();
		model.addAttribute("userData", userData);
		
		return "role";
	}
	
//	   @RequestMapping("/list")
//	    public String list2(Model model) {
//	        log.info("@# list()");
//	        model.addAttribute("myPageList", service.list());
//	        return "list"; 
//	    }
//		@RequestMapping("/list")
//		public String list(@RequestParam("member_Id") String memberId, Model model) {
//		    MyPageDTO userData = service.getUserById(memberId); 
//		    model.addAttribute("user", userData);
//		    return "list"; 
//		}
//		
	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model) {
	    // 세션 가져오기
	    HttpSession session = request.getSession(false); // false: 세션 없으면 null 반환
	    if(session == null || session.getAttribute("id") == null) {
	        // 로그인 안 되어 있으면 로그인 페이지로
	        return "redirect:login_view";
	    }

	    String memberId = (String) session.getAttribute("id"); // 세션에서 아이디 가져오기
	    MyPageDTO userData = service.getUserById(memberId); 
	    model.addAttribute("user", userData);
	    return "list";
	}
	
//	@RequestMapping("/modify")
//	public String modify(@RequestParam HashMap<String, String> param, Model model) {
//		log.info("@# modify()"+param);
//		service.modify(param);
//		
//		// member_Id가 param에 있는지 확인 후 리다이렉트에 추가
//		String memberId = param.get("member_Id");
//		return "redirect:list?member_Id=" + memberId;
//	}
	@RequestMapping("/modify")
	public String modify(HttpServletRequest request, @RequestParam HashMap<String, String> param, Model model) {
	    // 세션 확인
	    HttpSession session = request.getSession(false);
	    if(session == null || session.getAttribute("id") == null) {
	        return "redirect:login_view";
	    }

	    // 세션에서 memberId 가져오기
	    String memberId = (String) session.getAttribute("id");

	    // 수정할 파라미터에 member_Id가 없으면 세션에서 넣기
	    if(!param.containsKey("member_Id")) {
	        param.put("member_Id", memberId);
	    }

	    log.info("@# modify() param: " + param);
	    service.modify(param);

	    // 수정 후 세션 기반 memberId로 list 페이지로 리다이렉트
	    return "redirect:list";
	}
		
		// 레시피 보여주기
		@RequestMapping("/myrecipe")
		public String myrecipe(@RequestParam("member_Id") String memberId, Model model) {
		    List<MyRecipeDTO> recipeData = service.getById(memberId); 
		    model.addAttribute("recipe", recipeData);
		    return "myrecipe"; 
		}
	   
	
	@RequestMapping("/mypage_edit") //수정창 
	public String edit(@RequestParam("member_Id") String memberId, Model model) {
	    MyPageDTO userData = service.getUserById(memberId); 
	    model.addAttribute("user", userData);
	    return "mypage_edit"; 
	}
	
	@RequestMapping("/delete") //수정 페이지 삭제
	public String delete(@RequestParam HashMap<String, String> param, Model model,
						 HttpServletRequest request) {
		log.info("@# delete() param: " + param);
	    String memberId = param.get("member_Id");
	    log.info("@# delete() member_Id: " + memberId);
	    service.delete(param);
	    
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        } 
		
		return "redirect:home";
	}
	
	@RequestMapping("/delete2") //관리자 페이지 삭제
	public String delete2(@RequestParam HashMap<String, String> param, Model model) {
		log.info("@# delete() param: " + param);
	    String memberId = param.get("member_Id");
	    log.info("@# delete() member_Id: " + memberId);
	    service.delete(param);
		
		return "redirect:role";
	}
}