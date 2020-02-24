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
					<h1 class="text-center mt-2">관리자 유저 수정</h1>
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
										<img src="./images/update.png" style="width: 25px; height: 25px; cursor: pointer;" class="user_update"
										data-toggle="modal" data-target="#updateModal"> 
										<input type="hidden" value="${v.id }" class="userId">
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
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
            
            
            <!-- 모달 -->
            <div class="modal fade" id="updateModal" role="dialog">
            	<div class="modal-dialog" style="width: 300px; height: 700px;">
					<div class="modal-content" style="width: 100%;l">
						<div class="modal-header" style="border: none;">
							<h1>유저 수정</h1>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body text-center">
						<form id="update">
							<input type="text" id="id" readonly="readonly" name="id"/>
							<input type="text" id="email" readonly="readonly" name="email"/>
							<input type="text" id="zipcode" name="zipcode"/>
							<input type="text" id="address1" name="address1"/>
							<input type="text" id="address2" name="address2"/>
							<input type="text" id="phone" name="phone"/>
							<div>
								<button type="submit">전송</button>
							</div>
						</form>
						</div>
					</div>
            	</div>
            </div>
            <!-- 모달 -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

<script type="text/javascript">
$(document).ready(function(){
	$(".user_update").on('click',function(){
		var id = $(this).siblings(".userId").val();
		console.log(id);
		
		$.ajax({
			url: "./userUpdate",
			type: "post",
			cache: false,
			async: true,
			dataType: 'json',
			data: "id="  + id ,
			success:function(data){
				var json = JSON.parse(data.result);
				
				$("#id").val(json.id);
				$("#email").val(json.email);
				$("#zipcode").val(json.zipcode);
				$("#address1").val(json.address1);
				$("#address2").val(json.address2);
				$("#phone").val(json.phone);
				
			},
			error :function(request, status, error){
				console.log(request);
				console.log(status);
				console.log(error);
			}
		});
	});
	
	$("#update").submit(function(event){
		event.preventDefault();
		var QueryString = $(this).serialize();
		$.ajax({
			url:'./update',
			type:'post',
			cache:false,
			dataType: 'json',
			async:true,
			data:QueryString,
			success:function(data){
				console.log(data);
				if(data.result == 0){
				  $(".close").trigger("click");
		    	  location.reload();
				}
			},
			error:function(request, status, error){	
				
			}
		});
		
	});
	
	
});

</script>
</html> 
  