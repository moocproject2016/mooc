<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="/mooc/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script src="/mooc/js/bootstrap.min.js"></script>
<table class="table" align="center">
	<tr class="theadtop">
		<th>&nbsp;</th>
		<th>강의명</th>
		<th>강사</th>
		<th>강의시작일</th>
	<tr>
	<c:if test="${list!=null}">
		<c:forEach items="${list}" var="dto">
			<tr>
				<td align="center"><img src="${dto.main_lec_image}" style="width:50px;height:50px" onclick="location.href='/mooc/viewMainLec.mooc?main_lec_code=${dto.main_lec_code}'""></td>
				<td align="center"><a href="/mooc/viewMainLec.mooc?main_lec_code=${dto.main_lec_code}" target="blank">${dto.main_lec_subject}</a></td>
				<td align="center">${dto.u_name} </td>
				<td align="center"><fmt:formatDate value="${dto.main_lec_regdate}" type="date"/></td>
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
      						<a href="/mooc/user/likeLectureList.mooc?pageNum=${startPage - 10 }" aria-label="Previous">
        					<span aria-hidden="true">&laquo;</span>
      						</a>
    					</li>
						</c:if>
				
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:if test="${currentPage==i}">
								<li class="active"><a href="/mooc/user/likeLectureList.mooc.mooc?pageNum=${i}">${i}</a></li>
							</c:if>
							<c:if test="${currentPage!=i}">							
								<li><a href="/mooc/user/likeLectureList.mooc?pageNum=${i}">${i}</a></li>
							</c:if>
						</c:forEach>
					
						<c:if test="${endPage < pageCount}">
						<li>
						<a href="/mooc/user/likeLectureList.mooc?pageNum=${startPage + 10}" aria-label="Next">
        					<span aria-hidden="true">&raquo;</span>
      					</a>
      					</li>
						</c:if>
						</nav>
					</c:if>
				</td>
			</tr>
	</table>

