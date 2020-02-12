<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}" />


<script type="text/javascript">
$(document).ready(function(){
	
	$(".dropdown").on('mouseover', function(){
	    $(".dropdown-menu").attr('style','display:block');
	});
	
	$(".dropdown-menu").on('mouseover', function(){
	    $(".dropdown-menu").attr('style','display:block');
	});
	
	$(".dropdown-menu").on('mouseout', function(){
	    $(".dropdown-menu").attr('style','display:none');
	});
	
	 var obj =  {
		      url : '${root}/cateGroup/cateGroupTopList',
		      type : 'get',
		      cache: false,
		      async : true,
		      dataType : "json",
		      success : function(rdata) {
		    	  $.each(rdata.list, function(i, item) {
		    		  /* 나중에 url 나오면 쓰기 */
		    	  	$(".dropdown-menu").append(
		    	  			'<li role="presentation"><a role="menuitem" tabindex="-1" href="#" style="padding-left:10px;">'+item+'</a></li>'
		    	  	);
		    	  });
		      },
		      error : function(request, status, error) { // callback 함수
		        var msg = 'ERROR<br><br>';
		        msg += '<strong>request.status</strong><br>' + request.status
		            + '<hr>';
		        msg += '<strong>error</strong><br>' + error + '<hr>';
		        console.log(msg);
		      }
		    }
    $.ajax(obj);
});
	
</script>
 
 <header class="header">
        <div class="jumbotron text-center mb-0">
            <h1>전 자 제 품 쇼 핑 몰</h1>
            <p>가성비 좋은 모니터들과 마우스가 있습니다.!!!</p>
        </div>
    </header>
    <nav class="navbar navbar-expand-sm navbar-dark bg-dark">
        <a href="${root }" class="navbar-brand">HOME</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#coll">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="coll">
            <ul class="navbar-nav">
            	<c:if test="${sessionScope.id eq null }">
	                <li class="nav-item"><a href="${root }/member/create" class="nav-link">회원가입</a></li>
            	</c:if>
                <li class="nav-item"><a href="${root }/cateGroup/create" class="nav-link">카테고리 관리</a></li>
                <li class="nav-item"><a href="${root }/stock/create" class="nav-link">재고 관리</a></li>
                <c:choose>
                	<c:when test="${sessionScope.id eq null }">
		                <li class="nav-item"><a href="${root }/member/login" class="nav-link">로그인</a></li>
                	</c:when>
                	<c:otherwise>
	                	 <li class="nav-item"><a href="${root }/member/logOut" class="nav-link" onclick="alert('로그아웃 되었습니다.');">로그아웃</a></li>
                	</c:otherwise>
                </c:choose>
                
                <c:choose>
                  <c:when test="${sessionScope.admin_id eq null }">
		                <li class="nav-item"><a href="${root }/admin/login" class="nav-link">관리자 로그인</a></li>
                  </c:when>
                  <c:otherwise>
		                <li class="nav-item"><a href="${root }/admin/logOut" class="nav-link">관리자 로그아웃</a></li>
                  </c:otherwise>
                </c:choose>
		                <li class="nav-item"><a href="${root }/member/mail" class="nav-link">메일 보내기 테스트</a></li>
            </ul>
           	 <div class="dropdown" style="padding-left: 15px;">
		          <a id="dLabel" data-target="#" href="http://naver.com" data-toggle="dropdown" aria-haspopup="true" role="button" aria-expanded="false">
		            카테고리 목록
		            <span class="caret"></span>
		          </a>
		          <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
		          </ul>
	        </div>
        </div>
    </nav>
    
    <div class="container">
        <div class="row mt-2">
            <div class="col-md-3">
            	<c:import url="/cateGroup/cateGroupSideList"/>
            </div>
            