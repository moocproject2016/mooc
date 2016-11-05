<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<script>
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
				if(updateform.checkbox[i].checked==true){ state=true;  }
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
						checkIndex[cnt] = document.getElementById("index"+i).value;
						cnt++;

					}
				}
				
				updateform.action='/mooc/admin/admin_sendEmail.mooc?checkIndex='+checkIndex;
				updateform.submit();
			}
		}
		</script>
	<form name="updateform" method="post" action="/mooc/admin/accessList.mooc">
		<%-- <c:set var="index" value="0" /> --%>
		<table class="table" align="center">
			<thead>
				<tr class="tableHead"><td colspan="4"><h3>휴면계정 관리</h3></td></tr>
				<tr class="theadtop">
					<th><input type="checkbox" name="allcheck" onclick="allCheck()"/></th>
					<th>아이디</th>
					<th>이름</th>
					<th>최종접속일</th>
				</tr>
			</thead>
			<tbody>
			
				<c:forEach var="article" items="${list}" varStatus="i">
				<tr>
						
					<td align="center"><input type="checkbox" name="checkbox" value="${article.u_id}"  id="index${i.index}"/></td>
						<%-- <input type="hidden" name="index${i.index}" value="${article.u_id}" id="index${i.index}" /> --%>	
											
					<td align="center">${article.u_id}
				<%-- 	<input type="text" id="num${i.index}" value="${article.q_num}"/> --%>
					</td>
					<td align="center">${article.u_name}</td>
					<td align="center">${article.u_accessdate}</td>				
				</tr>
						
				<c:set var="index" value="${index+1}" />
			</c:forEach>
				</tbody>
		</table>	
			<table class="table" align="center">
			<tr>
				
				<td align="right">
					<a onclick="deleteNums()">이메일전송</a>
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
							<a href="/mooc/admin/accessList.mooc?pageNum=${startPage - 10 }">[이전]</a>
						</c:if>
				
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<a href="/mooc/admin/accessList.mooc?pageNum=${i}">[${i}]</a>
						</c:forEach>
					
						<c:if test="${endPage < pageCount}">
							<a href="/mooc/admin/accessList.mooc?pageNum=${startPage + 10}">[다음]</a>
						</c:if>
					</c:if>
				</td>
			</tr>
	</table>
