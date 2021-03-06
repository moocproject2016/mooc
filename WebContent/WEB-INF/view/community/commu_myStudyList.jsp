<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="tableWrap">
<form name="inform">

 	<table class="table" align="center"> 
	    <tr valign="middle" class="tableHead">
		    <td colspan="5">
				<h4>나의 SturdyRoom 목록입니다.</h4>
		    </td>
		  </tr>
		  <tr>
		  <td colspan="5">
		 <a href="/mooc/study/myStudyList.mooc?state=1">내가 생성한 그룹 목록보기</a>
		  </td>
		  <tr>
	    <tr height="30" bgcolor="#e7e7e7" >  
	      <th width="250px">제목</th> 
	      <th>인원</th>
	      <th width="200px">그룹장</th>
	      <th width="100px">개설날짜</th> 
	      <th width="100px">관리</th>    
	    </tr>
	    
		<c:if test="${list.size() == 0}">
	    	<tr align="center" valign="middle">
			    <td colspan="5">         
					가입된 스터디룸이 없습니다. 
				</td>
			</tr>
		</c:if>

		<c:forEach var="stglist" items="${list}" varStatus="i">
			<tr height="30">
				<td align="center">
					<a href="/mooc/study/myStudyRoomMain.mooc?stg_code=${stglist.stg_code}">${stglist.stg_name} </a>
				</td>
				<td align="center">           
					${stglist.stg_count}/${stglist.stg_limit}
				</td>
				<td align="center"> 
					${stglist.u_name}
				</td>
				<td align="center">
			      <fmt:formatDate value="${stglist.stg_regdate}" pattern="yyyy-MM-dd" />
				</td>
				<td align="center"> 
					<c:set var="u_id" value="min"/>
					<input type="button" value="수정" Onclick="javascript:window.location='/mooc/study/studyModify.mooc?stg_code=${stglist.stg_code}'"/><!-- **아이디에세션아이디 -->
					<input type="button" value="탈퇴" Onclick="javascript:window.location='/mooc/study/myStudydelete.mooc?stg_code=${stglist.stg_code}'"/><!-- **아이디에세션아이디 -->
				</td>
			</tr>
														     
		</c:forEach>
	</table>
</form>

</div>
 