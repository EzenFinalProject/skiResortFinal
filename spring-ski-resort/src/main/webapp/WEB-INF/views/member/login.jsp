<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link  href="/resources/css/member/login.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../common/nav.jsp"></jsp:include>
	
<form action="/member/login" method="post" >
	<div class="bodyContainer">
	<video width="100%" height="auto" autoplay loop muted>
	<source src="https://www.chamonix.com/sites/default/files/media/videos/homepage-vallorcine%201.mp4" type="video/mp4">
	</video>
		<span id="Title-1">ダイスキー</span>
		<span id="Title-2">DAISUSKI RESORT</span>
		<div id="Title-3"></div>
		<div class="loginTool">
			<div class="loginContainer">
				<div class="login-box">
						<div class="form-group">
							  <label class="col-form-label mt-4" for="inputDefault">
							  </label>
							  <input type="text" class="form-control" name="memberId" placeholder="아이디" id="inputDefault" />
						</div>
						
						 <div class="form-group">
						      <label for="exampleInputPassword1" class="form-label mt-4">
						      </label>
						      <input type="password" class="form-control" name="memberPwd" id="exampleInputPassword1" placeholder="비밀번호" autocomplete="off" />
					    </div>
					    <div class="btn-box">
							<button type="submit" class="btn btn-primary login-btn">로그인</button> 
							<a href="/member/register"><button type="button" class="btn btn-primary login-btn">회원가입</button></a>
						</div>
						
						<div class="a-box">
							<a href="/member/findId">아이디 찾기</a>
							<a href="/member/findPwd">비밀번호 찾기</a>
						</div>
						
				
				</div>	
				
				<div class="social-Box">
				
					<div id="kakao_id_login" style="text-align: center">
						<a href="#">
						<img width="70" src="/resources/etc/kakao_logo.png" /></a>
		       		</div>
		
					
					<div id="naver_id_login" style="text-align: center">
						<a href="#"><img width="70" src="/resources/etc/naver_logo.png" /></a>
					</div>
					
					<div id="google_id_login" style="text-align:center">
						<a href="#"><img width="70" src="/resources/etc/google_logo.png"/></a>
					</div>
				
				</div>
	
				<br>
				
			</div>	
			<div class="loginContainer2">
				<div class="loginBox2">
					<img width="400" height="400" src="/resources/etc/loginPic.png">
				</div>
			</div>
		</div>
	</div>
</form>

	<jsp:include page="../common/footer.jsp"></jsp:include>
	<script type="text/javascript">
		const isMod = `<c:out value="${isMod}" />`;
		if(isMod == 1){
			alert('회원 정보수정이 완료되었습니다. 안전을 위해 로그아웃이 진행됩니다.');
		}
		const isOk = `<c:out value="${isOk}" />`;
		if(isOk == 1){
			alert('탈퇴가 완료되었습니다.');
		}
		const errMsg = `<c:out value="${errMsg}" />`;
		if(errMsg == 1){
			alert('회원정보 오류입니다.');
		}
		const isPwd = `<c:out value="${isPwd}" />`;
		if(isPwd == 1){
			alert('이메일에 발송된 임시 비밀번호를 확인 후 로그인 해주세요.');
		}else if(isPwd == 2){
			alert('회원정보 오류입니다.');
		}
		
	</script>
	
	<script type="text/javascript" src="/resources/js/member/MemberLogin.js"></script>
	<script type="text/javascript" src="/resources/js/member/OauthLogin.js"></script>
</body>
</html>