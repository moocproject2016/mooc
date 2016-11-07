<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="/mooc/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script src="/mooc/js/bootstrap.min.js"></script>
        <script>
    	function noteOpen(a){
    		window.open("/mooc/user/user_image.mooc?sub_lec_code="+a, "window", "width=600,height=700,scrollbars=no,location=no");
    	}

        </script>
<table class="table" align="center">
	<tr class="theadtop">
		<th>타입</th>
		<th>강의</th>
		<th>진도</th>
		<th>최근수정일</th>
	<tr>
	<c:if test="${list!=null}">
		<c:forEach items="${list}" var="dto">
			<tr>
				<td align="center">${dto.note_type}</td><td>${dto.main_lec_subject} </td>
				<td align="center"><a onclick="noteOpen(${dto.sub_lec_code})">chapter ${dto.sub_lec_chapter} :${dto.sub_lec_subject}</a></td>
				<td align="center"><fmt:formatDate value="${dto.note_date}" type="date"/></td>
			</tr>
	</c:forEach>
	</c:if>
	<c:if test="${list==null}">
		<tr>
			Note기록이 없습니다.
		</tr>
	</c:if>
</table>




<table class="table" align="center">
			<tr>
				<td height="50" align="center">
					<c:if test="${count > 0}">					
						<c:set var="pageCount" value="${count / pageSize + ( count % pageSize == 0 ? 0 : 1)}" />
						<c:set var="pageBlock" value="${10}" />			
						<fmt:parseNumber var="result" value="${currentPage / 10}" integerOnly="true" />
						
						<c:set var="startPage" value="${result * 10 + 1}" />
						<c:set var="endPage" value="${startPage + pageBlock-1}" />
							<c:if test="${endPage > pageCount}">
								<c:set var="endPage" value="${pageCount}" />
							</c:if>	
						
						
						<nav>
  						<ul class="pagination">
									
						<c:if test="${startPage > 10}">
						<li>
      						<a href="/mooc/user/noteList.mooc?pageNum=${startPage - 10 }" aria-label="Previous">
        					<span aria-hidden="true">&laquo;</span>
      						</a>
    					</li>
						</c:if>
				
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:if test="${currentPage==i}">
								<li class="active"><a href="/mooc/user/noteList.mooc?pageNum=${i}">${i}</a></li>
							</c:if>
							<c:if test="${currentPage!=i}">							
								<li><a href="/mooc/user/noteList.mooc?pageNum=${i}">${i}</a></li>
							</c:if>
						</c:forEach>
					
						<c:if test="${endPage < pageCount}">
						<li>
						<a href="/mooc/user/noteList.mooc?pageNum=${startPage + 10}" aria-label="Next">
        					<span aria-hidden="true">&raquo;</span>
      					</a>
      					</li>
						</c:if>
						</nav>
					</c:if>
				</td>
			</tr>
	</table>

