package com.boot.YoRiZoRi.MY_Page.service;



import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.boot.YoRiZoRi.MY_Page.dao.MessageDAO;
import com.boot.YoRiZoRi.MY_Page.dto.MessageDTO;

import java.util.List;

@Slf4j
@Service
public class MessageServiceImpl implements MessageService {
    
    @Autowired
    private SqlSession sqlSession;

    // 쪽지 보내기
    @Override
    public boolean sendMessage(MessageDTO message) {
        MessageDAO dao = sqlSession.getMapper(MessageDAO.class);
        try {
            // DB에서 SENT_AT와 MESSAGE_ID는 시퀀스/트리거로 자동 생성됨
            // READ_STATUS는 DTO에서 설정하지 않으면 기본값 0(안 읽음)으로 유지됨
            dao.insertMessage(message);
            return true;
        } catch (Exception e) {
            log.error("쪽지 전송 실패: {}", e.getMessage());
            return false;
        }
    }
 // ✅ [추가] 미확인 쪽지 개수 조회
    @Override
    public int getUnreadMessageCount(String receiverId) {
        MessageDAO dao = sqlSession.getMapper(MessageDAO.class);
        // MessageDAO에서 정의한 메서드 호출
        return dao.getUnreadMessageCount(receiverId);
    }
    
    // 받은 쪽지 목록 조회
    @Override
    public List<MessageDTO> getReceivedMessages(String receiverId) {
        MessageDAO dao = sqlSession.getMapper(MessageDAO.class);
        // DAO에서 닉네임(senderNickname)을 조인해서 가져와야 함
        return dao.selectReceivedMessages(receiverId);
    }
    
    // 보낸 쪽지 목록 조회
    @Override
    public List<MessageDTO> getSentMessages(String senderId) {
        MessageDAO dao = sqlSession.getMapper(MessageDAO.class);
        // DAO에서 닉네임(receiverNickname)을 조인해서 가져와야 함
        return dao.selectSentMessages(senderId);
    }

    // 특정 쪽지 상세 조회 및 읽음 처리
    @Override
    @Transactional
    public MessageDTO viewMessage(int msgId, String memberId) {
        MessageDAO dao = sqlSession.getMapper(MessageDAO.class);
        
        MessageDTO message = dao.selectMessageById(msgId);
        
        // 해당 쪽지의 수신자만 읽음 처리 및 내용 확인 가능
        if (message != null) {
            
            // 1. 권한 확인: 수신자 또는 발신자인지 확인
            if (!message.getReceiverId().equals(memberId) && !message.getSenderId().equals(memberId)) {
                return null; // 권한 없음
            }

            // 2. 읽음 처리: 수신자이고 아직 읽지 않았다면 상태 업데이트
            if (message.getReceiverId().equals(memberId) && message.getReadStatus() == 0) {
                dao.updateMessageReadStatus(msgId);
                message.setReadStatus(1); // DTO 상태 즉시 업데이트
            }
        }
        
        return message;
    }

    // 쪽지 삭제
    @Override
    @Transactional // ✅ 트랜잭션 보장 (UPDATE 및 DELETE 작업)
    public boolean deleteMessage(int msgId, String memberId) {
        MessageDAO dao = sqlSession.getMapper(MessageDAO.class);
        log.info("Attempting logical delete for msgId: {} by member: {}", msgId, memberId);
        
        // 1. 쪽지 정보 조회 (삭제 플래그 포함)
        MessageDTO message = dao.selectMessageById(msgId);

        if (message == null) {
            log.warn("MsgId {} not found in DB.", msgId);
            return false;
        }

        // 2. 로그인된 사용자가 송/수신자에 해당하는지 확인
        boolean isSender = message.getSenderId().equals(memberId);
        boolean isReceiver = message.getReceiverId().equals(memberId);

        if (!isSender && !isReceiver) {
            log.warn("MsgId {}에 대한 삭제 권한 없음.", msgId);
            return false;
        }

        try {
            if (isSender) {
                // A. 발신자 삭제 요청
                if (message.getReceiverDeleteCk() == 1) {
                    // 2-A. 수신자도 이미 삭제함 -> 물리적 삭제
                    dao.hardDeleteMessage(msgId);
                    log.info("MsgId {} 물리적 삭제 완료 (양쪽 모두 삭제).", msgId);
                } else {
                    // 2-B. 수신자는 아직 삭제 안 함 -> 논리적 삭제 (플래그만 1로 변경)
                    dao.updateSenderDeleteCk(msgId);
                    log.info("MsgId {} 발신자 논리적 삭제 완료.", msgId);
                }
            } else if (isReceiver) {
                // B. 수신자 삭제 요청
                if (message.getSenderDeleteCk() == 1) {
                    // 2-A. 발신자도 이미 삭제함 -> 물리적 삭제
                    dao.hardDeleteMessage(msgId);
                    log.info("MsgId {} 물리적 삭제 완료 (양쪽 모두 삭제).", msgId);
                } else {
                    // 2-B. 발신자는 아직 삭제 안 함 -> 논리적 삭제 (플래그만 1로 변경)
                    dao.updateReceiverDeleteCk(msgId);
                    log.info("MsgId {} 수신자 논리적 삭제 완료.", msgId);
                }
            }
            
            return true;
        } catch (Exception e) {
            log.error("쪽지 삭제 처리 중 DB 오류 발생. msgId: {}", msgId, e);
            // 트랜잭션 롤백
            throw new RuntimeException("쪽지 삭제 처리 실패", e); 
        }
    }
}