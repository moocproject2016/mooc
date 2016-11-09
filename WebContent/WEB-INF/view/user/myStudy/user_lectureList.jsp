<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="fixedMenu">
		<div class="dropdown"  alian="right">
			<button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">
	   			 대분류 선택
			</button>
			<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
				<c:forEach var="topCtgDTO" items="${topCtgListUser}">
					<li class="presentation"><a href="#">${topCtgDTO.top_ctg_name}</a></li>
					<c:forEach var="subCtgDTO" items="${subCtgListUser}">
						<c:if test="${topCtgDTO.top_ctg_code==subCtgDTO.top_ctg_code}">
							<li><a href="/mooc/user/lectureList.mooc?sub_ctg_code=${subCtgDTO.sub_ctg_code}">${subCtgDTO.sub_ctg_name }</a></li>
						</c:if>
					</c:forEach>
					<li class="divider"></li>
				</c:forEach>
			</ul>			
		</div>
	</div>
<table class="table" align="center">
	<tr><td>
		강의 수:${subCount}
	</td></tr>
</table>

<table class="table"  style="width:90%;height:90%" align="center">
	<c:set var="foot" value="1"/>
	<c:forEach	items="${list}" var="dto">
	<c:if test="${foot==1||foot==5||foot==9}">
		<tr>
	</c:if>
	<td>
		<center>
			<img src="/mooc/files${dto.main_lec_image}" style="width:200px;height:200px"  class="img-rounded"  onclick="location.href='/mooc/viewMainLec.mooc?main_lec_code=${dto.main_lec_code}'" /><br/>
			강사:${dto.t_id}
			<a href="/mooc/user/lectureList_sub.mooc?main_lec_code=${dto.main_lec_code}"><br/>
			강의:${dto.main_lec_subject}</a><br/>
			comment:${dto.main_lec_content}<br />${dto.lecView_count}/${dto.subLec_count }
			(학습 진도 : <fmt:formatNumber type="number"  pattern="0.0" value="${dto.lecView_count/dto.subLec_count*100}"/>%)
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
      						<a href="/mooc/user/lectureList.mooc?sub_ctg_code=${sub_ctg_code}&pageNum=${startPage - 10 }" aria-label="Previous">
        					<span aria-hidden="true">&laquo;</span>
      						</a>
    					</li>
						</c:if>
				
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:if test="${currentPage==i}">
								<li class="active"><a href="/mooc/user/lectureList.mooc?sub_ctg_code=${sub_ctg_code}&pageNum=${i}">${i}</a></li>
							</c:if>
							<c:if test="${currentPage!=i}">							
								<li><a href="/mooc/user/lectureList.mooc?sub_ctg_code=${sub_ctg_code}&pageNum=${i}">${i}</a></li>
							</c:if>
						</c:forEach>
					
						<c:if test="${endPage < pageCount}">
						<li>
						<a href="/mooc/user/lectureList.mooc?sub_ctg_code=${sub_ctg_code}&pageNum=${startPage + 10}" aria-label="Next">
        					<span aria-hidden="true">&raquo;</span>
      					</a>
      					</li>
						</c:if>
						</nav>
					</c:if>
				</td>
			</tr>
	</table>