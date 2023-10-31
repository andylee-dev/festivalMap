package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Accomodations;
import com.oracle.s202350104.model.AccomodationsContent;

public interface AccomodationsDao {

	List<Accomodations>        listAccomodations();

	AccomodationsContent       detailAccomodations(int content_id);

	



}
