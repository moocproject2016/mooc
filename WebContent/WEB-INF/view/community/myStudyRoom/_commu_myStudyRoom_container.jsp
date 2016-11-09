<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
              
<table class="table" align="center">
	<tr>
		<td><h2>${stgList.stg_name} </h2></td>
	</tr>
	<tr>
		<td>${stgList.stg_purpose} </td>
	</tr>
</table> 

<table class="table" align="center">

	<tr>
		<td><h2>멤버 리스트</h2></td>
	</tr>
	<c:forEach var="sml" items="${stgMemberList}" varStatus="i">
		<tr>
			<td align="left">${sml.u_id}</td>
		</tr>
	</c:forEach>
	
</table>        
                        
