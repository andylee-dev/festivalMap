package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Spot;
import com.oracle.s202350104.model.SpotContent;

public interface SpotService {

	List<SpotContent> listSpot(SpotContent spotContent);

}
