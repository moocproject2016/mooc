<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<form action="noticeWrite.mooc" encType="multipart/form-data" method="post">
	<table class="tableWrap">
		<tr><td>
			<table class="table">
				<tr>
					<td>중요</td>
					<td><input type="checkbox" name="notice_type" value="1"/></td>
				</tr>
				<tr>
					<td>
						제목
					</td>
					<td><input type="text" name="notice_subject" /></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea rows="20" cols="70" name="notice_content"></textarea><td>
				</tr>
				<tr>
					<td>첨부파일</td>
					<td><input type="file" name="save" /></td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="작성" />
						<input type="button" value="돌아가기" onclick="document.location.href='notice.mooc?pageNum=${pageNum }'" />
					</td>					
				</tr>
			</table>
		</td></tr>
	</table>	
</form>