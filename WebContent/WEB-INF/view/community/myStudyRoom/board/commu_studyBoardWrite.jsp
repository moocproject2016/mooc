<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form action="myStudyBoardWritePro.mooc" encType="multipart/form-data" method="post">
	<table class="tableWrap">
		<tr><td>
			<table class="table">
				<tr>
					<th>제목</th>
					<td><input type="text" name="stg_b_subject" /></td>
					<th align="right">작성자</th>
					<td><input type="text" name="u_id" /></td> <!--  이부분은 세션 스코프로 아이디 바로 저장 해서 보여주기 -->
				</tr>
				<tr>
					<td width="200"  height="40"><b>유형</b></td>
					<td width="500">
							<select  name="stg_b_type" style="width: 200px;">
							<option selected="selected">-선택-</option>
							    <option value="과제">과제</option>
								<option value="논문">논문</option>
								<option value="자료">자료</option>
								<option value="기타">기타</option>
							</select>
					<td colspan="2"></td>
					
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea rows="20" cols="70" name="stg_b_content" align="left"></textarea><td>
					<td colspan="2"></td>
			
				</tr>
				<tr >
					<td>첨부파일</td>
					<td><input type="file" name="save" /></td>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td align="center" colspan="4">
						<input type="submit" value="작성" />
						<input type="button" value="돌아가기" onclick="document.location.href='myStudyBoardList.mooc?pageNum=${pageNum }'" />
					</td>
				</tr>
			</table>
		</td></tr>
	</table>	
</form>