package com.web.www.service;

import java.util.List;

import com.web.www.domain.coupon.Coupon;
import com.web.www.domain.hotel.RoomDetailImageVO;
import com.web.www.domain.hotel.RoomInfoVO;
import com.web.www.domain.hotel.RoomVO;

public interface HotelService {

	int updateRoomInfo(RoomInfoVO rivo);

	int addRoom(RoomVO rvo);

	List<RoomVO> getRoomList();

	int deleteRoom(int hotelRoomNum);

	int modifyRoom(RoomVO rvo);

	int selectRoomCnt();

	int cheakRoomCount(int hotelRoomNum);

	RoomVO getRoomDetail(int roomNum);

	void addRoomImage(RoomDetailImageVO roomDetailImageVO);

	RoomDetailImageVO getRoomDetailImageVO(int roomNum);

	List<RoomDetailImageVO> getimageList();

}
