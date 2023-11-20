package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.oracle.s202350104.model.Areas;
import com.oracle.s202350104.service.AreaService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
public class AreasRestController {
	private final AreaService areaService;

	@RequestMapping(value = "/getAreas", method = RequestMethod.GET)
	public List<Areas> getAreasList() {
		UUID transactionId = UUID.randomUUID();
		List<Areas> listAreas = null;
		try {
			log.info("[{}]{}:{}", transactionId, "getAreas", "start");
			listAreas = areaService.listAreas();
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "getAreas", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "getAreas", "end");
		}
		return listAreas;
	}

	@RequestMapping(value = "/getSigungu/{selectedArea}", method = RequestMethod.GET)
	public List<Areas> getSigunguList(@PathVariable int selectedArea) {
		UUID transactionId = UUID.randomUUID();
		List<Areas> listSigungu = null;
		try {
			log.info("[{}]{}:{}", transactionId, "getSigungu", "start");
			listSigungu = areaService.listSigungu(selectedArea);
			log.info("selectedArea- {}",selectedArea);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "getSigungu", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "getSigungu", "end");
		}
		return listSigungu;
	}

}
