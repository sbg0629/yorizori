package com.boot.YoRiZoRi.login.control;

import java.util.ArrayList;
import java.util.HashMap;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.YoRiZoRi.Main_Page.dto.ItemDTO;
import com.boot.YoRiZoRi.Main_Page.service.ItemService;
import com.boot.YoRiZoRi.login.dto.MemDTO;
import com.boot.YoRiZoRi.login.service.MemService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import java.util.Random;

@Controller
@Slf4j
public class MemController {

    @Autowired
    private MemService memService;
    
    @Autowired
    private JavaMailSender mailSender;
    
    @Autowired
    private ItemService itemService;
    
    // 로그인 화면
    @RequestMapping("/login")
    public String login() {
        log.info("@# GET /login");
        return "login";
    }

    // 로그인 처리
    @RequestMapping("/login_yn")
    public String login_yn(HttpServletRequest request) { 
        log.info("@# POST /login_yn: " + request.getParameter("MEMBER_ID")+request.getParameter("admin_ck"));
        
        String id = request.getParameter("MEMBER_ID"); 
        String pw = request.getParameter("PASSWORD"); 
        
        HashMap<String, String> param = new HashMap<String, String>();
        param.put("MEMBER_ID", id);
        param.put("PASSWORD", pw);
        
        ArrayList<MemDTO> dtos = memService.loginYn(param);
        
        if (dtos == null || dtos.isEmpty()) {
            request.setAttribute("msg", "아이디 또는 비밀번호가 잘못 되었습니다.");
            request.setAttribute("url", "login");
            return "alert";
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("id", dtos.get(0).getMemberId());
            session.setAttribute("name", dtos.get(0).getName());
            session.setAttribute("admin", dtos.get(0).getAdminck());
            return "redirect:home";
        }
    }

    // 로그인 성공 화면
    @RequestMapping("/login_ok")
    public String login_ok(HttpSession session) {
        log.info("@# GET /login_ok, session ID: " + session.getAttribute("id"));
        return "login_ok";
    }

    // 회원가입 화면
    @RequestMapping("/register")
    public String register() {
        log.info("@# GET /register");
        return "register";
    }

    @PostMapping("/checkDuplicate")
    @ResponseBody
    public String checkDuplicate(@RequestParam("fieldType") String fieldType, @RequestParam("value") String value) {
        log.info("@# POST /checkDuplicate: fieldType={}, value={}", fieldType, value);
        int count = 0;
        
        switch (fieldType) {
            case "id":
                count = memService.idCheck(value);
                break;
            case "nickname":
                count = memService.nicknameCheck(value);
                break;
            case "email":
                count = memService.emailCheck(value);
                break;
            case "phone":
                count = memService.phoneCheck(value);
                break;
        }
        
        return (count == 0) ? "SUCCESS" : "FAIL";
    }

    @RequestMapping("/registerOk")
    public String registerOk(@RequestParam HashMap<String, String> param, HttpSession session, HttpServletRequest request) {
        log.info("@# POST /registerOk: " + param);

        if (memService.idCheck(param.get("MEMBER_ID")) > 0) {
            request.setAttribute("msg", "이미 사용 중인 아이디입니다.");
            request.setAttribute("url", "register");
            return "alert";
        }
        if (memService.nicknameCheck(param.get("NICKNAME")) > 0) {
            request.setAttribute("msg", "이미 사용 중인 닉네임입니다.");
            request.setAttribute("url", "register");
            return "alert";
        }
        if (memService.emailCheck(param.get("EMAIL")) > 0) {
            request.setAttribute("msg", "이미 등록된 이메일입니다.");
            request.setAttribute("url", "register");
            return "alert";
        }
        if (memService.phoneCheck(param.get("PHONE_NUMBER")) > 0) {
            request.setAttribute("msg", "이미 등록된 전화번호입니다.");
            request.setAttribute("url", "register");
            return "alert";
        }

        memService.write(param);
        
        session.setAttribute("id", param.get("MEMBER_ID"));
        session.setAttribute("name", param.get("NAME"));
        session.setAttribute("admin", param.get("ADMIN_CK"));
        
        return "redirect:home"; 
    }
    
    // 로그아웃
    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        log.info("@# GET /logout");
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        } 
        return "redirect:/login";
    }
    
    @RequestMapping("/forgot_password")
    public String pathfinder(HttpServletRequest request) {
        log.info("@# GET /forgot_password");
        return "forgot_password";
    }
    
    @RequestMapping("/member_profile")
    public String memberProfile(@RequestParam("id") String memberId, Model model) {
        log.info("@# member_profile() for ID: " + memberId);
        
        // 1. 회원 정보 조회
        MemDTO memberInfo = memService.getMemberInfo(memberId);
        model.addAttribute("memberInfo", memberInfo);
        
        // 2. 해당 회원이 작성한 레시피 조회
        ArrayList<ItemDTO> recipes = itemService.getRecipesByMemberId(memberId);
        model.addAttribute("recipes", recipes);
        
        // 3. 레시피 개수
        int recipeCount = recipes != null ? recipes.size() : 0;
        model.addAttribute("recipeCount", recipeCount);
        
        return "member_profile";
    }

    @PostMapping("/find/send-reset-code")
    @ResponseBody
    public String sendResetCode(@RequestParam("id") String id,
                                @RequestParam("email") String email, 
                                HttpSession session) {
        log.info("@# POST /find/send-reset-code: id={}, email={}", id, email);

        try {
            HashMap<String, String> param = new HashMap<>();
            param.put("MEMBER_ID", id);
            param.put("EMAIL", email);
            
            int count = memService.checkIdAndEmail(param);
            
            if (count == 0) {
                return "FAIL_NOT_FOUND";
            }

            String verificationCode = createVerificationCode();

            String mailContent = 
                "<div style='font-family: \"Noto Sans KR\", sans-serif; text-align: center; padding: 40px; border: 1px solid #eee; border-radius: 10px;'>" +
                "  <h1 style='color: #ff6f61; font-size: 28px;'>요리조리 비밀번호 찾기</h1>" +
                "  <p style='font-size: 16px; color: #333; margin-top: 20px;'>비밀번호 재설정을 위한 인증번호입니다.</p>" +
                "  <p style='font-size: 16px; color: #333;'>아래의 인증번호를 화면에 입력해 주세요.</p>" +
                "  <div style='background-color: #fffaf7; padding: 20px 0; margin: 30px 0; border-radius: 8px;'>" +
                "    <strong style='font-size: 24px; color: #ff6f61; letter-spacing: 2px;'>" + verificationCode + "</strong>" +
                "  </div>" +
                "  <p style='font-size: 14px; color: #888;'>* 본 인증번호는 5분간 유효합니다.</p>" +
                "</div>";

            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, "UTF-8");
            
            helper.setFrom("YOUR_GMAIL@gmail.com");
            helper.setTo(email);
            helper.setSubject("[요리조리] 비밀번호 찾기 인증번호입니다.");
            helper.setText(mailContent, true);

            mailSender.send(mimeMessage);

            session.setAttribute(email, verificationCode);
            session.setMaxInactiveInterval(300);

            return "SUCCESS";

        } catch (Exception e) {
            log.error("Error sending reset code: {}", e.getMessage());
            return "FAIL_SERVER_ERROR";
        }
    }

    @PostMapping("/find/reset-password")
    @ResponseBody
    public String resetPassword(@RequestParam("memberId") String id,
                                @RequestParam("email") String email,
                                @RequestParam("code") String code,
                                @RequestParam("newPassword") String newPassword,
                                HttpSession session) {
        
        log.info("@# POST /find/reset-password: id={}, email={}", id, email);

        try {
            String storedCode = (String) session.getAttribute(email);

            if (storedCode == null) {
                return "FAIL_SESSION";
            }

            if (!storedCode.equals(code)) {
                return "FAIL_CODE";
            }

            HashMap<String, String> param = new HashMap<>();
            param.put("MEMBER_ID", id);
            param.put("EMAIL", email);
            param.put("PASSWORD", newPassword);
            
            memService.updatePassword(param);

            session.removeAttribute(email);

            return "SUCCESS";

        } catch (Exception e) {
            log.error("Error resetting password: {}", e.getMessage());
            return "FAIL_SERVER_ERROR";
        }
    }

    private String createVerificationCode() {
        Random random = new Random();
        int number = 100000 + random.nextInt(900000);
        return String.valueOf(number);
    }
}