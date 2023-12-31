package com.web.www.repository;

import java.util.List;

import com.web.www.domain.FileVO;

public interface FileDAO {

	int insertNoticeFile(FileVO fvo);

	List<FileVO> getNoticeFileList(long noticeNum);

	int noticeRemoveFile(String uuid);

	int insertQnaFile(FileVO fvo);

	List<FileVO> getQnaFileList(long qnaNum);

	int qnaRemoveFile(String uuid);

	void deleteAllFileQna(long qnaNum);

	void deleteAllFileNotice(long noticeNum);


	int insertItemFile(FileVO fvo);


	int insertQnaAnsFile(FileVO fvo);

	List<FileVO> getQnaAnsFileList(long qnaNum);

	List<FileVO> selectFileImpactList();

	List<FileVO> selectNoticeListFile();

	List<FileVO> selectNoticeListFirstFile(long noticeNum);

	void updateNoticeFile(FileVO ffvo);


}
