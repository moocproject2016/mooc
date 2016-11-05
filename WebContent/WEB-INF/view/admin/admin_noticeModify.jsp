<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<form action="noticeModifyPro.mooc" encType="multipart/form-data" method="post">
	<table class="table" align="center">
		<tr>
			<td>
				<input type="checkbox" name="notice_type" value="1"/> 중요글
			</td>
		</tr>
		<tr>
			<td>
				<input type="hidden" name="notice_num" value="${dto.notice_num }" />
			</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="notice_subject" value="${dto.notice_subject }" />
			</td>
		</tr>
		<tr>
			<td><textarea rows="20" cols="70" name="notice_content">${dto.notice_content }</textarea><td>
		</tr>
		<tr>
			<td>
			<div><input type="text" name="notice_file" value="${dto.notice_file}"/></div>
			<input type="file" name="save" /></td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<input type="submit" value="작성" />
				<input type="button" value="돌아가기" onclick="document.location.href='notice.mooc?pageNum=${pageNum }'" />
			</td>					
		</tr>
	</table>
</form>