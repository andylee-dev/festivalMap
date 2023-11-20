package com.oracle.s202350104.service.map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class KakaoMapSerivce implements MapService {

    @Value("${kakao.api.key}")
    private String apiKey;

    private final RestTemplate restTemplate;

    @Override
    public String searchAddress(String query) {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "KakaoAK " + apiKey);

        HttpEntity<String> entity = new HttpEntity<>(headers);
        String apiUrl = "https://dapi.kakao.com/v2/local/search/address.json?query=" + query;

        ResponseEntity<String> response = restTemplate.exchange(apiUrl, HttpMethod.GET, entity, String.class);

        if (response.getStatusCode() == HttpStatus.OK) {
            return response.getBody();
        } else {
            // API 호출 실패 시 예외처리
            return null;
        }
//    	return null;
    }
    @Override
	public String getApiKey() {
    	log.info(apiKey);
		return apiKey;
	}
   
}
