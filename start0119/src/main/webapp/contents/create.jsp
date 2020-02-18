<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath}" />

 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>상품 등록</title>
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head> 

<style>
.SelectBox {	width: 200px;	display: table-cell;}
.Title {    width: 500px;    display: table-cell;}
.width {	width: 200px;    display: table-cell;}
.err{color:red;}
</style>

<script type="text/javascript">
	 
	$(document).ready(function() {
		/* 게시판 내용 */
		 CKEDITOR.replace('contents'); 
		
		/*  카테고리 불러오기 */
		$("#categrpNo").on("change",function(){
			var SelectValue = this.options[this.selectedIndex].value;
			
			if(SelectValue != '0'){
				$("#stock").empty();
				   var obj =  {
					         url : './CateGroupAjax',
					         type : 'get',
					         cache: false,
					         async : true,
					         dataType : 'json',
					         data : 'categrpNo=' + SelectValue,
					         success : function(rdata) {
					        	 var stock = rdata.cate;
					        	 if(stock.length != 0){
					        		 $("#stockNo").empty();
					        		 $.each(stock, function(i, item) {
						        		$("#stockNo").append("<option value='"+item.stockNo +"'>"+item.stockName+"</option>");
					        		 });
					        	 }else{
					        		 $("#stockNo").html("<option>상품 없음</option>");
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
			}else{
				$("#stockNo").empty();
				$("#stockNo").append("<option>카테고리 먼저 선택</option>");
			}
		});	
		
		
		/* 이미지 등록 */
		$("#input_img").on('change',handleImgFileSelect);
		$("#thum_img").on('change',thumFileSelect);
	});
	
	
	 var sel_files = [];
	 
	 function handleImgFileSelect(e){
	   var files = e.target.files;
	   
	   var filetotal = $("#img").children().length;
	   var total = filetotal + files.length;
	   
	   if(total > 5){
	     alert("최대 5개만 가능합니다.");
	     $("#input_img").val("");
	     return;
	   }
	   
	   
	   var filesArray = Array.prototype.slice.call(files);
	   filesArray.forEach(function(f){
	      if(!f.type.match("image.*")){
	        alert("확장자는 이미지 확장자만 가능합니다.");
	        return;
	      }      
	      
	      sel_files.push(f);
	      
	      var reader = new FileReader();
	      reader.onload = function(e){
	        var tag ="<img src='"+ e.target.result +"' style='width:150px;height:150px; margin-left:10px;'>";
	        $("#img").append(tag);
	      }
	      reader.readAsDataURL(f);
	   });
	   
	 }
	 /*  썸네일 */
	 function thumFileSelect(e){
		   var files = e.target.files;
		   var filesArray = Array.prototype.slice.call(files);
		   filesArray.forEach(function(f){
		     if(!f.type.match("image.*")){
		       alert("확장자는 이미지 확장자만 가능합니다.");
		       return;
		     }      
		     
		     sel_files.push(f);
		     
		     var reader = new FileReader();
		     reader.onload = function(e){
		       $("#thum").attr("src",e.target.result);
		     }
		     reader.readAsDataURL(f);
		  });
		   
		 }
</script>
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
			
            <div class="col-md-9 cont">
				<div class="content">
					<h3 class="text-center">상품 등록</h3>
					<c:url value="/contents/create" var="path"/>
					<form:form  role="form" 
					commandName="ContentsCreateDto" action="${path }" 
					method="post"
					enctype="multipart/form-data"
					>
					<div>
					<span>카테고리 : </span>
							<!-- 카테고리                                                                     -->
							<form:select path="categrpNo" class="form-control SelectBox">
								<form:option value="0" selected="selected">
									선택
								</form:option>
								<c:forEach var="cate" items="${cate }">
									<form:option value="${cate.categrpNo }">
										${cate.categrpName }
									</form:option>							
								</c:forEach>
						    </form:select>
					    	 <div class="mt-2">
	                     		<form:errors path="categrpNo" cssClass="err"/>
                       		 </div>
							<!-- 카테고리                                                                     -->
							<span>상품 : </span>
							<!-- 상품명                                                                     -->
							<!-- js로 동적 처리                                                                     -->
					 		<form:select path="stockNo" class="form-control SelectBox">
					 			<form:option value="0">카테고리 먼저 선택</form:option>
					 		</form:select>
							<div class="mt-2">
	                     		<form:errors path="stockNo" cssClass="err"/>
                       		 </div>
							<!-- 상품명                                                                     -->
					</div>
					<div class="mt-2">
						<!-- 제목                                                                     -->
						<span>제목 : </span>
						<form:input path="title" class="form-control Title"/>
						<div class="mt-2">
                     		<form:errors path="title" cssClass="err"/>
                        </div>
						<!-- 제목                                                                     -->
					</div>
					<div class="mt-2">
						<!-- 키워드                                                                     -->
						<span>키워드 : </span>
						<form:input path="keyword" class="form-control width"/>
						<!-- 키워드                                                                     -->
						<div class="mt-2">
                     		<form:errors path="keyword" cssClass="err"/>
                        </div>
					</div>
					<div class="mt-2">
						<!-- 배송비 -->
						<span>배송비 : </span>
						<form:input path="deliveryCharge" class="form-control width"/>
						<!-- 배송비 -->
						<div class="mt-2">
                     		<form:errors path="deliveryCharge" cssClass="err"/>
                        </div>
					</div>
					<div class="mt-2">
						<!-- 등록자 -->
						<span>등록자 : </span>
						<input type="text" class="form-control width" value="${sessionScope.admin_id}" name="manager" readonly="readonly"/>
						<!-- 등록자 -->
					</div>
					<div class="mt-2">
						<!-- 내용 -->
						<form:textarea path="contents" class="form-control input-lg" rows="10"/>
						<!-- 내용 -->
						<div class="mt-2">
                     		<form:errors path="contents" cssClass="err"/>
                        </div>
					</div>
					<div class="mt-5">
						<h1>사진 등록</h1>
						<div id="img" style="margin-top: 30px; margin-bottom: 10px;">
						</div>
				        <form:input type="file" path="fnamesMF" class="input-sm" id="input_img" style="margin-top: 15px;" multiple="multiple"/>
					</div>
					<div class="mt-5">
						<h1>썸네일 등록</h1>
						<img id="thum" style="width: 150px; height: 150px;" src="./image/noimage.png"/>
					    <form:input type="file" path="fthum" class="input-sm" id="thum_img" />
					</div>
					<div class="mt-2 text-center">
						<button type="submit" class="btn btn-primary">등록</button>
					</div>
					</form:form>
				</div>
			</div>

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html> 
  