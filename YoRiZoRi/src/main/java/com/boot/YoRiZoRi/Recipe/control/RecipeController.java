package com.boot.YoRiZoRi.Recipe.control;

import java.util.List; // [추가]

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model; // [추가]
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.beans.propertyeditors.CustomNumberEditor;

import com.boot.YoRiZoRi.Recipe.dto.CategoryDTO;
import com.boot.YoRiZoRi.Recipe.dto.RecipeDTO;
import com.boot.YoRiZoRi.Recipe.service.RecipeService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping() // [수정] 컨트롤러 기본 경로 설정
public class RecipeController {
    
    @Autowired
    private RecipeService service;

    @Autowired
    private ServletContext servletContext;

    /**
     * [수정] 레시피 등록 페이지로 이동
     * DB에서 전체 카테고리 목록을 조회하여 Model에 담아 뷰로 전달합니다.
     */
    @RequestMapping(value="/write_recipe", method=RequestMethod.GET) // [수정] URL 및 메서드 방식 명시
    public String writeForm(Model model) {
        log.info("@# GET /recipe/write");
        
        // 서비스를 통해 모든 카테고리 목록을 가져온다.
        List<CategoryDTO> categories = service.getAllCategories();
        
        // 모델에 담아서 JSP로 전달한다. JSP에서는 "categories"라는 이름으로 이 목록을 사용할 수 있다.
        model.addAttribute("categories", categories);
        
        return "write_recipe"; // write_recipe.jsp 페이지를 보여줌
    }

    // 폼에서 빈 문자열로 넘어온 숫자 필드를 null로 처리하여 Integer 타입 변환 오류 방지
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Integer.class, new CustomNumberEditor(Integer.class, true));
    }

 // 레시피 폼 제출 처리
    @RequestMapping(value="/submit", method=RequestMethod.POST)
    public String submitRecipe(@ModelAttribute RecipeDTO recipeDTO, 
                               RedirectAttributes redirectAttributes,
                               HttpSession session) { // [수정] HttpSession 파라미터 추가
        
        log.info("@# POST /recipe/submit");

        // [추가] 1. 세션에서 로그인된 사용자 ID 가져오기
        String memberId = (String) session.getAttribute("id"); 
        
        // [추가] 2. (보안) 로그인이 안된 경우 처리
        if (memberId == null) {
            log.warn("@# 로그인되지 않은 사용자가 레시피 등록 시도.");
            // 로그인 페이지로 리다이렉트 (에러 메시지 포함)
            redirectAttributes.addFlashAttribute("msg", "로그인이 필요한 기능입니다.");
            return "redirect:/login"; // 로그인 페이지 경로로 변경하세요
        }

        try {
            // [추가] 3. DTO에 세션에서 가져온 사용자 ID 설정
            // (RecipeDTO에 setMemberId가 있다고 가정)
            recipeDTO.setMemberId(memberId); 

            // 웹 애플리케이션 내의 /resources/uploads 폴더의 실제 서버 경로를 찾음
            String uploadPath = "C:\\dev\\test_img";
            log.info("@# Upload Path: " + uploadPath);
            
            // 파일 처리 및 DB 저장을 모두 서비스 레이어에 위임
            // (이제 recipeDTO에는 memberId가 포함되어 있음)
            service.registerRecipe(recipeDTO, uploadPath);

            redirectAttributes.addFlashAttribute("msg", "레시피가 성공적으로 등록되었습니다.");
        
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("msg", "레시피 등록 중 오류가 발생했습니다.");
        }

        // 등록 성공/실패 여부와 관계없이 메인 페이지로 리다이렉트
        return "redirect:/home";
    }
}