<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<table class="table" align="center">
		<thead> 
			<tr class="tableHead"><td colspan="7"><h3>블랙유저 관리</h3></td></tr>
			<tr height="30" class="theadtop">
				<th>블랙유저</th> 
				<th>신고날짜</th>
				<th>메인</th> 
				<th>서브</th> 
				<th>내용</th>
				<th>상태</th>
				<th>관리</th>
			</tr>
		</thead>
		 <tr>
			<c:forEach var="c" items="${list}">
			<form method="post" action="/mooc/admin/blackListOut.mooc">
				<tr height="20px">
					<td align="center">
						<input type="text" value="${c.t_id}" style="border:0px; background-color:transparent;" readonly name="id">
						</br><font size="2" color="grey">신고자:&nbsp;${c.u_id}</font>
					</td>
					<td align="center">
						<fmt:formatDate value="${c.report_date}" pattern="yy년 MM월 dd일 hh시"/>
					</td>
					<td align="center">
						<a href="/mooc/viewMainLec.mooc?main_lec_code=${c.main_lec_code}" target="_blank">${c.main_lec_code}</a>
					</td>
					<td align="center">
						<a href="/mooc/watchLec.mooc?sub_lec_code=${c.sub_lec_code}" target="_blank">${c.sub_lec_code}</a>
					</td>
					<td align="center">
						${c.u_comment}
					</td>
					<td align="center">
						<c:if test="${c.t_flag==0}">
							사용 중
						</c:if>
						<c:if test="${c.t_flag==1}">
							탈락
						</c:if>
						<c:if test="${c.t_flag==2}">
							자퇴
						</c:if>
					</td>
					<td align="center">
						<input type="submit" value="강사 정지">
					</td>		
				</tr>
				
			</form>
			</c:forEach>
		</tr>
	</table>
