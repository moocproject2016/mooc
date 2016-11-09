<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	jQuery(document).ready(function(){
		selectMain=document.getElementById("main_select").value;
		pageNum=document.getElementById("currentPage").value;
	});
	function select(){
		selectMain=document.getElementById("main_select").value;
		window.location='/mooc/teacher/noticeList.mooc?main_lec_code='+selectMain;
	}
	function toWrite(){
		window.location='/mooc/teacher/noticeWrite.mooc?main_lec_code='+selectMain;
	}
</script>
<c:if test="${sessionScope.memId==null }">
	<script>
		alert("로그인이 필요합니다.");
		location.href="/mooc/user/userSign.mooc";
	</script>
</c:if>
<c:if test="${sessionScope.memId!=null }">
	<input type="hidden" id="currentPage"  name="pageNum" value="${currentPage}">
	
	<form action="/mooc/teacher/noticeList.mooc" method="post">
		<table class="table" align="center">
			<tr><td><h2>강의 공지<h5>총 공지글 수 : ${all_count}</h5></h2></td></tr>
			<tr><td>
				<select id="main_select" onchange="select()">
					<option value="0" <c:if test="${main_lec_code==0}">selected</c:if>>전체 강의</option>
					<c:forEach var="main_lec_dto" items="${main_lec_list }">
						<option value="${main_lec_dto.main_lec_code}" <c:if test="${main_lec_code==main_lec_dto.main_lec_code}">selected</c:if>>${main_lec_dto.main_lec_subject}</option>
					</c:forEach>
				</select>
				<select name="searchKey">
					<option>선택</option>
					<option value="lec_n_subject">제목</option>
					<option value="lec_n_content">내용</option>
				</select>
				<input type="text" name="searchValue"/>
				<input type="submit" value="검색" />
			</td>
			<td align="right">
				<input type="button" id="writeBtn" value="글작성" onclick="toWrite()"/>
			</td></tr>
		</table>
	</form>
	<div class="tableWrap">
			<table class="table" align="center">
			<thead>
				<tr bgcolor="ffffff">
					<th width="10%">번호</th>
					<th width="25%">강의</th>
					<th width="45%">제목</th>
					<th width="20%">날짜</th>
				</tr>
			</thead>
				<c:forEach var="lecNoticeDto" items="${lec_notice_list1 }" varStatus="i">
				<tr class="noticeTR">
					<td align="center">
						중요
					</td>
					<td align="center">${lecNoticeDto.main_lec_subject}</td>
					<td align="center">
						<a href="/mooc/teacher/noticeContent.mooc?lec_n_num=${lecNoticeDto.lec_n_num}&pageNum=${pageNum}">${lecNoticeDto.lec_n_subject}</a>
					</td>
					<td align="center"><fmt:formatDate value="${lecNoticeDto.lec_n_regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
				</tr>
				</c:forEach>
			</table>
			<table class="table"  align="center">
				<c:forEach var="lecNoticeDto" items="${lec_notice_list0 }" varStatus="i">
				<tr bgcolor=ffffff>
					<td align="center" width="10%">
						${lecNoticeDto.lec_n_num}
					</td>
					<td align="center" width="25%">${lecNoticeDto.main_lec_subject}</td>
					<td align="center" width="45%">
						<a href="/mooc/teacher/noticeContent.mooc?lec_n_num=${lecNoticeDto.lec_n_num}&pageNum=${pageNum}">${lecNoticeDto.lec_n_subject}</a>
					</td>
					<td align="center" width="20%"><fmt:formatDate value="${lecNoticeDto.lec_n_regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
				</tr>
				</c:forEach>
			</table>
	</div>
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
      						<a href="/mooc/teacher/noticeList.mooc?main_lec_code=${main_lec_code}&pageNum=${startPage - 10 }" aria-label="Previous">
        					<span aria-hidden="true">&laquo;</span>
      						</a>
    					</li>
						</c:if>
				
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:if test="${currentPage==i}">
								<li class="active"><a href="/mooc/teacher/noticeList.mooc?main_lec_code=${main_lec_code}&pageNum=${i}">${i}</a></li>
							</c:if>
							<c:if test="${currentPage!=i}">							
								<li><a href="/mooc/teacher/noticeList.mooc?main_lec_code=${main_lec_code}&pageNum=${i}">${i}</a></li>
							</c:if>
						</c:forEach>
					
						<c:if test="${endPage < pageCount}">
						<li>
						<a href="/mooc/teacher/noticeList.mooc?main_lec_code=${main_lec_code}&pageNum=${startPage + 10}" aria-label="Next">
        					<span aria-hidden="true">&raquo;</span>
      					</a>
      					</li>
						</c:if>
						</nav>
					</c:if>
				</td>
			</tr>
	</table>	
</c:if>