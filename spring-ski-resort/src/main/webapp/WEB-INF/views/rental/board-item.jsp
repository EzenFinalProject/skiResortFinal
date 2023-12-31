<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link rel="stylesheet" href="/resources/css/rental/item_list.css">
</head>
<body>
	<jsp:include page="../common/nav.jsp" />
	<div class="bodyContainer">
	
	<!-- 장바구니 -->
	<div class="shopContainer">
		<div class="shoppingBasket" id="shoppingBasket">
			<div class="shoppingBasketTitle">
				<p class="fs-4">장바구니</p>
				<p><button class="btn btn-outline-info reserveBtn" id="reserveBtn">예약신청하기</button></p>
			</div>
			<div class="itemSelectDiv" id="itemSelectDiv">
			
			
			</div>
		</div>
	</div>
	
		<div class="itemMenuContainer">
			<ul class="nav nav-tabs justify-content-center">
			  <li class="nav-item" id="skiItem">
			    <a class="nav-link" href="/rental/ski-item">스키</a>
			  </li>
			  <li class="nav-item" id="boardItem">
			    <a class="nav-link" href="/rental/board-item">스노우보드</a>
			  </li>
			  <li class="nav-item" id="wearItem">
			    <a class="nav-link" href="/rental/wear-item">의류/보호장비</a>
			  </li>  
			</ul>
		</div>
		
		<div class="menuCategory">
			<div>
				<nav class="nav flex-column nav-tabs">
				  <a class="nav-link" id="lowItem" href="#">일반장비SET</a>
				  <a class="nav-link" id="midItem" href="#">중급장비SET</a>
				  <a class="nav-link" id="premiumItem" href="#">프리미엄장비SET</a>
				</nav>
			</div>
		</div>
		
		<div class="itemContainer" id="itemContainer">
			<div class="boardItemList" id="boardItemList">
				
				<div class="itemInfo">	
					<div class="itemImageBox" id="lowItemImageBox">
						<c:forEach items="${boardLowItem }" var="lowItem">
							<div class="slide">
								<!-- 이미지파일 -->
								<img alt="BoardLowItem" data-name="${lowItem.rentalListLowItem }" 
								data-adultFee="${lowItem.rentalListItemAdultFee }" 
								data-kidFee="${lowItem.rentalListItemKidFee }" 
								data-num="${lowItem.rentalListItemNum }"
								data-img="${lowItem.imageUrl }"
								src="${lowItem.imageUrl }">
								<p class="fs-5">${lowItem.rentalListLowItem }</p>
								<c:choose>
									<c:when test="${fn:contains(lowItem.rentalListLowItem,'주니어') }">
										<p class="fs-5">${lowItem.rentalListItemKidFee }원</p>
									</c:when>
									<c:otherwise>
										<p class="fs-5">${lowItem.rentalListItemAdultFee }원</p>
									</c:otherwise>
								</c:choose>
							</div>
						</c:forEach>
					</div>
					
					
					
					
					<div class="itemImageBox" id="midItemImageBox" style="display: none;">
						
						<c:forEach items="${boardMidItem }" var="midItem">
							<div class="slide">
								<!-- 이미지파일 -->
								<img alt="BoardMidItem" data-name="${midItem.rentalListMidItem }" 
								data-adultFee="${midItem.rentalListItemAdultFee }" 
								data-kidFee="${midItem.rentalListItemKidFee }" 
								data-num="${midItem.rentalListItemNum }"
								data-img="${midItem.imageUrl }"
								src="${midItem.imageUrl }">
								<p class="fs-5">${midItem.rentalListMidItem }</p>
								<c:choose>
									<c:when test="${fn:contains(midItem.rentalListMidItem,'주니어') }">
										<p class="fs-5">${midItem.rentalListItemKidFee }원</p>
									</c:when>
									<c:otherwise>
										<p class="fs-5">${midItem.rentalListItemAdultFee }원</p>
									</c:otherwise>
								</c:choose>
							</div>
						</c:forEach>
						
					</div>
					
					
					
					
		
					<div class="itemImageBox" id="premiumItemImageBox" style="display: none;">
						
						<c:forEach items="${boardPremiumItem }" var="premiumItem">
							<div class="slide">
								<!-- 이미지파일 -->
								<img alt="BoardPremiumItem" data-name="${premiumItem.rentalListPremiumItem }" 
								data-adultFee="${premiumItem.rentalListItemAdultFee }" 
								data-kidFee="${premiumItem.rentalListItemKidFee }" 
								data-num="${premiumItem.rentalListItemNum }"
								data-img="${premiumItem.imageUrl }"
								src="${premiumItem.imageUrl }">
								<p class="fs-5">${premiumItem.rentalListPremiumItem }</p>
								<c:choose>
									<c:when test="${fn:contains(premiumItem.rentalListPremiumItem,'주니어') }">
										<p class="fs-5">${premiumItem.rentalListItemKidFee }원</p>
									</c:when>
									<c:otherwise>
										<p class="fs-5">${premiumItem.rentalListItemAdultFee }원</p>
									</c:otherwise>
								</c:choose>
							</div>
						</c:forEach>
						
					</div>
					
					<div class="slide-btn">
						<i class="bi bi-chevron-left slidePrevBtn" id="slidePrevBtn"></i>
						<i class="bi bi-chevron-right slideNextBtn" id="slideNextBtn"></i>
					</div>
					
					
					
	
				</div>
				
			</div>
		</div>

	</div>
	
	<script type="text/javascript">
		const memberEmail= `<c:out value="${mvo.memberEmail}"/>`;
		console.log(memberEmail);
	</script>	
	
	<script type="text/javascript" src="/resources/js/rental/item.js"></script>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>