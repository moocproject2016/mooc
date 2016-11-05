<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	jQuery(document).ready(function(){
		$('#top_ctg').change(function(){
			var top_ctg_code=$(this).val();
			$.ajax({
				type: 'post',
				url: "/mooc/getSubCtg.mooc",
				data: {
					top_ctg_code:top_ctg_code
				},			
				success: aa,
				error: bb
			});
		});
		function aa(data){
			var subCtgList=data.split(',');
			$('#sub_ctg').empty().data('options');  // selectbox 초기화
			$('#sub_ctg').append('<option>소분류</option>');   // 첫번째 option 추가
			
			for(var i=0;i<subCtgList.length;i++){
				$('#sub_ctg').append('<option value="'+subCtgList[i]+'">'+subCtgList[i]+'</option>');
			}
		}
		function bb(data){
			alert("소분류 가져오기가 실패하였습니다.");
		}
		
	});
	
</script>
<c:if test="${sessionScope.memId==null }">
	<script>
		alert("로그인이 필요합니다.");
		location.href="/mooc/user/userSign.mooc";
	</script>
</c:if>
<c:if test="${sessionScope.memId!=null }">
	<form action="/mooc/teacher/makeMainLecturePro.mooc" method="post" encType="multipart/form-data">
		<div class="tableWrap">
			<table class="table">
			      <tr bgcolor="gray">
			      	<th>항목</th><th>내용</th>
			      </tr>
			      <tr>
			      	<th>분류</th>
			      	<td>
			      		<select id="top_ctg" name="top_category">
			      			<option>대분류</option>
			      			<c:forEach var="topCtgDto" items="${topCtgList}">
			      				<option value="${topCtgDto.top_ctg_code }">${topCtgDto.top_ctg_name }</option>
			      			</c:forEach>
			      		</select>
			      		<select id="sub_ctg" name="sub_ctg_name">
			      			<option>소분류</option>
			      		</select>
			      	</td>
			      </tr>
			      <tr>
			      	<th>강의명</th><td><input type="text" name="main_lec_subject"/></td>
			      </tr>
			      <tr>
			      	<th>대표이미지</th><td><input type="file" name="save"/></td>
			      </tr>
			      <tr>
			      	<th>강의요약</th><td><textarea rows="6" cols="60" name="main_lec_content"></textarea></td>
			      </tr>
			      <tr>
			      	<td colspan="2" align="right">
			      		<input type="reset" value="다시 작성"/><input type="submit" value="강의 생성"/>
			      	</td>
			      </tr>
			 	</table>
	 	</div>
	</form>
</c:if>