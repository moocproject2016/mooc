<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table class="tableWrap">
	<tr><td>
		<table class="table">
			<tr>
				<td width="100">글번호&nbsp;&nbsp;&nbsp;${sgbdto.stg_b_num}</td>
				<td width="200" align="center">제목</td>
				<td width="300" colspan="3" align="left">[${sgbdto.stg_b_type}] ${sgbdto.stg_b_subject }</td>
				<td width="200">작성자 :${sgbdto.u_id}</td>
				<td width="300" align="right">${sgbdto.stg_b_regdate}</td>
			</tr>
			<tr>
				<td colspan="5" height="200" align="left" >
				<br /><br />
				${sgbdto.stg_b_content }
				</td>
				<td colspan="2" align="right"><a href="/mooc/notice_download.mooc?fileName=${sgbdto.stg_b_data}">${sgbdto.stg_b_data} 다운로드</a></td>
			</tr>
			<tr>
				<td colspan="7" align="center">
					<input type="button" value="수정" onclick="document.location.href='/mooc/study/myStudyBoardModify.mooc?stg_b_num=${sgbdto.stg_b_num }&pageNum=${pageNum }'" />
					<%-- <c:if test="${sgbdto.u_id==SessionScope.memId}"> --%>	
					<input type="button" value="삭제" onclick="document.location.href='/mooc/study/myStudyBoardDelete.mooc?stg_b_num=${sgbdto.stg_b_num }'" />
					<%-- </c:if> --%>
					<input type="button" value="목록" onclick="document.location.href='/mooc/study/myStudyBoardList.mooc?pageNum=${pageNum }'" />
				</td>
			</tr>
		</table>
	</td></tr>	
</table>