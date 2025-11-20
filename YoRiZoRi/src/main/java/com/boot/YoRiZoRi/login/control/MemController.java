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
import com.boot.YoRiZoRi.login.google.dto.GoogleUserInfo;
import com.boot.YoRiZoRi.login.google.service.GoogleOAuthService;
import com.boot.YoRiZoRi.login.kakao.dto.KakaoUserInfo;
import com.boot.YoRiZoRi.login.kakao.service.KakaoOAuthService;
import com.boot.YoRiZoRi.login.naver.dto.NaverUserInfo;
import com.boot.YoRiZoRi.login.naver.service.NaverOAuthService;
import com.boot.YoRiZoRi.login.service.MemService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import java.util.Random;

@Controller
@Slf4j
public class MemController {

	
	@Autowired
	private NaverOAuthService naverOAuthService; 

	@Autowired
	private GoogleOAuthService googleOAuthService;

    // 카카오 서비스 주입 추가
    @Autowired
    private KakaoOAuthService kakaoOAuthService;
	
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
        log.info("@# POST /login_yn: " + request.getParameter("MEMBER_ID"));
       
        String id = request.getParameter("MEMBER_ID");
        String pw = request.getParameter("PASSWORD");
      
        
        MemDTO member = memService.loginCheck(id, pw); 
        

        if (member == null) { // 로그인 실패
            request.setAttribute("msg", "아이디 또는 비밀번호가 잘못 되었습니다.");
            request.setAttribute("url", "login");
            return "alert";
        } else { // 로그인 성공
            HttpSession session = request.getSession();
            session.setAttribute("id", member.getMemberId());
            session.setAttribute("name", member.getName());
            session.setAttribute("admin", member.getAdminck());
            return "redirect:home";
        }
    }
    
    

	// 구글 소셜 로그인 콜백
	@RequestMapping("/login/oauth2/code/google")
	public String googleCallback(@RequestParam String code, HttpServletRequest request) {
		log.info("@# GET /login/oauth2/code/google, code={}", code);

		try {
			String accessToken = googleOAuthService.getGoogleAccessToken(code);
			GoogleUserInfo googleUserInfo = googleOAuthService.getGoogleUserInfo(accessToken);

			HashMap<String, String> userInfo = new HashMap<>();
			userInfo.put("socialType", "google");
			userInfo.put("socialId", googleUserInfo.getId());
			userInfo.put("EMAIL", googleUserInfo.getEmail());
			userInfo.put("NAME", googleUserInfo.getName());

			String nickname = googleUserInfo.getName();
			if (nickname == null || nickname.trim().isEmpty()) {
				nickname = googleUserInfo.getEmail().split("@")[0];
			}
			userInfo.put("NICKNAME", nickname);

			MemDTO socialMember = memService.findOrCreateMember(userInfo);

			if (socialMember == null) {
				request.setAttribute("msg", "이미 해당 이메일로 가입된 계정이 있습니다.");
				request.setAttribute("url", "login");
				return "login_page/alert";
			}

			HttpSession session = request.getSession();
			session.setAttribute("id", socialMember.getMemberId());
			session.setAttribute("name", socialMember.getName());
			session.setAttribute("admin", socialMember.getAdminck());

			return "redirect:/home";

		} catch (Exception e) {
			log.error("@# 구글 로그인 처리 중 예외 발생: {}", e.getMessage());
			request.setAttribute("msg", "소셜 로그인 중 오류가 발생했습니다. 관리자에게 문의하세요.");
			request.setAttribute("url", "login");
			return "login_page/alert";
		}
	}
	
	
	
	// 카카오 소셜 로그인 콜백 (최종 수정)
    @RequestMapping("/oauth2/callback/kakao")
    public String kakaoCallback(@RequestParam String code, HttpServletRequest request) {
        log.info("@# GET /login/oauth2/code/kakao, code={}", code);

        try {
            // 1. 카카오 액세스 토큰을 가져옴
            String accessToken = kakaoOAuthService.getKakaoAccessToken(code);
            
            // 2. 액세스 토큰으로 사용자 정보 요청
            KakaoUserInfo kakaoUserInfo = kakaoOAuthService.getKakaoUserInfo(accessToken); 

            // 3. 소셜 사용자 정보 저장 (DB에 전달할 데이터)
            HashMap<String, String> userInfo = new HashMap<>();
            userInfo.put("socialType", "kakao");
            
            // Long 타입의 ID를 String으로 변환
            userInfo.put("socialId", String.valueOf(kakaoUserInfo.getId())); 
            
            // ******************** EMAIL 처리 ********************
            // DB의 NOT NULL 제약조건을 제거했으므로, null 값을 그대로 전달합니다.
            // MyBatis에서 TypeException 방지를 위해 매퍼 파일에 jdbcType=VARCHAR 명시가 필요합니다.
            String email = kakaoUserInfo.getEmail();
            userInfo.put("EMAIL", email); 
            // ****************************************************
            
            userInfo.put("NAME", kakaoUserInfo.getName()); 
            
            // ******************** NICKNAME 로직 개선 ********************
            String nickname = kakaoUserInfo.getName(); 
            if (nickname == null || nickname.trim().isEmpty()) {
                if (email != null && !email.trim().isEmpty()) {
                    // 이메일이 있을 경우 이메일 앞부분 사용
                    nickname = email.split("@")[0]; 
                } else {
                    // 이메일도 null/empty일 경우 고유한 닉네임 생성 (충돌 방지)
                    nickname = "kakao_user_" + kakaoUserInfo.getId(); 
                }
            }
            userInfo.put("NICKNAME", nickname);
            // ****************************************************

            // 4. 사용자 정보로 DB에 저장 또는 로그인 처리
            MemDTO socialMember = memService.findOrCreateMember(userInfo);

            // 이미 등록된 이메일이 있을 경우 (또는 로직상 오류 발생 시)
            if (socialMember == null) {
                request.setAttribute("msg", "이미 해당 이메일로 가입된 계정이 있습니다.");
                request.setAttribute("url", "login");
                return "login_page/alert";
            }

            // 5. 세션에 사용자 정보 저장
            HttpSession session = request.getSession();
            session.setAttribute("id", socialMember.getMemberId());
            session.setAttribute("name", socialMember.getName());
            session.setAttribute("admin", socialMember.getAdminck());

            return "redirect:/home";

        } catch (Exception e) {
            log.error("@# 카카오 로그인 처리 중 예외 발생: {}", e.getMessage());
            request.setAttribute("msg", "소셜 로그인 중 오류가 발생했습니다. 관리자에게 문의하세요.");
            request.setAttribute("url", "login");
            return "login_page/alert";
        }
    }


	// 네이버 소셜 로그인 콜백
	@RequestMapping("/login/oauth2/code/naver")
	public String naverCallback(@RequestParam String code, HttpServletRequest request) {
		log.info("@# GET /login/oauth2/code/naver, code={}", code);

		try {
			// 1. 네이버 액세스 토큰을 가져옴
			String accessToken = naverOAuthService.getNaverAccessToken(code);

			// 2. 액세스 토큰으로 사용자 정보 요청
			NaverUserInfo naverUserInfo = naverOAuthService.getNaverUserInfo(accessToken);

			// 3. 소셜 사용자 정보 저장
			HashMap<String, String> userInfo = new HashMap<>();
			userInfo.put("socialType", "naver");
			userInfo.put("socialId", naverUserInfo.getId());
			userInfo.put("EMAIL", naverUserInfo.getEmail());
			userInfo.put("NAME", naverUserInfo.getName());

			// 닉네임이 비어있다면, 이메일에서 추출
			String nickname = naverUserInfo.getName();
			if (nickname == null || nickname.trim().isEmpty()) {
				nickname = naverUserInfo.getEmail().split("@")[0];
			}
			userInfo.put("NICKNAME", nickname);

			// 4. 사용자 정보로 DB에 저장 또는 로그인 처리
			MemDTO socialMember = memService.findOrCreateMember(userInfo);

			// 이미 등록된 이메일이 있을 경우
			if (socialMember == null) {
				request.setAttribute("msg", "이미 해당 이메일로 가입된 계정이 있습니다.");
				request.setAttribute("url", "login");
				return "login_page/alert";
			}

			// 5. 세션에 사용자 정보 저장
			HttpSession session = request.getSession();
			session.setAttribute("id", socialMember.getMemberId());
			session.setAttribute("name", socialMember.getName());
			session.setAttribute("admin", socialMember.getAdminck());

			return "redirect:/home"; // 홈으로 리디렉션

		} catch (Exception e) {
			log.error("@# 네이버 로그인 처리 중 예외 발생: {}", e.getMessage());
			request.setAttribute("msg", "소셜 로그인 중 오류가 발생했습니다. 관리자에게 문의하세요.");
			request.setAttribute("url", "login");
			return "login_page/alert";
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