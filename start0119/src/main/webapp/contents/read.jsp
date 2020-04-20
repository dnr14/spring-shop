<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="root" value="${pageContext.request.contextPath}" />


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" />
<title>게시판 상세</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>

<script>

var number = 0;
var setnumber = 0;

$(document).ready(function(){
	
	/*  바로구매 */
	$("#purchase").on('click',function(){
	var member_id = $("#memberid").val();
		
		if(member_id == ""){
			alert("로그인을 해야 이용 할 수 있습니다.");
			return;
		}
		
		var stockNo = $("#stockNo").val();
		var stockName = $("#stockName").val();
		var stockCnt = $("#stockCnt").val();
		var contentsNo = $("#contentsNo").val();
		var uri = "${requestScope['javax.servlet.forward.request_uri']}" +"?" +"${pageContext.request.queryString}";
		
		/* 장바구니 ajax 시작 */
		 var obj =  {
			      url : '../basket/add',
			      type : 'get',
			      cache: false,
			      async : true,
			      dataType : 'json',
			      data :'stockNo=' + stockNo +'&title=' + stockName + '&cnt='+ stockCnt +"&uri=" + uri + "&contentsNo=" + contentsNo,
			      success : function(rdata) {
			    	  var result = rdata.result;
			    	  if(result === "ok"){
				    	  alert("장바구니에 등록되었습니다.");
			    	  }else{
				    	  alert("이미 장바구니에 등록되어있습니다.");
			    	  }
			    	  alert("바로 구매로 이동합니다.");
			    	  document.location.href ="<c:url value='/payment/create' />";
			      },
			      error : function(request, status, error) {
			      }
			    }
			    /* 장바구니 ajax 끝 */
			    $.ajax(obj);
	});
	
	/* 장바구니 추가 기능 시작*/
	$("#showppingbarsket").on("click",function(){
		var member_id = $("#memberid").val();
		
		if(member_id == ""){
			alert("로그인을 해야 이용 할 수 있습니다.");
			return;
		}
		
		var stockNo = $("#stockNo").val();
		var stockName = $("#stockName").val();
		var stockCnt = $("#stockCnt").val();
		var contentsNo = $("#contentsNo").val();
		var uri = "${requestScope['javax.servlet.forward.request_uri']}" +"?" +"${pageContext.request.queryString}";
		
		/* 장바구니 ajax 시작 */
		 var obj =  {
			      url : '${root}/basket/add',
			      type : 'get',
			      cache: false,
			      async : true,
			      dataType : 'json',
			      data :'stockNo=' + stockNo +'&title=' + stockName + '&cnt='+ stockCnt +"&uri=" + uri + "&contentsNo=" + contentsNo,
			      success : function(rdata) {
			    	  var result = rdata.result;
			    	  if(result === "ok"){
				    	  alert("장바구니에 등록되었습니다.");
			    	  }else if(result === "over"){
				    	  alert("장바구니에 5개만 등록가능합니다.");
			    	  }
			    	  else{
				    	  alert("이미 장바구니에 등록되어있습니다.");
			    	  }
			      },
			      error : function(request, status, error) { // callback 함수
			      }
			    }
			    /* 장바구니 ajax 끝 */
			    $.ajax(obj);
	});
	/* 장바구니 추가 기능 끝*/
	
	/* 사진 불러오기 */
  setInterval(function(){
    changeRepresentImage(setnumber);
    setnumber++;
    if(setnumber == number){
      setnumber = 0;
    }
  }, 2000);
  
  var obj =  {
      url : '${root}/contents/read_file',
      type : 'get',
      cache: false,
      async : true,
      dataType : 'json',
      data : 'contentsNo=' + ${contentsVO.contentsNo},
      success : function(rdata) {
        if(rdata.file_read.length > 0){
        $("#images").attr("src","./storage/" + rdata.file_read[0].fupname);
        number = rdata.file_read.length;
	        for(var index = 0; index < rdata.file_read.length; index++){
	          
	          var tag = "<a href='javascrpt:;' onMouseover='changeRepresentImage("+index+");'>";
	          tag += "<img src='./storage/"+rdata.file_read[index].fupname+"' class='images' style='width:20%;height:100px; padding:0 5px 0 5px; border-radius: 20px;'/>";
	          tag += "</a>";
	          $("#view").append(tag);
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
/* 사진 불러오기 */

/* 사진 2초마다 돌아가기 */
function changeRepresentImage(num) {
  var link = $(".images").eq(num).attr("src");
  $("#images").attr("src", link);
  setnumber=num;
}
/* 사진 2초마다 돌아가기 */

/*  사진 크게 보기*/
function modal_view(e){
  $("#modal-img").attr("src",e.currentTarget.src);
}
/*  사진 크게 보기*/

function sum(e){
	
	var cnt = e.target.value;
	var price =${contentsVO.stockPrice};
	if(cnt > 10 ){
		alert("10개 이상 구매 불가능합니다.");
		cnt = 10;
		e.target.value = 10;
	}
	var sum = cnt  * price;
	$("#price").html('');
	$("#price").append(comma(sum));
	
	if(sum < 25000){
		sum += 2500;
		console.log(sum);
	} 
	$("#total_price").html('');
	$("#total_price").append(comma(sum));
	
}
function comma(num){
    var len, point, str; 
       
    num = num + ""; 
    point = num.length % 3 ;
    len = num.length; 
   
    str = num.substring(0, point); 
    while (point < len) { 
        if (str != "") str += ","; 
        str += num.substring(point, point + 3); 
        point += 3; 
    } 
     
    return str;
 
}
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function contentsDelete(){
	
	$.ajax({
		url : "./delete",
		type : "post",
		cache : false,
		async : true,
		dataType : "json",
		data : "contentsNo=" + $("#contentsNo").val(),
		success : function(data){
			console.log(data);
			if(data.result === 0){
				alert("상품이 삭제 되었습니다.");
				location.href='./list';
			}
		},
		errors : function(request, status, error){
			console.log(status);
			console.log(request);
			console.log(error);
		}
	});
	
}
function deleteCancel(){
	  $(".deleteClose").trigger("click");
}

</script>

<style type="text/css">
input:focus {
	outline: none;
}
</style>

<body>
	<jsp:include page="/menu/top.jsp" flush='false' />


	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog" style="width: 700px; height: 500px;">
			<div class="modal-content" style="height: 100%;">
				<div class="modal-header" style="border: none;">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<img src="./image/noimage.png" style="width: 100%; height: 400px;"
						id="modal-img" />
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="deleteModal" role="dialog">
		<div class="modal-dialog"
			style="width: 300px; height: 250px; margin-top: 100px;">
			<div class="modal-content" style="height: 100%;">
				<div class="modal-header" style="border: none;">
					<button type="button" class="deleteClose close"
						data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body text-center">
					<p>
						게시글이 삭제됩니다,<br> 정말로 삭제 하시겠습니까?<br> 복구 할수 없습니다.
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger"
						onclick="contentsDelete()">삭제</button>
					<button type="button" class="btn btn-danger"
						onclick="deleteCancel()">취소</button>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-9 cont">
		<div class="content">
			<h3 class="text-center">게시글 상세</h3>

			<c:if test="${not empty sessionScope.admin_id }">
				<div class="text-right">
					<a href="./images_update?contentsNo=${contentsVO.contentsNo}"><span
						class="label label-primary">썸네일 / 이미지 수정</span></a> | <a
						href="./update?contentsNo=${contentsVO.contentsNo}"><span
						class="label label-primary">상품 수정</span></a> | <a
						href="./delete?contentsNo=${contentsVO.contentsNo}"
						data-toggle="modal" data-target="#deleteModal"><span
						class="label label-danger">상품 삭제</span></a>
				</div>
			</c:if>

			<div style="margin: 30px 0 10px 0;" class="row">
				<!-- 이미지 -->
				<div class="col-sm-6  well">
					<div style="text-align: center; margin-bottom: 10px;">
						<a href="#" data-toggle="modal" data-target="#myModal"> <img
							src="./image/noimage.png" style="width: 300px; height: 300px;"
							id="images" onclick="modal_view(event)" />
						</a>
					</div>
					<div id="view" style="text-align: center;"></div>
					<div style="margin-top: 10px; text-align: center;">
						<label class="label label-danger">이미지에 마우스를 올려보세요.</label>
					</div>
				</div>

				<!-- 구매  -->
				<div class="col-sm-6">
					<div class="col-sm-12" style="margin-bottom: 5px;">
						<h3 style="font-size: 14px; margin: 0px; font-size: inherit;">${contentsVO.title}</h3>
					</div>
					<DIV class='menu_line' style='clear: both;'></DIV>
					<div>
						<div class="row" style="margin-bottom: 5px;">
							<div class="col-sm-3">
								<span style="color: #888; font-size: 0.9em;">판매가</span>
							</div>
							<div class="col-sm-9">
								<h3 style="margin: 0px;">
									<fmt:formatNumber value="${contentsVO.stockPrice}"
										pattern="#,###.##" />
									원
								</h3>
								<input type="hidden" value="${contentsVO.stockPrice}" />
							</div>
						</div>

						<div class="row" style="margin-bottom: 5px;">
							<div class="col-sm-3">
								<span style="color: #888; font-size: 0.9em;">구매혜택</span>
							</div>
							<div class="col-sm-9">
								<span style="color: #888; font-size: 0.9em;"> <fmt:formatNumber
										var="expiry" value="${contentsVO.stockPrice * 0.01}"
										maxFractionDigits="1" /> 적립포인트&nbsp${expiry}원
								</span>
							</div>
						</div>

						<div class="row" style="margin-bottom: 5px;">
							<div class="col-sm-3">
								<span style="color: #888; font-size: 0.9em;">재고 갯수</span>
							</div>
							<div class="col-sm-9">
								<span style="color: #888; font-size: 0.9em;">
									${contentsVO.stockCnt }개 </span>
							</div>
						</div>

						<div class="row" style="margin-bottom: 5px;">
							<div class="col-sm-3">
								<span style="color: #888; font-size: 0.9em;">카테고리</span>
							</div>
							<div class="col-sm-9">
								<span style="color: #888; font-size: 0.9em;">
									${contentsVO.categrpName} </span>
							</div>
						</div>

						<div class="row" style="margin-bottom: 5px;">
							<div class="col-sm-3">
								<span style="color: #888; font-size: 0.9em;">상품명</span>
							</div>
							<div class="col-sm-9">
								<span style="color: #888; font-size: 0.9em;">
									${contentsVO.stockName} </span>
							</div>
						</div>

						<div class="row" style="margin-bottom: 5px;">
							<div class="col-sm-3">
								<span style="color: #888; font-size: 0.9em;">배송비</span>
							</div>
							<div class="col-sm-9">
								<span style="color: #888; font-size: 0.9em;"> <fmt:formatNumber
										value="${contentsVO.deliveryCharge}" pattern="#,###.##" />원
								</span>
							</div>
						</div>
					</div>
					<div>
						<div
							style="padding: 10px; background: #dbdbdb; margin-top: 5px; border-radius: 20px;">
							<span style="margin-right: 10px; color: black;">${contentsVO.title}</span>
							<input type="number" value="1"
								style="border: 1px solid; border-radius: 5px; width: 45px; padding-left: 5px;"
								min="1" max="10" onchange="sum(event)" id="stockCnt">
						</div>
						<div style="margin-top: 10px;">
							<div style="text-align: right;">
								총 상품금액 &nbsp <span id="price"> <fmt:formatNumber
										value="${contentsVO.stockPrice}" pattern="#,###.##" /></span>원
							</div>
							<div style="text-align: right;">
								총 합계금액 &nbsp
								<c:if test="${contentsVO.stockPrice < 25000}">
									<c:set value="${contentsVO.stockPrice}" var="stockPrice" />
									<c:set value="${contentsVO.deliveryCharge}"
										var="deliveryCharge" />
									<span id="total_price"><fmt:formatNumber
											value="${stockPrice +  deliveryCharge}" pattern="#,###.##" /></span>원
				                  </c:if>
								<c:if test="${contentsVO.stockPrice > 25000}">
									<span id="total_price"><fmt:formatNumber
											value="${contentsVO.stockPrice}" pattern="#,###.##" /></span>원
				                  </c:if>
								<br>(택배비 포함 25000원 이상 무료 배송)
							</div>
						</div>
						<div class="row" style="margin-top: 20px;">
							<div class="col-sm-4">
								<button type="button" class="btn btn-primary"
									style="width: 100%; height: 50px;" id="purchase">바로구매</button>
							</div>
							<div class="col-sm-4">
								<button type="button" class="btn btn-primary"
									style="width: 100%; height: 50px;" id="showppingbarsket">장바구니</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="section1" style="margin: 10px 0 10px 0; width: 100%;">
		<nav class="navbar navbar-expand-md bg-dark" style="width: 100%;">
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav" style="width: 100%; text-align: center;">
					<li style="width: 20%;"><a href="#section1"
						style="color: white;">상품상제정보</a></li>
					<li style="width: 20%;"><a href="#section2">배송안내</a></li>
					<li style="width: 20%;"><a href="#section3">교환 및 반품 안내</a></li>
					<li style="width: 20%;"><a href="#section4">상품 후기</a></li>
					<li style="width: 20%;"><a href="#section5">상품 문의</a></li>
				</ul>
			</div>
		</nav>

		<div class="col-sm-12" id="section1">${contentsVO.contents}</div>
	</div>

	<div id="section2" style="margin: 10px 0 10px 0; width: 100%;">
		<nav class="navbar navbar-expand-md bg-dark">
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav" style="width: 100%; text-align: center;">
					<li style="width: 20%;"><a href="#section1">상품상제정보</a></li>
					<li style="width: 20%;"><a href="#section2"
						style="color: white;">배송안내</a></li>
					<li style="width: 20%;"><a href="#section3">교환 및 반품 안내</a></li>
					<li style="width: 20%;"><a href="#section4">상품 후기</a></li>
					<li style="width: 20%;"><a href="#section5">상품 문의</a></li>
				</ul>
			</div>
		</nav>
		<div style="margin-top: 10px; margin-bottom: 20px; font-size: 0.8em;">
			<strong>배송안내</strong><br> <br> &lt<strong>배송정보</strong>&gt<br>
			<strong>- 배송방법</strong> : 택배/소포/등기<br> - 배송지역 : 국내배송<br> -
			택배사 : 한진택배<br> - 배송완료일수 : 2-3일정도 소요<br> - 배송비 : 2,500원<br>

			- 배송비 무료조건 : 30,000원 이상 주문 시 무료<br> - 추가 배송비 : 도서산간 지역<br>

			※업체 직배송 제품이나 상품 종류에 따라 배송비가 추가될 수 있음 <br> <br> &lt<strong>반품주소</strong>&gt<br>

			- 반품지명 : 올라펫 물류센터<br> - 반품주소 : 경기도 화성시 서신면 전곡산단9길 5, 백운엔지니어링 A동
			올라펫물류센터<br> - 반품 연락처 : 1544-7867<br> - 반품 택배사 : 한진택배<br>
			<br> &lt<strong>출하지주소</strong>&gt<br> - 출하지명 : 올라펫 물류센터<br>

			- 출하지 주소 : 경기도 화성시 서신면 전곡산단9길 5, 백운엔지니어링 A동 올라펫물류센터<br> - 출하지
			연락처 : 1544-7867<br>
		</div>
	</div>
	<div id="section3" style="margin: 10px 0 10px 0; width: 100%;">
		<nav class="navbar navbar-expand-md bg-dark" style="width: 100%;">
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav" style="width: 100%; text-align: center;">
					<li style="width: 20%;"><a href="#section1">상품상제정보</a></li>
					<li style="width: 20%;"><a href="#section2">배송안내</a></li>
					<li style="width: 20%;"><a href="#section3"
						style="color: white;">교환 및 반품 안내</a></li>
					<li style="width: 20%;"><a href="#section4">상품 후기</a></li>
					<li style="width: 20%;"><a href="#section5">상품 문의</a></li>
				</ul>
			</div>
		</nav>
		<div style="margin-top: 10px; margin-bottom: 20px; font-size: 0.8em;">
			<h3>교환 및 반품안내</h3>
			<img src="./image/menu.jpg" style="width: 100%;">
			<div style="font-size: 0.8em; margin: 10px 0 10px 0;">
				<strong>환불안내</strong><br> - 환불관련 자세한 사항은 카카오톡 @올라펫 또는 올라펫샵
				서비스센터 1544-7867 로 문의주시기 바랍니다.<br>
				<br> <strong>AS안내</strong> - 소비자분쟁해결 기준(공정거래위원회 고시)에 따라 피해를
				보상받을 수 있습니다.<br> - "식품"의 경우 A/S가 불가능 합니다.<br> - 상품 제조사의
				A/S 기준에 따릅니다. <br> - A/S 관련 자세한 사항은 카카오톡 @올라펫 또는 올라펫샵 고객센터
				1544-7867 로 문의주시기 바랍니다.<br>
			</div>
		</div>
	</div>
	<div id="section4" style="margin: 10px 0 10px 0; width: 100%;">
		<nav class="navbar navbar-expand-md bg-dark" style="width: 100%;">
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav" style="width: 100%; text-align: center;">
					<li style="width: 20%;"><a href="#section1">상품상제정보</a></li>
					<li style="width: 20%;"><a href="#section2">배송안내</a></li>
					<li style="width: 20%;"><a href="#section3">교환 및 반품 안내</a></li>
					<li style="width: 20%;"><a href="#section4"
						style="color: white;">상품 후기</a></li>
					<li style="width: 20%;"><a href="#section5">상품 문의</a></li>
				</ul>
			</div>
		</nav>
	</div>

	<div id="section5" style="margin: 10px 0 10px 0; width: 100%;">
		<nav class="navbar navbar-expand-md bg-dark" style="width: 100%;">
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav" style="width: 100%; text-align: center;">
					<li style="width: 20%;"><a href="#section1">상품상제정보</a></li>
					<li style="width: 20%;"><a href="#section2">배송안내</a></li>
					<li style="width: 20%;"><a href="#section3">교환 및 반품 안내</a></li>
					<li style="width: 20%;"><a href="#section4">상품 후기</a></li>
					<li style="width: 20%;"><a href="#section5"
						style="color: white;">상품 문의</a></li>
				</ul>
			</div>
		</nav>
	</div>

	<!-- 상품 번호-->
	<input type="hidden" value="${contentsVO.stockNo }" id="stockNo">
	<!-- 상품 이름-->
	<input type="hidden" value="${contentsVO.stockName }" id="stockName">
	<!-- 구매자 -->
	<input type="hidden" value="${sessionScope.id }" id="memberid">

	<input type="hidden" value="${contentsVO.contentsNo}" id="contentsNo">


	<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
</html>
