package com.oracle.s202350104.service;

import java.util.List;


import com.oracle.s202350104.model.AccomodationContent;
import com.oracle.s202350104.model.Areas;


public interface AccomodationService {

	List<AccomodationContent>  listAccomodation(AccomodationContent accomodation);
	AccomodationContent        detailAccomodation(int contentId);
	int                        totalAccomodation();
	int                        accomodationDelete(int contentId);
	void                       insertAccomodation(AccomodationContent accomodation);
	int                        updateAccomodation(AccomodationContent accomodation);
	int 					   approveAccomodation(int contentId);
	List<AccomodationContent>  listSmallCode(AccomodationContent accomodationContent);
	List<AccomodationContent>  listSearchAccomodation(AccomodationContent accomodationContent);
	int                        totalSearchAccomodation(AccomodationContent accomodationContent);
	int                        conTotalAccomodation(AccomodationContent accomodation);
	List<AccomodationContent>  indexlistSearchAccomodation(AccomodationContent accomodation);
	int                        admintotalAccomodation();



	

}
