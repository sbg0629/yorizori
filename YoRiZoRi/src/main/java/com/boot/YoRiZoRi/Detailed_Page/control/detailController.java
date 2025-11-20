package com.boot.YoRiZoRi.Detailed_Page.control;

import com.boot.YoRiZoRi.Detailed_Page.dto.DetailDTO;
import com.boot.YoRiZoRi.Detailed_Page.dto.CommentDTO;
import com.boot.YoRiZoRi.Detailed_Page.dto.ReviewDTO;
import com.boot.YoRiZoRi.Detailed_Page.service.detailService;
import com.boot.YoRiZoRi.Recipe.dto.CategoryDTO;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
public class detailController {

    private final detailService detailedService;
    

    // 생성자를 통한 의존성 주입 (DI)
    public detailController(detailService detailedService) {
        this.detailedService = detailedService;
    }
    
  

    /**
     * 레시피 상세 정보 페이지를 보여주는 메서드
     * @param id 레시피 ID
     * @param model 뷰에 데이터를 전달하기 위한 객체
     * @return 뷰 이름
     */
    @RequestMapping("/detail.do")
    public String recipeDetail(@RequestParam("recipe_Id") int id, Model model) {
        // 서비스 호출: 조회수 증가와 함께 상세 정보 가져오기
        DetailDTO detail = detailedService.getRecipeDetailWithHit(id);

        if (detail == null) {
            model.addAttribute("msg", "존재하지 않는 레시피입니다.");
            return "errorPage"; // 에러 페이지로 이동
        }

        model.addAttribute("recipe", detail);
        return "recipeDetail"; // recipeDetail.jsp 뷰로 이동
    }

    // ==========================================================
    // ## 수정 기능 추가 부분 (START) ##
    // ==========================================================

    /**
     * 레시피 수정 폼(페이지)을 보여주는 메서드
     * @param recipeId 수정할 레시피의 ID
     * @param model 뷰에 기존 데이터를 전달하기 위한 객체
     * @return 뷰 이름
     */
    @GetMapping("/modifyRecipe")
    public String modifyRecipeForm(@RequestParam("recipeId") int recipeId, Model model) {
        
        DetailDTO recipe = detailedService.getRecipeDetailForUpdate(recipeId);

        //  1. 모든 카테고리 목록을 서비스에서 가져옵니다.
        List<CategoryDTO> categoryList = detailedService.getAllCategories();

        if (recipe == null) {
            model.addAttribute("msg", "수정할 레시피를 찾을 수 없습니다.");
            return "errorPage";
        }
        
        model.addAttribute("recipe", recipe);
        
        // 2. 가져온 카테고리 목록을 "categories"라는 이름으로 모델에 추가합니다.
        model.addAttribute("categories", categoryList);
        
        return "modify_recipe"; // modify_recipe.jsp 뷰로 이동
    }

    /**
     * 제출된 레시피 수정 내용을 처리하는 메서드
     * @param recipeDto JSP 폼에서 전송된 데이터가 담긴 DTO 객체
     * @param redirectAttributes 리다이렉트 시 간단한 메시지를 전달하기 위한 객체
     * @return 리다이렉트할 URL
     */
    @PostMapping("/updateRecipe")
    public String updateRecipe(DetailDTO recipeDto, RedirectAttributes redirectAttributes) {
        
        // 중요: 실제 DB 업데이트를 수행하는 '업데이트' 메서드를 호출합니다.
        // 이 메서드 역시 Service에 새로 추가해야 합니다.
        detailedService.updateRecipe(recipeDto);

        // 수정 완료 후 사용자에게 피드백을 주기 위해 메시지를 추가
        redirectAttributes.addFlashAttribute("message", "레시피가 성공적으로 수정되었습니다.");
        
        // 수정이 완료되면, 해당 레시피의 상세 페이지로 다시 이동시킵니다.
        return "redirect:/detail.do?recipe_Id=" + recipeDto.getRecipeId();
    }


    // ## 수정 기능 추가 부분 (END) ##
  
    @GetMapping("/deleteRecipe")
    public String deleteRecipe(@RequestParam("recipeId") int recipeId, RedirectAttributes redirectAttributes) {
        
        // 1. 서비스에 삭제 작업 위임
        detailedService.deleteRecipe(recipeId);
        
        // 2. 사용자에게 피드백 메시지 전달
        redirectAttributes.addFlashAttribute("message", "레시피가 성공적으로 삭제되었습니다.");
        
        // 3. 작업 완료 후, 레시피 목록이나 홈 화면으로 이동
        return "redirect:/home"; // '/home'은 메인 페이지 URL에 맞게 수정하세요.
    }
    
    // ## 댓글 관련 메서드 ##
    
    /**
     * 댓글 작성
     */
    @PostMapping("/comment/write")
    @ResponseBody
    public Map<String, Object> writeComment(@RequestParam("recipeId") int recipeId,
                                          @RequestParam("content") String content,
                                          HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        // 로그인 체크
        String memberId = (String) session.getAttribute("id");
        if (memberId == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        
        // 댓글 작성
        CommentDTO comment = new CommentDTO();
        comment.setRecipe_Id(recipeId);
        comment.setMemberId(memberId);
        comment.setContent(content);
        comment.setRef_id(0); // 원댓글
        comment.setCmt_step(0);
        comment.setCmt_depth(0);
        
        boolean success = detailedService.insertComment(comment);
        
        if (success) {
            result.put("success", true);
            result.put("message", "댓글이 작성되었습니다.");
        } else {
            result.put("success", false);
            result.put("message", "댓글 작성에 실패했습니다.");
        }
        
        return result;
    }
    
    /**
     * 대댓글 작성
     */
    @PostMapping("/comment/reply")
    @ResponseBody
    public Map<String, Object> writeReply(@RequestParam("recipeId") int recipeId,
                                        @RequestParam("parentCommentId") int parentCommentId,
                                        @RequestParam("content") String content,
                                        HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        // 로그인 체크
        String memberId = (String) session.getAttribute("id");
        if (memberId == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        
        // 부모 댓글 정보 조회
        CommentDTO parentComment = detailedService.getCommentById(parentCommentId);
        if (parentComment == null) {
            result.put("success", false);
            result.put("message", "부모 댓글을 찾을 수 없습니다.");
            return result;
        }
        
        // 대댓글 작성
        CommentDTO reply = new CommentDTO();
        reply.setRecipe_Id(recipeId);
        reply.setMemberId(memberId);
        reply.setContent(content);
        reply.setRef_id(parentCommentId);
        reply.setCmt_step(parentComment.getCmt_step() + 1);
        reply.setCmt_depth(parentComment.getCmt_depth() + 1);
        
        boolean success = detailedService.insertReply(reply);
        
        if (success) {
            result.put("success", true);
            result.put("message", "답글이 작성되었습니다.");
        } else {
            result.put("success", false);
            result.put("message", "답글 작성에 실패했습니다.");
        }
        
        return result;
    }
    
    /**
     * 댓글 수정
     */
    @PostMapping("/comment/update")
    @ResponseBody
    public Map<String, Object> updateComment(@RequestParam("commentId") int commentId,
                                           @RequestParam("content") String content,
                                           HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        // 로그인 체크
        String memberId = (String) session.getAttribute("id");
        if (memberId == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        
        // 댓글 작성자 확인
        CommentDTO comment = detailedService.getCommentById(commentId);
        if (comment == null || !comment.getMemberId().equals(memberId)) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 댓글 수정
        comment.setContent(content);
        boolean success = detailedService.updateComment(comment);
        
        if (success) {
            result.put("success", true);
            result.put("message", "댓글이 수정되었습니다.");
        } else {
            result.put("success", false);
            result.put("message", "댓글 수정에 실패했습니다.");
        }
        
        return result;
    }
    
    /**
     * 댓글 삭제
     */
    @PostMapping("/comment/delete")
    @ResponseBody
    public Map<String, Object> deleteComment(@RequestParam("commentId") int commentId,
                                           HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        // 로그인 체크
        String memberId = (String) session.getAttribute("id");
        if (memberId == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        
        // 댓글 작성자 확인
        CommentDTO comment = detailedService.getCommentById(commentId);
        if (comment == null || !comment.getMemberId().equals(memberId)) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 댓글 삭제
        boolean success = detailedService.deleteComment(commentId);
        
        if (success) {
            result.put("success", true);
            result.put("message", "댓글이 삭제되었습니다.");
        } else {
            result.put("success", false);
            result.put("message", "댓글 삭제에 실패했습니다.");
        }
        
        return result;
    }
    
    // ## 후기 관련 메서드 ##
    
    /**
     * 후기 작성
     */
    @PostMapping("/review/write")
    @ResponseBody
    public Map<String, Object> writeReview(@RequestParam("recipeId") int recipeId,
                                         @RequestParam("content") String content,
                                         @RequestParam("rating") int rating,
                                         @RequestParam(value = "image", required = false) String image,
                                         HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        // 로그인 체크
        String memberId = (String) session.getAttribute("id");
        if (memberId == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        
        // 평점 유효성 검사
        if (rating < 1 || rating > 5) {
            result.put("success", false);
            result.put("message", "평점은 1~5점 사이로 입력해주세요.");
            return result;
        }
        
        // 후기 작성
        ReviewDTO review = new ReviewDTO();
        review.setRecipe_Id(recipeId);
        review.setMemberId(memberId);
        review.setContent(content);
        review.setRating(rating);
        review.setImage(image);
        
        boolean success = detailedService.insertReview(review);
        
        if (success) {
            result.put("success", true);
            result.put("message", "후기가 작성되었습니다.");
        } else {
            result.put("success", false);
            result.put("message", "후기 작성에 실패했습니다.");
        }
        
        return result;
    }
    
    /**
     * 후기 수정
     */
    @PostMapping("/review/update")
    @ResponseBody
    public Map<String, Object> updateReview(@RequestParam("reviewId") int reviewId,
                                          @RequestParam("content") String content,
                                          @RequestParam("rating") int rating,
                                          @RequestParam(value = "image", required = false) String image,
                                          HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        // 로그인 체크
        String memberId = (String) session.getAttribute("id");
        if (memberId == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        
        // 평점 유효성 검사
        if (rating < 1 || rating > 5) {
            result.put("success", false);
            result.put("message", "평점은 1~5점 사이로 입력해주세요.");
            return result;
        }
        
        // 후기 작성자 확인
        ReviewDTO review = detailedService.getReviewById(reviewId);
        if (review == null || !review.getMemberId().equals(memberId)) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 후기 수정
        review.setContent(content);
        review.setRating(rating);
        review.setImage(image);
        boolean success = detailedService.updateReview(review);
        
        if (success) {
            result.put("success", true);
            result.put("message", "후기가 수정되었습니다.");
        } else {
            result.put("success", false);
            result.put("message", "후기 수정에 실패했습니다.");
        }
        
        return result;
    }
    
    /**
     * 후기 삭제
     */
    @PostMapping("/review/delete")
    @ResponseBody
    public Map<String, Object> deleteReview(@RequestParam("reviewId") int reviewId,
                                          HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        // 로그인 체크
        String memberId = (String) session.getAttribute("id");
        if (memberId == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        
        // 후기 작성자 확인
        ReviewDTO review = detailedService.getReviewById(reviewId);
        if (review == null || !review.getMemberId().equals(memberId)) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 후기 삭제
        boolean success = detailedService.deleteReview(reviewId);
        
        if (success) {
            result.put("success", true);
            result.put("message", "후기가 삭제되었습니다.");
        } else {
            result.put("success", false);
            result.put("message", "후기 삭제에 실패했습니다.");
        }
        
        return result;
    }
    
    // ==================== 북마크 관련 메서드 ====================
    
    /**
     * 북마크 추가/제거 토글
     */
    @PostMapping("/bookmark/toggle")
    @ResponseBody
    public Map<String, Object> toggleBookmark(@RequestParam("recipeId") int recipeId,
                                             HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        String memberId = (String) session.getAttribute("id");
        if (memberId == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        
        // 현재 북마크 상태 확인
        boolean isBookmarked = detailedService.isBookmarked(memberId, recipeId);
        
        if (isBookmarked) {
            // 북마크 제거
            boolean success = detailedService.removeBookmark(memberId, recipeId);
            if (success) {
                result.put("success", true);
                result.put("bookmarked", false);
                result.put("message", "즐겨찾기가 해제되었습니다.");
            } else {
                result.put("success", false);
                result.put("message", "즐겨찾기 해제에 실패했습니다.");
            }
        } else {
            // 북마크 추가
            boolean success = detailedService.addBookmark(memberId, recipeId);
            if (success) {
                result.put("success", true);
                result.put("bookmarked", true);
                result.put("message", "즐겨찾기에 추가되었습니다.");
            } else {
                result.put("success", false);
                result.put("message", "즐겨찾기 추가에 실패했습니다.");
            }
        }
        
        return result;
    }
    
    /**
     * 북마크 상태 확인
     */
    @GetMapping("/bookmark/status")
    @ResponseBody
    public Map<String, Object> checkBookmarkStatus(@RequestParam("recipeId") int recipeId,
                                                  HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        String memberId = (String) session.getAttribute("id");
        if (memberId == null) {
            result.put("success", false);
            result.put("bookmarked", false);
            return result;
        }
        
        boolean isBookmarked = detailedService.isBookmarked(memberId, recipeId);
        result.put("success", true);
        result.put("bookmarked", isBookmarked);
        
        return result;
    }
    
    /**
     * 사용자의 북마크 목록 조회
     */
    @GetMapping("/mybookmark")
    public String getMyBookmarks(@RequestParam("member_Id") String memberId, 
                                HttpSession session, 
                                Model model) {
        // 로그인 확인
        String sessionId = (String) session.getAttribute("id");
        if (sessionId == null || !sessionId.equals(memberId)) {
            return "redirect:/login";
        }
        
        // 북마크 목록 조회
        List<DetailDTO> bookmarkList = detailedService.getBookmarkList(memberId);
        model.addAttribute("bookmarkList", bookmarkList);
        
        return "mybookmark";
    }
    
    @PostMapping("/review/writeFile")
    public String writeReviewWithFile(@ModelAttribute ReviewDTO review, 
                                      RedirectAttributes redirectAttributes,
                                      HttpSession session) {
        
        // 1. 로그인 체크
        String memberId = (String) session.getAttribute("id");
        if (memberId == null) {
            redirectAttributes.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/login_view"; // 로그인 페이지 경로로 변경
        }
        if (review.getImageFile() == null || review.getImageFile().isEmpty()) {
            // 이 메시지가 로그에 찍힌다면, 파일이 컨트롤러에서 Service로 넘어갈 때 유실된 것입니다.
            System.out.println("❌ ERROR: Review Image File object is MISSING or EMPTY upon Controller reception.");
        } else {
            System.out.println("✅ SUCCESS: File received in Controller. Filename: " + review.getImageFile().getOriginalFilename());
        }
        
        // ⭐ [수정 핵심] DTO 바인딩 문제 해결
        // ReviewDTO에 private int recipeId; 필드를 추가하여 폼 데이터(name="recipeId")가 여기에 바인딩되었다고 가정합니다.
        // DB 컬럼명(recipe_Id)에 올바른 값을 설정합니다. (이전까지 0이 들어갔던 문제를 해결)
        if (review.getRecipe_Id() == 0 && review.getRecipeId() != 0) {
            review.setRecipe_Id(review.getRecipeId());
        }

        // 2. 평점 유효성 검사 (클라이언트 검증 실패 대비)
        if (review.getRating() < 1 || review.getRating() > 5) {
            redirectAttributes.addFlashAttribute("message", "평점은 1~5점 사이로 입력해주세요.");
            // 이제 review.getRecipe_Id()에는 올바른 ID(1)가 설정되어 있습니다.
            return "redirect:/detail.do?recipe_Id=" + review.getRecipe_Id();
        }
        
        // 3. 후기 작성 (Service에서 파일 처리 및 DB 저장)
        review.setMemberId(memberId);
        
        try {
            // Service의 insertReview 메서드 (파일 처리 로직 포함 가정) 호출
            // Service로 전달되는 review 객체의 recipe_Id는 이제 1입니다.
            boolean success = detailedService.insertReview(review);
            
            if (success) {
                redirectAttributes.addFlashAttribute("message", "후기가 성공적으로 작성되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("message", "후기 작성에 실패했습니다.");
            }
            
        } catch (Exception e) {
            // [TODO] log.error("후기 작성 중 오류 발생", e);
            redirectAttributes.addFlashAttribute("message", "후기 작성 중 서버 오류가 발생했습니다.");
        }

        // 4. 후기 작성 후 해당 레시피 상세 페이지로 리다이렉트
        // ✅ review.getRecipe_Id()는 올바른 값(1)을 반환하므로, URL은 detail.do?recipe_Id=1이 됩니다.
        return "redirect:/detail.do?recipe_Id=" + review.getRecipe_Id();
    }
}