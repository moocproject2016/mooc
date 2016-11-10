<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form action="myStudyBoardModifyPro.mooc" encType="multipart/form-data" method="post">
	<table class="tableWrap">
		<tr><td>
			<table class="table">
				<tr>
					<td><b>제목</b><input type="hidden" name="stg_b_num" value="${sgbdto.stg_b_num }" /></td>
					<td><input type="text" name="stg_b_subject" value="${sgbdto.stg_b_subject }" /></td>
					<td><b>작성자</b>:${sgbdto.u_id}
				</tr>
				<tr>
					<td width="100"  height="40" align="lest"><b>유형</b></td>
					<td width="400" colspan="2">
				       <select  name="stg_b_type" style="width: 90px;">
							<option value="과제" <c:if test="${sgbdto.stg_b_type eq'과제'}">selected</c:if>>과제</option>
							<option value="논문" <c:if test="${sgbdto.stg_b_type eq'논문'}">selected</c:if>>논문</option>
							<option value="자료" <c:if test="${sgbdto.stg_b_type eq'자료'}">selected</c:if>>자료</option>
							<option value="기타" <c:if test="${sgbdto.stg_b_type eq'기타'}">selected</c:if>>기타</option>
							
						</select>
					
					</td>
				
				</tr>
				<tr>
					<td><b>내용</b></td>
					<td><textarea rows="10" cols="50" name="stg_b_content">${sgbdto.stg_b_content }</textarea><td>
				</tr>
				<tr>
					<td><b>첨부파일</b></td>
					<td colspan="3">
					<div><input type="text" name="stg_b_data" value="${sgbdto.stg_b_data}" size=100 style="border:0px;" readonly/></div>
					<input type="file" name="save" /></td>
				</tr>	
				<tr>
					<td colspan="3" align="center">
						<input type="submit" value="작성" />
						<input type="button" value="돌아가기" onclick="document.location.href='/mooc/study/myStudyBoardRoom.mooc?stg_b_num=${sgbdto.stg_b_num }&pageNum=${pageNum }'" />
					</td>					
				</tr>
			</table>
		</td></tr>
	</table>
</form>