package com.boot.YoRiZoRi.Detailed_Page.control;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.YoRiZoRi.Detailed_Page.service.DeleteService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class DeleteController {
	
	@Autowired
	DeleteService service;
	
	@RequestMapping("/deleteReview")
	public String deleteReview(@RequestParam HashMap<String, String> param, HttpSession session) {
		String loginId = (String)session.getAttribute("id");
		
		if (loginId == null) {
			return "redirect:/login";
		}
		
		param.put("memberId", loginId);
		log.info("@# deleteReview() param: " + param);
		service.deleteReview(param);
		
		return "redirect:/detail.do?recipe_Id=" + param.get("recipe_Id");
	}
	
    @RequestMapping("/deleteComment")
    public String deleteComment(@RequestParam HashMap<String, String> param, HttpSession session) {
        String loginId = (String)session.getAttribute("id");
        
        if (loginId == null) {
        	return "redirect:/login";
        }
        
        param.put("memberId", loginId);
        log.info("@# deleteComment() param: " + param);
        service.deleteComment(param);

        return "redirect:/detail.do?recipe_Id=" + param.get("recipe_Id");
    }
}
