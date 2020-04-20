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
<title>재고 관리 및 등록</title>
 
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
		
		<!-- 재고 수정 -->
			<div class="modal fade" id="myModal" role="dialog">
			    <div class="modal-dialog" style="width: 700px; height: 700px;">
			      <div class="modal-content"style="height: 100%;">
			        <div class="modal-header" style="border: none;">
			          <button type="button" class="close" data-dismiss="modal">&times;</button>
			        </div>
			        <div class="modal-body">
			        	<div class="row">
			        		<div class=col-sm-12>
									<h3 class="text-center">재고 수정</h3>
									<form id="update_form">
									<input type="hidden" id="update_stockNo" name="stockNo">
										<div class="form-group">
											<label for="update_stockName">상품 이름</label> 
											<input type="text" class="form-control" placeholder="상품이름을 입력하세요." name="stockName" id="update_stockName">
										</div>
										<div class="form-group">
											<label for="update_stockPrice">상품 가격</label> 
											<input type="text" class="form-control" placeholder="상품이름을 입력하세요." name="stockPrice" id="update_stockPrice">
										</div>
										<div class="form-group">
											<label for="update_stockCnt">상품 갯수</label> 
											<input type="text" class="form-control" placeholder="상품이름을 입력하세요." name="stockCnt" id="update_stockCnt">
										</div>
										<div class="form-group">
											<label for="update_categrpNo">카테고리</label>	
											<select id="update_categrpNo" class="form-control" name="categrpNo">
												
											</select>
										</div>
										<div>
											<button type="submit" class="btn btn-primary">등록</button>
										</div>
										</form>
								</div>
			        		</div>
			        	</div>
			        </div>
			      </div>
			    </div>
		<!--  재고 수정 -->
		<div class="col-sm-9 cont">
			<div class="content">
				<h3 class="text-center mt-2">재고 관리 및 등록</h3>
				<c:url value="./create" var="path"/>
				<form:form  role="form" commandName="stockCreateRequest" action="${path }" method="post">
					<div class="form-group">
						<label for="manager">카테고리</label>
						<form:select path="categrpNo" class="form-control">
							<c:forEach var="cateGroup" items="${stockCateGroup }">
								<form:option value="${cateGroup.categrpNo }">${cateGroup.categrpName}</form:option>
							</c:forEach>
						</form:select>
					</div>	
					<div class="form-group">
						<label for="stockName">재고이름</label>
						<form:input path="stockName" type="text" class="form-control" placeholder="재고이름을 입력하세요."/>
						<div class="mt-2">
							<form:errors path="stockName" style="color:red"/>
						</div>
					</div>
					<div class="form-group">
						<label for="stockPrice">재고가격</label>
						<form:input path="stockPrice" type="number" min="0" max="99999" class="form-control"/>
						<div class="mt-2">
							<form:errors path="stockPrice" style="color:red"/>
						</div>
					</div>
					<div class="form-group">
						<label for="stockCnt">재고수량</label>
						<form:input path="stockCnt" type="number" min="0" max="99999" class="form-control"  />
						<div class="mt-2">
							<form:errors path="stockCnt" style="color:red"/>
						</div>
					</div>
					<div class="form-group">
						<label for="manager">등록자</label>
						<c:set value="${sessionScope.admin_id}" var="manager"/>
						<form:input path="manager" type="text"  value="${manager }" class="form-control"  readonly="true"/>
						<div class="mt-2">
							<form:errors path="manager" style="color:red"/>
						</div>
					</div>
					<div class="form-group">
						<form:button type="submit" class="btn btn-primary">재고 등록</form:button>
					</div>
				</form:form>
			</div>
			
			<!-- 등록된 상품 보기 -->
			<table class="table">
				<thead class="text-center">
					<tr>
						<th>상품<br>No</th>
						<th>카테고리</th>
						<th>상품<br>이름</th>
						<th>상품<br>가격</th>
						<th>상품<br>갯수</th>
						<th>등록자</th>
						<th>등록일</th>
						<th>수정 / 삭제</th>
					</tr>
				</thead>
				
				<tbody class="text-center">
					<c:forEach var="list" items="${list }">
						<tr>
							<td>${list.stockNo }</td>
							<td>${list.categrpName }</td>
							<td>${list.stockName }</td>
							<td><fmt:formatNumber type="number"  value="${list.stockPrice }" pattern="#,###,###원"/></td>
							<td><fmt:formatNumber type="number"  value="${list.stockCnt }" pattern="#,###,###개"/></td>
							<td>${list.manager }</td>
							<td>${list.stockRdate }</td>
							<td>
								<img src="./images/update.png" 
								alt="수정" style=" width: 30px; height: 30px; cursor: pointer;" class="update"
								 data-toggle="modal" data-target="#myModal"> 
								<input type="checkbox" class="ml-2 stockCheckBox">
								<input type="hidden"  value="${list.stockNo}" class="stockNo"/>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="text-right">
				<button class="btn btn-primary" id="sotckDelete">삭제</button>
			</div>
			<div class="mt-3 text-center">
				<c:if test="${pm.prev}">
					<a style="text-decoration: none; " href="./create?pagenum=${pm.startPage - 1}" >&laquo;</a>
				</c:if>
				<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="idx">

					<c:if test="${idx != 0}">
						<a style="text-decoration: none; " href="./create?pagenum=${idx}" >${idx }</a>
					</c:if>
				</c:forEach>
				<c:if test="${pm.next}">
					<a style="text-decoration: none; " href="./create?pagenum=${pm.endPage + 1}" >&raquo;</a>
				</c:if>
			</div>
		</div>
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

<script type="text/javascript">
$(document).ready(function() {
		
		//재고 목록 삭제
		$("#sotckDelete").on("click",function(){
			var multiparam= new Array();
			var stockNo = $(".stockNo");
			$(".stockCheckBox").each(function(index, item) {
				if(item.checked == true){
					multiparam.push(stockNo[index].value);
				}
			});
			
			if(multiparam.length == 0){
				alert("체크를 해주세요.");
				return;
			}
			
			var result = confirm("삭제를 하면 하위 컨텐츠도 삭제 됩니다.");
			if(result == false){
				alert("취소 되었습니다.");
				return;
			}
			
			var param = {
					array : multiparam,
					pagenum : ${pm.pagenum}
			}
			
			console.log(param);
			
			 var obj =  {
				      url : '${root}/stock/delete',
				      type : 'post',
				      cache: false,
				      async : true,
				      dataType : "json",
				      contentType : "application/json; charset=utf-8",//JSON으로 넘길때
				      data :JSON.stringify(param),
				      success : function(rdata) {
				    	  
				    	  console.log(rdata.result);
				    	  if(rdata.pagenum != ${pm.pagenum}){
				    		  location.href='./stock/create=?pagenum=' + rdata.pagenum;				    		  
				    	  }else{
					    	  location.reload();
				    	  }
				    	  
				      },
				      error : function(request, status, error) { // callback 함수
				    	  var msg = 'ERROR<br><br>';
					        msg += '<strong>request.status</strong><br>';
					        msg += request.status;
					        msg += '<hr>';
					        msg += '<strong>error</strong><br>' + error + '<hr>';
					        console.log(msg);
				      }
				    }
		    $.ajax(obj);
		});
		/* 재고 삭제 */
		
		
		// 재고 수정 불러오기
		$(".update").on('click',function(){
			var stockNo = $(this).siblings(".stockNo").val();	
			var obj =  {
				      url : '${root}/stock/update',
				      type : 'post',
				      cache: false,
				      async : true,
				      dataType : "json",
				      data : "stockNo="+ stockNo,
				      success : function(rdata) {
				    	  var jsonData = rdata.stockVO;
				    	  $("#update_stockName").val(jsonData.stockName);
				    	  $("#update_stockPrice").val(jsonData.stockPrice);
				    	  $("#update_stockCnt").val(jsonData.stockCnt);
				    	  $("#update_stockNo").val(jsonData.stockNo);
				    	  
				    	  var html;
				    	  var categrpName = jsonData.categrpName;
				    	  
				    		$.each(rdata.cateGroup, function(i, item) {
				    			if(item.categrpName === categrpName){
					    			html += "<option value='"+item.categrpNo+"' selected='selected'>" + item.categrpName +"</option>";
   				    			    $("#update_categrpNo").val(item.categrpNo);
				    			}else{
					    			html += "<option value='"+item.categrpNo+"'>" + item.categrpName +"</option>";
				    			}
							});
				    	  $("#update_categrpNo").append(html);
				    	  
				      },
				      error : function(request, status, error) { // callback 함수
				    	  var msg = 'ERROR<br><br>';
					        msg += '<strong>request.status</strong><br>';
					        msg += request.status;
					        msg += '<hr>';
					        msg += '<strong>error</strong><br>' + error + '<hr>';
					        console.log(msg);
				      }
				    }
				    $.ajax(obj);
		});
		// 재고 수정 불러오기
		
		
		// 재고 수정
		$("#update_form").submit(function(event) {
			event.preventDefault();
			
			var queryString = $(this).serialize();
			console.log(queryString);
			var obj =  {
				      url : '${root}/stock/updateProc',
				      type : 'post',
				      cache: false,
				      async : true,
				      dataType : "json",
				      data : queryString,
				      success : function(rdata) {
				    	  var count = rdata.count;
				    	  if(count > 0){
				    		  alert("수정에 성공했습니다.");
					    	  $(".close").trigger("click");
					    	  location.reload();
				    	  }
				      },
				      error : function(request, status, error) { // callback 함수
				    	  var msg = 'ERROR<br><br>';
					        msg += '<strong>request.status</strong><br>';
					        msg += request.status;
					        msg += '<hr>';
					        msg += '<strong>error</strong><br>' + error + '<hr>';
					        console.log(msg);
				      }
				    }
				    $.ajax(obj);
		});
		// 재고 수정
});
</script>

 
</html> 
  