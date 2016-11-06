<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <script>
function myFunction(i) {
	var u_id=document.getElementById("u_id").value;
	alert(u_id);
	 cw=screen.availWidth;
	 ch=screen.availHeight;
	 test=window.open('https://172.16.8.27:9001/doLive.html?sub_lec_code='+i+'&u_id='+u_id,'_blank','width='+cw+',height='+ch+',resizable=no,scrollbars=yes');
	}
</script>

<c:set var="currentPage" value="/mooc/teacher/liveLecListClass.mooc"/>
<div class="tableWrap">
	<input type="hidden" id="u_id" value="${sessionScope.memId}"/>
	<table class="table">
		<thead>
			<tr>
				<th>강의명</th><th>챕터명</th><th>강의날짜</th><th></th>
			</tr>
		</thead>
		<c:forEach var="subLiveLecDTO" items="${subLiveLecList}">
			<tr>
				<td>${subLiveLecDTO.main_lec_subject}</td>
				<td>${subLiveLecDTO.sub_lec_subject}</td>
				<td>${subLiveLecDTO.sub_lec_regdate}</td>
				<td><input type="button" value="실시간 강의 시작" onclick="myFunction(${subLiveLecDTO.sub_lec_code })"/></td>
			</tr>
		</c:forEach>
	</table>
</div>