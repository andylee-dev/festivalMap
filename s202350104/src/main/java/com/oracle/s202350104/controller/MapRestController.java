package com.oracle.s202350104.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.oracle.s202350104.service.AreaService;
import com.oracle.s202350104.service.map.MapService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
public class MapRestController {
	private final MapService kakaoMapService;
	
	@RequestMapping("/api/searchAddress")
    public String searchAddress(@RequestParam String query) {
        return kakaoMapService.searchAddress(query);
    }
}
