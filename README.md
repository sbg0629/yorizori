# 🍳 YoriZori — 요리 정보 제공 & 레시피 커뮤니티 플랫폼

<p align="center">
  <img src="https://github.com/user-attachments/assets/3f5231f5-e368-4875-9b5e-bcb8ff08f52e" alt="재미나이 이미지 YoriZori Project Banner" />
</p>




## 📌 프로젝트 소개
**YoriZori**는 사용자가 다양한 레시피를 공유하고, 북마크하며,  
실시간 채팅과 1:1 쪽지를 통해 소통할 수 있는 **요리 정보 플랫폼**입니다.  
STS3 → STS4 기반으로 전체 기술 스택을 안정적으로 리빌드했으며,  
Spring 기반의 서버, JSP 화면, Oracle DB, MyBatis, Spring Security 등  
최신 기술을 활용해 CRUD, 인증/인가, 커뮤니티 기능을 제공합니다.

sts3 ->  https://github.com/kh2yorizori/kh2_yorizori
---

## ✨ 주요 기능

- **회원 관리**: 회원가입, 로그인/로그아웃, 마이페이지, 회원 정보 수정, Spring Security 기반 인증/권한 관리
- **레시피 관리**: 레시피 등록/수정/삭제, 전체/카테고리별/내 레시피 조회, 북마크(즐겨찾기)
- **게시판**: 공지사항 게시판, 게시글 작성/수정/삭제
- **커뮤니티**: 실시간 채팅(WebSocket), AI 요리 챗봇(Gemini), 1:1 쪽지 기능

---

## 📸 서비스 화면

<!-- 1 -->
### 🔐 로그인 / 🧾 메인 페이지
<p align="center">
  <img src="https://github.com/user-attachments/assets/f7193ac1-6d4f-4f84-9dc9-e1f67d233842" width="47%" />
  <img src="https://github.com/user-attachments/assets/e28d85b0-2158-4f78-8869-3a88241671b7" width="47%" />
</p>

<!-- 2 -->
### 🥘 레시피 목록 / 🍳 레시피 상세 페이지
<p align="center">
  <img src="https://github.com/user-attachments/assets/1f24b8c3-0a7b-4b04-8e7c-00190cdcb368" width="47%" />
  <img src="https://github.com/user-attachments/assets/a608aaad-3331-47f4-9e9e-d42bd2b11d65" width="47%" />
</p>


<!-- 3 -->
### 💬 실시간 채팅 / 🤖 AI 요리 챗봇(Gemini)
<p align="center">
  <img src="https://github.com/user-attachments/assets/92ba12a9-38b6-465a-b5aa-c13f70f18123" width="47%" />
  <img src="https://github.com/user-attachments/assets/1d43cb23-df41-4dda-a2f3-f7adbf9a04bc" width="47%" />
</p>

<!-- 4 -->
### 🔐 공지사항 / 🔐 게시판 페이지
<p align="center">
  <img src="https://github.com/user-attachments/assets/b1603884-e6ef-4af8-9f92-0b7292793e69" width="47%" />
  <img src="https://github.com/user-attachments/assets/fdd8a51f-6b18-4134-8bc3-c04dd7ae5da1" width="47%" />
</p>

<!-- 5 -->
### 🔐 쪽지 목록 / 🔐 쪽지 상세 페이지
<p align="center">
  <img src="https://github.com/user-attachments/assets/0535efa8-5177-4df5-b391-fcde6d0c22a4" width="47%" />
  <img src="https://github.com/user-attachments/assets/3ab112f6-6d08-4837-b0ca-eb1bca8f1fb2" width="47%" />
</p>

<!-- 6 -->
### 🔐 쪽지 작성 / 🔐 쪽지함 페이지
<p align="center">
  <img src="https://github.com/user-attachments/assets/10347bda-a261-4207-ba53-e0e06a193df3" width="47%" />
  <img src="https://github.com/user-attachments/assets/90216f2f-c64f-4105-822e-0b46679117b3" width="47%" />
</p>

<!-- 7 -->
### 🔐 마이페이지 / 🔐 추천회원 프로필
<p align="center">
  <img src="https://github.com/user-attachments/assets/16673cd2-7173-4dc2-ace4-789d2cc05088" width="47%" />
  <img src="https://github.com/user-attachments/assets/50fb4226-1330-4bbf-be35-2e121e33e345" width="47%" />
</p>

<!-- 8 -->
### 🔐 북마크 페이지 / 🔐 관리자 페이지
<p align="center">
  <img src="https://github.com/user-attachments/assets/5a9bb62a-e41e-4022-9e26-2aed53107415" width="47%" />
  <img src="https://github.com/user-attachments/assets/8f9a8e66-f531-42d9-b3a7-a57229d65ec2" width="47%" />
</p>






## 🛠 기술 스택

### Backend
- Java 17
- Spring Framework / MVC / Security
- MyBatis
- Tomcat
- Oracle Database

### Frontend
- JSP
- HTML5, CSS3, JavaScript
- jQuery

### DevOps & Tools
- Git / GitHub
- STS3 → STS4
- Gradle
- Postman

<p align="center">
  <img src="https://skillicons.dev/icons?i=java,spring,mysql,html,css,js,git,github" />
</p>

---

## 📁 프로젝트 구조

```bash
YoRiZoRi/
├─ src/main/java/com.boot/
│  ├─ Board/               # 게시판 기능
│  ├─ Chat/                # 실시간 채팅/챗봇
│  ├─ ChatBot.controller/  # 챗봇 컨트롤러
│  ├─ common.dto/          # 공통 DTO
│  ├─ Detailed_Page/       # 레시피 상세페이지
│  ├─ login/               # 로그인/회원 기능
│  ├─ Main_Page/           # 메인 페이지
│  ├─ MY_Page/             # 마이페이지
│  ├─ Notice/              # 공지사항
│  ├─ Recipe/              # 레시피 CRUD
│  ├─ config/
│  │  ├─ WebMvcConfig.java
│  │  └─ UnreadMessageInterceptor.java
│  └─ YoRiZoRiApplication.java
│
├─ src/main/resources/
│  ├─ mybatis.mappers/     # MyBatis 매퍼 XML
│  ├─ templates/           # (필요시) Thymeleaf 템플릿
│  ├─ static/              # 정적 파일(CSS/JS)
│  ├─ application.properties
│  └─ mybatis-config.xml
│
├─ src/main/webapp/
│  ├─ WEB-INF/
│  │  ├─ lib/
│  │  └─ views/
│  │     ├─ board/
│  │     ├─ common/
│  │     ├─ notice/
│  │     ├─ recipe/
│  │     ├─ login.jsp
│  │     ├─ home.jsp
│  │     ├─ mypage_edit.jsp
│  │     ├─ myrecipe.jsp
│  │     ├─ recipe_list.jsp
│  │     ├─ recipeDetail.jsp
│  │     └─ write_recipe.jsp
│  └─ web.xml
│
├─ build.gradle
├─ gradlew
├─ gradlew.bat
└─ README.md
```

---

## 👥 팀원 소개

<br>

<h3 align="center">YORIZORI Team</h3>

<br>

<div align="center">

<table>
  <tr>
    <!-- 팀원 1(팀장) -->
    <td align="center">
      <a href="https://github.com/sbg0629">
        <img src="https://github.com/sbg0629.png" width="130" height="130" style="border-radius: 10px;">
        <br><br>
        <b>손봉균 (팀장)</b>
      </a>
      <br>
      <sub>풀스택 - 로그인, 회원가입, 추천 회원, 실시간 채팅, 구글 소셜로그인, 페이징 처리, 게시판</sub>
    </td>
    <!-- 팀원 2 -->
    <td align="center">
       <a href="https://github.com/LeeHyunJin323">
      <img src="https://github.com/LeeHyunJin323.png" width="130" height="130" style="border-radius: 10px;">
      <br><br>
      <b>이현진</b>
          </a>
      <br>
      <sub>백엔드 - 마이페이지, 시큐리티, 네이버·카카오 소셜로그인, 댓글/대댓글, 공지 사항</sub>
    </td>
    <!-- 팀원 3 -->
    <td align="center">
       <a href="https://github.com/RollingSoap">
      <img src="https://github.com/RollingSoap.png" width="130" height="130" style="border-radius: 10px;">
      <br><br>
      <b>박동영</b>
          </a>
      <br>
      <sub>백엔드 - 레시피 페이지, 카테고리 구현, Gemini 챗봇, 이메일 인증</sub>
    </td>
    <!-- 팀원 4 -->
    <td align="center">
       <a href="https://github.com/Rootplant">
      <img src="https://github.com/Rootplant.png" width="130" height="130" style="border-radius: 10px;">
      <br><br>
      <b>정찬호</b>
          </a>
      <br>
      <sub>백엔드 - 레시피 상세페이지, 쪽지 기능, 이미지 처리</sub>
    </td>
  </tr>
</table>

</div>

<br>

---

## 🧩 기타 특장점

- **JWT + Spring Security 기반 인증/인가**
- **WebSocket 기반 실시간 채팅**
- **REST API 기반 통신 구성**
- **컴포넌트 기반 UI 구조 채택**

---
