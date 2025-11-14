package com.boot.YoRiZoRi.Chat.service;

import com.boot.YoRiZoRi.Chat.dao.Chatdao;
import com.boot.YoRiZoRi.Chat.dto.ChatDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class ChatService {
    
    private final Chatdao chatDAO;
    
    /**
     * 메시지 저장 (TALK 타입만 DB 저장)
     */
    @Transactional
    public void saveMessage(ChatDTO message) {
        if (message.getType() == ChatDTO.MessageType.TALK) {
            try {
                chatDAO.insertMessage(message);
                log.info("메시지 저장 성공: {}", message.getMessage());
            } catch (Exception e) {
                log.error("메시지 저장 실패: {}", e.getMessage());
                throw new RuntimeException("메시지 저장 중 오류 발생", e);
            }
        }
    }
    
    /**
     * 최근 메시지 조회 (채팅방 입장 시)
     */
    public List<ChatDTO> getRecentMessages(int limit) {
        try {
            return chatDAO.selectRecentMessages(limit);
        } catch (Exception e) {
            log.error("최근 메시지 조회 실패: {}", e.getMessage());
            return List.of();
        }
    }
    
    /**
     * 특정 ID 이후 메시지 조회
     */
    public List<ChatDTO> getMessagesAfter(Long chatId) {
        try {
            return chatDAO.selectMessagesAfter(chatId);
        } catch (Exception e) {
            log.error("메시지 조회 실패: {}", e.getMessage());
            return List.of();
        }
    }
    
    /**
     * 전체 메시지 수 조회
     */
    public int getTotalMessageCount() {
        try {
            return chatDAO.countTotalMessages();
        } catch (Exception e) {
            log.error("메시지 수 조회 실패: {}", e.getMessage());
            return 0;
        }
    }
}