package com.boot.YoRiZoRi.Board.dao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.boot.YoRiZoRi.Board.dto.BoardCommentDTO;


@Repository
public class BoardCommentDAOImpl implements BoardCommentDAO {
    
    @Autowired
    private SqlSession sqlSession;
    
    private static final String NAMESPACE = "com.boot.YoRiZoRi.Board.dao.BoardCommentDAO";
    
    @Override
    public List<BoardCommentDTO> getComments(int boardId) {
        return sqlSession.selectList(NAMESPACE + ".getComments", boardId);
    }
    
    @Override
    public void writeComment(HashMap<String, String> param) {
        sqlSession.insert(NAMESPACE + ".writeComment", param);
    }
    
    @Override
    public void modifyComment(HashMap<String, String> param) {
        sqlSession.update(NAMESPACE + ".modifyComment", param);
    }
    
    @Override
    public void deleteComment(int commentId) {
        sqlSession.delete(NAMESPACE + ".deleteComment", commentId);
    }
    
    @Override
    public BoardCommentDTO getComment(int commentId) {
        return sqlSession.selectOne(NAMESPACE + ".getComment", commentId);
    }
    
    @Override
    public List<BoardCommentDTO> getCommentsPaged(Map<String, Object> param) {
        return sqlSession.selectList(NAMESPACE + ".getCommentsPaged", param);
    }
    
    @Override
    public int getCommentCount(int boardId) {
        return sqlSession.selectOne(NAMESPACE + ".getCommentCount", boardId);
    }
}

