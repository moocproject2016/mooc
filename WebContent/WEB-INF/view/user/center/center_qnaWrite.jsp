<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



	<form method="post" name="form" action="/mooc/user/center/center_qnaWritePro.mooc">
		<table class="table" align="center">
			<tr class="tableHead">
				<td>
					<h3>문의 작성</h3>
				</td>
			</tr>
			<tr>
				<td>${memId}
					<input type="hidden" name="u_id" value="${sessionScope.memId}">
				</td>
			</tr>
			<tr>
				<td><input type="text" name="q_subject" rows="10" cols="50" placeholder="제목" /></td>
			</tr>
			<tr>
				<td><textarea name="q_content" rows="10" cols="50" placeholder="내용" ></textarea></td>
			</tr>
			<tr>
				<td><input type="submit" value="작성"></td>
			</tr>
		</table>
	</form>
