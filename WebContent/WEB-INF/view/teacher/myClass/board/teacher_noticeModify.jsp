<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script>
	jQuery(document).ready(function(){
		$('#orgingFileBtn').click(function(){ 
			document.getElementById("before_div").style.display="block";
			document.getElementById("after_div").style.display="none";
			jQuery("#after").replaceWith(jQuery("#after").clone(true));
		});
		
		$('#delFileBtn').click(function(){ 
			document.getElementById("before_div").style.display="none";
			document.getElementById("after_div").style.display="block";
		});
	});
</script>
<c:if test="${sessionScope.memId==null }">
	<script>
		alert("로그인이 필요합니다.");
		location.href="/mooc/user/userSign.mooc";
	</script>
</c:if>
<c:if test="${sessionScope.memId!=null }">
	<form action="/mooc/teacher/noticeModifyPro.mooc" encType="multipart/form-data" method="post"  name="orderForm" onSubmit="return check_info()">
	<input type="hidden" value="${lecNoticeDTO.lec_n_num}" name="lec_n_num"/>
	<table class="tableWrap">
		<tr><td>
			<table class="table">
				<tr>
					<td>강의</td>
					<td>
						<select id="main_select" name="main_lec_code">
							<option <c:if test="${lecNoticeDTO.main_lec_code==0}">selected</c:if>>강의 목록</option>
							<c:forEach var="main_lec_dto" items="${main_lec_list }">
								<option value="${main_lec_dto.main_lec_code}" <c:if test="${lecNoticeDTO.main_lec_code==main_lec_dto.main_lec_code}">selected</c:if>>
								${main_lec_dto.main_lec_subject}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>중요</td>
					<td><input type="checkbox" value=1 name="lec_n_type" <c:if test="${lecNoticeDTO.lec_n_type==1}">checked</c:if>/></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input type="text" size=50 name="lec_n_subject" value="${lecNoticeDTO.lec_n_subject }" /></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea rows="20" cols="70" name="lec_n_content">${lecNoticeDTO.lec_n_content }</textarea><td>
				</tr>
				<tr>
					<td>첨부파일</td>
					<td>
						<div id="before_div" style='display:block;'>
							<input type="button"  id="delFileBtn" value="파일삭제" />
							<input type="text" name="before_file" value="${lecNoticeDTO.lec_n_file}" size="50" style="border: 0px;" readonly/>
						</div>
						<div id="after_div" style='display:none;'>
							<input type="button" id="orgingFileBtn" value="기존 파일로 변경" />
							<input type="file" name="after_file" id="after"/>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="작성" />
						<input type="button" value="돌아가기" onclick="document.location.href='/mooc/teacher/noticeList.mooc?main_lec_code=${lecNoticeDTO.main_lec_code}'" />
					</td>					
				</tr>
			</table>
		</td></tr>
	</table>	
	</form>	
</c:if>


<script type="text/javascript">
	function check_info() {
		
		if(document.orderForm.lec_n_subject.value == ""){
			alert("제목을 입력하세요");
			document.orderForm.lec_n_subject.focus();
			return false;
		}
		if(document.orderForm.lec_n_content.value == ""){
			alert("내용을 입력하세요");
			document.orderForm.lec_n_subject.focus();
			return false;
		}
	}
</script>