<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="Toptable">

	<a href="javascript:modifySubCtg()">내용 변경</a>&nbsp;&nbsp;
	<a href="javascript:deleteSubCtgList()">선택 삭제</a>
	<form name="searchSubName" action="/mooc/admin/ctgList.mooc">
		
		<select name="ctg_code" id="top_category" onchange="go_url(this.value)">
			<option value="0" ${ctg_code == 0 ? 'selected="selected"' : '' }>전체 보기</option>
			<c:forEach var="topCtgDto" items="${topCtgList}">
				<option value="${topCtgDto.top_ctg_code}" ${ctg_code == topCtgDto.top_ctg_code ? 'selected="selected"' : '' }>${topCtgDto.top_ctg_name }</option>
			</c:forEach>
		</select>
		<input type="text" name="searchSubName" placeholder="소분류 검색">
		<input type="submit" value="검색" />
	</form>
	<form name="moveForm" method="post">
		<select name="top_ctg_code">
			<option>대분류</option>
				<c:forEach var="topCtgDto" items="${topCtgList}">
					<option value="${topCtgDto.top_ctg_code}">
						${topCtgDto.top_ctg_name}
					</option>
				</c:forEach>
	   	</select>
   		<input type="button" value="선택 이동" onclick="moveSubCtgs()"/>
   	</form>
</div>

	<form name="formCheck">
		<table class="table">
			<thead>
				<tr>
					<th><input type="checkbox" name="allcheck" onclick="allCheck()"/></th>
					<th>대분류</th>
					<th>소분류</th>
				</tr>
			</thead>
			<tbody>
				<form class="navbar-form navbar-left" role="search"></form>
				<form name="updateForm" method="post">
					<c:forEach var="c" items="${ctgList}">
						<tr>
							<td><input type="checkbox" name="checkbox" value="${c.sub_ctg_code}"/></td>
							<td>
								<select name="top_ctg_code">
					      			<c:forEach var="topCtgDto" items="${topCtgList}">
					      				<option value="${topCtgDto.top_ctg_code}" ${c.top_ctg_code == topCtgDto.top_ctg_code ? 'selected="selected"' : '' }>
					      					${topCtgDto.top_ctg_name }
					      				</option>
					      			</c:forEach>
					      		</select>
							</td>
							<td>
								<input type="text" name="sub_ctg_name" value="${c.sub_ctg_name}" />
								<input type="hidden" name="sub_ctg_code" value="${c.sub_ctg_code}"/>
								<a href="/mooc/admin/ctgSubPreDelete.mooc?ctg_code=${c.sub_ctg_code}">-</a>
							</td>
						</tr>
					</c:forEach>
					<input type="submit" style="display:none" />
				</form>
			</tbody>
		</table>
	</form>
