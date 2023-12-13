<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 관리자 게시판</title>
<link  href="/resources/css/developer/setting.css" rel="stylesheet">
<link  href="/resources/css/developer/devNotice.css" rel="stylesheet">
</head>
<body>
<div class="devMainContainer">
	<div class="devNav">
		<div class="marquee marquee1">
			  <p class="marquee-text"><img alt="" height="50" src="/resources/etc/line.png"></p>
		</div>	
	</div>
	
	<div class="devBody">	
		<jsp:include page="../common/devCategory.jsp"></jsp:include>
		

		<div class="mmmmainContainer dev-container">
		<!-- 각자 페이지 개발구역 -->
		<div class="dev-notice-container">
			<div class="dev-notice-regbtn-container">
				<a href="/notice/register">
				<div class="d-grid gap-2 col-3 mx-auto dev-notice-regbtn-container2">
				  <button type="button" class="btn btn-primary">공지사항 등록하기</button>
				</div>
				</a>
			</div>
			
			
			<!-- 게시글 목록 테이블 라인 -->
			<div class="accordion accordion-flush" id="accordionFlushExample">
			  <div class="accordion-item">
			    <h2 class="accordion-header">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
			        중요 게시물 목록(총 N개)
			      </button>
			    </h2>
			    <div id="flush-collapseTwo" class="accordion-collapse collapse show" data-bs-parent="#accordionFlushExample">
			      <div class="accordion-body" style="background-color: rgb(208 208 208);">
			      
			      <!-- 검색 라인  -->		      	
					<div class="container-fluid">
						<form action="/developer/settingNotice" class="d-flex" role="search" method="get">
							<div class="dropdown btn-group">
							  <select class="dropdown-toggle" name="type" data-bs-toggle="dropdown" aria-expanded="false">
							   	<option class="dropdown-item" value="tcw" ${typed eq 'tcw' ? 'selected' : '' }>전체</option>
							   	<option class="dropdown-item" value="t" ${typed eq 't' ? 'selected' : '' }>제목</option>
							   	<option class="dropdown-item" value="c" ${typed eq 'c' ? 'selected' : '' }>내용</option>
							   	<option class="dropdown-item" value="w" ${typed eq 'w' ? 'selected' : '' }>작성자</option>
							  </select>
							</div>
							<div class="">
								<input placeholder="검색어를 입력해 주세요." name="keyword" type="search" value="" class="form-control me-2">
								<input type="hidden" name="pageNo" value="1">
								<input type="hidden" name="qty" value="${ph.pgvo.qty }">
							</div>
								<button class="btn btn-primary" type="submit"><div>검색</div></button>
								<a href="/developer/settingNotice">
								<button type="button" class="btn btn-success" style="margin-left: 5px;">전체</button>
								</a>
						</form>
					</div><br>
			      
			      <!-- 테이블 라인 -->
			      	<table class="table table-dark table-hover">
					  <thead>
					    <tr class="dev-notice-tr">
					      <th scope="col" class="dev-notice-no">No.</th>
					      <th scope="col" class="dev-notice-category">게시물 분류</th>
					      <th scope="col" class="dev-notice-title">게시물 제목</th>
					      <th scope="col" class="dev-notice-writer">작성자</th>
					      <th scope="col" class="dev-notice-reg">작성일시</th>
					      <th scope="col" class="dev-notice-point-modify">게시물 관리</th>
					    </tr>
					  </thead>
					  <tbody>
					  	<c:forEach items="${plist }" var="pvo">
					  	<c:if test="${ph.pgvo.keyword == '' || ph.pgvo.keyword == null || ph.pgvo.keyword == '공지사항' || ph.pgvo.keyword == '이벤트' || ph.pgvo.keyword == '보도자료' || ph.pgvo.keyword == '쇼핑몰' || ph.pgvo.keyword == '채용정보' || ph.pgvo.keyword == '기타' }">
					    <tr class="dev-notice-tr">
					      <td>${pvo.noticeNum }</td>
					      <td>${pvo.noticeCategory }</td>
					      <td class="dev-notice-title-td"><div><a href="/notice/detail?noticeNum=${pvo.noticeNum }">${pvo.noticeTitle }</a></div></td>
					      <td>${pvo.noticeWriter }</td>
					      <td>${fn:replace((fn:substring(pvo.noticeRegAt,0,10)),'-','.') }</td>
					      <td style="text-align: left; background-color: black;">
					      	<a href="/notice/modify?noticeNum=${pvo.noticeNum }">
								<button type="button" class="btn btn-warning">수정</button>
							</a>
							<a href="/developer/noticeRemove?noticeNum=${pvo.noticeNum }">
								<button type="button" class="btn btn-danger">삭제</button>
							</a>
							<div class="dev-notice-point-isok">
								<div class="form-check form-switch">
								  <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckChecked" checked>
								   <span>중요공지 등록</span>
								  <button>적용</button>
								</div>
							</div>
							<div class="dev-notice-point-isok">
								<div class="form-check form-switch">
								  <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckChecked" checked>
								   <span>상단슬라이드 등록</span>
								  <button>적용</button>
								</div>
							</div>
					      </td>
					    </tr>
					    </c:if>
					    </c:forEach>
					  </tbody>
					</table>
					
					<!-- 페이징 라인 -->
					<div class="notice-paging-container">
					  <nav aria-label="Page navigation example">
					  	<!-- 이전 -->
					  	<ul class="pagination notice-paging-ul">					  
					  		<li class="page-item ${(ph.prev eq false) ? 'disabled' : '' }">
						  		<a class="page-link" href="/developer/settingNotice?pageNo=${ph.startPage - 1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}" aria-label="Previous">
						  		<span aria-hidden="true">&laquo;</span>
						  		</a>
					  		</li>
					  		<c:forEach begin="${ph.startPage }" end="${ph.endPage }" var="i">
			  					<li>
			  						<a class="page-link" href="/developer/settingNotice?pageNo=${i }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}">${i }</a>
			  					</li>
			  				</c:forEach>
			  			<!-- 다음 -->
			  				<li class="page-item ${(ph.next eq false) ? 'disabled' : ''}">
			  					<a class="page-link" href="/developer/settingNotice?pageNo=${ph.endPage + 1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}" aria-label="Next">
			        			<span aria-hidden="true">&raquo;</span>
			    				</a>
			  				</li>	
					  	</ul>
					  </nav>
					</div>
					
					
			      </div>
			    </div>
			  </div>
			  
			  
			  <div class="accordion-item">
			    <h2 class="accordion-header">
			      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="true" aria-controls="flush-collapseOne">
			        게시물 목록 (총 N개)
			      </button>
			    </h2>
			    <div id="flush-collapseOne" class="accordion-collapse collapse show" data-bs-parent="#accordionFlushExample">
			      <div class="accordion-body" style="background-color: rgb(208 208 208);">
			      
			      	<!-- 검색 라인  -->		      	
					<div class="container-fluid">
						<form action="/developer/settingNotice" class="d-flex" role="search" method="get">
							<div class="dropdown btn-group">
							  <select class="dropdown-toggle" name="type" data-bs-toggle="dropdown" aria-expanded="false">
							   	<option class="dropdown-item" value="tcw" ${typed eq 'tcw' ? 'selected' : '' }>전체</option>
							   	<option class="dropdown-item" value="t" ${typed eq 't' ? 'selected' : '' }>제목</option>
							   	<option class="dropdown-item" value="c" ${typed eq 'c' ? 'selected' : '' }>내용</option>
							   	<option class="dropdown-item" value="w" ${typed eq 'w' ? 'selected' : '' }>작성자</option>
							  </select>
							</div>
							<div class="">
								<input placeholder="검색어를 입력해 주세요." name="keyword" type="search" value="" class="form-control me-2">
								<input type="hidden" name="pageNo" value="1">
								<input type="hidden" name="qty" value="${ph.pgvo.qty }">
							</div>
								<button class="btn btn-primary" type="submit"><div>검색</div></button>
						</form>
					</div><br>			      
			 
			      	<!-- 테이블 라인 -->
			      	<table class="table table-hover">
					  <thead>
					    <tr class="dev-notice-tr">
					      <th scope="col" class="dev-notice-no">No.</th>
					      <th scope="col" class="dev-notice-category">게시물 분류</th>
					      <th scope="col" class="dev-notice-title">게시물 제목</th>
					      <th scope="col" class="dev-notice-writer">작성자</th>
					      <th scope="col" class="dev-notice-reg">작성일시</th>
					      <th scope="col" class="dev-notice-modify">게시물 관리</th>
					    </tr>
					  </thead>
					  <tbody>
					  	<c:forEach items="${list }" var="nvo">
					    <tr class="dev-notice-tr">
					      <td>${nvo.noticeNum }</td>
					      <td>${nvo.noticeCategory }</td>
					      <td class="dev-notice-title-td"><div><a href="/notice/detail?noticeNum=${nvo.noticeNum }">${nvo.noticeTitle }</a></div></td>
					      <td>${nvo.noticeWriter }</td>
					      <td>${fn:replace((fn:substring(nvo.noticeRegAt,0,10)),'-','.') }</td>
					      <td>
					      	<a href="/notice/modify?noticeNum=${nvo.noticeNum }">
								<button type="button" class="btn btn-warning">수정</button>
							</a>
							<a href="/developer/noticeRemove?noticeNum=${nvo.noticeNum }">
								<button type="button" class="btn btn-danger">삭제</button>
							</a>
					      </td>
					    </tr>
					    </c:forEach>
					  </tbody>
					</table>
					
					<br>
		
					<!-- 페이징 라인 -->
					<div class="notice-paging-container">
					  <nav aria-label="Page navigation example">
					  	<!-- 이전 -->
					  	<ul class="pagination notice-paging-ul">
					  		<li class="page-item ${(ph.prev eq false) ? 'disabled' : '' }">
						  		<a class="page-link" href="/developer/settingNotice?pageNo=${ph.startPage - 1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}" aria-label="Previous">
						  		<span aria-hidden="true">&laquo;</span>
						  		</a>
					  		</li>
					  		<c:forEach begin="${ph.startPage }" end="${ph.endPage }" var="i">
			  					<li>
			  						<a class="page-link" href="/developer/settingNotice?pageNo=${i }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}">${i }</a>
			  					</li>
			  				</c:forEach>
			  			<!-- 다음 -->
			  				<li class="page-item ${(ph.next eq false) ? 'disabled' : ''}">
			  					<a class="page-link" href="/developer/settingNotice?pageNo=${ph.endPage + 1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}" aria-label="Next">
			        			<span aria-hidden="true">&raquo;</span>
			    				</a>
			  				</li>	
					  	</ul>
					  </nav>
					</div>
					
			      </div>
			    </div>
			  </div>  
			</div>
			

		</div>
	</div>	
	</div>
</div>
<script type="text/javascript" src="/resources/js/developer/setting.js"></script>
</body>
</html>