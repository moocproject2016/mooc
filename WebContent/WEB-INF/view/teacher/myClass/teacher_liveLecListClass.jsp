<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <script>
function myFunction(i,x) {
	var u_name=document.getElementById("u_name").value;
	var sub_lec_subject=document.getElementsByName("sub_lec_subject")[x].value;
	var sub_lec_chapter=document.getElementsByName("sub_lec_chapter")[x].value;
	var u_type=1; //학생은 0, 선생은 1
	 cw=screen.availWidth;
	 ch=screen.availHeight;
	 test=window.open('https://172.16.8.27:9001/doLive.html?sub_lec_code='+i+'&u_name='+u_name+'&sub_lec_subject='+sub_lec_subject+'&sub_lec_chapter='+sub_lec_chapter,'_blank','width='+cw+',height='+ch+',resizable=no,scrollbars=yes');
	}
</script>

<c:set var="currentPage" value="/mooc/teacher/liveLecListClass.mooc"/>
<div class="tableWrap">
	<input type="hidden" id="u_name" value="${sessionScope.memName}"/>
	<table class="table">
		<thead>
			<tr>
				<th>강의명</th><th>챕터</th><th>챕터명</th><th>강의날짜</th><th></th>
			</tr>
		</thead>
		<c:forEach var="subLiveLecDTO" items="${subLiveLecList}" varStatus="i">
			<tr>
				<td>${subLiveLecDTO.main_lec_subject}</td>
				<td><input type="hidden" name="sub_lec_chapter" value="${subLiveLecDTO.sub_lec_chapter}"/>${subLiveLecDTO.sub_lec_chapter}</td>
				<td><input type="hidden" name="sub_lec_subject" value="${subLiveLecDTO.sub_lec_subject}"/>${subLiveLecDTO.sub_lec_subject}</td>
				<td>${subLiveLecDTO.sub_lec_regdate}</td>
				<td><input type="button" value="실시간 강의 시작" onclick="myFunction(${subLiveLecDTO.sub_lec_code },'${i.index }')"/></td>
			</tr>
		</c:forEach>
	</table>
</div>