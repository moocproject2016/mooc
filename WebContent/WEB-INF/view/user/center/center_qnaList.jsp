<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<script>
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
				
				updateform.action='/mooc/user/center/center_qnaDeleteForm.mooc?checkIndex='+checkIndex;
				updateform.submit();
			}
		}
		
		function submitBtn(index){
			var updateform=document.updateform;
			alert("수정되었습니다.");
			updateform.action='/mooc/user/center/center_qnaWrite.mooc?index='+index;
			updateform.submit();
		}
	</script>
	
	<c:if test="${u_id==null}">
		<script>
	        alert("로그인을 해주세요.");
	        window.location='/mooc/user/userSign.mooc';
		</script>
	</c:if>
<div class="tableWrap">
	<form name="updateform" method="post" action="/mooc/user/center/qnaList.mooc">
		<c:set var="index" value="0" />
		<table class="table" align="center">
			<thead>
				<tr>
					<th><input type="checkbox" name="allcheck" onclick="allCheck()"/></th>
					<th><input type="hidden" value="문의번호" />번호</th>
					<th>아이디</th>
					<th>제목</th>
					<th>문의날짜</th>
					<th>답변</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="article" items="${list}" varStatus="i">
				<tr>
					<td align="center"><input type="checkbox" name="checkbox" value="${article.q_num}"/></td>
						<input type="hidden" name="index${i.index}" value="${article.q_num}" id="index${i.index}" />	
											
					<td align="center">${article.q_num}
				<%-- 	<input type="text" id="num${i.index}" value="${article.q_num}"/> --%>
					</td>
					<td align="center">${article.u_id}</td>
					<td align="center" onclick="displaySwitch('${i.count}');">
						<b>${article.q_subject}</b>
					</td>
					<td align="center">${article.q_regdate}</td>
					<td align="center">
						<c:if test="${article.c_content==null}">
							미답
						</c:if>
						<c:if test="${article.c_content!=null}">
							완료
						</c:if>
					</td>			
				</tr>
						
				<c:if test="${article.q_content!=null}">
					<tr>
						<td colspan="7" align="left">
							<div id="content${i.count}" style="display:none; height:auto;">
								문의 내용 &nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${article.q_content}<br /><br />
								<hr>
									
									<c:if test="${article.c_content!=null}">
									관리자 답변 &nbsp;:&nbsp;&nbsp;
									${article.c_content}
									
								</c:if>
							</div>					
						</td>
					</tr>
				</c:if>
				<input type="hidden" name="index" value="${index}"/>
				<c:set var="index" value="${index+1}" />
			</c:forEach>	
			</tbody>
		</table>
		
		<table class="table" align="center">
			<tr >
				<td align="lift">
					<a href="/mooc/user/center/center_qnaWrite.mooc">글쓰기</a>
				</td>
				<td align="right">
					<a onclick="deleteNums()">선택삭제</a>
				</td>					
			</tr>
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
							<a href="/mooc/qna.mooc?pageNum=${startPage - 10 }">[이전]</a>
						</c:if>
				
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<a href="/mooc/qna.mooc?pageNum=${i}">[${i}]</a>
						</c:forEach>
					
						<c:if test="${endPage < pageCount}">
							<a href="/mooc/qna.mooc?pageNum=${startPage + 10}">[다음]</a>
						</c:if>
					</c:if>
				</td>
			</tr>
	</table>
</div>