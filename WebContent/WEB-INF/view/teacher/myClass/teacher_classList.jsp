<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	function clickMain(x,len){
		var main_lec;
		if(len==1){
			main_lec_code=document.inform.main_lec_code.value;
		}else if(len>1){
			main_lec_code=document.inform.main_lec_code[x-1].value;
		}
		$.ajax({
			type: 'post',
			url: "/mooc/teacher/classList_Ajax.mooc",
			data: {
				main_lec_code:main_lec_code
			},			
			success: function(data) {
				$('.rightTable').empty();
				$('.rightTable').append(data);
			},
			error: function(data){
				alert("실패");
			}
		});
		
		
	}
</script>
<form name="inform">
<div class="tableWrap">
		<div class="leftTable">
			생성한 강의 (총 ${main_lec_count}강)
			<table class="table">
				<tr><th>강의 제목</th><th>강의 생성일</th><th></th><th></th></tr>
				<c:forEach var="main_lec_dto" items="${main_lec_list}" varStatus="i">
					<tr>
						<td>
							<a href="javascript:void();" onclick="clickMain('${i.count}','${fn:length(main_lec_list)}')">${main_lec_dto.main_lec_subject}</a>
							<input type="hidden" name="main_lec_code" value="${main_lec_dto.main_lec_code}"/>
						</td>
						<td><fmt:formatDate value="${main_lec_dto.main_lec_regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
						<td><a href="/mooc/teacher/classModify.mooc?main_lec_code=${main_lec_dto.main_lec_code }">수정</a></td>
						<td><a href="/mooc/teacher/classDelete.mooc?main_lec_code=${main_lec_dto.main_lec_code }">삭제</a></td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="rightTable">
		</div>
</div>
</form>