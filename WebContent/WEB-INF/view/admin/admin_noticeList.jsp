<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="tableWrap">
	<table class="table" align="center">
		<tr>
			<td colspan="3">
				<input type="button" value="새 글 작성" onclick="document.location.href='noticeWrite.mooc'" />
			</td>
		</tr>
		<tr class="tableHead">
			<td colspan="3"><h3>공지사항</h3></td>
		</tr>
		<tr>
			<th width="10%">번호</th>
			<th width="70%">제목</th>
			<th width="20%">날짜</th>
		</tr>
		<c:forEach var="dto" items="${type1 }" varStatus="i">
			<tr bgcolor="#f0f0f0">
				<td align="center">공지</td>
				<td align="center">						
					<a href="/mooc/admin/noticeContent.mooc?notice_num=${dto.notice_num}&pageNum=${pageNum}">${dto.notice_subject}</a>						
				</td>
				<td align="center"><fmt:formatDate value="${dto.notice_regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
			</tr>
		</c:forEach>
		<c:forEach var="dto" items="${list }" varStatus="i">
			<tr bgcolor="ffffff">
				<td align="center">${dto.notice_num}</td>
				<td align="center">						
					<a href="/mooc/admin/noticeContent.mooc?notice_num=${dto.notice_num }&pageNum=${pageNum}">${dto.notice_subject}</a>						
				</td>
				<td align="center"><fmt:formatDate value="${dto.notice_regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
			</tr>
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
								<a href="/mooc/admin/noticeList.mooc?dto.notice_num=${dto.notice_num}&pageNum=${startPage - 10 }" aria-label="Previous">
									<span aria-hidden="true">&laquo;</span>
								</a>
							</li>
						</c:if>
		
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:if test="${currentPage==i}">
								<li class="active"><a href="/mooc/admin/noticeList.mooc?dto.notice_num=${dto.notice_num}&pageNum=${i}">${i}</a></li>
							</c:if>
							<c:if test="${currentPage!=i}">							
								<li><a href="/mooc/admin/noticeList.mooc?dto.notice_num=${dto.notice_num}&pageNum=${i}">${i}</a></li>
							</c:if>
						</c:forEach>
		
						<c:if test="${endPage < pageCount}">
							<li>
								<a href="/mooc/admin/noticeList.mooc?dto.notice_num=${dto.notice_num}&pageNum=${startPage + 10}" aria-label="Next">
									<span aria-hidden="true">&raquo;</span>
								</a>
							</li>
						</c:if>
					</ul>
				</nav>
			</c:if>
		</td>
	</tr>
</table>
</div>