<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>유저 관리 페이지</title>
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
          <div class="col-md-9 cont">
            <div class="content">
					<h1 class="text-center">유저 관리 페이지</h1>
					<div class="text-center">
						<div class="mt-2"><button type="button" class="btn btn-primary" id="UserUpdate">유저 수정</button></div>
						<div class="mt-2"><button type="button" class="btn btn-primary" id="UserDelete">유저 삭제</button></div>
					</div>
				</div>  
            </div>
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
<script type="text/javascript">
$(document).ready(function(){
	$("#UserUpdate").on('click',function(){
		location.href='./userUpdate';		
	});
	
	$("#UserDelete").on('click',function(){
		location.href='./userDelete';		
	});
	
	
});

</script>

</html> 
  