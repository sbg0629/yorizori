package com.boot.YoRiZoRi.Chat.web;


import com.boot.YoRiZoRi.Chat.dto.ChatDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import java.time.LocalDateTime;

@Slf4j
@Component
@RequiredArgsConstructor
public class WebSocketEventListener {
    
    private final SimpMessageSendingOperations messagingTemplate;
    
    /**
     * WebSocket 연결 종료 이벤트 처리
     */
    @EventListener
    public void handleWebSocketDisconnectListener(SessionDisconnectEvent event) {
        StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());
        
        String username = (String) headerAccessor.getSessionAttributes().get("username");
        String userId = (String) headerAccessor.getSessionAttributes().get("userId");
        
        if (username != null) {
            log.info("사용자 퇴장: {}", username);
            
            ChatDTO chatMessage = ChatDTO.builder()
                    .type(ChatDTO.MessageType.LEAVE)
                    .senderId(userId)
                    .senderNickname(username)
                    .message(username + "님이 퇴장하셨습니다.")
                    .sentAt(LocalDateTime.now())
                    .build();
            
            // 퇴장 메시지 브로드캐스트
            messagingTemplate.convertAndSend("/topic/public", chatMessage);
        }
    }
}