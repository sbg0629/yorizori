package com.boot.YoRiZoRi.Chat.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ChatDTO {
    private Long chatId;
    private String senderId;
    private String senderNickname; // 채팅에서 닉네임 표시용
    private String message;
    private LocalDateTime sentAt;
    
    // 메시지 타입 구분 (ENTER, TALK, LEAVE)
    public enum MessageType {
        ENTER, TALK, LEAVE
    }
    
    private MessageType type;
}