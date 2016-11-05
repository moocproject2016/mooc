<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
	function back(){
		window.location='/mooc/teacher/myClass.mooc';
	}
</script>

<br/>
<br/>
<br/>
<br/>
<center>
<form method="post" action="/mooc/teacher/teacherProfilePro.mooc">
<table class="table" style="width:50%;">
	<tr>
			<td  style="font-size:20px;width:30%;">강사 id</td><td>${dto.t_id}</td>
	</tr>
	<tr>
		<c:if test="${check!=1}">
		 	<td style="font-size:20px;width:30%;">학력 </td><td>${fn:replace(dto.t_education,crcn,br)}</td>
		 </c:if>
		<c:if test="${check==1}">
			<td style="font-size:20px;width:30%;">학력 </td><td><textarea name="t_education" class="form-control" row="3">${dto.t_education}</textarea></td>
		</c:if>
	</tr>
  	<tr>
  	 	<c:if test="${check!=1}">
			<td style="font-size:20px;width:30%;">자격증 </td><td>${fn:replace(dto.t_certificate,crcn,br)}</td>
		</c:if>
		<c:if test="${check==1}">
			<td style="font-size:20px;width:30%;">자격증 </td><td><textarea name="t_certificate" class="form-control" row="3">${dto.t_certificate}</textarea></td>
		</c:if>
	</tr>
	<tr>
		<c:if test="${check!=1}">
			<td style="font-size:20px;width:30%;">수상내역 </td><td>${fn:replace(dto.t_prize,crcn,br)} </td>
		</c:if>
		<c:if test="${check==1}">
			<td style="font-size:20px;width:30%;">수상내역</td><td><textarea name="t_prize" class="form-control" row="3">${dto.t_prize}</textarea></td>
		</c:if>
	</tr>
	<tr>
		<c:if test="${check!=1}">
			<td style="font-size:20px;width:30%;">기술 </td> <td>${fn:replace(dto.t_skill,crcn,br)}</td>
		</c:if>
		<c:if test="${check==1}">
			<td style="font-size:20px;width:30%;">기술 </td> <td><textarea name="t_skill" class="form-control" row="3">${dto.t_skill}</textarea></td>
		</c:if>
	</tr>
	<tr>
		<c:if test="${check!=1}">
			<td style="font-size:20px;width:30%;">소개 </td><td>${fn:replace(dto.t_other,crcn,br)}</td>
		</c:if>
		<c:if test="${check==1}">
			<td style="font-size:20px;width:30%;">기술 </td> <td><textarea name="t_other" class="form-control" row="3">${dto.t_other}</textarea></td>
		</c:if>
	</tr>
</table>
	<c:if test="${sessionScope.memId==dto.t_id&&check!=1}">
		<input type="button" value="수정" onclick="window.location='/mooc/teacher/teacherProfile.mooc?check=1'"/>
	</c:if>
	<c:if test="${sessionScope.memId==dto.t_id&&check==1}">
	<input type="submit" value="수정완료" />
	</c:if>
		<input type="button" value="뒤로가기" onclick="back()"/>
</form>
</center>