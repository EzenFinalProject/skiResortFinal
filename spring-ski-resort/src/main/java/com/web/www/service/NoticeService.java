package com.web.www.service;

import java.util.List;


import com.web.www.domain.board.PagingVO;
import com.web.www.domain.FileVO;
import com.web.www.domain.board.NoticeDTO;
import com.web.www.domain.board.NoticeVO;

public interface NoticeService {

	int noticeRegister(NoticeDTO noticeDTO);

	NoticeDTO noticeDetail(long noticeNum);

	List<NoticeVO> noticeList(PagingVO pgvo);
	
	List<NoticeVO> noticeListNoPaging();
	
	List<FileVO> noticeListFile();

	int noticeModify(NoticeVO nvo);

	int noticeRemove(long noticeNum);

	int getTotalCount(PagingVO pgvo);

	int noticeFileModify(NoticeDTO ndto);

	int noticeRemoveFile(String uuid);

	List<NoticeVO> getTwoNotice();

	List<NoticeVO> noticePointList(PagingVO pgvo);

	List<FileVO> noticeImpactFileList();

	int selectEventCnt();

	void addEvent(NoticeVO noticeVO);

	List<NoticeVO> getFiveEvent();

	int settingNoticePointModify(NoticeVO nvo);


	

	



}
