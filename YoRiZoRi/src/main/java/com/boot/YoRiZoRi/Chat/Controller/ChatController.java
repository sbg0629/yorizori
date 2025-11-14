package com.boot.YoRiZoRi.Chat.Controller;

import com.boot.YoRiZoRi.Chat.dto.ChatDTO;
import com.boot.YoRiZoRi.Chat.service.ChatService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
public class ChatController {
    
    private final ChatService chatService;
    
    /**
     * 채팅 페이지 뷰 반환 (로그인 필수)
     */
    @GetMapping("/chat")
    public String chatPage(HttpSession session) {
        // 로그인 체크 - 세션의 'id' 속성 확인
        if (session.getAttribute("id") == null) {
            return "redirect:/login"; // 로그인 페이지로 리다이렉트
        }
        return "chat/chat"; // chat.jsp
    }
    
    /**
     * 최근 메시지 조회 API (REST)
     */
    @GetMapping("/api/chat/recent")
    @ResponseBody
    public List<ChatDTO> getRecentMessages(
            @RequestParam(defaultValue = "50") int limit) {
        return chatService.getRecentMessages(limit);
    }
    
    /**
     * 메시지 전송 처리
     * 클라이언트가 /app/chat.sendMessage로 메시지를 보내면
     * 이 메서드가 처리 후 /topic/public으로 브로드캐스트
     */
    @MessageMapping("/chat.sendMessage")
    @SendTo("/topic/public")
    public ChatDTO sendMessage(@Payload ChatDTO chatMessage) {
        log.info("메시지 수신: {} - {}", chatMessage.getSenderNickname(), chatMessage.getMessage());
        
        // 현재 시간 설정
        chatMessage.setSentAt(LocalDateTime.now());
        
        // DB에 저장 (TALK 타입만)
        if (chatMessage.getType() == ChatDTO.MessageType.TALK) {
            chatService.saveMessage(chatMessage);
        }
        
        return chatMessage;
    }
    
    /**
     * 사용자 입장 처리
     */
    @MessageMapping("/chat.addUser")
    @SendTo("/topic/public")
    public ChatDTO addUser(
            @Payload ChatDTO chatMessage,
            SimpMessageHeaderAccessor headerAccessor) {
        
        // WebSocket 세션에 사용자 정보 저장
        headerAccessor.getSessionAttributes().put("username", chatMessage.getSenderNickname());
        headerAccessor.getSessionAttributes().put("userId", chatMessage.getSenderId());
        
        log.info("사용자 입장: {}", chatMessage.getSenderNickname());
        
        chatMessage.setType(ChatDTO.MessageType.ENTER);
        chatMessage.setSentAt(LocalDateTime.now());
        chatMessage.setMessage(chatMessage.getSenderNickname() + "님이 입장하셨습니다.");
        
        return chatMessage;
    }
}