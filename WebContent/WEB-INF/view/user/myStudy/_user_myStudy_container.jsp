<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

<c:if test="${sessionScope.memId!=null }">
                   
	<h3>최근 게시물</h3>
	<ul class="nav nav-tabs">
		<li class="active"><a data-toggle="tab" href="#home">알림</a></li>
		<li><a data-toggle="tab" href="#menu1">강의 공지사항</a></li>
		<li><a data-toggle="tab" href="#menu2">강의 질문답변</a></li>
		<li><a data-toggle="tab" href="#menu3">관리자 문의답변</a></li>
	</ul>

	<div class="tab-content">
	<div id="home" class="tab-pane fade in active">
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
							문의 내용 &nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${alram.lec_q_content}<br /><br />	<hr>
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
					<td>${alram.u_id}</td>
					<td onclick="displaySwitch('${i.count}re7');">
						<b>${alram.lec_q_subject}</b>
					</td>
					<td>${alram.lec_q_regdate}</td>
				</tr>
		<c:if test="${alram.lec_q_content!=null}">
				<tr>
					<td colspan="7" align="left">
					<div id="content${i.count}re7" style="display:none; height:auto;">문의 내용 &nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${alram.lec_q_content}<br /><br /><hr>
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
	</div>
	<div id="menu1" class="tab-pane fade">
			<li></li>
			<c:forEach var="lecNoticeDto" items="${list}" varStatus="i">
				<li>.<a href="/mooc/user/user_noticeView.mooc?lec_n_num=${lecNoticeDto.lec_n_num}&pageNum=${pageNum}&check=1">${lecNoticeDto.lec_n_subject}</a>[${lecNoticeDto.main_lec_subject}]</li>
			</c:forEach>
	    </div>
			
	    <div id="menu2" class="tab-pane fade">
			<li class="more">› <a href="/mooc/user/myLec_questionList.mooc">강의 질문답변 더보기</a></li>
			<c:forEach var="lecture_question" items="${lecture_question}" varStatus="i">
				<li>.<a href="/mooc/user/myLec_questionList.mooc">${lecture_question.lec_q_subject}</a></li>
			</c:forEach>
	    </div>
	    
	    <div id="menu3" class="tab-pane fade">
			<li class="more">› <a href="/mooc/user/myQuestion.mooc">관리자 문의답변 더보기</a></li>
				<c:forEach var="question" items="${question}" varStatus="i">
					<li>.<a href="/mooc/user/myQuestion.mooc"><c:set var="date" value="${fn:split(question.q_subject, ' ')}"/>${date[0]}</a></li>
				</c:forEach>
	    </div>
	</div>
	
	</c:if>
