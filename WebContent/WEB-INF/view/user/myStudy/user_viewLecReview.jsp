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
				if(updateform.checkbox[i].checked==true){ state=true; updateform.checkbox[i].value=i;}
			}
			return state;
		}
		
		function deleteNums(){
			var updateform=document.updateform;
			if(selectCheck()==false){
				alert("삭제할 게시글을 선택해주세요.");
			}else{
				updateform.action='/mooc/user/Lec_reviewDelete.mooc';
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
<br />
<br />
<br />
<br />
<br />
<div class="tableWrap">
	<form name="updateform" method="post" action="/mooc/admin/qnaWriteForm.mooc">
	<c:set var="index" value="0" />
		<table class="table" align="center">
			<thead>
				<tr>
					<th>문의번호</th>
					<th>강의명</th>
					<th>아이디</th>
					<th>평점</th>
					<th>별점</th>
					<th>문의날짜</th>
				</tr>
			</thead>
				<tbody>
				<c:forEach var="lec_review" items="${view_review}" varStatus="i">
				<tr>
					
					<td>${lec_review.main_lec_code}<input type="hidden" name="main_lec_code" value="${lec_review.main_lec_code}"/><input type="hidden" name="index" value="${index}" id="${index}"/></td>
					<td onclick="displaySwitch('${i.count}re');">
						<b>${lec_review.lec_r_subject}</b>
					</td>
					<td>${lec_review.u_id}</td>							
					<td>평점 : ${lec_review.lec_r_score}</td>
					<td>
					 	 <c:if test="${lec_review.lec_r_score<=5 && lec_review.lec_r_score>4}">★★★★★</c:if>
        			 	 <c:if test="${lec_review.lec_r_score<=4 && lec_review.lec_r_score>3}">★★★★☆</c:if>
      				  	 <c:if test="${lec_review.lec_r_score<=3 && lec_review.lec_r_score>2}">★★★☆☆</c:if>
      					 <c:if test="${lec_review.lec_r_score<=2 && lec_review.lec_r_score>1}">★★☆☆☆</c:if>
         				 <c:if test="${lec_review.lec_r_score<=1 && lec_review.lec_r_score>0}">★☆☆☆☆</c:if>
					</td>
					
					<td><fmt:formatDate value="${lec_review.lec_r_regdate}" pattern="yy-mm-dd hh:mm"/></td>
				</tr>
				<c:if test="${lec_review.lec_r_content!=null}">
					<tr>
						<td colspan="7" align="left">
							<div id="content${i.count}re" style="display:none; height:auto;">
								후기 내용&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${lec_review.lec_r_content}<br /><br />
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
						
						
						<nav>
  						<ul class="pagination">
									
						<c:if test="${startPage > 10}">
						<li>
      						<a href="user_viewReview.mooc?pageNum=${startPage - 10 }" aria-label="Previous">
        					<span aria-hidden="true">&laquo;</span>
      						</a>
    					</li>
						</c:if>
				
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:if test="${currentPage==i}">
								<li class="active"><a href="user_viewReview.mooc?pageNum=${i}">${i}</a></li>
							</c:if>
							<c:if test="${currentPage!=i}">							
								<li><a href="user_viewReview.mooc?pageNum=${i}">${i}</a></li>
							</c:if>
						</c:forEach>
					
						<c:if test="${endPage < pageCount}">
						<li>
						<a href="user_viewReview.mooc?pageNum=${startPage + 10}" aria-label="Next">
        					<span aria-hidden="true">&raquo;</span>
      					</a>
      					</li>
						</c:if>
						</nav>
					</c:if>
				</td>
			</tr>
	</table>
</div>