<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>
 <link rel="stylesheet" href="/resources/css/index.css">
</head>
<body>
	<jsp:include page="common/nav.jsp"></jsp:include>
	<div class="ytLandscape" id="ytLandscape">
		<iframe 
			src="https://www.youtube.com/embed/h1VWRkX8vD8?si=hXoOA0167YGh5z27&autoplay=1&mute=1&controls=0&loop=1&playlist=h1VWRkX8vD8&modestbranding=1"
			title="YouTube video player" frameborder="0"
			allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
			allowfullscreen> 
			</iframe>
			<h1 id="maintext1">好き</h1>
			<h1 id="maintext2">Daisuski</h1>
			
			
		<div id="wrapper">
		 	<div id="innerItem1"></div> 
			<div id="innerItem2"></div> 
			<div id="innerItem3"></div> 
		 	<div id="innerItem4"></div> 
		</div>
	</div>
	
<!-- index 영상 아래 들어갈 내용은 여기에  -->	
	<div class="index-content">
		<div id="notice-box">
			<h1 class="notice-logo">INFORMATION</h1>
			
		</div>
		<div class="news-topic">
			<h1>News & Topic</h1>	
		</div>
	
		<div class="accommodations">
			<h1>ACCOMMODATIONS</h1>	
		</div>
	

	</div>		
			
		
	<jsp:include page="common/footer.jsp"></jsp:include>	
</body>
<script type="text/javascript" src="/resources/js/index.js" ></script>
</html>
