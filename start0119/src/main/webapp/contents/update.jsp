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
<title>상품 수정</title>
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
</head> 

<script type="text/javascript">
$(function(){
	  CKEDITOR.replace('contents'); 
	  repository_select();
	});
function repository_select(){
	  var tag_name = document.getElementById('categroup');
	  var categrpNo = tag_name.options[tag_name.selectedIndex].value;
	  
	  if(categrpNo != '0'){
	    $('#repositoy').empty();
	    var obj =  {
	        url : './repository_select',
	        type : 'get',
	        cache: false,
	        async : true,
	        dataType : 'json',
	        data : 'categrpNo=' + categrpNo,
	        
	        success : function(rdata) {
	          var repositoy_select = rdata.repositoy_select;
	          if(repositoy_select.length > 0){
	        	 $.each(repositoy_select, function(i, item) {
		              $('#repositoy').append("<option value='"+item.stockNo+"'>"+item.stockName+"</option>");
	        	 });
	          }else{
	            $('#repositoy').append("<option>없음</option>");
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
	    $('#repositoy').empty();
	    var html = "<option>카테고리 선택하세요.</option>";
	    $('#repositoy').append(html);
	  }
	 
	}
	
	
</script>
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
            <div class="col-md-9 cont">
				<div class="content">
					<form action="./update" method="post">
				      <input type="hidden" value="${contentsVO.contentsNo}" name="contentsNo">
				      <!-- 카테고리 -->
				      <span class="badge">카테고리 선택 :</span>     
				      <select name="categrpNo" id='categroup' onchange="repository_select()" class="input-sm form-control">  
				          <option value="0">선택</option>
				     	  <c:forEach var="cate" items="${cate}">
				          <option value="${cate.categrpNo}" ${contentsVO.categrpNo == cate.categrpNo ? "selected='selected'" : ''}>${cate.categrpName}(${cate.categrpNo})</option>
				      	  </c:forEach>
				      </select>
				      <br>
				      <!-- 상품 재고 -->
				      <div class="form-group" >
				        <span class="badge">재고 선택 :</span> <select name="stockNo" id='repositoy' class="input-sm form-control"></select><br>
				      </div>
				      <div class="form-group" >
				        <span class="badge">배송비 :</span> <input type="number"  value="${contentsVO.deliveryCharge}" name="deliveryCharge" style="width: 20%;" class="input-sm form-control">
				      </div>      
				      <div class="form-group">
				        <span class="badge">제목 :</span> <input type="text" value="${contentsVO.title}"  name="title" class="input-sm form-control">
				      </div>
				      <div class="form-group">
				        <span class="badge">검색어 :</span> <input type="text"  value="${contentsVO.keyword}" name="keyword" class="input-sm form-control"><br>
				      </div>
				      <div class="form-group">
				      <span class="badge">등록직원 :</span> <input type="text" value="${contentsVO.manager}" name="manager" class="input-sm form-control" value="${ contentsVO.manager}" readonly="readonly"><br>
				      </div>
				        <textarea class="form-control input-lg" name='contents' id='contents' rows='10' >${contentsVO.contents}</textarea>
				      <div style="margin-top: 10px; text-align: center;">
				        <button type="submit" class="btn btn-primary">등록</button>
				        <button type="button" class="btn btn-primary">취소</button>
				      </div>
				    </form>
				</div>
			</div>

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html> 
  