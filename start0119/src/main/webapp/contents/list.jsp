<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath}" />

 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>오류 페이지</title>
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head> 

 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
			
            <div class="col-md-9 cont">
				<div class="content">
					<h3 class="text-center">오류 페이지</h3>
					<div class="text-center p-5" style="font-size: 2em; color:red;">
						${error}
					</div>
					<div class="text-center">
						<button class="btn btn-primary" onclick="history.back()">다시시도</button>
						<button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/'">홈으로</button>
					</div>
				</div>
		   </div>

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html> 
  