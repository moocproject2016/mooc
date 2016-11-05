<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	<script>
		
		function searchId(){
			var updateform=document.updateform;
			updateform.action='/mooc/admin/qnaWriteForm.mooc?search='+document.getElementById('searchId').value;
			updateform.submit();
		}
		
		function displaySwitch(num){
			content = document.getElementById("content"+num)
			if(content.style.display=="none"){
				content.style.display="block";
			}else{
				content.style.display="none";
			}
			
		}
		
		function allCheck(){
			checkbox=document.getElementsByName("checkbox");
			if(updateform.allcheck.checked){  
				for(var i=0;i<checkbox.length;i++){
					checkbox[i].checked=true;
				}
			}else{
				for(var i=0;i<checkbox.length;i++){
					checkbox[i].checked=false;
				}
			}
		}
				
		function selectCheck(){
			var state=false;
			if(updateform.checkbox.checked==true){state=true;}
			for(var i=0;i<updateform.checkbox.length;i++){
				if(updateform.checkbox[i].checked==true){ state=true; }
			}
			return state;
		}
		
		function deleteNums(){
			var updateform=document.updateform;
			if(selectCheck()==false){
				alert("삭제할 게시글을 선택해주세요.");
			}else{
				updateform.action='/mooc/admin/qnaDeleteForm.mooc';
				updateform.submit();
			}
		}
		
		function submitBtn(index){
			var updateform=document.updateform;
			alert("수정되었습니다.");
			updateform.action='/mooc/admin/qnaWriteForm.mooc?index='+index;
			updateform.submit();
		}
	</script>
</head>	

	<form name="updateform" method="post" action="/mooc/admin/qnaWriteForm.mooc">
		<c:set var="index" value="0" />
		<table class="table" align="center">
			<thead>
				<tr>
				
					<th>문의번호</th>
					<th>아이디</th>
					<th>제목</th>
					<th>문의날짜</th>
					<th>답변</th>
				</tr>
			</thead>
			<tbody>
			
				<c:forEach var="list" items="${view_question}" varStatus="i">
				<tr>
						
					<td align="center">${list.q_num}<input type="hidden" name="num" value="${list.q_num}"/></td>
					<td align="center">${list.u_id}</td>
					<td align="center" onclick="displaySwitch('${i.count}');">
						<b>${list.q_subject}</b>
					</td>
					<td>${list.q_regdate}</td>
					<td>
						<c:if test="${list.c_content==null}">
							미답
						</c:if>
						<c:if test="${list.c_content!=null}">
							완료
						</c:if>
					</td>				
				</tr>
						
				<c:if test="${list.q_content!=null}">
					<tr>
						<td colspan="7" align="left">
							<div id="content${i.count}" style="display:none; height:auto;">
								문의 내용 &nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${list.q_content}<br /><br />
								<hr>
							</div>					
						</td>
					</tr>
				</c:if>		
				<c:set var="index" value="${index+1}" />
			</c:forEach>
				</tbody>
		</table>	
			
		
	</form>
		
		<table class="table" align="center">
			<tr>
				<td height="50" align="center">
					<c:if test="${count > 0}">
					
						<c:set var="pageCount" value="${count / pageSize + ( count % pageSize == 0 ? 0 : 1)}" />
						<c:set var="pageBlock" value="${10}" />			
						<fmt:parseNumber var="result" value="${currentPage / 10}" integerOnly="true" />
						
						<c:set var="startPage" value="${result * 10 + 1}" />
						<c:set var="endPage" value="${startPage + pageBlock-1}" />
							<c:if test="${endPage > pageCount}">
								<c:set var="endPage" value="${pageCount}" />
							</c:if>	
										
						<c:if test="${startPage > 10}">
							<a href="/mooc/user/user_viewQna.moocc?pageNum=${startPage - 10 }">[이전]</a>
						</c:if>
				
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<a href="/mooc/user/user_viewQna.mooc?pageNum=${i}">[${i}]</a>
						</c:forEach>
					
						<c:if test="${endPage < pageCount}">
							<a href="/mooc/user/user_viewQna.mooc?pageNum=${startPage + 10}">[다음]</a>
						</c:if>
					</c:if>
				</td>
			</tr>
	</table>
