<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
</div>
	<h2>${stg_code} / ���͵� Ŀ�´�Ƽ</h2>
		<table class="table">
			<tr>
				<td>
					<form action="/mooc//study/myStudyBoardList.mooc?sub_ctg_code=${sub_ctg_code}"  method="post">
						<select  name="searchBType" style="width: 200px;">
								<option value=0 selected="selected">-��������-</option>
								<option value="��">��</option>
								<option value="�ڷ�">�ڷ�</option>
								<option value="����">����</option>
								<option value="��Ÿ">��Ÿ</option>
						</select>
						<select  name="searchBType1" style="width: 200px;">
							<option selected="selected">-����-</option>
						    <option value="stg_b_subject">����</option>
							<option value="u_id">�ۼ���</option>
						</select>
						<input type="text" name="searchBValue1">
						<input type="submit" value="�˻�"  />
					</form>
				</td>
			</tr>
			<tr bgcolor="ffffff">
				<td width="10%">��ȣ</td>
				<td width="10%">����</td>
				<td align="center" width="30%">����</td>
				<td width="20%">�ۼ���</td>
				<td width="30%">��¥</td>
			</tr>
			<c:forEach var="dto" items="${list}" varStatus="i">
			
			<tr bgcolor="ffffff">
				<td>${fn:length(list)-i.count+1}</td>
				<td align="left"  width="150">${dto.stg_b_type}</td>
				<td align="center">
					<a href="/mooc/study/myStudyBoardRoom.mooc?stg_b_num=${dto.stg_b_num}">${dto.stg_b_subject}</a>
				</td>
				<td>${dto.u_id}</td>
				<td><fmt:formatDate value="${dto.stg_b_regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
			</tr>
			</c:forEach>
		</table>
		<input type="button" value="�ۼ�" onclick="document.location.href='myStudyBoardWrite.mooc'" />
