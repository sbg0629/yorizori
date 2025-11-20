package com.boot.YoRiZoRi.MY_Page.service;

import java.util.List;

import com.boot.YoRiZoRi.MY_Page.dto.MessageDTO;

public interface MessageService {
    
    // 쪽지 보내기
    boolean sendMessage(MessageDTO message);
    
    // 받은 쪽지 목록 조회
    List<MessageDTO> getReceivedMessages(String receiverId);
    
    // 보낸 쪽지 목록 조회
    List<MessageDTO> getSentMessages(String senderId);

    // 특정 쪽지 상세 조회 및 읽음 처리
    MessageDTO viewMessage(int msgId, String memberId);

    // 쪽지 삭제
    boolean deleteMessage(int msgId, String memberId);
    
    int getUnreadMessageCount(String receiverId);
}