package com.boot.YoRiZoRi.MY_Page.dto;

import java.sql.Date; // Oracle DATE 타입에 대응
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
// import org.springframework.web.multipart.MultipartFile; // 쪽지에는 불필요

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MessageDTO {
    private int msgId;            // MESSAGE_ID (PK)
    private String senderId;      // SENDER_ID
    private String receiverId;    // RECEIVER_ID
    private String content;       // CONTENT
    private Date sentDate;        // SENT_AT
    private int readStatus;       // READ_STATUS (0: 안 읽음, 1: 읽음)
    
    // DB에 없는 필드 (DAO 조회 시 조인/별칭으로 가져와야 함)
    private String senderNickname;
    private String receiverNickname;
    
    private int senderDeleteCk;
    private int receiverDeleteCk;
}