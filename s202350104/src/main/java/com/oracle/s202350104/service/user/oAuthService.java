package com.oracle.s202350104.service.user;

import java.io.IOException;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.oracle.s202350104.controller.kakaoOauth;
import com.oracle.s202350104.model.Users;

@Service
public class oAuthService {
	
	/* private final UserRepository userRepository; */
	
	private static KakaoUserInfoDto getKakaoUserInfoDto(String code) throws JsonProcessingException {
		ResponseEntity<String> accessTokenResponse = kakaoOauth.requestAccessToken(code);
		KakaoOauthTokenDto oAuthToken = kakaoOauth.getAccessToken(accessTokenResponse);
		ResponseEntity<String> userInfoResponse = kakaoOauth.requestUserInfo(oAuthToken);
		KakaoUserInfoDto kakaoUser = kakaoOauth.getUserInfo(userInfoResponse);
		return kakaoUser;
	}

	public static ResponseEntity<String> kakaoLogin(String code) throws IOException {
		KakaoUserInfoDto kakaoUser = getKakaoUserInfoDto(code);
		/*
		 * if(!userRepository.existsByEmail(kakaoUser.getEmail())) {
		 * userRepository.save( User.builder() .email(kakaoUser.getmail())
		 * .nickName(kakaoUser.getName()) .password("kakao") .id(kakaoUser.getName() +
		 * LocalDateTime.now()) .build() );
		 * 
		 * return getSingleResult(userRepository.findByEmail( kakaoUser.getEmail()
		 * ).orElseThrow(CEmailSignFailedException::new));
		 * 
		 * } return getSingleResult(userRepository.findByEmail( kakaoUser.getEmail()
		 * ).orElseThrow(CEmailSignFailedException::new));
		 */
		return null;
			
		
		
		
	}

}
