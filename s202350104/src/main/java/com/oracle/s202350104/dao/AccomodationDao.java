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
	int                             updateAccomodation(AccomodationContent accomodation);
	int                             approveAccomodation(AccomodationContent accomodation);
	List<AccomodationContent>       listSmallCode(AccomodationContent accomodationContent);
	List<AccomodationContent>       listSearchAccomodation(AccomodationContent accomodationContent);
	int                             totalSearchAccomodation(AccomodationContent accomodationContent);
	int                             conTotalAccomdation(AccomodationContent accomodation);
	List<AccomodationContent>       indexlistSearchAccomodation(AccomodationContent accomodation);
	int                             admintotalAccomodation();
	int                             accomodationRestore(int contentId);

	



}
