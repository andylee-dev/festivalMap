package com.oracle.s202350104.service.user;

import java.io.IOException;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.oracle.s202350104.controller.kakaoOauth;

@Service
public class oAuthService {
	
	private static KakaoUserInfoDto getKakaoUserInfoDto(String code) throws JsonProcessingException {
		ResponseEntity<String> accessTokenResponse = kakaoOauth.requestAccessToken(code);
		KakaoOauthTokenDto oAuthToken = kakaoOauth.getAccessToken(accessTokenResponse);
		ResponseEntity<String> userInfoResponse = kakaoOauth.requestUserInfo(oAuthToken);
		KakaoUserInfoDto kakaoUser = kakaoOauth.getUserInfo(userInfoResponse);
		return kakaoUser;
	}

	public static ResponseEntity<String> kakaoLogin(String code) throws IOException {
		KakaoUserInfoDto kakaoUser = getKakaoUserInfoDto(code);
		
		return null;
		
		
	}

}
