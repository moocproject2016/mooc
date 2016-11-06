<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
	function searchId() {
		var updateform = document.updateform;
		updateform.action = '/mooc/admin/qnaWriteForm.mooc?search='
				+ document.getElementById('searchId').value;
		updateform.submit();
	}

	function displaySwitch(num) {
		content = document.getElementById("content" + num)
		if (content.style.display == "none") {
			content.style.display = "block";
		} else {
			content.style.display = "none";
		}

	}

	function allCheck() {
		checkbox = document.getElementsByName("checkbox");
		if (updateform.allcheck.checked) {
			for (var i = 0; i < checkbox.length; i++) {
				checkbox[i].checked = true;
			}
		} else {
			for (var i = 0; i < checkbox.length; i++) {
				checkbox[i].checked = false;
			}
		}
	}

	function selectCheck() {
		var state = false;

		if (updateform.checkbox.checked == true) {
			state = true;
		}
		for (var i = 0; i < updateform.checkbox.length; i++) {
			if (updateform.checkbox[i].checked == true) {
				state = true;
				updateform.checkbox[i].value = i;
			}

		}
		return state;
	}

	function deleteNums() {
		var updateform = document.updateform;
		if (selectCheck() == false) {
			alert("삭제할 게시글을 선택해주세요.");
		} else {

			updateform.action = '/mooc/user/myStgDelete.mooc';
			updateform.submit();

		}
	}
	function submitBtn(index) {
		var updateform = document.updateform;
		alert("수정되었습니다.");
		updateform.action = '/mooc/admin/qnaWriteForm.mooc?index=' + index;
		updateform.submit();
	}
</script>

<ul class="nav nav-pills">
	<li role="presentation" class="active"><a href="myStgWriter.mooc">스터디
			게시판</a></li>
	<li role="presentation"><a href="myQuestion.mooc">관리자 문의 / 답변</a></li>
	<li role="presentation"><a href="myLecture_review.mooc">강의 후기</a></li>
	<li role="presentation"><a href="myLec_questionList.mooc">강의
			질문/ 답변</a></li>
</ul>

<form name="updateform">
	<c:set var="index" value="0" />
	<table class="table" align="center">
		<tr>
			<td>
				<h1>
					내가 쓴 게시글<small>&nbsp;&nbsp;&nbsp;&nbsp;스터디 게시판</small>
				</h1>
				<div class="page-header"></div>
			</td>
		</tr>
	</table>
	<table class="table" align="center">
		<thead>
			<tr class="theadtop">
				<th><input type="checkbox" name="allcheck" onclick="allCheck()" /></th>
				<th>번호</th>
				<th>제목</th>
				<th>날짜</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="stg_b" items="${stg_b}" varStatus="i">
				<tr>
					<td align="center"><input type="checkbox" name="checkbox"
						value="0" /></td>
					<td align="center">${stg_b.stg_b_num}<input type="hidden"
						name="stg_b_num" value="${stg_b.stg_b_num}" /><input type="hidden"
						name="index" value="${index}" id="${index}" /></td>
					<td align="center" onclick="displaySwitch('${i.count}re1');">
						<b>${stg_b.stg_b_subject}</b>
					</td>
					<td align="center"><c:set var="date"
							value="${fn:split(stg_b.stg_b_regdate, ' ')}" /> ${date[0]}</td>
				</tr>
				<c:if test="${stg_b.stg_b_content!=null}">
					<tr>
						<td colspan="7" align="left">
							<div id="content${i.count}re1"
								style="display: none; height: auto;">
								문의 내용
								&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${stg_b.stg_b_content}<br />
								<br />
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
		<td>
			<form action="/mooc/user/myStgWriter.mooc" method="post">
				<select name="search">
					<option value="subject">제목</option>
					<option value="id">아이디</option>
					<option value="content">내용</option>
				</select> <input type="text" name="select"> <input type="submit"
					value="검색">
			</form>
		</td>
	</tr>
</table>
<table class="table" align="center">
	<tr>
		<td height="50" align="center"><c:if test="${count > 0}">
				<c:set var="pageCount"
					value="${count / pageSize + ( count % pageSize == 0 ? 0 : 1)}" />
				<c:set var="pageBlock" value="${10}" />
				<fmt:parseNumber var="result" value="${currentPage / 10}"
					integerOnly="true" />

				<c:set var="startPage" value="${result * 10 + 1}" />
				<c:set var="endPage" value="${startPage + pageBlock-1}" />
				<c:if test="${endPage > pageCount}">
					<c:set var="endPage" value="${pageCount}" />
				</c:if>


				<nav>
					<ul class="pagination">

						<c:if test="${startPage > 10}">
							<li><a href="myStgWriter.mooc?pageNum=${startPage - 10 }"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
							</a></li>
						</c:if>

						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:if test="${currentPage==i}">
								<li class="active"><a href="myStgWriter.mooc?pageNum=${i}">${i}</a></li>
							</c:if>
							<c:if test="${currentPage!=i}">
								<li><a href="myStgWriter.mooc?pageNum=${i}">${i}</a></li>
							</c:if>
						</c:forEach>

						<c:if test="${endPage < pageCount}">
							<li><a href="myStgWriter.mooc?pageNum=${startPage + 10}"
								aria-label="Next"> <span aria-hidden="true">&raquo;</span>
							</a></li>
						</c:if>
				</nav>
			</c:if></td>
	</tr>
</table>
