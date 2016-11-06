<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<link rel="stylesheet"
	href="http://netdna.bootstrapcdn.com/font-awesome/4.6.2/css/font-awesome.min.css">
<link href="top_style.css" rel="stylesheet" type="text/css">
<script>
	jQuery(document).ready(function() {
		selectMain = document.getElementById("main_select").value;
		pageNum = document.getElementById("currentPage").value;
	});
	function select() {
		selectMain = document.getElementById("main_select").value;
		window.location = '/mooc/teacher/qnaList.mooc?main_lec_code='
				+ selectMain;
	}
	function displaySwitch(num) {
		content = document.getElementById("content" + num)
		if (content.style.display == "none") {
			content.style.display = "block";
		} else {
			content.style.display = "none";
		}
	}

	function submitBtn(index) {
		var updateform = document.updateform;
		alert("수정되었습니다.");
		updateform.action = '/mooc/admin/qnaWriteForm.mooc?index=' + index;
		updateform.submit();
	}
</script>
</head>
<br />
<br />
<br />
<h2>질문게시판</h2>
<table style="width: 100%;">
	<tr>
		<td><select id="main_select" onchange="select()">
				<option value="0" <c:if test="${main_lec_code==0}">selected</c:if>>전체
					강의</option>
				<c:forEach var="main_lec_dto" items="${main_lec_list }">
					<option value="${main_lec_dto.main_lec_code}"
						<c:if test="${main_lec_code==main_lec_dto.main_lec_code}">selected</c:if>>${main_lec_dto.main_lec_subject}</option>
				</c:forEach>
		</select> 총 질문 수 : ${all_count}</td>
	</tr>
</table>
<div class="tableWrap">

	<%-- <c:set var="index" value="0" /> --%>
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

			<c:forEach var="article" items="${view_question}" varStatus="i">
				<tr>
					<input type="hidden" name="index${i.index}"
						value="${article.lec_q_num}" id="index${i.index}" />

					<td>${article.lec_q_num}<%-- 	<input type="text" id="num${i.index}" value="${article.q_num}"/> --%>
					</td>
					<td>${article.u_id}</td>
					<td onclick="displaySwitch('${i.count}');"><b>${article.lec_q_subject}</b>
					</td>
					<td><fmt:formatDate value="${article.lec_q_regdate}"
							pattern="yyyy-MM-dd HH:mm" /></td>
					<td><c:if test="${article.lec_c_content==null}">
							미답
						</c:if> <c:if test="${article.lec_c_content!=null}">
							완료
						</c:if></td>
				</tr>

				<c:if test="${article.lec_q_content!=null}">
					<tr>

						<td colspan="7" align="left">
							<div id="content${i.count}" style="display: none; height: auto;">
								문의 내용
								&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${article.lec_q_content}<br />
								<br />
								<hr>
								<c:if test="${u_type==1}">
									<form name="contentUpdate"
										action="/mooc/teacher/view_ReContent3.mooc">
										<input type="hidden" name="main_lec_code"
											value="${main_lec_code}" /> <input type="hidden"
											name="lec_q_num" value="${article.lec_q_num}" /> 답변
										&nbsp;:&nbsp;&nbsp;
										<textarea name="lec_c_content" rows="40" cols="100">${article.lec_c_content}</textarea>
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
			<td>
				<form action="/mooc/teacher/reviewList.mooc" method="post">
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

					<c:if test="${startPage > 10}">
						<a
							href="/mooc/teacher/qnaList.mooc?main_lec_code=${main_lec_code }&pageNum=${startPage - 10 }">[이전]</a>
					</c:if>

					<c:forEach var="i" begin="${startPage}" end="${endPage}">
						<a
							href="/mooc/teacher/qnaList.mooc?main_lec_code=${main_lec_code }&pageNum=${i}">[${i}]</a>
					</c:forEach>

					<c:if test="${endPage < pageCount}">
						<a
							href="/mooc/teacher/qnaList.mooc?main_lec_code=${main_lec_code }&pageNum=${startPage + 10}">[다음]</a>
					</c:if>
				</c:if></td>
		</tr>
	</table>
</div>