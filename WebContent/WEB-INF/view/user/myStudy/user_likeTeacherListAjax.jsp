<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<table class="table">
<tr class="theadtop"><th></th><th>메인 강의</th><th>생성일</th><th></th></tr>
<c:forEach var="dto1" items="${list}">
		<tr>
			<td align="center"><img src="${dto1.main_lec_image}" style="width:50px;height:50px" onclick="location.href='/mooc/viewMainLec.mooc?main_lec_code=${dto.main_lec_code}'"></td>
			<td align="center"><a href="/mooc/viewMainLec.mooc?main_lec_code=${dto1.main_lec_code}">${dto1.main_lec_subject}</a></td>	
			<td align="center"><fmt:formatDate value="${dto1.main_lec_regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
		</tr>
</c:forEach>
</table>