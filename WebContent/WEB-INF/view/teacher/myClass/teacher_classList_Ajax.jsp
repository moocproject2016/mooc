<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="currentPage" value="/mooc/teacher/classList.mooc"/>
<b>${main_lec_subject }</b> > 생성한 챕터(총 ${fn:length(subLecList)}강)
<table class="table">
<tr><th>챕터</th><th>제목</th><th>방식</th></tr>
<c:forEach var="sub_lec_dto" items="${subLecList}">
	<c:if test="${sub_lec_dto.main_lec_code==main_lec_code}">
		<tr>
			<td>${sub_lec_dto.sub_lec_chapter}</td>
			<td><a href="/mooc/teacher/watch.mooc?sub_lec_code=${sub_lec_dto.sub_lec_code }&currentPage=${currentPage}">${sub_lec_dto.sub_lec_subject}</a></td>
			<td>
				<c:if test="${sub_lec_dto.sub_lec_type==0}">녹화</c:if>
				<c:if test="${sub_lec_dto.sub_lec_type==1}">실시간</c:if>
				<c:if test="${sub_lec_dto.sub_lec_type==2}">실시간(완료)</c:if>
			</td>
		</tr>
	</c:if>
</c:forEach>
</table>