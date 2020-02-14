<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
 
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
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
		<div class="col-sm-9 cont">
			<div class="content">
				<h3 class="text-center">재고 관리 및 등록</h3>
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
						<form:input path="stockCnt" type="number" min="0" max="99999" class="form-control" />
						<div class="mt-2">
							<form:errors path="stockCnt" style="color:red"/>
						</div>
					</div>
					<div class="form-group">
						<label for="manager">등록자</label>
						<c:set value="${sessionScope.id}" var="manager"/>
						<form:input path="manager" type="text"  value="${manager }" class="form-control" />
						<div class="mt-2">
							<form:errors path="manager" style="color:red"/>
						</div>
					</div>
					<div class="form-group">
						<form:button type="submit" class="btn btn-primary">재고 등록</form:button>
					</div>
				</form:form>
			</div>
		</div>
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html> 
  