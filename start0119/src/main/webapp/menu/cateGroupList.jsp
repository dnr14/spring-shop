<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <c:set var="root" value="${pageContext.request.contextPath}" />
 
        <h2 class="text-center">카테고리</h2>
           <p class="text-center">원하시는 제품을 찾아보세요!!</p>
           <ul class="list-group">
           		<c:forEach var="cateGroupSideList" items="${cateGroupSideList}">
         			   <li class="list-group-item list-group-itme-action"><a href="#">${cateGroupSideList.categrpName} (${cateGroupSideList.categrpCnt})</a></li>
           		</c:forEach>
           </ul>
  
