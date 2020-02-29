<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set value="${pageContext.request.contextPath }" var="root"/>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>장바구니</title>
 

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
 
</head> 
 
 <style>
/*  체크박스 크기 */
input[type=checkbox]{  -webkit-transform: scale(2.5); /* Safari and Chrome */  padding: 5px;}
</style>
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
		
		<div class="col-sm-9 cont">
			<div class="content">
				<h3 class="text-center mt-2">장바구니</h3>
				<table class="table">
					<c:choose>
						<c:when test="${list.size() == 0 }">
						<tbody class="text-center">
							<tr>
								<td style="text-align: center;height: 150px; vertical-align: middle;"  colspan='7'>장바구니에 등록된 상품이없습니다.</td>
					      	</tr>
						</tbody>
						</c:when>
						<c:otherwise>
						<thead class="text-center">
						<tr>
							<th>번호</th>
							<th>이미지</th>
							<th>제목</th>
							<th>갯수</th>
							<th>등록일</th>
							<th>삭제</th>
						</tr>
					  </thead>
					  <tbody class="text-center">
							<c:forEach items="${list }" var="v">
							<tr>
								<td style="vertical-align: middle;">${v.basketno}</td>
								<td>
									<img src="../contents/storage/${v.thumb}" style="width: 100px; height: 100px;">
								</td >
								<td style="vertical-align: middle;">
									<a href='${v.uri }'>
										${v.title}
									</a>
								</td>
								<td style="vertical-align: middle;">${v.cnt}</td>
								<td style="vertical-align: middle;">${v.rdate}</td>
								<td style="vertical-align: middle;">
									<input type="checkbox" value="${v.basketno }" class="basketno">
								</td>
							</tr>
							</c:forEach>
						</tbody>
						</c:otherwise>
					</c:choose>
				</table>
				<div class="text-right">
				<c:if test="${list.size() != 0 }">
					<button type="button" id="order">결제</button>
				</c:if>
					<button type="button" id="BasketDelete">삭제</button>
				</div>
			</div>
		</div>
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

<script type="text/javascript">
$(document).ready(function(){
	$("#BasketDelete").on('click',function(){
		var list = $(".basketno");
		var array = Array();
		$.each(list,function(i,item){
			var pass = item.checked;
			if(pass){
				array.push(item.value);
			}
		});
		
		var param = {
				list:array
		};
		
		if(array.length == 0){
			return;
		}		
		
		$.ajax({
			url:"./delete",
			type:"post",
			cache:false,
			async:true,
			dataType:"json",
			data:JSON.stringify(param),
			 contentType : "application/json; charset=utf-8",//JSON으로 넘길때,
			 success:function(data){console.log("성공");
				 if(data.result==="ok"){
					 location.reload();
				 }
			 },
			 error:function(){}
		});
		
	});
	
	$("#order").on('click',function(){
		location.href='../payment/create';
	});
	
});
</script>

</html> 
  