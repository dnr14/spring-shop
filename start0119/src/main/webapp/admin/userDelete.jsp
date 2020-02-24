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
 <style>
/*  체크박스 크기 */
input[type=checkbox]{  -webkit-transform: scale(2.5); /* Safari and Chrome */  padding: 5px;}
</style>
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
          <div class="col-md-9 cont">
            <div class="content">
					<h1 class="text-center mt-2">관리자 유저 삭제</h1>
					<div class="text-center">
						<table class="table">
							<thead>
								<tr>
									<th>아이디</th>
									<th>이메일</th>
									<th>생성일자</th>
									<th>수정</th>
								</tr>
							</thead>
							<tbody class="text-center">
							<c:forEach items="${list }" var="v">
								<tr>
									<td>${v.id }</td>
									<td>${v.email }</td>
									<td>${v.rdata }</td>
									<td>
										<input type="checkbox" value="${v.id }" class="userId"> 
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						<div class="text-right">
							<button type="button" id="userDelete">삭제</button>
						</div>
					</div>
					<div class="text-center">
						<c:if test="${page.prev }">
							<a style="text-decoration: none; " href="./userUpdate?pagenum=${page.startPage - 1}" >&laquo;</a>
						</c:if>
						<c:forEach begin="${page.startPage}" end="${page.endPage}" var="idx">
							<c:if test="${idx != 0}">
								<a style="text-decoration: none; " href="./userUpdate?pagenum=${idx}" >${idx }</a>
							</c:if>
						</c:forEach>
						<c:if test="${page.next }">
							<a style="text-decoration: none; " href="./userUpdate?pagenum=${page.endPage + 1}" >&raquo;</a>	
						</c:if>
					</div>
				</div>  
            </div>
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

<script type="text/javascript">
$(document).ready(function(){
	$("#userDelete").on('click',function(){
		var list = $(".userId");
		var array = new Array();
		$.each(list, function(i, item) {
			var pass = item.checked;
			if(pass){
				array.push(item.value);
			}
		});
		
		var param ={
			list : array				
		};
		
		$.ajax({
			url:"./delete",
			type:"post",
			cache:false,
			async:true,
			dataType:'json',
	        contentType : "application/json; charset=utf-8",//JSON으로 넘길때
			data:JSON.stringify(param),
			success:function(data){console.log("성공");location.reload()},
			error:function(request,status,error){}
		});
	});
});

</script>
</html> 
  