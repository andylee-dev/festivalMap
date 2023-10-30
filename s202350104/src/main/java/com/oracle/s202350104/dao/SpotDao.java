package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Spot;
import com.oracle.s202350104.model.SpotContent;

public interface SpotDao {

	List<Spot> listSpot(SpotContent spotContent);

}
