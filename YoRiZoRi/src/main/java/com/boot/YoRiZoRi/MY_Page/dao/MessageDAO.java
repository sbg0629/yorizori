package com.boot.YoRiZoRi.MY_Page.dao;


import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.boot.YoRiZoRi.MY_Page.dto.MessageDTO;

@Mapper
public interface MessageDAO {
    
    // 쪽지 보내기 (INSERT)
    void insertMessage(MessageDTO message);
    
    // 받은 쪽지 목록 조회 (receiver_delete_ck = 0 인 것만 조회하도록 XML 수정 필요)
    List<MessageDTO> selectReceivedMessages(@Param("receiverId") String receiverId);
    
    // 보낸 쪽지 목록 조회 (sender_delete_ck = 0 인 것만 조회하도록 XML 수정 필요)
    List<MessageDTO> selectSentMessages(@Param("senderId") String senderId);

    // 특정 쪽지 상세 조회 (닉네임 조인 필요)
    MessageDTO selectMessageById(@Param("msgId") int msgId);
    
    // 쪽지 읽음 처리 (UPDATE READ_STATUS = 1)
    void updateMessageReadStatus(@Param("msgId") int msgId);
    
    // 쪽지 삭제 (DELETE 또는 상태 변경 UPDATE)
    void deleteMessage(@Param("msgId") int msgId);
    
    int getUnreadMessageCount(@Param("receiverId") String receiverId);

    // ==========================================================
    // ✅ [추가] 논리적 삭제를 위한 상태 업데이트 메서드
    // ==========================================================
    
    // 발신자 삭제 플래그 업데이트 (sender_delete_ck = 1)
    void updateSenderDeleteCk(@Param("msgId") int msgId);

    // 수신자 삭제 플래그 업데이트 (receiver_delete_ck = 1)
    void updateReceiverDeleteCk(@Param("msgId") int msgId);
    
    void hardDeleteMessage(@Param("msgId") int msgId);
}