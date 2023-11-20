package com.oracle.s202350104.configuration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class SetCurrentPageInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 요청 전에 실행됩니다.
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        // 핸들러 메소드 호출 후 view로 이동하기 전에 실행됩니다.
        if (modelAndView != null) {
            // 현재 페이지의 model 객체를 가져와서 currentPage를 추가합니다.
            modelAndView.addObject("currentPageUrl", request.getRequestURI());
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        // 요청 처리가 완료된 후 실행됩니다.
    }
}
