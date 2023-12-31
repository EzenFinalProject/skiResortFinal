<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다이스키 고객문의 디테일</title>
<jsp:include page="../common/nav.jsp" />
<link rel="stylesheet" href="/resources/css/qna/qna_detail.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
</head>

<body>
<c:set value="${qdto.qvo }" var="qvo"></c:set>
<c:set value="${qadto.qavo }" var="qavo"></c:set>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.mvo.authList" var="auths"/>
	<sec:authentication property="principal.mvo.memberId" var="authId"/>
	<sec:authentication property="principal.mvo.memberEmail" var="authEmail"/>
	<sec:authentication property="principal.mvo.memberType" var="authType"/>
</sec:authorize>


<!-- <div class="qna-img-container" style="background-image: url('https://www.princehotels.com/shinfurano/wp-content/uploads/sites/40/2022/11/2022_11_1920_ski_2-1.jpg')">	</div>
 -->	
<div class="container qna-container">
<div class="qna-header qna-header-two">
	<h1 class="qna-header-h1">고객문의<span class="qna-header-span">Question And Answer</span></h1>
</div>



<div class="qna-menu-container">
	<div class="qna-menu-container-child">



	<table class="table qna-table">
		<thead class="table-secondary">
			<tr class="qna-table-tr">
				<td class="qna-table-td-category">
				      <div class="qna-table-td-child-category">
				      	<c:if test="${qvo.qnaCategory=='스키장' }">
					      	<span class="material-symbols-outlined qna-icon-ski" style="color: #004080;">downhill_skiing</span>
					      	<span class="qna-table-td-child-category-span" style="color: #004080;">${qvo.qnaCategory }</span>
				      	</c:if>
				      	<c:if test="${qvo.qnaCategory=='호텔' }">
					      	<span class="material-symbols-outlined" style="color: #934900;">location_city</span>
					      	<span class="qna-table-td-child-category-span" style="color: #934900;">${qvo.qnaCategory }</span>
				      	</c:if>
				      	<c:if test="${qvo.qnaCategory=='렌탈' }">
					      	<span class="material-symbols-outlined" style="color: #893436;">apparel</span>
					      	<span class="qna-table-td-child-category-span" style="color: #893436;">${qvo.qnaCategory }</span>
				      	</c:if>
				      	<c:if test="${qvo.qnaCategory=='교통' }">
					      	<span class="material-symbols-outlined" style="color: #34702e;">local_taxi</span>
					      	<span class="qna-table-td-child-category-span" style="color: #34702e;">${qvo.qnaCategory }</span>
				      	</c:if>
				      	<c:if test="${qvo.qnaCategory=='예약' }">
					      	<span class="material-symbols-outlined" style="color: #007575;">schedule</span>
					      	<span class="qna-table-td-child-category-span" style="color: #007575;">${qvo.qnaCategory }</span>
				      	</c:if>
				      	<c:if test="${qvo.qnaCategory=='결제' }">
					      	<span class="material-symbols-outlined" style="color: #b3a000;">credit_card</span>
					      	<span class="qna-table-td-child-category-span" style="color: #b3a000;">${qvo.qnaCategory }</span>
				      	</c:if>
				      	<c:if test="${qvo.qnaCategory=='기타' }">
					      	<span class="material-symbols-outlined" style="color: #472e50;">other_admission</span>
					      	<span class="qna-table-td-child-category-span" style="color: #472e50;">${qvo.qnaCategory }</span>
				      	</c:if>
				      </div>
			      </td>	
				  <c:if test="${qvo.qnaSecret=='Y' }">
			      	<c:if test="${(authType == 'normal' && authId == qvo.qnaWriter) || (authType != 'normal' && authEmail == qvo.qnaWriter) || auths.stream().anyMatch(authVO -> authVO.auth.equals('ROLE_ADMIN')).get()}">          
			      		<th scope="col" class="qna-table-th-title"><div class="qna-table-td-title"><span class="material-symbols-outlined" style="font-size: 21px">lock</span>${qvo.qnaTitle }</div></th>
			      	</c:if>
			      </c:if>
			      <c:if test="${qvo.qnaSecret=='N' }">
			      		<th scope="col" class="qna-table-th-title"><div class="qna-table-td-title">${qvo.qnaTitle }</div></th>
			      </c:if>
		      <td class="qna-table-td-category"><div class="qna-table-td-child-reg">${fn:replace((fn:substring(qvo.qnaRegAt,0,10)),'-','.') }</div></td>		      
		    </tr>
		</thead>
		<tbody>		
			<tr class="qna-table-tr">
				<td class="qna-table-td ">
			      	<div class="qna-table-td-child">
			      		<c:if test="${qvo.qnaIsok=='Y' }"><div class="qna-isok-y isok-line isok-end">답변완료</div></c:if>
			      		<c:if test="${qvo.qnaIsok=='N' }"><div class="qna-isok-n isok-line isok-end">대기중</div></c:if>
			      	</div>
		      	</td>
		      	<td class="qna-table-td qna-table-td-writer" colspan="2">
		      		<div class="qna-table-div-writer">${qvo.qnaWriter }</div>
		      	</td>
			</tr>			
			<!-- 내용 표시란 -->
			<tr>
				<td class="qna-table-content" colspan="3" style="padding: 30px 20px;">
					<div class="qna-table-content-child">		
						<pre>${qvo.qnaContent }</pre>
					</div>
					<div>
						<!-- 파일표시란 -->
						<c:set value="${qdto.flist }" var="flist"></c:set>
						<ul class="list-group list-group-flush">
							<c:forEach items="${flist }" var="fvo">
								<li>
									<c:choose>
										<c:when test="${fvo.fileType > 0 }">
											<div class="qna-table-content-img-container">
											<img class="qna-table-content-img" alt="이미지x" src="/upload/${fn: replace(fvo.fileSave,'\\','/')}/${fvo.fileUuid}_${fvo.fileName}">
											</div>
										</c:when>
									</c:choose>
								</li>
							</c:forEach>
						</ul>
					</div>
				</td>
			</tr>
		
		
		<!-- Q&A 답변 라인 -->

		<c:if test="${qvo.qnaIsok == 'Y' }">
			<tr class="table-light qna-table-ans-head">
				<td class="" colspan="3">
					<div class="qna-table-td-child">답변완료: ${qavo.qnaAnsRegAt }</div>
				</td>
			</tr>
			<tr>	
				<td colspan="3" class="qna-table-ans-content">
					<div class="qna-table-ans-content-child">
						<pre>${qavo.qnaAnsContent }</pre>
					</div>
					<div>
						<!-- 파일표시란 -->
						<c:set value="${qadto.flist }" var="flistans"></c:set>
						<ul class="list-group list-group-flush">
							<c:forEach items="${flistans }" var="afvo">
								<li>
									<c:choose>
										<c:when test="${afvo.fileType > 0 }">
											<div class="qna-table-content-img-container">
											<img class="qna-table-content-img" alt="이미지x" src="/upload/${fn: replace(afvo.fileSave,'\\','/')}/${afvo.fileUuid}_${afvo.fileName}">
											</div>
										</c:when>
									</c:choose>
								</li>
							</c:forEach>
						</ul>
					</div>
				</td>
			</tr>	
		</c:if>

	</tbody>
	</table>	
	
	
	
		<!-- 버튼 -->
		<div class="qna-detail-btn">
			<a href="/qna/list">
				<button type="button" class="qna-btn myqna-btn">목록</button>
			</a>
			<c:if test="${qvo.qnaIsok=='N' }">
				<c:if test="${(authType == 'normal' && authId == qvo.qnaWriter) || (authType != 'normal' && authEmail == qvo.qnaWriter) || auths.stream().anyMatch(authVO -> authVO.auth.equals('ROLE_ADMIN')).get()}">			
					<a href="/qna/modify?qnaNum=${qvo.qnaNum }">
						<button type="button" class="qna-btn myqna-btn">수정</button>
					</a>
				</c:if>	
			</c:if>
			<c:if test="${auths.stream().anyMatch(authVO -> authVO.auth.equals('ROLE_ADMIN')).get()}">
				<c:if test="${qvo.qnaIsok=='N' }">	
						<a href="/qna/ans-register?qnaNum=${qvo.qnaNum }">
							<button type="button" class="qna-btn myqna-btn">답변등록</button>
						</a>
				</c:if>
				<c:if test="${qvo.qnaIsok=='Y' }">	
						<a href="/qna/ans-modify?qnaNum=${qvo.qnaNum }">
							<button type="button" class="qna-btn myqna-btn">답변수정</button>
						</a>
				</c:if>
				<a href="/developer/settingQna">
					<button type="button" class="qna-btn my-admin-btn">관리자페이지</button>
				</a>
			</c:if>	
		</div>
	
	
	
	  </div>
	</div>
</div>	


<jsp:include page="../common/footer.jsp" />	
<script type="text/javascript">
		const isOk = `<c:out value="${isOk}"></c:out>`
		if(isOk=="1"){
			alert('게시글이 수정 되었습니다.');
		}
</script>
<script type="text/javascript">
		const isOk2 = `<c:out value="${isOk2}"></c:out>`
		if(isOk2=="1"){
			alert('답변이 등록 되었습니다.');
		}
</script>
<script type="text/javascript">
		const isUp = `<c:out value="${isUp}"></c:out>`
		if(isUp=="1"){
			alert('답변이 수정 되었습니다.');
		}
</script>
<!--가져온 코드를 줄바꿈 해주는 코드  -->
<script type="text/javascript">
//enter => <br>
var text = document.getElementById("textarea-board").value;
text = text.replace(/(?:\r\n|\r|\n)/g, '<br>');

//<br> => enter
var text = document.getElementById("textarea-board").value;
text = text.replaceAll("<br>", "\r\n");
</script>
</body>
</html>