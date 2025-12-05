# YoRIZORi
## Cooking business information system

**YoRIZORi**는 사용자의 레시피 정보를 기반으로 레시피를 공유하고, 취향에 맞는 새로운 요리를 추천하는 플랫폼입니다. 
사용자들끼리 실시간 채팅을 통해 레시피를 공유하고 요리 팁을 나눌 수 있습니다. 
---

<img src="images/MoodSync_desc.png" alt="포스터" width="100%"/> 

---

<h2>🌟프로젝트 기능개요(기여도: 상: ⭐/ 중: ★/ 하: ☆)</h2>

| 기능명 | 설명 | 기여도 |
|--------|------|--------|
| **챗봇 레시피 Q&A** | Gemini RAG로 DB 레시피 정보만 답변 | 중 ★ |
| **실시간 단체 채팅** |  WebSocket 그룹 채팅, 최근 메시지 조회 | 상 ⭐ |
| **레시피 등록/카테고리** | WebSocket 그룹 채팅, 최근 메시지 조회 |  중 ★ |
| **추천/검색 뷰** | 메인·리스트·상세 JSP로 레시피 탐색 |  중 ★ |
| **게시판/공지** | 커뮤니티 글, 댓글, 공지 CRUD | 중 ★ |
| **마이페이지/쪽지** | 북마크·내 레시피·쪽지함 관리 | 상 ⭐ |
| **문의/피드백 처리** | 게시판/공지로 수집(현 구조 활용) | 하 ☆ |

---

<h2>🛠️ 기술 스택</h2>

📌 Backend

Java 17
Spring Framework / Spring MVC
Spring Security
MyBatis
Tomcat
Oracle Database
Google(Gmail) API 연동

<p align="left"> <img src="https://img.shields.io/badge/Java 17-007396?style=for-the-badge&logo=openjdk&logoColor=white"/> <img src="https://img.shields.io/badge/Spring MVC-6DB33F?style=for-the-badge&logo=spring&logoColor=white"/> <img src="https://img.shields.io/badge/Spring Security-6DB33F?style=for-the-badge&logo=springsecurity&logoColor=white"/> <img src="https://img.shields.io/badge/MyBatis-14274E?style=for-the-badge&logo=databricks&logoColor=white"/> <img src="https://img.shields.io/badge/Tomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black"/> <img src="https://img.shields.io/badge/Oracle DB-F80000?style=for-the-badge&logo=oracle&logoColor=white"/> <img src="https://img.shields.io/badge/Google API-4285F4?style=for-the-badge&logo=google&logoColor=white"/> </p>
📌 Frontend
JSP
HTML5 / CSS3
JavaScript
jQuery

<p align="left"> <img src="https://img.shields.io/badge/JSP-007396?style=for-the-badge&logo=java&logoColor=white"/> <img src="https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white"/> <img src="https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white"/> <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black"/> <img src="https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white"/> </p>
📌 Version Control
Git / GitHub
<p align="left"> <img src="https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white"/> <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white"/> </p>


### 📌 데이터 및 모델링
- 사용자 감정 입력값 (행복, 슬픔, 스트레스, 차분함, 흥분, 피곤함)
- 예측 모델: TensorFlow.js 기반의 Multi-class Classification
- 이탈 분석 모델: 사용자 활동 수, 피드백, 최근 활동 기반 Churn 예측


---

<h2>📊 핵심 세부기능 설명</h2>

### ✅ 감정 기반 추천 시스템
- 6가지 감정에 따라 콘텐츠 추천
- DB에 저장된 100개의 추천 활동/책/음악 리스트 제공

### ✅ 감정 예측 모델
- 감정 입력(6차원 벡터) → 대표 감정 클래스 예측
- Express + TensorFlow.js 서버 구성

### ✅ 사용자 분석 기능
- 감정 이력 시계열 분석  
- 감정 유형별 사용자 군집화 (K-means 활용)
- 최근 활동 및 피드백 기반 이탈 가능성 예측

---

## 🎬 전체 보기(자세히)

<details>
  <summary>✨UI/UX 테마 보기</summary>

  <h3>◈ 메인 페이지 구성</h3>
  <img src="images/total/main_page.png" alt="main_page" width="100%"/>

  <h3>◈ 로그인/회원가입 UI</h3>
  <img src="images/total/main_join.png" alt="main_join" width="100%"/>

  <h3>◈ Footer</h3>
  <img src="images/total/footer_info.png" alt="footer_info" width="100%"/>
    <details>
      <summary><h4>개인정보 처리방침</h4></summary>
      <img src="images/total/footer_info_rule.png" alt="footer_info_rule" width="100%"/>
    </details>
    <details>
      <summary><h4>이용약관</h4></summary>
      <img src="images/total/footer_info_using.png" alt="footer_info_using" width="100%"/>
    </details>
    <details>
      <summary><h4>회사소개</h4></summary>
      <img src="images/total/footer_info_company.png" alt="footer_info_company" width="100%"/>
    </details>
    <details>
      <summary><h4>도움말</h4></summary>
      <img src="images/total/footer_help.png" alt="footer_help" width="100%"/>
    </details>

  <h3>◈ 다크 모드</h3>
  <img src="images/total/main_dark.png" alt="main_dark" width="100%"/>

  <p>이 이외의 UI/UX에 대해서는 다른 기능설명에서 제공하도록 하겠습니다!</p>
</details>

<details>
  <summary>✨추천 요청하기 보기</summary>
  <h3>◈ 사용자 감정 입력 UI</h3>
  <h4>감정 컨텐트</h4>
  <img src="images/recommendation/emotion_select_UI.png" alt="emotion_select_UI" width="100%"/>
  <h4>입력 결과 사이드 탭</h4>
  <img src="images/recommendation/emotion_selected_tab.png" alt="emotion_selected_tab" width="100%"/>

  <h3>◈ 감정 입력 : SliderCard</h3>
  <img src="images/recommendation/emotion_select_slider.png" alt="emotion_select_slider" width="100%"/>

  <h3>◈ 감정 입력 : Face-API</h3>
  <img src="images/recommendation/emotion_face2.png" alt="emotion_face2" width="100%"/>
  <img src="images/recommendation/emotion_face1.png" alt="emotion_face1" width="100%"/>

  <h3>◈ Recommendation</h3>
  <img src="images/total/footer_info.png" alt="footer_info" width="100%"/>
  <details>
    <summary><h4>Music</h4></summary>
    <img src="images/recommendation/recom_music.png" alt="recom_music" width="100%"/>
    <img src="images/recommendation/music_content.png" alt="music_content" width="100%"/>
    <img src="images/recommendation/music_content2.png" alt="music_content2" width="100%"/>
  </details>
  <details>
    <summary><h4>Activity</h4></summary>
    <img src="images/recommendation/recom_act.png" alt="recom_act" width="100%"/>
  </details>
  <details>
    <summary><h4>Book</h4></summary>
    <img src="images/recommendation/recom_book.png" alt="recom_book" width="100%"/>
    <img src="images/recommendation/book_content.png" alt="book_content" width="100%"/>
    <img src="images/recommendation/book_content2.png" alt="book_content2" width="100%"/>
  </details>
</details>

<details>
  <summary>✨마이페이지 보기</summary>
  <h3>◈ 마이페이지 UI</h3>
  <img src="images/mypage/mypage_UI2.png" alt="mypage_UI2" width="100%"/>
  <img src="images/mypage/mypage_UI1.png" alt="mypage_UI1" width="100%"/>
  
  <h3>◈ 일자별 감정 차트 및 컨텐트 목록</h3>
  <details>
    <summary><h4>감정 분포 차트</h4></summary>
    <img src="images/mypage/mypage_daily1.png" alt="mypage_daily1" width="100%"/>
  </details>
  <details>
    <summary><h4>RecommendationList : Music</h4></summary>
    <img src="images/mypage/mypage_daily2.png" alt="mypage_daily2" width="100%"/>
  </details>
  <details>
    <summary><h4>RecommendationList : Activity & Book</h4></summary>
    <img src="images/mypage/mypage_daily3.png" alt="mypage_daily3" width="100%"/>
  </details>
  
  <h3>◈ 주간 감정 추세</h3>
  <img src="images/mypage/mypage_week.png" alt="mypage_week" width="100%"/>

  <h3>◈ 주간 추천 기록</h3>
  <img src="images/mypage/mypage_week_using.png" alt="mypage_week_using" width="100%"/>  
</details>

<details>
  <summary>✨컬렉션 보기</summary>
  <h3>◈ 컬렉션페이지 UI</h3>
  <h4>공개 컬렉션</h4>
  <img src="images/collection/collection_open_UI.png" alt="collection_open_UI" width="100%"/>

  <h4>나의 컬렉션</h4>
  <img src="images/collection/collection_my_UI.png" alt="collection_my_UI" width="100%"/>
  
  <h3>◈ 컬렉션 CRUD</h3>
  <h4>컬렉션 content</h4>
  <img src="images/collection/collection_content.png" alt="collection_content" width="100%"/>

  <h4>새 컬렉션 생성</h4>
  <img src="images/collection/collection_new.png" alt="collection_new" width="100%"/>

  <h4>컬렉션 상세보기</h4>
  <img src="images/collection/collection_desc.png" alt="collection_desc" width="100%"/>

  <h4>컬렉션 수정모드</h4>
  <img src="images/collection/collection_modify.png" alt="collection_modify" width="100%"/>
  
</details>

<details>
  <summary>✨관리자페이지 보기</summary>
  <iframe width="560" height="315" src="https://www.youtube.com/embed/영상ID" frameborder="0" allowfullscreen></iframe>
</details>

<details>
  <summary>✨문의하기 보기</summary>
  <iframe width="560" height="315" src="https://www.youtube.com/embed/영상ID" frameborder="0" allowfullscreen></iframe>
</details>

<details>
  <summary>✨피드백 보기</summary>
  <iframe width="560" height="315" src="https://www.youtube.com/embed/영상ID" frameborder="0" allowfullscreen></iframe>
</details>

---

<h2>🧬 테이블 명세서 및 ERD </h2>

<h3> Entity-Relationship Diagram </h3>
<img src="images/ERD.png" alt="ERD" width="100%"/>
<details>
  <summary><h4> 🔍테이블 세부 명세서🔍 </h4></summary>
  <img src="images/ERD_desc1.webp" alt="ERD" width="100%"/>
  <img src="images/ERD_desc2.webp" alt="ERD" width="100%"/>
  <img src="images/ERD_desc3.webp" alt="ERD" width="100%"/>
  <img src="images/ERD_desc4.webp" alt="ERD" width="100%"/>
  <img src="images/ERD_desc5.webp" alt="ERD" width="100%"/>
  <img src="images/ERD_desc6.webp" alt="ERD" width="100%"/>
  <img src="images/ERD_desc7.webp" alt="ERD" width="100%"/>
  <img src="images/ERD_desc8.webp" alt="ERD" width="100%"/>
  <img src="images/ERD_desc9.webp" alt="ERD" width="100%"/>
  <img src="images/ERD_desc10.webp" alt="ERD" width="100%"/>
  <img src="images/ERD_desc11.webp" alt="ERD" width="100%"/>
  <img src="images/ERD_desc12.webp" alt="ERD" width="100%"/>
  <img src="images/ERD_desc13.webp" alt="ERD" width="100%"/>
</details>

---

## 🗂️ 시스템 구조도
 <img src="images/system_structure.webp" alt="system_structure" width="100%"/>
