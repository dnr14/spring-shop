<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="root" value="${pageContext.request.contextPath}" />

 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>상품 목록</title>
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head> 

 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
            <div class="col-md-9 cont">
				<div class="content">
					<h3 class="text-center">
					<c:choose>
						<c:when test="${categrpName eq null }">
							전체 목록
						</c:when>
						<c:otherwise>
							${categrpName }
						</c:otherwise>
					</c:choose>
					</h3>
					<div class="mt-3 text-center">
						<c:url var="path" value="./list?pagenum=1&categrpno="/>
						<form class="form-group" action="${path }" method="get">
						<span>검색 : </span>
						<input type="search" class="form-control" style="width: 400px;display: inline;" placeholder="검색어를 입력하세요." name="title">
						<input type="hidden" name="categrpno">
						<input type="hidden" name="pagenum">
						<button class="btn btn-primary">찾기</button>						
						</form>						
					</div>
					<div class="mt-3">
						 <c:forEach var="list" items="${list}">
							<div class="main" onclick="location.href='${root}/contents/read?contentsNo=${list.contentsNo}'"
							style="width: 30%; float: left; text-align: center; 
							border: 1px solid; margin:  0 1.6% 20px 1.6%; 
							border-radius:4px; cursor: pointer;" onclick="console.log('디버그')">
								<img src="./storage/${list.thumb }" class="opac" style="width: 50%; height: 100px; margin-top: 15px;"/>
								<div class="mt-2 mb-2">
									<p class="title mt-2">
									<c:if test="${list.likey >= 20 }">
										<span class="badge badge-danger">인기상품</span>
									</c:if>
									${list.title }
									</p>
								</div>
								<div><span>keyWord : </span>#${list.keyword}</div>
								<div><span>조회수 : </span><fmt:formatNumber pattern="##,###회" type="number"  value="${list.cnt }"/></div>
								<div><span>좋아요♥ </span>♥ ${list.likey }</div>
							</div>
						 </c:forEach>
					</div>
					<div class="mt-2 text-center" style="clear: both;">
						<c:if test="${page.prev }">
							<a style="text-decoration: none; " href="./list?pagenum=${page.startPage - 1}&categrpno=${categrpno}&title=${title}" >&laquo;</a>
						</c:if>
						<c:forEach begin="${page.startPage}" end="${page.endPage}" var="idx">
							<c:if test="${idx != 0}">
								<a style="text-decoration: none; " href="./list?pagenum=${idx}&categrpno=${categrpno}&title=${title}" >${idx }</a>
							</c:if>
						</c:forEach>
						<c:if test="${page.next }">
							<a style="text-decoration: none; " href="./list?pagenum=${page.endPage + 1}&categrpno=${categrpno}&title=${title}" >&raquo;</a>
						</c:if>
					</div>
				</div>
		   </div>

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

<script type="text/javascript">
$(document).ready(function () {
    
    let value = 0;
    setInterval(() => {
        if (value == 0) {
            $(".badge-danger").attr('style', 'color: yellow');
            value = 1;
        } else if (value == 1) {
            $(".badge-danger").attr('style', 'color: red');
            value = 2;
        } else {
            $(".badge-danger").attr('style', 'color: white');
            value = 0;
        }
    }, 500);

    $(".main").mouseenter(function(){
        $(this).find('.opac').attr('style','opacity: 0.5; width: 50%; height: 100px; margin-top: 15px;');
        $(this).find('.title').attr('style','font-weight: bold; color:#ff4d4d;');
    });
    $(".main").mouseleave(function(){
        $(".opac").attr('style','width: 50%; height: 100px; margin-top: 15px;');
        $(".title").attr('style','font-weight: bold; color:black;');
    });
    
});	
</script>

</html> 
  