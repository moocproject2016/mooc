<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<div class="tableWrap">

	<table class="table" align="center"> 
		<tr valign="middle" class="tableHead">
			<td colspan="5">	
	    	 	<form action="/mooc/community.mooc"  method="post">
					<select  name="searchType" style="width: 200px;">
					    <option value="stg_name">방 제목</option>
						<option value="u_id">그룹장ID</option>
					</select>
					<input type="text" name="searchValue">
					<input type="submit" value="검색"  />
				</form>
			</td>
	    </tr>
	    <tr height="30" class="theadtop">  
			<th>분류</th> 
			<th>제목</th> 
			<th width="50">인원</th>
			<th width="80">상태</th>
			<th width="150">그룹장</th>
			<th width="100">개설날짜</th>     
	    </tr>
	    
		<c:forEach var="stglist" items="${studylist}" varStatus="i">
			<tr height="30" onClick="purposeDisplay('purpose_${stglist.stg_code}')">
				<td align="center">${stglist.sub_ctg_name}</td>
				<td align="center">
					${stglist.stg_name}
				</td>
				<td align="center">           
					<input type="text" name="stg_people" value="${stglist.stg_count}" size=1 style="text-align:right; border:0px;background-color:transparent;" readonly/>
					/<input type="text" name="stg_limit" value="${stglist.stg_limit}" size=2 style="border:0px; background-color:transparent;" readonly/> 
				</td>
				<td align="center">
				<input type="hidden" name="stg_type" value="${stglist.stg_type}">
				<c:if test="${stglist.stg_type == 1 }">
					공개
				</c:if>
				<c:if test="${stglist.stg_type == 0 }">
					비공개
				</c:if>
				</td>
				<td align="center"> 
					${stglist.u_name}
				</td>
				<td align="center">
			      <fmt:formatDate value="${stglist.stg_regdate}" pattern="yyyy-MM-dd" />
				</td>
			</tr>
			
			<tr id="purpose_${stglist.stg_code}" style='display: none;'>
				<td colspan="4">${stglist.stg_purpose}</td>
				<td colspan="2" align="right">
					<c:if test="${stglist.stg_type == 0 }"> <INPUT type=password name="passwd"  size="15" maxlength="12" placeholder="비밀번호"></c:if>
					<c:if test="${stglist.stg_type == 1 }"> <INPUT type=hidden name="passwd"></c:if>
					<input type="button" value="가입" Onclick="joincheck('${i.index}',${stglist.stg_code},${pageNum})"/>
				</td>
			</tr>
			</c:forEach>
		    <c:if test="${list.size() == 0}">
		    	<tr>
					<td colspan="5">           
						개설된 스터디룸이 없습니다. 
					</td>
				<tr>
			</c:if>
		</table>
	
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
      						<a href="/mooc/community.mooc?pageNum=${startPage - 10 }" aria-label="Previous">
        					<span aria-hidden="true">&laquo;</span>
      						</a>
    					</li>
						</c:if>
				
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:if test="${currentPage==i}">
								<li class="active"><a href="/mooc/community.mooc?pageNum=${i}">${i}</a></li>
							</c:if>
							<c:if test="${currentPage!=i}">							
								<li><a href="/mooc/community.mooc?pageNum=${i}">${i}</a></li>
							</c:if>
						</c:forEach>
					
						<c:if test="${endPage < pageCount}">
						<li>
						<a href="/mooc/community.mooc?pageNum=${startPage + 10}" aria-label="Next">
        					<span aria-hidden="true">&raquo;</span>
      					</a>
      					</li>
						</c:if>
						</ul>
					</nav>
				</c:if>
			</td>
		</tr>
	</table>
</div>

<script language="JavaScript">

 function purposeDisplay(id) {
	   var style = document.getElementById(id).style;
	   style.display = (style.display == 'none' ? 'table-row' : 'none');
	}
 function joincheck(x,stg_code,pageNum){
			if((document.getElementsByName("stg_people")[x].value == document.getElementsByName("stg_limit")[x].value)){
				alert("인원이 가득차 가입 할수 없습니다..")
			
           }else{
        	   if(document.getElementsByName("stg_type")[x].value==0){
        		   if(document.getElementsByName("passwd")[x].value==""){
        			   alert("비밀번호를 입력해주세요.");
        		   }else{
        			   $.ajax({
        					type: 'post',
        					url: "/mooc/study/studyJoin_ajax.mooc",
        					data: {
        						stg_password:document.getElementsByName("passwd")[x].value,
        						stg_code:stg_code
        					},			
        					success: function(data) {
        						if(data!="fail"){
        							window.location='/mooc/study/studyJoin.mooc?AllstdJoin=&pageNum='+pageNum+'&stg_code='+stg_code;
        						}else{
        							alert("비밀번호가 틀렸습니다.");
        						}
        					},
        					error: function(data){
        						alert("실패");
        					}
        				});
        		   }
        	   }else{
        		   window.location='/mooc/study/studyJoin.mooc?AllstdJoin=&pageNum='+pageNum+'&stg_code='+stg_code;
       			}
			}
 }
	
</script>
