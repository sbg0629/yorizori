package com.boot.YoRiZoRi.Chat.dao;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.boot.YoRiZoRi.Chat.dto.ChatDTO;

import java.util.List;

@Mapper
public interface Chatdao {
    
    // 메시지 저장
    void insertMessage(ChatDTO message);
    
    // 최근 메시지 조회 (페이징)
    List<ChatDTO> selectRecentMessages(@Param("limit") int limit);
    
    // 특정 시간 이후 메시지 조회
    List<ChatDTO> selectMessagesAfter(@Param("chatId") Long chatId);
    
    // 전체 메시지 수 조회
    int countTotalMessages();
}