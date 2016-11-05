<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<table class="table">
<tr><th>학생</th><th>수강신청일</th></tr>
<c:forEach var="dto1" items="${list}">
		<tr>
			<td>${dto1.u_id}</td>	
			<td><fmt:formatDate value="${dto1.reg_lec_date}" pattern="yyyy-MM-dd HH:mm"/></td>
		</tr>
</c:forEach>
</table>