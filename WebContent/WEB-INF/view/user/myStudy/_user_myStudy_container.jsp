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
			<li class="more">› <a href="#">알림 더보기</a></li>
			<li>목록1</li>
			<li>목록2</li>
			<li>목록3</li>
	    </div>
	    
		<div id="menu1" class="tab-pane fade">
			<li class="more">› <a href="/mooc/user/user_noticeView.mooc">강의 공지사항 더보기</a></li>
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
