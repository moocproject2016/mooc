<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="tableWrap">
	<table class="table" align="center"> 
		<tr valign="middle" class="tableHead">
			<td colspan="5">	
	    	 	<form action="/mooc/community.mooc?sub_ctg_code=${sub_ctg_code}"  method="post">
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
			<th width="150">그룹장</th>
			<th width="100">개설날짜</th>     
	    </tr>
		<c:forEach var="stglist" items="${studylist}" varStatus="i">
			<tr height="30" onClick="purposeDisplay('purpose_${stglist.stg_code}')" style='cursor:pointer;'>
				<td align="center">${stglist.sub_ctg_name}</td>
				<td align="center">
					${stglist.stg_name}
				</td>
				<td align="center">           
					<input type="text" name="stg_people" value="${stglist.stg_count}" size=1 style="text-align:right; border:0px;background-color:transparent;" readonly/>
					/<input type="text" name="stg_limit" value="${stglist.stg_limit}" size=2 style="border:0px; background-color:transparent;" readonly/> 
				</td>
				<td align="center"> 
					${stglist.u_name}
				</td>
				<td align="center">
			      <fmt:formatDate value="${stglist.stg_regdate}" pattern="yyyy-MM-dd" />
				</td>
			</tr>
			<div id="myModal" class="modal fade" tabindex="-1" role="dialog">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">×</button>
								<h3>${stglist.stg_name}</h3>
						</div>
						<div class="modal-body">
							<p>${stglist.stg_purpose}</p>
							<input  type="button" value="가입" Onclick="joincheck('${i.index}',${stglist.stg_code})"/>
						</div>
						<div class="modal-footer">
							
							<button class="btn" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
				
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
      						<a href="/mooc/community.mooc?sub_ctg_code=${sub_ctg_code}&pageNum=${startPage - 10 }" aria-label="Previous">
        					<span aria-hidden="true">&laquo;</span>
      						</a>
    					</li>
						</c:if>
				
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:if test="${currentPage==i}">
								<li class="active"><a href="/mooc/community.mooc?sub_ctg_code=${sub_ctg_code}&pageNum=${i}">${i}</a></li>
							</c:if>
							<c:if test="${currentPage!=i}">							
								<li><a href="/mooc/community.mooc?sub_ctg_code=${sub_ctg_code}&pageNum=${i}">${i}</a></li>
							</c:if>
						</c:forEach>
					
						<c:if test="${endPage < pageCount}">
						<li>
						<a href="/mooc/community.mooc?sub_ctg_code=${sub_ctg_code}&pageNum=${startPage + 10}" aria-label="Next">
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
</form>
</div>

<script>

function purposeDisplay(id) {
	   var style = document.getElementById(id).style;
	   style.display = (style.display == 'none' ? 'table-row' : 'none');
	}
function joincheck(x,stg_code){
			if((document.getElementsByName("stg_people")[x].value == document.getElementsByName("stg_limit")[x].value)){
				alert("인원이 가득차 가입 할수 없습니다..")
			
        }else{
     	  window.location='/mooc/study/studyJoin.mooc?stg_code='+stg_code+'&sub_ctg_code='+${sub_ctg_code};
			}
}
	
</script>
