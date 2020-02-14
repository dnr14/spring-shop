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
<title>카테고리 생성 페이지</title>
 
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
			
		<div class="modal fade" id="myModal" role="dialog">
		    <div class="modal-dialog" style="width: 700px; height: 500px;">
		      <div class="modal-content"style="height: 100%;">
		        <div class="modal-header" style="border: none;">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        <div class="modal-body">
		        	<div class="row">
		        		<div class=col-sm-12>
								<h3 class="text-center">카테고리 수정</h3>
								<form id="update_form">
								<input type="hidden" id="update_categrpNo" name="categrpNo">
									<div class="form-group">
										<label for="categrpName">카테고리 이름</label> 
										<input type="text" class="form-control" placeholder="카테고리 이름을 입력하세요." name="categrpName" id="update_categrpName">
									</div>
									<div class="form-group">
										<label for="categrpSeqno">카테고리 출력 순서</label> 
										<input type="number" class="form-control" min="1" max="10" name="categrpSeqno" id="update_categrpSeqno">
									</div>
									<div class="form-group">
										<label for="categrpVisible">카테고리 출력 유무</label> 
										<select name="categrpVisible" class="form-control w-25"  id="update_categrpVisible">
											<option value="Y" selected="selected">Y</option>
											<option value="N">N</option>
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

            <div class="col-md-9 cont">
				<div class="content">
					<h3 class="text-center">카테고리 등록</h3>
					<c:url value="/cateGroup/create.do" var="path"/>
					<form:form role="form" commandName="cateGroupCreateRequest" action="${path }" method="post">
						<div class="form-group">
							<label for="categrpName">카테고리 이름</label> 
								<form:input 
								type="text"
								class="form-control"
								placeholder="카테고리 이름을 입력하세요." 
								path="categrpName" />
								<div class="mt-2">
									<form:errors path="categrpName" style="color:red"/>
								</div>
						</div>
						<div class="form-group">
							<label for="categrpSeqno">카테고리 출력 순서</label> 
								<form:input 
								type="number"
								class="form-control"
								min="1"
								max="10"
								path="categrpSeqno" />
								<div class="mt-2">
									<form:errors path="categrpSeqno" style="color:red"/>
								</div>
						</div>
						<div class="form-group">
							<label for="categrpVisible">카테고리 출력 유무</label> 
							<form:select path="categrpVisible" class="form-control w-25">
								<form:option value="Y" selected="selected">Y</form:option>
								<form:option value="N" >N</form:option>
							</form:select>
						</div>
						<div>
							<button type="submit" class="btn btn-primary">등록</button>
						</div>
					</form:form>
					<div class="mt-3">
						<c:if test="${Excess != null}">
							<span style="color:red">${Excess}</span>
						</c:if>
					</div>
				</div>
				
				<table class="table mt-3" >
					<colgroup>
						<col width="10%"> <!-- 카테고리 번호 -->
						<col width="15%"> <!-- 카테고리 이름  -->
						<col width="20%"> <!--  하위 컨텐츠 갯수-->
						<col width="15%"> <!--  카테고리 출력 순서 -->
						<col width="10%"> <!-- 카테고리 출력 유무 -->
						<col width="20%"> <!-- 카테고리 등록 시간 -->
						<col width="10%"> <!-- 카테고리 등록 시간 -->
					</colgroup>
					
					<thead class="text-center">
						<tr>
							<th>번호</th>
							<th>이름</th>
							<th>하위 컨텐츠 갯수</th>
							<th>카테고리<br> 출력 순서</th>
							<th>출력<br> 유무</th>
							<th>등록 시간</th>
							<th>수정 / <br>삭제</th>
						</tr>
					</thead>
					
					<tbody class="text-center">
						<c:forEach var="list" items="${cateGroupList}"> 
						<tr>
							<td>${list.categrpNo}</td>
							<td>${list.categrpName}</td>
							<td>${list.categrpCnt}</td>
							<td>${list.categrpSeqno}</td>
							<td>${list.categrpVisible}</td>
							<td>${list.categrpRdate}</td>
							<td>
								<img src="../categroup/images/update.png" 
								alt="수정" style=" width: 30px; height: 30px; cursor: pointer;" class="update"
								 data-toggle="modal" data-target="#myModal"> 
								<input type="checkbox" class="ml-2 cateGroupCheckBox">
								<input type="hidden"  value="${list.categrpNo}" class="categrpNo"/>
							</td>
						</tr>			
						</c:forEach>
					</tbody>
				</table>
				<div class="text-right">
					<button class="btn btn-primary" id="cateGroupDeleteAllCheck">전체 체크</button>
					<button class="btn btn-primary" id="cateGroupDelete">삭제</button>
				</div>
			</div>
			

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

<script type="text/javascript">
$(document).ready(function(){
		
		//카테고리 목록 삭제
		$("#cateGroupDelete").on("click",function(){
			var multiparam= new Array();
			var categrpNo = $(".categrpNo");
			$(".cateGroupCheckBox").each(function(index, item) {
				if(item.checked == true){
					multiparam.push(categrpNo[index].value);
				}
			});
			
			if(multiparam.length == 0){
				alert("체크를 해주세요.");
				return;
			}
			
			var result = confirm("삭제를 하면 하위 컨텐츠도 삭제 됩니다.");
			console.log(result);
			if(result == false){
				alert("취소 되었습니다.");
				return;
			}
			
			
			var param = {
					array : multiparam
			}
			
			 var obj =  {
				      url : '${root}/cateGroup/cateGroupDelete',
				      type : 'post',
				      cache: false,
				      async : true,
				      dataType : "json",
				      contentType : "application/json; charset=utf-8",//JSON으로 넘길때
				      data :JSON.stringify(param),
				      success : function(rdata) {
				    	  location.reload();
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
		//카테고리 목록 삭제
		
		//카테고리 모두 체크
		$("#cateGroupDeleteAllCheck").on('click',function(){
			$.each($(".cateGroupCheckBox"), function(i, item) {
				console.log(item.checked);
				item.checked = true;
			});
		});
		//카테고리 모두 체크
		
		// 카테고리 수정 불러오기
		$(".update").on('click',function(){
			var categrpNo = $(this).siblings(".categrpNo").val();	
			var obj =  {
				      url : '${root}/cateGroup/cateGroupUpdate',
				      type : 'post',
				      cache: false,
				      async : true,
				      dataType : "json",
				      data : "categrpNo="+ categrpNo,
				      success : function(rdata) {
				    	  var json = JSON.parse(rdata.cateGroupVO);
				    	  $("#update_categrpName").val(json.categrpName);
				    	  $("#update_categrpSeqno").val(json.categrpSeqno);
				    	  $("#update_categrpVisible").val(json.categrpVisible);
				    	  $("#update_categrpNo").val(json.categrpNo);
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
		// 카테고리 수정 불러오기
		
		// 카테고리 수정
		$("#update_form").submit(function(event) {
			event.preventDefault();
			
			var queryString = $(this).serialize();
			console.log(queryString);
			var obj =  {
				      url : '${root}/cateGroup/cateGroupUpdateProc',
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
				        msg += '<strong>request.status</strong><br>' + request.status
				            + '<hr>';
				        msg += '<strong>error</strong><br>' + error + '<hr>';
				        console.log(msg);
				      }
				    }
				    $.ajax(obj);
		});
		// 카테고리 수정
		
});
</script>
</html> 
  