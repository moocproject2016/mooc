<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	function clickMain(x){
		var main_lec;
		t_id=document.getElementsByName("t_id")[x].value;
		
		$.ajax({
			type: 'post',
			url: "/mooc/user/likeTeacherList_Ajax.mooc",
			data: {
				t_id:t_id
			},
			success: function(data) {
				$('.rightTable80').empty();
				$('.rightTable80').append(data);
			},
			error: function(data){
				alert("실패");
			}
		});
		
		
	}
</script>


<form name="inform">
	<div class="leftTable20">
		<ul><h3>관심강사</h3></br>
		<c:forEach var="dto" items="${list}"  varStatus="i">
			<li><a href="javascript:clickMain('${i.index}','${fn:length(list)}');">${dto.u_name}</a></li>
			<input type="hidden" name="t_id" value="${dto.t_id}"/>
		</c:forEach>
		</ul>
	</div>
	<div class="rightTable80">
	</div>
</form>

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
     						<a href="/mooc/user/likeTeacherList.mooc?sub_ctg_code=${sub_ctg_code}&pageNum=${startPage - 10 }" aria-label="Previous">
       					<span aria-hidden="true">&laquo;</span>
     						</a>
   					</li>
					</c:if>
			
					<c:forEach var="i" begin="${startPage}" end="${endPage}">
						<c:if test="${currentPage==i}">
							<li class="active"><a href="/mooc/user/likeTeacherList.mooc?sub_ctg_code=${sub_ctg_code}&pageNum=${i}">${i}</a></li>
						</c:if>
						<c:if test="${currentPage!=i}">							
							<li><a href="/mooc/user/likeTeacherList.mooc?sub_ctg_code=${sub_ctg_code}&pageNum=${i}">${i}</a></li>
						</c:if>
					</c:forEach>
				
					<c:if test="${endPage < pageCount}">
					<li>
					<a href="/mooc/user/likeTeacherList.mooc?sub_ctg_code=${sub_ctg_code}&pageNum=${startPage + 10}" aria-label="Next">
       					<span aria-hidden="true">&raquo;</span>
     					</a>
     					</li>
					</c:if>
					</nav>
				</c:if>
			</td>
		</tr>
	</table>