<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<form action="notice_writePro.mooc" encType="multipart/form-data" method="post" name="orderForm" onSubmit="return check_info()">
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
<script type="text/javascript">
	function check_info() {
		
		if(document.orderForm.notice_subject.value == ""){
			alert("제목을 입력하세요");
			document.orderForm.notice_subject.focus();
			return false;
		}
		if(document.orderForm.notice_content.value == ""){
			alert("내용을 입력하세요");
			document.orderForm.notice_content.focus();
			return false;
		}
	}
</script>