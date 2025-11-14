package com.boot.YoRiZoRi.ChatBot.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import org.springframework.beans.factory.annotation.Autowired; // [추가]
import com.boot.YoRiZoRi.Main_Page.service.ItemService; // [추가]
import com.boot.YoRiZoRi.Main_Page.dto.ItemDTO; // [추가]

import java.util.Collections;
import java.util.List;
import java.util.Map;

@RestController
public class GeminiChatController {

    // 1. application.properties에서 API 키 주입
    @Value("${gemini.api.key}")
    private String apiKey;

    // 2. RestTemplate을 사용하여 HTTP 요청 (새 인스턴스 생성)
    private final RestTemplate restTemplate = new RestTemplate();
    
    @Autowired
    private ItemService itemService;

    /**
     * JSP에서 '/gemini/chat'으로 보내는 POST 요청을 처리
     */
    @PostMapping("/gemini/chat")
    public ResponseEntity<String> geminiChat(@RequestBody Map<String, String> payload) {
        
        String userMessage = payload.get("message");
        if (userMessage == null || userMessage.isEmpty()) {
            return ResponseEntity.badRequest().body("메시지가 없습니다.");
        }

        // 3. Gemini API의 URL (v1beta, flash 모델 사용)
        // (API 키가 URL 파라미터로 포함됨)
        String apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-lite:generateContent?key=" + apiKey;

        // 4. HTTP 요청 헤더 설정 (JSON 타입)
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

     // 1. DB 검색 (기존과 동일)
        ItemDTO recipe = itemService.findRecipeByName(userMessage);

        String systemInstruction;
        String prompt;

        // 2. DB에 정보가 있을 경우 (RAG 프롬프트)
        if (recipe != null) {
            
            // [수정] 시스템 지시: DB 정보가 '모든 것'이라고 명시
            systemInstruction = "당신은 '요리조리' 챗봇입니다. " +
                                "당신의 임무는 오직 [제공된 DB 정보] 안에서만 질문에 대한 답을 찾는 것입니다. " +
                                "당신의 일반 지식이나 인터넷 정보는 **절대** 사용해서는 안 됩니다. " +
                                "[제공된 DB 정보]가 이 레시피에 대한 **모든 정보**입니다. " +
                                "예를 들어, 조리 시간이 '30분'이면 '30분'이라고만 답하세요. " +
                                "[DB 정보]에 없는 내용은 'DB에 정보가 없습니다'라고 답변하세요.";
            
            // [수정] 프롬프트: '별점'과 '조리 순서' 추가
            prompt = "[사용자 질문]: " + userMessage + "\n" +
                     "[제공된 DB 정보]\n" +
                     "제목: " + recipe.getTitle() + "\n" +
                     "조회수: " + recipe.getHit() + "\n" +
                     "난이도: " + recipe.getDifficulty() + "\n" +
                     "조리 시간: " + recipe.getCookingTime() + "\n" +
                     "요리 양: " + recipe.getServingSize() + "인분\n" +
                     "평균 별점: " + String.format("%.1f", recipe.getRating()) + "점 (5점 만점)\n" + // 소수점 1자리
                     "재료 목록: " + recipe.getIngredients() + "\n" +
                     "조리 순서: " + recipe.getCookingSteps() + "\n" +
                     "레시피 설명: " + recipe.getDescription();
        
        // 3. DB에 정보가 없을 경우 (기존과 동일)
        } else {
            systemInstruction = "당신은 '요리조리'라는 레시피 웹사이트의 챗봇입니다. " +
                                "항상 친절하고 간결하게 답변해주세요. " +
                                "주로 레시피 추천이나 요리 팁에 대해 답변합니다. " +
                                "찾는 레시피가 저희 DB에 없는 것 같습니다.";
            
            prompt = userMessage;
        }

        // 5. API 요청 본문 생성 (기존과 동일)
        String requestBody = "{" +
            "  \"systemInstruction\": {" +
            "    \"parts\": [ {\"text\": \"" + systemInstruction.replace("\"", "\\\"") + "\"} ]" +
            "  }," +
            "  \"contents\": [" +
            "    { \"role\": \"user\", \"parts\": [ {\"text\": \"" + prompt.replace("\"", "\\\"") + "\"} ] }" +
            "  ]" +
            "}";

        // 6. HTTP 요청 엔티티 생성
        HttpEntity<String> requestEntity = new HttpEntity<>(requestBody, headers);

        try {
            // 7. RestTemplate으로 API 호출 (POST 요청)
            // (응답을 Map 객체로 받음)
            ResponseEntity<Map> response = restTemplate.postForEntity(apiUrl, requestEntity, Map.class);

            // 8. API 응답 (JSON)에서 실제 텍스트 답변 추출
            // 응답 구조: { "candidates": [ { "content": { "parts": [ { "text": "..." } ] } } ] }
            String geminiResponse = extractTextFromResponse(response.getBody());

            return ResponseEntity.ok(geminiResponse);

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("Gemini API 호출 중 오류 발생: " + e.getMessage());
        }
    }

    /**
     * 복잡한 Gemini 응답 JSON에서 텍스트만 추출하는 헬퍼 메소드
     */
    private String extractTextFromResponse(Map responseBody) {
        try {
            List<Map> candidates = (List<Map>) responseBody.get("candidates");
            if (candidates == null || candidates.isEmpty()) {
                return "응답이 없습니다.";
            }
            Map content = (Map) candidates.get(0).get("content");
            List<Map> parts = (List<Map>) content.get("parts");
            return (String) parts.get(0).get("text");
        } catch (Exception e) {
            return "응답 형식을 분석하는 데 실패했습니다.";
        }
    }
}