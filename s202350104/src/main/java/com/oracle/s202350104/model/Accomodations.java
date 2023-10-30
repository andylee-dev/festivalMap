package com.oracle.s202350104.model;

import lombok.Data;

@Data
public class Accomodations {
	private int content_id;
	private int room_count;
	private String reservation_url;
	private String refund;
	private String check_in;
	private String check_out;
	private String is_pickup;
	private String is_cook;
	private String is_parking;
	

}
