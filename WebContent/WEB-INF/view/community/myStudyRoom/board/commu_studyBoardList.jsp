<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
</div>
	<h2>${stg_code} / 스터디 커뮤니티</h2>
		<table class="table">
			<tr>
				<td>
					<form action="/mooc//study/myStudyBoardList.mooc?sub_ctg_code=${sub_ctg_code}"  method="post">
						<select  name="searchBType" style="width: 200px;">
								<option value=0 selected="selected">-유형선택-</option>
								<option value="논문">논문</option>
								<option value="자료">자료</option>
								<option value="과제">과제</option>
								<option value="기타">기타</option>
						</select>
						<select  name="searchBType1" style="width: 200px;">
							<option selected="selected">-선택-</option>
						    <option value="stg_b_subject">제목</option>
							<option value="u_id">작성자</option>
						</select>
						<input type="text" name="searchBValue1">
						<input type="submit" value="검색"  />
					</form>
				</td>
			</tr>
			<tr bgcolor="ffffff">
				<td width="10%">번호</td>
				<td width="10%">유형</td>
				<td align="center" width="30%">제목</td>
				<td width="20%">작성자</td>
				<td width="30%">날짜</td>
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
		<input type="button" value="작성" onclick="document.location.href='myStudyBoardWrite.mooc'" />
