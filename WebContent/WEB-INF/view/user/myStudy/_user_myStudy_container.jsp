<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                        
	<h3>최근 게시물</h3>
	<ul class="nav nav-tabs">
		<li class="active"><a data-toggle="tab" href="#home">알림</a></li>
		<li><a data-toggle="tab" href="#menu1">강의 공지사항</a></li>
		<li><a data-toggle="tab" href="#menu3">강의 질문답변</a></li>
		<li><a data-toggle="tab" href="#menu3">홈페이지 문의답변</a></li>
	</ul>

	<div class="tab-content">
		<div id="home" class="tab-pane fade in active">
			<li class="more">› <a href="#">알림 더보기</a></li>
			<li>목록1</li>
			<li>목록2</li>
			<li>목록3</li>
	    </div>
		<div id="menu1" class="tab-pane fade">
			
			
	    </div>
	    <div id="menu3" class="tab-pane fade">
			<li class="more">› <a href="/mooc/user/myLec_questionList.mooc">강의 질문답변 더보기</a></li>
			<form name="updateform" method="post" action="/mooc/admin/qnaWriteForm.mooc">
				<table class="table" align="center">
					<thead>
						<tr class="theadtop">
							<th>번호</th>
							<th>강의</th>
							<th>제목</th>
							<th>날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="lecture_question" items="${lecture_question}" varStatus="i">
							<tr>					
								<td align="center">${lecture_question.lec_q_num}<input type="hidden" name="lec_q_num" value="${lecture_question.lec_q_num}"/>
									<input type="hidden" name="index" value="${index}"/>
								</td>
								<td align="center">강의 질문</td>
								<td align="center" onclick="displaySwitch('${i.count}re2');">
									<b>${lecture_question.lec_q_subject}</b>
								</td>
								<td align="center">
									<c:set var="date" value="${fn:split(lecture_question.lec_q_regdate, ' ')}"/>
									${date[0]}
								</td>
							</tr>
							<c:if test="${lecture_question.lec_q_content!=null}">
								<tr>
									<td colspan="6" align="left">
										<div id="content${i.count}re2" style="display:none; height:auto;">
											문의 내용 &nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${lecture_question.lec_q_content}<br /><br />
											<hr>
										</div>					
									</td>
								</tr>
							</c:if>		
						</c:forEach>
					</tbody>
				</table>	
			</form>
	    </div>
	    <div id="menu3" class="tab-pane fade">
			<li class="more">› <a href="/mooc/user/myQuestion.mooc">홈페이지 문의답변 더보기</a></li>
	    </div>
	</div>
