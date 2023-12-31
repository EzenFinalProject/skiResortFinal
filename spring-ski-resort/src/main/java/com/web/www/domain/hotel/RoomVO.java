package com.web.www.domain.hotel;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class RoomVO {
	private int hotelRoomNum ;
	private String hotelRoomName;
	private String hotelRoomExplain;
	private int hotelRoomStandardPeople;
	private String hotelRoomType; 
	private String hotelReserveIsok;
	private String hotelRoomArea;
	private int hotelRoomFee;
	private int hotelRoomCount;
	private int hotelInitialCount;

	
	public RoomVO(String hotelRoomName, String hotelRoomExplain, int hotelRoomStandardPeople, String hotelRoomType,
		 String hotelRoomArea, int hotelRoomFee, int hotelRoomCount ,int hotelInitialCount) {
		this.hotelRoomName = hotelRoomName;
		this.hotelRoomExplain = hotelRoomExplain;
		this.hotelRoomStandardPeople = hotelRoomStandardPeople;
		this.hotelRoomType = hotelRoomType;
		this.hotelRoomArea = hotelRoomArea;
		this.hotelRoomFee = hotelRoomFee;
		this.hotelRoomCount = hotelRoomCount;
		this.hotelInitialCount =hotelInitialCount;
	}
	
		
}
