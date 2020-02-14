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
<title>결과 페이지</title>
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
 
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />

            <div class="col-md-9 cont">
                <div class="content">
                	<c:choose>
                		<c:when test="${find eq id}">
               				<h1 class="text-center">아이디 찾기 결과</h1>
            				<c:if test="${empty  Id}">
								<h1 class="text-center">해당 이메일은 없습니다.</h1>
							</c:if>	
							<c:if test="${not empty Id}">
								<h1 class="text-center">이메일 : ${Email}</h1>
								<h1 class="text-center">아이디 : ${Id}</h1>
							</c:if>
							<div class="text-center">
							<c:if test="${not empty Id}">
								<button class="btn btn-primary" onclick="location.href='${root}/member/login'">로그인</button>
								<button class="btn btn-primary" onclick="location.href='${root}/member/PwdFind'">비밀번호 찾기</button>
							</c:if>
							<c:if test="${empty  Id}">
								<button class="btn btn-primary" onclick="history.back()">다시시도</button>
							</c:if>
							</div>
                		</c:when>
                		
                		<c:otherwise>
                			<h1 class="text-center">비밀번호 찾기 결과</h1>
            				<c:if test="${empty  Id  && empty Email}">
								<h1 class="text-center">해당 정보가 없습니다.</h1>
							</c:if>	
            				<c:if test="${not empty  Id &&not empty Email}">
								<h1 class="text-center">${Id}님의 ${Email}로 </h1>
								<h1 class="text-center">비밀번호를 전송 했습니다.</h1>
							</c:if>
							<div class="text-center">
            				<c:if test="${not empty  Id &&not empty Email }">
								<button class="btn btn-primary" onclick="location.href='${root}/member/login'">로그인</button>
							</c:if>
            				<c:if test="${empty  Id && empty Email }">
								<button class="btn btn-primary" onclick="history.back()">다시시도</button>
							</c:if>
							</div>
							<div class="text-center mt-5">
								이메일 발송이 안될 시 dnr0145@gamil.com 관리자 이메일로 문의드립니다.
							</div>
                		</c:otherwise>
                	</c:choose>
				</div>  
            </div>
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
</html> 
  