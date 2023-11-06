package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.AccomodationContent;

public interface AccomodationDao {

	List<AccomodationContent>       listAccomodation(AccomodationContent accomodation);
	AccomodationContent       		detailAccomodation(int contentId);
	int								totalAccomodation();
	int                             accomodationDelete(int contentId);
	int                             insertContent(AccomodationContent accomodation);
	int                             insertAccomodation(AccomodationContent accomodation);

	



}
