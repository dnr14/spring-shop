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
					<h1 class="text-center">로그인</h1>
					<c:url value="/member/login" var="path"/>
					<form:form role="form" commandName="memberLoginCheck" action="${path }" method="post">
						<div class="form-group">
							<label for="id">아이디 </label> 
							<form:input type="text" path="id" class="form-control" placeholder="아이디를 입력하세요." value="${memberLoginCheck.id }"/>
							<div class="mt-2">
								<form:errors path="id" style="color:red"/>
							</div>
						</div>
						<div class="form-group">
							<label for="pwd">패스워드</label> 
							<form:password path="pwd" class="form-control" placeholder="비밀번호를 입력하세요."/>
							<div class="mt-2">
								<form:errors path="pwd" style="color:red"/>
							</div>
						</div>
						<div>
							<label for="cookieCheck1">아이디 저장</label><form:checkbox path="cookieCheck" class="ml-2" value="${memberLoginCheck.cookieCheck }"/>
						</div>
						<div class="text-center">
							<button type="submit" class="btn btn-primary w-100">로그인</button>
							<button type="button" class="btn btn-primary w-100 mt-2" id="test_id">테스트 아이디</button>
							<button type="button" class="btn btn-primary w-100 mt-2" onclick="location.href='${root}/member/IdFind'">아이디 찾기</button>
							<button type="button" class="btn btn-primary w-100 mt-2" onclick="location.href='${root}/member/PwdFind'">비밀번호 찾기</button>
						</div>
					</form:form>
				</div>  
            </div>
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

<script type="text/javascript">
	/*  테스트 아이디 */
	$(document).ready(function() {
		$("#test_id").on("click",function(){
			$("#id").val("dnr14");
			$("#pwd").val("1234");
		})	;
	});
</script>

</html> 
  