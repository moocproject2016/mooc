<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	function go(){
		if(document.getElementById('selected').value=='강의'){
			window.location='/mooc/user/user_lectureListSerch.mooc?main_lec_subject='+document.getElementById('write').value+'&sub_ctg_code='+${sub_ctg_code}
		}else if(document.getElementById('selected').value=='강사'){
			window.location='/mooc/user/user_lectureListSerch.mooc?t_id='+document.getElementById('write').value+'&sub_ctg_code='+${sub_ctg_code}

		}
	}	
</script>
<table class="table" align="center">
	<tr>
		<td><center><h2>${subName}</h2></center></td>
		<td colspan="2" align="right">
			<select class="form-control" id="selected">
				<option>강의</option>
				<option>강사</option>
			</select>
			<input type="text" class="form-control" id="write" placeholder="찾고 싶은 강의  검색">
	    	<input class="btn btn-default" type="button" value="Go!" onClick="go()"/>
		</td>
	</tr>
</table>
<table class="table" align="center">
	<c:set var="foot" value="1"/>
	<c:forEach	items="${list}" var="dto">
	<c:if test="${foot==1||foot==5||foot==9}">
		<tr>
	</c:if>
	<td>
		<center><img src="${dto.main_lec_image}" style="width:250px;height:250px"  class="img-rounded"  onclick="location.href='/mooc/viewMainLec.mooc?main_lec_code=${dto.main_lec_code}'" /><br/>
		<a href="/mooc/viewMainLec.mooc?main_lec_code=${dto.main_lec_code}"><br/>${dto.main_lec_subject}</a><br/>
			<p>${dto.main_lec_content}</p>
		${dto.u_name}
			</center>
	</td>
	
	
	<c:if test="${foot==4||foot==8||foot==12}">
		</tr>
	</c:if>
	<c:set var="foot" value="${foot+1}"/>
	</c:forEach>
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
      						<a href="/mooc/user/lectureListCategory.mooc?sub_ctg_code=${sub_ctg_code}&pageNum=${startPage - 10 }" aria-label="Previous">
        					<span aria-hidden="true">&laquo;</span>
      						</a>
    					</li>
						</c:if>
				
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:if test="${currentPage==i}">
								<li class="active"><a href="/moo/user/lectureListCategory.mooc?sub_ctg_code=${sub_ctg_code}&pageNum=${i}">${i}</a></li>
							</c:if>
							<c:if test="${currentPage!=i}">							
								<li><a href="/mooc/user/lectureListCategory.mooc?sub_ctg_code=${sub_ctg_code}&pageNum=${i}">${i}</a></li>
							</c:if>
						</c:forEach>
					
						<c:if test="${endPage < pageCount}">
						<li>
						<a href="/mooc/user/lectureListCategory.mooc?sub_ctg_code=${sub_ctg_code}&pageNum=${startPage + 10}" aria-label="Next">
        					<span aria-hidden="true">&raquo;</span>
      					</a>
      					</li>
						</c:if>
						</nav>
					</c:if>
				</td>
			</tr>
	</table>
	
	<script>
	$('#openBtn').click(function(){
		$('#myModal').modal({show:true})
	});
	</script>