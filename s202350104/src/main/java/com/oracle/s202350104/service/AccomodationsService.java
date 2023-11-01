package com.oracle.s202350104.service;

import java.util.List;


import com.oracle.s202350104.model.AccomodationsContent;

public interface AccomodationsService {

	List<AccomodationsContent>  listAccomodations(AccomodationsContent accomodations);
	AccomodationsContent        detailAccomodations(int content_id);
	int                         totalAccomodations();
	

}
