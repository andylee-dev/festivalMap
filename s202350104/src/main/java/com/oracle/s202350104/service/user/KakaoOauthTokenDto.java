package com.oracle.s202350104.service.user;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter

public class KakaoOauthTokenDto {
	private String access_token;
	private String refresh_token;
	private Integer refresh_token_expires_in;
	private Integer expirse_in;
	private String scope;
	private String token_type;

}
