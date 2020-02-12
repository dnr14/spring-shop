<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath}" />
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>로그인 실패 페이지</title>
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head> 

 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
          <div class="col-md-9 cont">
            <div class="content">
				    	<h1 class="text-center">관리자 로그인</h1>
				    	<div class="text-center">
				    	  <h1 style="color:red">로그인에 실패 했습니다.</h1>
				    	</div>
				    	<div class="text-center">
				    	  <button class="btn btn-danger" onclick="history.back();">다시 시도</button> 
				    	  <button class="btn btn-danger ml-2" onclick="location.href='${root}/'">메인으로</button> 
				    	</div>
				    </div>  
          </div>
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
</html> 
  