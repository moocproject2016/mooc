<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.memId==null }">
	<script>
		alert("로그인이 필요합니다.");
		location.href="/mooc/user/userSign.mooc";
	</script>
</c:if>
<c:if test="${sessionScope.memId!=null }">
	<form action="/mooc/teacher/noticeWritePro.mooc" encType="multipart/form-data" method="post" name="orderForm" onSubmit="return check_info()">
	<table class="tableWrap">
		<tr><td>
			<table class="table">
				<tr>
					<td>강의</td>
					<td>
						<select id="main_select" name="main_lec_code">
							<option value="0" selected>강의 목록</option>
							<c:forEach var="main_lec_dto" items="${main_lec_list }">
								<option value="${main_lec_dto.main_lec_code}" <c:if test="${main_lec_code==main_lec_dto.main_lec_code}">selected</c:if>>
								${main_lec_dto.main_lec_subject}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>중요</td>
					<td><input type="checkbox" value=1 name="lec_n_type"/></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input type="text" size=50 name="lec_n_subject" /></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea rows="20" cols="70" name="lec_n_content"></textarea><td>
				</tr>
				<tr>
					<td>첨부파일</td>
					<td><input type="file" name="save" /></td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="작성" />
						<input type="button" value="돌아가기" onclick="document.location.href='/mooc/teacher/noticeList.mooc'" />
					</td>					
				</tr>
			</table>
		</td></tr>
	</table>	
	</form>
</c:if>

<script>
	function check_info() {
		if(document.orderForm.main_lec_code.value == "0"){
			alert("강의목록을 선택하세요");
			document.orderForm.main_lec_code.focus();
			return false;
		}
		if(document.orderForm.lec_n_subject.value == ""){
			alert("제목을 입력하세요");
			document.orderForm.lec_n_subject.focus();
			return false;
		}
		if(document.orderForm.lec_n_content.value == ""){
			alert("내용을 입력하세요");
			document.orderForm.lec_n_content.focus();
			return false;
		}
	}
	</script>