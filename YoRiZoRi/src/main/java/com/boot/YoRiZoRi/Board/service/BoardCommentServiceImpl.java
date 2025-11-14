package com.boot.YoRiZoRi.Board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.YoRiZoRi.Board.dao.BoardCommentDAO;
import com.boot.YoRiZoRi.Board.dto.BoardCommentDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoardCommentServiceImpl implements BoardCommentService {
    
    @Autowired
    private BoardCommentDAO boardCommentDAO;
    
    @Override
    public List<BoardCommentDTO> getComments(int boardId) {
        log.info("@# BoardCommentServiceImpl.getComments() boardId={}", boardId);
        return boardCommentDAO.getComments(boardId);
    }
    
    @Override
    public void writeComment(HashMap<String, String> param) {
        log.info("@# BoardCommentServiceImpl.writeComment() param={}", param);
        boardCommentDAO.writeComment(param);
    }
    
    @Override
    public void modifyComment(HashMap<String, String> param) {
        log.info("@# BoardCommentServiceImpl.modifyComment() param={}", param);
        boardCommentDAO.modifyComment(param);
    }
    
    @Override
    public void deleteComment(int commentId) {
        log.info("@# BoardCommentServiceImpl.deleteComment() commentId={}", commentId);
        boardCommentDAO.deleteComment(commentId);
    }
    
    @Override
    public BoardCommentDTO getComment(int commentId) {
        log.info("@# BoardCommentServiceImpl.getComment() commentId={}", commentId);
        return boardCommentDAO.getComment(commentId);
    }
    
    @Override
    public List<BoardCommentDTO> getCommentsPaged(Map<String, Object> param) {
        log.info("@# BoardCommentServiceImpl.getCommentsPaged() param={}", param);
        return boardCommentDAO.getCommentsPaged(param);
    }
    
    @Override
    public int getCommentCount(int boardId) {
        log.info("@# BoardCommentServiceImpl.getCommentCount() boardId={}", boardId);
        return boardCommentDAO.getCommentCount(boardId);
    }
}

