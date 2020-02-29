<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>배송 관리</title>
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head> 
 <!--  
 상세 페이지
 페이징
 검색
 -->
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
          <div class="col-md-9 cont">
            <div class="content">
					<h1 class="text-center">배송 현황</h1>
					<div class="mt-2 mb-2">
						<form action="./delivery" method="get">
							<div class="input-group">
								<input type="search" name="seach">	
								<button type="submit">찾기</button>
								<button type="button" onclick="location.href='./delivery'">전체보기</button>
							</div>
						</form>
					</div>
					<table class="table">
						<thead class="text-center">
							<tr>
								<th>송장번호</th>
								<th>결제방법</th>
								<th>결제은행</th>
								<th>결제상태</th>
								<th>결제가격</th>
								<th>배송상태</th>
								<th>상태변경</th>
								<th>주문시간</th>
							</tr>
						</thead>
						<tbody class="text-center">
						<c:forEach items="${delivery}" var="v">
							<tr>
								<td style="vertical-align: middle;">
									<a href="#" onclick="detail(${v.orderNo})" data-toggle="modal" data-target="#myModal">
										${v.staticNumber }
									</a>
								</td>
								<td style="vertical-align: middle;">${v.paymentkind }</td>
								<td style="vertical-align: middle;">${v.paymentBank }</td>
								<td style="vertical-align: middle;">${v.paymentStatus }</td>
								<td style="vertical-align: middle;"><fmt:formatNumber pattern="#,###,###원">${v.paymentPrice }</fmt:formatNumber></td>
								<td style="vertical-align: middle;">${v.deliveryStatus}</td>
								<td style="vertical-align: middle;">
									<select class="deliveryStatus">
										<option ${v.deliveryStatus eq "배송 준비 중" ? 'selected="selected" ' : ''}>배송 준비 중</option>
										<option ${v.deliveryStatus eq "배송 중" ? 'selected="selected" ' : ''}>배송 중</option>
										<option ${v.deliveryStatus eq "배송 완료" ? 'selected="selected" ' : ''}>배송 완료</option>
									</select>
									<input type="hidden" value="${v.orderNo }" class="orderNo">
								</td>
								<c:set var="date" value="${v.rdate}" />
								<td style="vertical-align: middle;" class="text-center">
									<fmt:formatDate value="${date }"/><br>
									<fmt:formatDate value="${date }" dateStyle="short" type="time"/>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
					<div class="text-right">
						<button type="button" onclick="update()">모두 수정</button>
					</div>
					<div class="mt-3 text-center">
						<c:if test="${pm.prev}">
							<a style="text-decoration: none; " href="./delivery?pagenum=${pm.startPage - 1}" >&laquo;</a>
						</c:if>
						<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="idx">
		
							<c:if test="${idx != 0}">
								<a style="text-decoration: none; " href="./delivery?pagenum=${idx}" >${idx }</a>
							</c:if>
						</c:forEach>
						<c:if test="${pm.next}">
							<a style="text-decoration: none; " href="./delivery?pagenum=${pm.endPage + 1}" >&raquo;</a>
						</c:if>
					</div>
				</div>  
            </div>
            
            <div class="modal fade" id="myModal" role="dialog">
		    	<div class="modal-dialog" style="width: 700px; height: 900px;">
			       <div class="modal-content"style="height: 100%;">
				        <div class="modal-header" style="border: none;">
				        	<h1 class="text-center">상세정보</h1>
				          	<button type="button" class="close" data-dismiss="modal">&times;</button>
				        </div>
				        <div class="modal-body">
				        	<div class="text-center">
					        	<div class="mt-2">
					        		<label>주문번호</label>
					        		<input type="text" readonly="readonly" class="form-control" id="orderNo">
					        	</div>
					        	<div class="mt-2">
					        		<label>주문자</label>
					        		<input type="text" readonly="readonly" class="form-control" id="orderName">
					        	</div>
					        	<div class="mt-2">
					        		<label>zipcode</label>
					        		<input type="text" readonly="readonly" class="form-control" id="zipCode">
					        	</div>
					        	<div class="mt-2">
					        		<label>주소</label>
					        		<input type="text" readonly="readonly" class="form-control" id="address1">
					        	</div>
					        	<div class="mt-2">
					        		<label>주소상세</label>
					        		<input type="text" readonly="readonly" class="form-control" id="address2">
					        	</div>
					        	<div class="mt-2">
					        		<label>주문자 번호</label>
					        		<input type="text" readonly="readonly" class="form-control" id="orderPhone">
					        	</div>
					        	<div class="mt-2">
					        		<label>상품 이름</label>
					        		<input type="text" readonly="readonly" class="form-control" id="stockName">
					        	</div>
					        	<div class="mt-2">
					        		<label>상품 가격</label>
					        		<input type="text" readonly="readonly" class="form-control" id="stockPrice">
					        	</div>
					        	<div class="mt-2">
					        		<label>주문 갯수</label>
					        		<input type="text" readonly="readonly" class="form-control" id="stockCnt">
					        	</div>
				        	</div>
				        </div>
			       </div>
		    	</div>
		    </div>
            
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
<script type="text/javascript">
function detail(param){
	$.ajax({
		url:'./detaliAjax',type:'post',dataType:'json',data:"orderNo="+param,
		success:function(data){ 
			var v = JSON.parse(data.vo);
			console.log(v);
			$("#orderNo").val(v.orderNo);
			$("#orderName").val(v.orderName);
			$("#zipCode").val(v.orderZipcode);
			$("#address1").val(v.orderAddress1);
			$("#address2").val(v.orderAddress2);
			$("#orderPhone").val(v.orderPhone);
			$("#stockName").val(v.stockname);
			$("#stockPrice").val(v.stockprice + "원");
			$("#stockCnt").val(v.stockCnt + "개");
		},
		error:function(request,status,error){}
	});
}

function update(){
	var list = $(".deliveryStatus");
	var array = new Array();
	
	$.each(list,function(i,item){
		var options = item.options;
		var orderNo = $(this).siblings().val();
		$.each(options,function(i,item){
			if(item.selected){
				var deliveryStatus = item.value;
				var ob = {
						orderNo : orderNo,
						deliveryStatus : deliveryStatus
				};
				array.push(ob);
			}
		});
	});
	
	$.ajax({
		url:'./updateAjax',
		type:'post',
		cache:false,
		async:true,
		dataType:'json',
	    contentType : "application/json; charset=utf-8",//JSON으로 넘길때
		data:JSON.stringify(array),
		success:function(data){
			alert("수정되었습니다.");
			location.reload();
		},
		error:function(request,status,error){}
	}); 
}


</script>

</html> 
  