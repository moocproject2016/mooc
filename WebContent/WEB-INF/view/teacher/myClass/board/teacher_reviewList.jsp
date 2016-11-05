<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
	jQuery(document).ready(function(){
		selectMain=document.getElementById("main_select").value;
		pageNum=document.getElementById("currentPage").value;
	});
	function select(){
		selectMain=document.getElementById("main_select").value;
		window.location='/mooc/teacher/reviewList.mooc?main_lec_code='+selectMain;
	}
	function displaySwitch(num){
		content = document.getElementById("content"+num)
		if(content.style.display=="none"){
			content.style.display="block";
		}else{
			content.style.display="none";
		}
		
	}
</script>
<h2>강의후기</h2>
<table style="width: 100%;">
		<tr><td>
			<select id="main_select" onchange="select()">
				<option value="0" <c:if test="${main_lec_code==0}">selected</c:if>>전체 강의</option>
				<c:forEach var="main_lec_dto" items="${main_lec_list }">
					<option value="${main_lec_dto.main_lec_code}" <c:if test="${main_lec_code==main_lec_dto.main_lec_code}">selected</c:if>>${main_lec_dto.main_lec_subject}</option>
				</c:forEach>
			</select> 총 후기 수 : ${all_count}
		</td></tr>
</table>
<div class="tableWrap">
	<c:set var="index" value="0" />
		<table class="table" align="center">
			<thead>
				<tr>
					<th>강의 번호</th>
					<th>강의명</th>
					<th>아이디</th>
					<th>평점</th>
					<th>별점</th>
					<th>문의날짜</th>
				</tr>
			</thead>
				<tbody>
				<c:forEach var="lec_review" items="${member}" varStatus="i">
				<tr>
					<td>${lec_review.main_lec_code}<input type="hidden" name="main_lec_code" value="${lec_review.main_lec_code}"/><input type="hidden" name="index" value="${index}" id="${index}"/></td>
					<td onclick="displaySwitch('${i.count}re');">
						<b>${lec_review.lec_r_subject}</b>
					</td>
					<td>${lec_review.u_id}</td>							
					<td>평점 : ${lec_review.lec_r_score}</td>
					<td>
					 	 <c:if test="${lec_review.lec_r_score<=5 && lec_review.lec_r_score>4}">★★★★★</c:if>
        			 	 <c:if test="${lec_review.lec_r_score<=4 && lec_review.lec_r_score>3}">★★★★☆</c:if>
      				  	 <c:if test="${lec_review.lec_r_score<=3 && lec_review.lec_r_score>2}">★★★☆☆</c:if>
      					 <c:if test="${lec_review.lec_r_score<=2 && lec_review.lec_r_score>1}">★★☆☆☆</c:if>
         				 <c:if test="${lec_review.lec_r_score<=1 && lec_review.lec_r_score>0}">★☆☆☆☆</c:if>
					</td>
					
					<td>${lec_review.lec_r_regdate}</td>
				</tr>
				<c:if test="${lec_review.lec_r_content!=null}">
					<tr>
						<td colspan="7" align="left">
							<div id="content${i.count}re" style="display:none; height:auto;">
								후기 내용&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${lec_review.lec_r_content}<br /><br />
								<hr>
							</div>					
						</td>
					</tr>
				</c:if>		
				<c:set var="index" value="${index+1}" />
			</c:forEach>
				</tbody>
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
      						<a href="reviewList.mooc?pageNum=${startPage - 10 }&main_lec_code=${main_lec_code}" aria-label="Previous">
        					<span aria-hidden="true">&laquo;</span>
      						</a>
    					</li>
						</c:if>
				
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:if test="${currentPage==i}">
								<li class="active"><a href="reviewList.mooc?pageNum=${i}&main_lec_code=${main_lec_code}">${i}</a></li>
							</c:if>
							<c:if test="${currentPage!=i}">							
								<li><a href="reviewList.mooc?pageNum=${i}&main_lec_code=${main_lec_code}">${i}</a></li>
							</c:if>
						</c:forEach>
					
						<c:if test="${endPage < pageCount}">
						<li>
						<a href="reviewList.mooc?pageNum=${startPage + 10}&main_lec_code=${main_lec_code}" aria-label="Next">
        					<span aria-hidden="true">&raquo;</span>
      					</a>
      					</li>
						</c:if>
						</nav>
					</c:if>
				</td>
			</tr>
	</table>
</div>