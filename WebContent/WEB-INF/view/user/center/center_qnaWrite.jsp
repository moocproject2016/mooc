<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



	<form method="post" action="/mooc/user/center/center_qnaWritePro.mooc" name="orderForm" onSubmit="return check_info()">
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
<script type="text/javascript">
	function check_info() {
		
		if(document.orderForm.q_subject.value == ""){
			alert("제목을 입력하세요");
			document.orderForm.q_subject.focus();
			return false;
		}
		if(document.orderForm.q_content.value == ""){
			alert("내용을 입력하세요");
			document.orderForm.q_content.focus();
			return false;
		}
	}
</script>