<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<form name="inform" method="post">
<input type="hidden" name="currentPage" value="/mooc/teacher/subLecture_list.mooc?main_lec_code=${main_lec_dto.main_lec_code }"/> 
<div class="tableWrap">
		<table class="table">
			<tr><td colspan="3">강의명 : ${main_lec_dto.main_lec_subject }<input type="hidden" name="main_lec_code" value="${main_lec_dto.main_lec_code }"/></td></tr>
			<tr>
				<td rowspan="3"><img src="\mooc\files${main_lec_dto.main_lec_image }" width="100" height="100"/></td>
				<td>강의내용 </td><td>${main_lec_dto.main_lec_content }</td>
			</tr>
			<tr>
				<td>강의수</td><td>${fn:length(sub_lec_list)}</td>
			</tr>
			<tr>
				<td>강의 생성 날짜</td><td><fmt:formatDate value="${main_lec_dto.main_lec_regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
			</tr>
		</table>
		<table class="table">
			<c:forEach var="lectureDTO" items="${sub_lec_list}">	
				<tr>
					<td width="30%">
						<input type="text" name="sub_lec_chapter" value="${lectureDTO.sub_lec_chapter }" style="border:0px;" readonly/>
						<input type="hidden" name="sub_lec_code" value="${lectureDTO.sub_lec_code }"/>
					</td>
					<td width="60%">
						<a href="/mooc/teacher/watch.mooc?sub_lec_code=${lectureDTO.sub_lec_code }">${lectureDTO.sub_lec_subject }</a>
						<input type="hidden" value="${lectureDTO.sub_lec_type }"/>
					</td>
					<td width="10%">
						<c:if test="${lectureDTO.sub_lec_type==0}">녹화</c:if>
						<c:if test="${lectureDTO.sub_lec_type==1}">실시간</c:if>
						<c:if test="${lectureDTO.sub_lec_type==2}">실시간(완료)</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
</div>
</form>