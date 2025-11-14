package com.boot.YoRiZoRi.login.control;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
//import jakarta.mail.internet.MimeMessage; // Spring Boot 3+
 import javax.mail.internet.MimeMessage; // Spring Boot 2.x

//import jakarta.servlet.http.HttpSession; // Spring Boot 3+
 import javax.servlet.http.HttpSession; // Spring Boot 2.x

import lombok.RequiredArgsConstructor;
import java.util.Random;

@RestController
@RequiredArgsConstructor // final 필드에 대한 생성자 자동 주입 (Lombok)
@RequestMapping("/mail") // JSP의 fetch 경로와 일치
public class MailVerificationController {

    // 1. JavaMailSender 의존성 주입 (application.properties 설정을 기반으로 자동 구성됨)
    private final JavaMailSender mailSender;

    // 2. 인증번호 발송 API (POST /mail/send-verification)
    @PostMapping("/send-verification")
    public String sendVerificationEmail(@RequestParam("email") String email, HttpSession session) {
        
        try {
            // 1. 인증번호 생성
            String verificationCode = createVerificationCode();

            // 2. 메일 본문 생성 (HTML)
            String mailContent = createEmailContent(verificationCode);

            // 3. 메일 발송
            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, "UTF-8");
            
            // (중요) application.properties에 설정한 본인 이메일 주소를 "from"으로 설정
            helper.setFrom("YOUR_GMAIL@gmail.com"); 
            helper.setTo(email);
            helper.setSubject("[요리조리] 회원가입 인증번호입니다.");
            helper.setText(mailContent, true); // true: HTML 형식으로 발송

            mailSender.send(mimeMessage);

            // 4. 세션에 인증번호 저장 (key: 이메일, value: 인증번호)
            // (유효시간 5분 설정)
            session.setAttribute(email, verificationCode);
            session.setMaxInactiveInterval(300); // 300초 = 5분

            return "SUCCESS"; // JSP로 성공 응답

        } catch (Exception e) {
            e.printStackTrace();
            return "FAIL"; // JSP로 실패 응답
        }
    }

    // 3. 인증번호 확인 API (POST /mail/check-verification)
    @PostMapping("/check-verification")
    public String checkVerificationCode(@RequestParam("email") String email,
                                        @RequestParam("code") String code,
                                        HttpSession session) {
        
        // 1. 세션에서 이메일(key)로 저장된 인증번호 조회
        String storedCode = (String) session.getAttribute(email);

        // 2. 세션에 인증번호가 없거나(시간 만료) 일치하지 않는 경우
        if (storedCode == null) {
            return "FAIL"; // (세션 만료)
        }
        
        if (storedCode.equals(code)) {
            // 3. 인증 성공: 세션에서 인증번호 제거 (일회용)
            session.removeAttribute(email); 
            return "SUCCESS";
        } else {
            // 4. 인증 실패: 코드가 일치하지 않음
            return "FAIL";
        }
    }

    /**
     * 6자리 숫자 인증번호 생성
     */
    private String createVerificationCode() {
        Random random = new Random();
        int number = 100000 + random.nextInt(900000); // 100000 ~ 999999
        return String.valueOf(number);
    }

    /**
     * 이메일 본문 (HTML) 생성
     */
    private String createEmailContent(String code) {
        return "<div style='font-family: \"Noto Sans KR\", sans-serif; text-align: center; padding: 40px; border: 1px solid #eee; border-radius: 10px;'>" +
               "  <h1 style='color: #ff6f61; font-size: 28px;'>요리조리 회원가입</h1>" +
               "  <p style='font-size: 16px; color: #333; margin-top: 20px;'>안녕하세요! 요리조리에 가입해 주셔서 감사합니다.</p>" +
               "  <p style::'font-size: 16px; color: #333;'>아래의 인증번호를 회원가입 화면에 입력해 주세요.</p>" +
               "  <div style='background-color: #fffaf7; padding: 20px 0; margin: 30px 0; border-radius: 8px;'>" +
               "    <strong style='font-size: 24px; color: #ff6f61; letter-spacing: 2px;'>" + code + "</strong>" +
               "  </div>" +
               "  <p style='font-size: 14px; color: #888;'>* 본 인증번호는 5분간 유효합니다.</p>" +
               "</div>";
    }
}