<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set value="${pageContext.request.contextPath }" var="root"/>

 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>회원정보 삭제 페이지</title>
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
 
</head> 
<style>
	.err{
		color:red;
	}
	
</style>


<script type="text/javascript">
	$(document).ready(function() {
		/* 회원 삭제*/
		$("#memberDelete").submit(function(event) {
			event.preventDefault();
			var queryString = $(this).serialize();
			console.log(queryString);
			var obj =  {
				      url : '${root}/member/delete',
				      type : 'post',
				      cache: false,
				      async : true,
				      dataType : "json",
				      data : queryString,
				      success : function(jsonObject) {
				    	  var result = jsonObject.result;
				    	  
				    	  $("#error_text").css("display","block");
				    	  
				    	  if(result === "pwd_null"){
								$("#error_text").html("비밀번호를 입력하세요.");				    		  
				    	  }else if(result ==="pwd_mismatch"){
								$("#error_text").html("비밀번호가 다릅니다.");				    		  
				    	  }else if(result === "delete_fail") {
				    		  alert("삭제에 실패 했습니다. 관리자한테 문의하세요.");
				    	  }else if(result === "delete_success"){
				    		  alert("회원이 삭제 되었습니다. \n 이용해 주셔서 감사합니다.")
				    		  location.href="${root}/member/logOut";  
				    	  }
				    	  
				      },
				      error : function(request, status, error) { // callback 함수
				        var msg = 'ERROR<br><br>';
				        msg += '<strong>request.status</strong><br>';
				        msg += request.status;
				        msg += '<hr>';
				        msg += '<strong>error</strong><br>' + error + '<hr>';
				        console.log(msg);
				        
				        alert('통신이 안좋습니다. 관리자 한테 문의하세요.');
				      }
				    }
				    $.ajax(obj);
		});
		/*  회원삭제 */
		
	});
</script>

<body>
<jsp:include page="/menu/top.jsp" flush='false' />
            <div class="col-md-9 cont">
                <div class="content">
                    <h3 class="text-center mt-2">회원정보 삭제</h3>
                    <form id="memberDelete" class="form-group">
                    	<label for="pwd">비밀번호</label>
                    	<div class="mt-2"><input type="password" id="pwd" class="form-control" name="pwd"></div>
                    	<div class="mt-2" ><span style="display: none; color:red;" id="error_text"></span></div>
                    	<div class="mt-2"><button type="submit" class="btn btn-danger">회원삭제</button></div>
                    	<div class="mt-2" style="color:red;">삭제 시 복구가 불가능합니다. 그래도 진행 하시겠습니까??</div>
                    </form>
                </div>
            </div>
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html> 
  