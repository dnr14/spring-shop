<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>로그인 페이지</title>
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
 
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />

            <div class="col-md-9 cont">
                <div class="content">
					<h1 class="text-center">비밀번호 찾기</h1>
					<c:url value="/member/PwdFind" var="path"/>
					<form:form role="form" commandName="memberIdPwdFind" action="${path }" method="post">
						<div class="form-group">
							<label for="id">아이디 </label> 
							<form:input type="text" path="id" class="form-control" placeholder="아이디를 입력하세요." value="${memberLoginCheck.id }"/>
							<div class="mt-2">
								<form:errors path="id" style="color:red"/>
							</div>
						</div>
						<div class="form-group">
							<label for="email">이메일</label> 
							<form:input type="email" path="email" class="form-control" placeholder="이메일을 입력하세요."/>
							<div class="mt-2">
								<form:errors path="email" style="color:red"/>
							</div>
						</div>
						<div class="text-center">
							<button type="submit" class="btn btn-primary w-100">비밀번호 찾기</button>
						</div>
					</form:form>
				</div>  
            </div>
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
</html> 
  