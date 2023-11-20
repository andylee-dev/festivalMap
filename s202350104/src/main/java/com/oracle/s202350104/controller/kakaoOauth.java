package com.oracle.s202350104.controller;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.oracle.s202350104.service.user.KakaoOauthTokenDto;
import com.oracle.s202350104.service.user.KakaoUserInfoDto;

import lombok.RequiredArgsConstructor;


@Component
@RequiredArgsConstructor



public class kakaoOauth {
	
	private final String KAKAO_TOKEN_REQUEST_URL = "https://kauth.kakao.com/oauth/token";
	
	
	
	public static String responseUrl() {
		String kakaoLoginUrl = "https://kauth.kakao.com/oauth/authorize?client_id=1100bcfd9fdffe4494895e126275157a&redirect_uri=http://localhost:8189/app/login/kakao&response_type=code";
		
		return kakaoLoginUrl;
	}
	
	public static ResponseEntity<String> requestAccessToken(String code) {
	    RestTemplate restTemplate = new RestTemplate();
	    HttpHeaders headers = new HttpHeaders();
	    MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
	    headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
	    
	    parameters.add("grant_type", "authorization_code");
	    parameters.add("client_id", "3d40db7fe264068aa3438b9a0b8b2274");
	    parameters.add("redirect_uri", "http://localhost:8189/app/login/kakao");
	    parameters.add("code", code);
	    
	    HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(parameters, headers);
	    ResponseEntity<String> response = restTemplate.postForEntity("https://kauth.kakao.com/oauth/token", request, String.class);
	    
		return response;
}
	public static KakaoOauthTokenDto getAccessToken(ResponseEntity<String> response) throws JsonProcessingException {
		ObjectMapper objectMapper = new ObjectMapper();
		KakaoOauthTokenDto kakaoOauthTokenDto = objectMapper.readValue(response.getBody(), KakaoOauthTokenDto.class);
		return kakaoOauthTokenDto;
	}
	
	public static ResponseEntity<String> requestUserInfo(KakaoOauthTokenDto oAuthToken) {
		HttpHeaders headers = new HttpHeaders();
		RestTemplate restTemplate = new RestTemplate();
		headers.add("Authorization", "Bearer" + oAuthToken.getAccess_token());
		
		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(headers);
		ResponseEntity<String> response = restTemplate.exchange("https://kapi.kakao.com/v2/user/me",HttpMethod.GET, request, String.class);
		return response;
	}
	
	public static KakaoUserInfoDto getUserInfo(ResponseEntity<String> response) throws JsonProcessingException {
		ObjectMapper objectMapper = new ObjectMapper();
		KakaoUserInfoDto kakaoUserInfoDto = objectMapper.readValue(response.getBody(), KakaoUserInfoDto.class);
		return kakaoUserInfoDto;
		
	}
	
}
