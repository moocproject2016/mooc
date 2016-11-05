<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
function checkIt(){
	alert("");
		var userinput = eval("document.insertSubForm");
		if(!userinput.top_ctg_code.value){ alert("대분류를 선택해주세요"); return false;	}
	}
	
</script>
	
<div class="topBtn">
	<button class="btn btn-xs" onclick="displayTop()">대분류 추가</button>
	<button class="btn btn-xs" onclick="displaySub()">소분류 추가</button>
	<button class="btn btn-xs" onclick="modifyTopCtg()">내용 변경</button>
	<form name="searchTopName" action="/mooc/admin/ctgList.mooc">
		<input type="text" name="searchTopName" placeholder="대분류 검색">
		<input type="submit" value="검색" />
	</form>
</div>
<br /><br />
		<table class="table" id="topCtgInsertForm" style="display:block; height:auto;">
			<tr>
				<th>대분류</th>
			</tr>
			<tr>
				<td>
					<form name="insertTopForm" method="post" action="/mooc/admin/ctgTopWrite.mooc">
						<input type="text" size="20" name="top_ctg_name" placeholder="ex)English"/>
						<a href="javascript:inputTopCtg()">+</a>&nbsp;
						<a href="javascript:insertTopCtg()">등록</a>
						<div id="topInput"></div>
					</form>
				</td>
			</tr>
		</table>
		<table class="table" id="subCtgInsertForm" style="display:block; height:auto;">
			<tr>
				<th>소분류</th>
			</tr>
			<tr>
				<td>
					<form name="insertSubForm" method="post" action="/mooc/admin/ctgSubWrite.mooc" onSubmit="return checkIt()">
						<select name="top_ctg_code">
			      			<option>선택</option>
			      			<c:forEach var="topCtgDto" items="${topCtgList}">
			      				<option value="${topCtgDto.top_ctg_code}">${topCtgDto.top_ctg_name}</option>
			      			</c:forEach>
			      		</select>
			      		<br />
						<input type="text" size="20" name="sub_ctg_name" placeholder="ex)speaking"/>
						<a href="javascript:inputSubCtg()">+</a>&nbsp;
						<a href="javascript:insertSubCtg()">등록</a>
						<div id="subInput"></div>
					</form>
				</td>
			</tr>
		</table>
		
		<form name="updateTopForm" method="post">
			<table>
				<tr>
				<c:forEach var="topCtgDto" items="${topCtgList}">
					<td>
						<input type="text" name="top_ctg_name" value="${topCtgDto.top_ctg_name}" />
						<input type="hidden" name="top_ctg_code" value="${topCtgDto.top_ctg_code}" />
						<a href="/mooc/admin/ctgTopPreDelete.mooc?ctg_code=${topCtgDto.top_ctg_code}">-</a>
					</td>
				</tr>
				</c:forEach>
			</table>
		</form>
