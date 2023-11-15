<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	
</style>
</head>
<body>
<jsp:include page="../common/nav.jsp" />
<div class="container" >
	<table class="table"  >
	  <thead >
	    <tr>
	      <th scope="col">No.</th>
	      <th scope="col">카테고리</th>
	      <th scope="col">제목</th>
	      <th scope="col">작성자</th>
	      <th scope="col">등록일</th>
	      <th scope="col">조회</th>
	    </tr>
	  </thead>
	  <tbody>
	    <tr>
	      <th scope="row">1</th>
	      <td>Mark</td>
	      <td><a href="/notice/detail">제목제목</a></td>
	      <td>@mdzdo</td>
	      <td>@mdo</td>
	    </tr>
	    <tr>
	      <th scope="row">2</th>
	      <td>Jacob</td>
	      <td>Thornton</td>
	      <td>Thornton</td>
	      <td>Thornton</td>
	      <td>@fat</td>
	    </tr>
	    <tr>
	      <th scope="row">3</th>	      
	      <td>@twitter</td>
	      <td>@twitter</td>
	      <td>@twitter</td>
	      <td>@twitter</td>
	      <td>@twitter</td>
	    </tr>
	  </tbody>
	</table>
	<a href="/notice/register">
	<button type="button">글작성</button>
	</a>
</div>
<jsp:include page="../common/footer.jsp" />
</body>
</html>