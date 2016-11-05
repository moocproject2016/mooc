<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<form method="post" name="form" action="/mooc/user/user_qnaWritePro.mooc">
	<input type="hidden" name="main_lec_code" value="${q1_code}">
	<table class="table" align="center">
		<tr>
			<th width="100">회원Id</th>
			<td>${memId}</td>
				<input type="hidden" name="u_id" value="${sessionScope.memId}">
		</tr>
		<tr>
			<th width="100">제목</th>
			<td><input type="text" name="lec_q_subject" rows="10" cols="50" /></td>
		</tr>
		<tr>
			<th width="100">문의 내용</th>
			<td><textarea name="lec_q_content" rows="10" cols="50"></textarea></td>
		</tr>				
		<tr>
			<td colspan="2" align="right"><input type="submit" value="작성 완료"></td>
		</tr>
	</table>
</form>
