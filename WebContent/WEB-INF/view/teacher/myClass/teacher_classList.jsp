<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<form name="inform">
	생성한 강의 (총 ${main_lec_count}강)
	<table class="table">
		<tr class="theadtop"><th>강의 제목</th><th>강의 생성일</th><th></th><th></th></tr>
		<c:forEach var="main_lec_dto" items="${main_lec_list}" varStatus="i">
			<tr>
				<td align="center">
					<a href="/mooc/teacher/classSubList.mooc?main_lec_code=${main_lec_dto.main_lec_code}">${main_lec_dto.main_lec_subject}</a>
				</td>
				<td align="center"><fmt:formatDate value="${main_lec_dto.main_lec_regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
				<td align="center"><a href="/mooc/teacher/classModify.mooc?main_lec_code=${main_lec_dto.main_lec_code }">수정</a></td>
				<td align="center"><a href="/mooc/teacher/classDelete.mooc?main_lec_code=${main_lec_dto.main_lec_code }">삭제</a></td>
			</tr>
		</c:forEach>
	</table>
</form>