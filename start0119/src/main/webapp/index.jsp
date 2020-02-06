<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <meta charset="UTF-8">
    <title>회원가입 페이지</title>
</head>
<body>
   <jsp:include page="/menu/top.jsp" flush='false' />
            <div class="col-md-9 cont">
                <div class="content">
                    <h1 class="text-center">인기제품</h1>
                    <div class="row">
                        <div class="col-md-4 main">
                            <div style="padding: 10px;border: 1px solid;border-radius: 10px; cursor: pointer;" >
                                <img src="./image.jpg" alt="이미지가 없습니다." style="width: 100%;" class="opac">
                                <p style="font-weight: bold;" class="title"><span class="badge badge-danger mr-2">인기제품</span>프리미엄 모니터</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
      <jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
<script>
    
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
            $(this).find('.opac').attr('style','opacity: 0.5; width: 100%;');
            $(this).find('.title').attr('style','font-weight: bold; color:#ff4d4d;');
        });
        $(".main").mouseleave(function(){
            $(".opac").attr('style','width: 100%;');
            $(".title").attr('style','font-weight: bold; color:black;');
        });
    });
</script>

</html>