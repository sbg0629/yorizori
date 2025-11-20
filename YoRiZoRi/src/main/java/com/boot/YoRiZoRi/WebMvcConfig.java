package com.boot.YoRiZoRi;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    // 이미지를 저장한 서버의 절대 경로를 상수로 지정합니다.
    private final String IMAGE_UPLOAD_PATH = "file:///C:/dev/test_img/";
    
 // ✅ [수정 핵심] Interceptor 인스턴스를 주입받습니다.
    @Autowired
    private UnreadMessageInterceptor unreadMessageInterceptor;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 1. 요청 URL 패턴: /images/** 로 들어오는 모든 요청
        // 2. 매핑할 로컬 경로: IMAGE_UPLOAD_PATH (C:/dev/test_img/)
        registry.addResourceHandler("/images/**")
                .addResourceLocations(IMAGE_UPLOAD_PATH);
    }
    
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // ✅ [수정] 주입받은 인스턴스를 등록합니다.
        registry.addInterceptor(unreadMessageInterceptor) 
                .addPathPatterns("/**")
                .excludePathPatterns("/css/**", "/js/**", "/images/**", "/error");
    }
}