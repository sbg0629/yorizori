package com.boot.YoRiZoRi.MY_Page.control;


import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.boot.YoRiZoRi.MY_Page.dto.MessageDTO;
import com.boot.YoRiZoRi.MY_Page.service.MessageService;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@Controller
@Slf4j
public class MessageController {

    private final MessageService messageService;

    // 생성자를 통한 의존성 주입 (DI)
    @Autowired
    public MessageController(MessageService messageService) {
        this.messageService = messageService;
    }
    
 // ==========================================================
    // ✅ [추가] 1. 모든 요청에 미확인 쪽지 개수를 모델에 추가 (헤더 표시용)
    // ==========================================================
    @ModelAttribute("unreadCount")
    public int getUnreadMessageCountForHeader(HttpSession session) {
        String memberId = (String) session.getAttribute("id");
        if (memberId != null) {
            // 로그인 상태인 경우에만 미확인 쪽지 개수 조회
            return messageService.getUnreadMessageCount(memberId);
        }
        return 0;
    }

    // ... (messageBox 메서드 생략)
    
    // ==========================================================
    // ✅ [추가] 2. 특정 쪽지 상세 조회 및 읽음 처리 (/view_message)
    // ==========================================================

    @GetMapping("/view_message")
    public String viewMessage(@RequestParam("msgId") int msgId,
    		@RequestParam(value = "boxType", defaultValue = "received") String boxType,
                              HttpSession session,
                              Model model,
                              RedirectAttributes redirectAttributes) {
        
        String memberId = (String) session.getAttribute("id");
        

        if (memberId == null) {
            redirectAttributes.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/login_view"; // 로그인 페이지 경로로 변경해주세요
        }

        // Service에서 상세 조회 및 읽음 처리 (트랜잭션)
        // MessageDTO에는 이미 senderNickname 정보가 포함되어야 합니다.
        MessageDTO message = messageService.viewMessage(msgId, memberId);

        if (message == null) {
            redirectAttributes.addFlashAttribute("msg", "쪽지를 찾을 수 없거나 접근 권한이 없습니다.");
            return "redirect:/message_box";
        }
        message.setMsgId(msgId);
        log.info("ViewMessage - 최종 msgId = {}", message.getMsgId());

        
        model.addAttribute("message", message);
        model.addAttribute("currentBoxType", boxType);
        return "message_view"; // message_view.jsp로 이동
    }

    // ==========================================================
    // 1. 받은 쪽지함 목록 조회 (/message_box)
    // ==========================================================

    @RequestMapping("/message_box")
    public String messageBox(@RequestParam(value = "box", defaultValue = "received") String boxType,
                             HttpSession session, 
                             Model model) {
        
        String memberId = (String) session.getAttribute("id");

        if (memberId == null) {
            // 로그인 페이지로 리다이렉트
            return "redirect:/login_view"; // 또는 "/login"
        }

        List<MessageDTO> messageList;
        
        if ("sent".equals(boxType)) {
            // ✅ 보낸 쪽지함 목록 조회
            messageList = messageService.getSentMessages(memberId);
            model.addAttribute("boxTitle", "보낸 쪽지함");
            model.addAttribute("activeBox", "sent");
        } else { // 기본값: received (받은 쪽지함)
            // 받은 쪽지함 목록 조회
            messageList = messageService.getReceivedMessages(memberId);
            model.addAttribute("boxTitle", "받은 쪽지함");
            model.addAttribute("activeBox", "received");
        }
        
        // 쪽지 목록을 모델에 추가
        model.addAttribute("messageList", messageList);

        return "message_box"; // message_box.jsp로 포워딩
    }

   

    // ==========================================================
    // 3. 쪽지 작성 폼 (/send_message_view)
    // ==========================================================
    
    @GetMapping("/send_message_view")
    public String sendMessageView(@RequestParam(value = "receiver", required = false) String receiverId,
                                  Model model,
                                  HttpSession session) {
        
        if (session.getAttribute("id") == null) {
            return "redirect:/login_view";
        }

        if (receiverId != null) {
            // 특정 사용자에게 답장/보내기 시, 받는 사람 ID를 미리 설정
            model.addAttribute("receiverId", receiverId);
        }
        
        return "message_send"; // message_send.jsp (쪽지 작성 폼)으로 이동
    }


    // ==========================================================
    // 4. 쪽지 전송 처리 (/message/send)
    // ==========================================================
    
    @PostMapping("/message/send")
    public String sendMessage(@ModelAttribute MessageDTO message,
                              RedirectAttributes redirectAttributes,
                              HttpSession session) {
        
        String senderId = (String) session.getAttribute("id");
        
        if (senderId == null) {
            redirectAttributes.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/login_view";
        }
        
        if (message.getReceiverId() == null || message.getReceiverId().isEmpty()) {
             redirectAttributes.addFlashAttribute("msg", "받는 사람 ID를 입력해주세요.");
             return "redirect:/send_message_view";
        }

        // 보내는 사람 ID 설정
        message.setSenderId(senderId);
        
        boolean success = messageService.sendMessage(message);

        if (success) {
            redirectAttributes.addFlashAttribute("message", "쪽지가 성공적으로 전송되었습니다!");
            return "redirect:/message_box?box=sent"; // 보낸 쪽지함으로 리다이렉트
        } else {
            redirectAttributes.addFlashAttribute("message", "쪽지 전송에 실패했습니다. 받는 사람 ID를 확인해주세요.");
            return "redirect:/send_message_view";
        }
    }

    // ==========================================================
    // 5. 쪽지 삭제 처리 (AJAX 또는 리다이렉트)
    // ==========================================================

    @PostMapping("/message/delete")
    @ResponseBody // AJAX 응답을 위해 사용
    public Map<String, Object> deleteMessage(
        @RequestParam("msgId") String msgIdStr, // ✅ [수정] int 대신 String으로 받습니다.
        HttpSession session) {
    	
    	log.info("현재 아이디값 : {}", msgIdStr);
    	log.info("현재 msgIdStr 값: {}", msgIdStr);
        
        Map<String, Object> result = new HashMap<>();
        
        // 1. 로그인 체크
        String memberId = (String) session.getAttribute("id");
        if (memberId == null) {
            result.put("success", false);
            result.put("message", "로그인 후 이용 가능합니다.");
            return result;
        }

        // 2. 값 유효성 및 타입 변환 체크
        if (msgIdStr == null || msgIdStr.trim().isEmpty()) {
            result.put("success", false);
            result.put("message", "삭제할 쪽지 ID를 찾을 수 없습니다.");
            return result;
        }

        int msgId;
        try {
            // 3. String을 안전하게 int로 변환
            msgId = Integer.parseInt(msgIdStr.trim());
        } catch (NumberFormatException e) {
            // 숫자가 아닌 값이 들어왔을 경우
            result.put("success", false);
            result.put("message", "유효하지 않은 쪽지 ID 형식입니다.");
            return result;
        }
        
        // 4. 서비스 호출 (논리적 삭제 로직 실행)
        boolean success = messageService.deleteMessage(msgId, memberId);

        if (success) {
            result.put("success", true);
            result.put("message", "쪽지가 삭제되었습니다.");
        } else {
            result.put("success", false);
            // service.deleteMessage 내에서 권한/DB 오류 발생 시
            result.put("message", "삭제에 실패했습니다. 권한을 확인해주세요.");
        }
        return result;
    }
    @GetMapping("/message/unread/count")
    @ResponseBody
    public Map<String, Object> getUnreadCountAjax(HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        String memberId = (String) session.getAttribute("id");

        if (memberId != null) {
            try {
                int count = messageService.getUnreadMessageCount(memberId);
                result.put("success", true);
                result.put("count", count);
            } catch (Exception e) {
                log.error("미확인 쪽지 개수 조회 오류", e);
                result.put("success", false);
                result.put("count", 0);
            }
        } else {
            result.put("success", true);
            result.put("count", 0); // 비로그인 시 0 반환
        }
        return result;
    }
}