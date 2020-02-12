<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>관리자 로그인 페이지</title>
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
 
</head> 
<script type="text/javascript">
 $(document).ready(function() {
    $("#testLogin").on('click',function(){
      $("#id").val('admin1');
      $("#pwd").val('1234');
    }); 	
 });

</script> 
 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
          <div class="col-md-9 cont">
            <div class="content">
					<h1 class="text-center">관리자 로그인</h1>
					<c:url value="/admin/login.do" var="path"/>
					<form:form role="form" commandName="adminLoginCheck" action="${path }" method="post">
						<div class="form-group">
							<label for="id">아이디 </label> 
							<form:input type="text" path="id" id="id" class="form-control" placeholder="아이디를 입력하세요." value="${memberLoginCheck.id }"/>
							<div class="mt-2">
								<form:errors path="id" style="color:red"/>
							</div>
						</div>
						<div class="form-group">
							<label for="pwd">패스워드</label> 
							<form:password path="pwd" id="pwd" class="form-control" placeholder="비밀번호를 입력하세요."/>
							<div class="mt-2">
								<form:errors path="pwd" style="color:red"/>
							</div>
						</div>
						<div class="text-left">
							<button type="submit" class="btn btn-primary w-25">로그인</button>
							<button type="button" class="btn btn-primary w-25" id="testLogin">테스트 아이디</button>
						</div>
					</form:form>
				</div>  
            </div>
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
</html> 
  