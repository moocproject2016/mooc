<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
	    <link href="/mooc/css/bootstrap.css" rel="stylesheet">
    <link href="/mooc/css/common.css" rel="stylesheet">
    <link href="/mooc/css/style.css" rel="stylesheet">
	<script>
		
		function go(){
			if(document.getElementById('selected').value=='제목'){
				alert("제목검색");
				window.location='/mooc/admin/searchqnaList.mooc?q_subject='+document.getElementById('search').value
			}
			else if(document.getElementById('selected').value=='아이디'){
				alert("아이디검색");
				indow.location='/mooc/admin/searchqnaList.mooc?u_id='+document.getElementById('search').value
			}
			
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
				if(updateform.checkbox[i].checked==true){ state=true; updateform.checkbox[i].value=i; }
			}
			return state;
		}
		
		function deleteNums(){
			var updateform=document.updateform;
			if(selectCheck()==false){
				alert("삭제할 게시글을 선택해주세요.");
				return;
			}else{
				var checkIndex = new Array();
				var cnt = 0;
				for(var i=0;i<updateform.checkbox.length;i++){
					if(updateform.checkbox[i].checked==true){
						
						checkIndex[cnt] = document.getElementById("index"+ updateform.checkbox[i].value).value;
						cnt++;
					}
				}
				
				updateform.action='/mooc/admin/qnaDeleteForm.mooc?checkIndex='+checkIndex;
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

		<table class="table" align="center">
			<thead>
			<tr><td colspan="5"><h2>질문게시판</h2></td></tr>
				<tr>
					<th>문의번호</th>
					<th>아이디</th>
					<th>제목</th>
					<th>문의날짜</th>
					<th>답변</th>
				</tr>
			</thead>
			<tbody>
			
				<c:forEach var="article" items="${list1}" varStatus="i">
				<tr>
						<input type="hidden" name="index${i.index}" value="${article.lec_q_num}" id="index${i.index}" />	
											
					<td align="center">${article.lec_q_num}
				<%-- 	<input type="text" id="num${i.index}" value="${article.q_num}"/> --%>
					</td>
					<td align="center">${article.u_id}</td>
					<td align="center" onclick="displaySwitch('${i.count}');">
						<b>${article.lec_q_subject}</b>
					</td>
					<td align="center"><fmt:formatDate value="${article.lec_q_regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
					<td>
						<c:if test="${article.lec_c_content==null}">
							미답
						</c:if>
						<c:if test="${article.lec_c_content!=null}">
							완료
						</c:if>
					</td>				
				</tr>
						
				<c:if test="${article.lec_q_content!=null}">
					<tr>
						
						<td colspan="7" align="left">
							<div id="content${i.count}" style="display:none; height:auto;">
								문의 내용 &nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${article.lec_q_content}<br /><br />
								<hr>
								<c:if test="${u_type==1}">
								<form name="contentUpdate" action="/mooc/user/view_ReContent.mooc">
							
										<input type="hidden" name="main_code" value="${main_lec_code}"/>
										<input type="hidden" name="lec_q_num" value="${article.lec_q_num}"/>
										답변 &nbsp;:&nbsp;&nbsp;
										<textarea name="lec_c_content" row="40" cols="100">${article.lec_c_content}</textarea>
										<c:if test="${article.lec_c_content!=null}">
											<input type="submit" value="답변수정">
										</c:if>
										<c:if test="${article.lec_c_content==null}">
											<input type="submit" value="답변등록">
										</c:if>									
								</form>
							</c:if>
								
							
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
							<a href="/mooc/user/user_viewQnaList.mooc?pageNum=${startPage - 10 }">[이전]</a>
						</c:if>
				
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<a href="/mooc/user/user_viewQnaList.mooc?pageNum=${i}">[${i}]</a>
						</c:forEach>
					
						<c:if test="${endPage < pageCount}">
							<a href="/mooc/user/user_viewQnaList.mooc?pageNum=${startPage + 10}">[다음]</a>
						</c:if>
					</c:if>
				</td>
			</tr>
	</table>
