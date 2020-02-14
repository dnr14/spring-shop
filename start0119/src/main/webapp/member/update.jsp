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
<title>회원정보 수정 페이지</title>
 
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
		/* 비밀번호 수정 */
		$("#beforePwd").submit(function(event) {
			event.preventDefault();
			
			var queryString = $(this).serialize();
			console.log(queryString);
			var obj =  {
				      url : '${root}/member/pwdUpdate',
				      type : 'post',
				      cache: false,
				      async : true,
				      dataType : "json",
				      data : queryString,
				      success : function(rdata) {
				    	  var result = rdata.result;
				    	  console.log(result);
				    	  $("#beforePwdError").css('display','none');
				    	  $("#afterPwdError").css('display','none');
				    	  $("#afterPwd_Check_Error").css('display','none');
				    	  
				    	  if(result === "pwd_update"){
				    		  alert("비밀번호가 변경되었습니다.");
				    	 	  $(".close").trigger("click");
					    	  location.reload();
				    	  }else if(result === "beforePwd_mismatch"){
				    		  $("#beforePwdError").html("비밀번호가 틀렸습니다.").css('display','block');
				    	  }else if(result === "afterPwd_mismatch"){
				    		  $("#afterPwdError").html("변경할 비밀번호가 틀렸습니다.").css('display','block');;
				    	  }else{
				    		 // empty
				    		 if(result === "beforePwd_empty"){
				    	 		  $("#beforePwdError").html("값을 입력해주세요.").css('display','block');
				    		 }else if(result === "afterPwd_empty"){
					    		  $("#afterPwdError").html("값을 입력해주세요.").css('display','block');;
				    		 } else if(result === "afterPwd_Check_empty"){
					    		  $("#afterPwd_Check_Error").html("값을 입력해주세요.").css('display','block');;
				    		 }
				    	  }
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
		/*  비밀번호 수정*/
		
	});
</script>

<body>
<jsp:include page="/menu/top.jsp" flush='false' />

	<!-- 비밀번호 수정 -->
	<div class="modal fade" id="myModal" role="dialog">
		    <div class="modal-dialog" style="width: 700px; height: 400px;">
		      <div class="modal-content"style="height: 100%;">
		        <div class="modal-header" style="border: none;">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        <div class="modal-body">
		        	<form id="beforePwd">
		        	<div id="before">
		        		<h1>비밀번호 입력</h1>
			        	<div><input type="password" class="form-control" placeholder="이전 비밀번호를 입력하세요." name="beforePwd"></div>
			        	<div class="mt-2"><span id="beforePwdError" style="display: none; color: red;"></span></div>
			        	<div class="mt-2"><input type="password" class="form-control" placeholder="변경할 비밀번호를 입력하세요." name="afterPwd" maxlength="8"></div>
			        	<div class="mt-2"><span id="afterPwdError" style="display: none; color: red;"></span></div>
			        	<div class="mt-2"><input type="password" class="form-control" placeholder="변경할 비밀번호를 입력하세요." name="afterPwd_Check" maxlength="8"></div>
			        	<div class="mt-2"><span id="afterPwd_Check_Error" style="display: none; color: red;"></span></div>
			        	<button type="submit" class="btn btn-primary mt-2">수정</button>
		        	</div>
		        	</form>
		        </div>
		       </div>
		      </div>
		    </div>
		    <!-- 비밀번호 수정 -->

            <div class="col-md-9 cont">
                <div class="content">
                    <h3 class="text-center">회원정보 수정</h3>
                    <c:url value="/member/update" var="path"/>
                    <form:form  role="form" commandName="memberCreateRequest" action="${path }" method="post">
                    <c:set value="${memberVO }" var="mem"/>
                        <div class="form-group">
                            <label for="id">아이디 : </label>
                       	   <form:input type="text" path="id" class="form-control" value="${mem.id }" readonly="true"/>
                        </div>
                        <div class="form-group">
                        	<!-- RegisterRequestValidator 검사 시 pwd nullpoin Exception 방지 -->
                       		<form:password class="form-control"  path="pwd"  value="${mem.pwd }"  style="display:none;"/>
                        </div>
                        <div class="form-group">
                        	<!-- RegisterRequestValidator 검사 시 pwd nullpoin Exception 방지 -->
                            <form:password class="form-control"  path="pwd_check" value="${mem.pwd }" style="display:none;"/>
                        </div>
                        <div class="form-group">
                            <label for="email">이메일 : </label>
                       	   <form:input type="email" path="email" class="form-control" value="${mem.email }" readonly="true"/>
                        </div>
                        <div class="form-group">
                            <label for="phone">핸드폰 : </label>
                       		<form:input type="text" path="phone" class="form-control" value="${mem.phone }"/>
                       		 <div class="mt-2">
	                     		<form:errors path="phone" cssClass="err"/>
                       		 </div>
                        </div>
                        <div class="form-group">
                            <label for="zipcode">주소 : </label>
                            <form:input type="text" path="zipcode" class="form-control" value="${mem.zipcode }"/>
                            <div class="mt-2">
	                      		<form:errors path="zipcode" cssClass="err"/>
                            </div>
                            <form:input type="text" path="address1" class="form-control mt-2" value="${mem.address1 }" />
                             <div class="mt-2">
	                      		<form:errors path="address1" cssClass="err"/>
                             </div>
                            <form:input type="text" path="address2" class="form-control mt-2"  value="${mem.address2 }"/>
                             <div class="mt-2">
	                      		<form:errors path="address2" cssClass="err"/>
                             </div>
                      		<div class="mt-2">
	                            <button type="button" class="btn btn-primary" onclick="DaumPostcode();">주소 찾기</button>
	                            <button type="button" class="btn btn-primary ml-2" data-toggle="modal" data-target="#myModal">비밀번호 변경</button>
                      		</div>
                        </div>
                        <!-- ----- DAUM 우편번호 API 시작 ----- -->
					    <div id="wrap" style="display:none; border:1px solid;width:500px;height:300px;margin:5px 110px;position:relative;">
					      <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
					    </div>
                        
                        <button type="submit" class="btn btn-primary">회원수정</button>
                    </form:form>
                </div>
            </div>
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');
 
    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }
 
    function DaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
 
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                console.log(fullAddr);
                var extraAddr = ''; // 조합형 주소 변수
 
                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }
 
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('address1').value = fullAddr;
 
                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';
 
                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
                
                $('#address2').focus();
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);
 
        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
    
    function move_scroll(){
        // 화면이동 id=wrap
        var offset = $("#move_top").offset();
        $('html, body').animate({scrollTop : offset.top}, 400);
    }
</script>
 
</html> 
  