package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.AccomodationsContent;

public interface AccomodationsDao {

	List<AccomodationsContent>      listAccomodations(AccomodationsContent accomodations);
	AccomodationsContent       		detailAccomodations(int content_id);
	int								totalAccomodations();

	



}
