package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Accomodations;
import com.oracle.s202350104.model.AccomodationsContent;

public interface AccomodationsService {

	List<Accomodations>         listAccomodations();

	AccomodationsContent        detailAccomodations(int content_id);

}
