<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <head>
		<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.6.2/css/font-awesome.min.css">
		<link href="top_style.css" rel="stylesheet" type="text/css">
		<script>
			function displaySwitch(num){
				content = document.getElementById("content"+num)
				if(content.style.display=="none"){
					content.style.display="block";
				}else{
					content.style.display="none";
				}				
			}
		</script>
	</head>
	
    <br/><br/><br/><br/><br/><br/>
    <br/>
    <table border="0">
	    <tr>
	    	<td>	
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href='/mooc/main.mooc'><input type="button" value="main" align="center"></a>
			</td>
		</tr>
	</table>
	<br/>
	<c:if test="${sessionScope.alram==1}">
	<div class="tableWrap">
		<table class="table" align="center">
				<thead>
					<tr>
						<th>게시판</th>
						<th>아이디</th>
						<th>제목</th>
						<th>등록일</th>
					</tr>
				</thead>
		<c:if test="${sessionScope.first_c_lec_question < sessionScope.second_c_lec_question}">
		<tbody>
		<c:forEach var="alram" items="${lec_q_alram}" varStatus="i">
				<tr>
					<td>강의 질문 게시판<input type="hidden" name="num" value="${alram.lec_q_num}"/></td>
					<td>${alram.u_id}</td>
					<td onclick="displaySwitch('${i.count}re2');">
						<b>${alram.lec_q_subject}</b>
					</td>
					<td>${alram.lec_q_regdate}</td>
				</tr>
				<c:if test="${alram.lec_q_content!=null}">
					<tr>
						<td colspan="7" align="left">
							<div id="content${i.count}re2" style="display:none; height:auto;">
								문의 내용 &nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${alram.lec_q_content}<br /><br />
								<hr>
							</div>					
						</td>
					</tr>
				</c:if>
		</c:forEach>
		</tbody>
		</c:if>
		
		<c:if test="${sessionScope.first_like_lec_list < sessionScope.second_like_lec_list}">
		<tbody>
		<c:forEach var="alram" items="${like_lec_list}" varStatus="i">
				<tr>
					<td>관심 강사 게시판<input type="hidden" name="num" value="${alram.lec_q_num}"/></td>
					<td>${alram.t_id}</td>
					<td onclick="displaySwitch('${i.count}re7');">
						<b>${alram.main_lec_subject}</b>
					</td>
					<td>${alram.main_lec_regdate}</td>
				</tr>
				<c:if test="${alram.main_lec_content!=null}">
					<tr>
						<td colspan="7" align="left">
							<div id="content${i.count}re7" style="display:none; height:auto;">
								문의 내용 &nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${alram.main_lec_content}<br /><br />
								<hr>
							</div>					
						</td>
					</tr>
				</c:if>
		</c:forEach>
		</tbody>
		</c:if>
		
		<c:if test="${sessionScope.first_notice < sessionScope.second_notice}">
		<tbody>
		<c:forEach var="alram" items="${notice_alram}" varStatus="i">
				<tr>
					<td>공지사항<input type="hidden" name="num" value="${alram.notice_num}"/></td>
					<td>관리자</td>
					<td onclick="displaySwitch('${i.count}re1');">
						<b>${alram.notice_subject}</b>
					</td>
					<td>${alram.notice_regdate}</td>
				</tr>
				<c:if test="${alram.notice_content!=null}">
					<tr>
						<td colspan="7" align="left">
							<div id="content${i.count}re1" style="display:none; height:auto;">
								공지 내용 &nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${alram.notice_content}<br /><br />
								<hr>
							</div>					
						</td>
					</tr>
				</c:if>
		</c:forEach>
		</tbody>
		</c:if>
		<c:if test="${sessionScope.first_c_lec_notice < sessionScope.second_c_lec_notice}">
		<tbody>
		<c:forEach var="alram" items="${lec_notice_alram}" varStatus="i">
				<tr>
					<td>강의 공지사항<input type="hidden" name="num" value="${alram.lec_n_num}"/></td>
					<td>${alram.t_id}</td>
					<td onclick="displaySwitch('${i.count}re3');">
						<b>${alram.lec_n_subject}</b>
					</td>
					<td>${alram.lec_n_regdate}</td>
				</tr>
				<c:if test="${alram.lec_n_content!=null}">
					<tr>
						<td colspan="7" align="left">
							<div id="content${i.count}re3" style="display:none; height:auto;">
								강의 공지 내용 &nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${alram.lec_n_content}<br /><br />
								<hr>
							</div>					
						</td>
					</tr>
				</c:if>
		</c:forEach>
		</tbody>
		</c:if>
		<c:if test="${sessionScope.first_c_lec_review < sessionScope.second_c_lec_review}">
		<tbody>
		<c:forEach var="alram" items="${lec_revew_alram}" varStatus="i">
				<tr>
					<td>강의 후기<input type="hidden" name="num" value="${alram.main_lec_code}"/></td>
					<td>${alram.u_id}</td>
					<td onclick="displaySwitch('${i.count}re4');">
						<b>${alram.lec_r_subject}</b>
					</td>
					<td>${alram.lec_r_regdate}</td>
				</tr>
				<c:if test="${alram.lec_r_content!=null}">
					<tr>
						<td colspan="7" align="left">
							<div id="content${i.count}re4" style="display:none; height:auto;">
								후기 내용 &nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${alram.lec_r_content}<br /><br />
								<hr>
							</div>					
						</td>
					</tr>
				</c:if>
		</c:forEach>
		</tbody>
		</c:if>
		
		
		</table>
	</div>
	</c:if>
	
	<c:if test="${sessionScope.alram==0}">
	<div class="tableWrap">
		<table class="table" align="center">
				<thead>
					<tr>
						<th>게시판</th>
						<th>아이디</th>
						<th>제목</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="4" align="center">새로운 알림이 없습니다.</td>
					</tr>
				</tbody>
	</table>
	</div>
	</c:if>