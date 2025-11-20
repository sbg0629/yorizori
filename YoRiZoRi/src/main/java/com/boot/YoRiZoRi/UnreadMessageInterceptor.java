package com.boot.YoRiZoRi;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.boot.YoRiZoRi.MY_Page.service.MessageService;

// 이 클래스가 Bean으로 등록되어야 @Autowired가 작동합니다.
@Component
public class UnreadMessageInterceptor implements HandlerInterceptor {

    @Autowired
    private MessageService messageService;

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
        
        // 뷰를 반환하지 않는 요청(API 호출, 리다이렉트 등)은 스킵하여 성능 저하 방지
        if (modelAndView == null || modelAndView.getViewName() == null || modelAndView.getViewName().startsWith("redirect:")) {
            return;
        }

        HttpSession session = request.getSession(false);
        String memberId = (session != null) ? (String) session.getAttribute("id") : null;

        if (memberId != null) {
            try {
                // Service를 통해 미확인 쪽지 개수 조회
                int count = messageService.getUnreadMessageCount(memberId);
                
                // Model에 추가하여 JSP의 ${unreadCount}로 접근 가능하게 함
                modelAndView.addObject("unreadCount", count);
            } catch (Exception e) {
                // DB 오류 발생 시 로그 기록 (TODO)
                modelAndView.addObject("unreadCount", 0); 
            }
        } else {
            // 비로그인 상태일 경우 0으로 설정
            modelAndView.addObject("unreadCount", 0);
        }
    }
}