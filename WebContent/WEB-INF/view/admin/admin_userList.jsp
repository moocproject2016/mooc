<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<script>
	function submitBtn(){			
			var updateform=document.updateform;
			updateform.action='/mooc/admin/qnaWrite.mooc';
			updateform.submit();
		}
	</script>
	
	<table class="table" align="center"> 
		<thead>
			<tr class="tableHead"><td colspan="8"><h3>유저 관리</h3></td></tr>
			<tr>
				<td colspan="8">
					<input type="button" name="user" value="학생" onclick="window.location='/mooc/admin/userList.mooc?type=0'">	&nbsp;&nbsp;
					<input type="button" name="lecture" value="강사" onclick="window.location='/mooc/admin/userList.mooc?type=1'">	&nbsp;&nbsp;
					<input type="button" name="all" value="유저" onclick="window.location='/mooc/admin/userList.mooc'">		&nbsp;&nbsp;
				</td>
			</tr>
			<tr height="30" class="theadtop">
				<th align="center">아이디</th> 
				<th align="center">비밀번호</th> 
				<th align="center">이름</th>
				<th align="center" width="90px">가입일</th> 
				<th align="center" width="90px">탈퇴일</th> 
				<th align="center">상태</th>
				<th align="center">구분</th>
				<th align="center">관리</th>
			</tr>
		</thead>
		<tr align="center">
			<c:forEach var="c" items="${list}">
				<form method="post" action="/mooc/admin/userModify.mooc">
					<tr align="center" height="20">
						<td>
							<input type="text" value="${c.u_id}" size="20" style="border:0px; background-color:transparent;" readonly name="u_id">
						</td>
						<td>
							<input type="text" value="${c.u_pw}" size="7" name="u_pw">
						</td>
						<td>
							<input type="text" value="${c.u_name}" size="5" name="u_name">
						</td>
						<td>
							<fmt:formatDate value="${c.u_indate}" pattern="yy-MM-dd"/>
						</td>
						<td>
							<fmt:formatDate value="${c.u_outdate}" pattern="yy-MM-dd"/>
						</td>
						<td>
							<c:if test="${c.u_flag==0}">가입</c:if>
							<c:if test="${c.u_flag==1}">탈퇴</c:if>
						</td>
						<td>
							<c:if test="${c.u_type==0}">학생</c:if>
							<c:if test="${c.u_type==1}">강사</c:if>
						</td>
									
						<td align="center">
							<input type="submit" value="변경">
						</td>		
					</tr>
				</form>
			</c:forEach>
		</tr>
	</table>
</div>