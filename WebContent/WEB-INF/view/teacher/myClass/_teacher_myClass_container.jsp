<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
	<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.6.2/css/font-awesome.min.css">
	<link href="top_style.css" rel="stylesheet" type="text/css">
	<script>			
		jQuery(document).ready(function(){
			selectMain=document.getElementById("main_select").value;
			pageNum=document.getElementById("currentPage").value;
		});
		function select(){
			selectMain=document.getElementById("main_select").value;
			window.location='/mooc/teacher/reviewList.mooc?main_lec_code='+selectMain;
		}
		function displaySwitch(num){
			content = document.getElementById("content"+num)
			if(content.style.display=="none"){
				content.style.display="block";
			}else{
				content.style.display="none";
			}
		}
		
		function submitBtn(index){
			var updateform=document.updateform;
			alert("수정되었습니다.");
			updateform.action='/mooc/admin/qnaWriteForm.mooc?index='+index;
			updateform.submit();
		}
	</script>
</head>	
                    
	<h3>최근 게시물</h3>
	<ul class="nav nav-tabs">
		<li class="active"><a data-toggle="tab" href="#home">강의 공지사항</a></li>
		<li><a data-toggle="tab" href="#menu1">강의 후기</a></li>
		<li><a data-toggle="tab" href="#menu2">강의 질문</a></li>
	</ul>

	<div class="tab-content">
		<div id="home" class="tab-pane fade in active">
			<li class="more">› <a href="/mooc/teacher/noticeList.mooc">강의 공지사항 더보기</a></li>
			<table class="table">
				<thead>
					<tr bgcolor="ffffff">
						<th width="10%">번호</th>
						<th width="25%">강의</th>
						<th width="45%">제목</th>
						<th width="20%">날짜</th>
					</th>
				</thead>
				<c:forEach var="lecNoticeDto" items="${lec_notice_list1 }" varStatus="i">
				<tr bgcolor="#f0f0f0">
					<td>
						중요
					</td>
					<td>${lecNoticeDto.main_lec_subject}</td>
					<td>
						<a href="/mooc/teacher/noticeContent.mooc?lec_n_num=${lecNoticeDto.lec_n_num}&pageNum=${pageNum}">${lecNoticeDto.lec_n_subject}</a>
					</td>
					<td><fmt:formatDate value="${lecNoticeDto.lec_n_regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
				</tr>
				</c:forEach>
			</table>
			<table class="table">
				<c:forEach var="lecNoticeDto" items="${lec_notice_list0 }" varStatus="i">
				<tr bgcolor=ffffff>
					<td align="center" width="10%">
						${lecNoticeDto.lec_n_num}
					</td>
					<td align="center" width="25%">${lecNoticeDto.main_lec_subject}</td>
					<td align="center" width="45%">
						<a href="/mooc/teacher/noticeContent.mooc?lec_n_num=${lecNoticeDto.lec_n_num}&pageNum=${pageNum}">${lecNoticeDto.lec_n_subject}</a>
					</td>
					<td align="center" width="20%"><fmt:formatDate value="${lecNoticeDto.lec_n_regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
				</tr>
				</c:forEach>
			</table>
			
	    </div>
	    
	    <div id="menu1" class="tab-pane fade">
	    
			<li class="more">› <a href="/mooc/teacher/reviewList.mooc">강의 후기 더보기</a></li>
			<table class="table">
			<thead>
				<tr>
					<th>강의 번호</th>
					<th>강의명</th>
					<th>아이디</th>
					<th>평점</th>
					<th>별점</th>
					<th>문의날짜</th>
				</tr>
			</thead>
				<tbody>
				<c:forEach var="lec_review" items="${lec_review_list}" varStatus="i">
				<tr>
					<td align="center" >${lec_review.main_lec_code}<input type="hidden" name="main_lec_code" value="${lec_review.main_lec_code}"/><input type="hidden" name="index" value="${index}" id="${index}"/></td>
					<td align="center" onclick="displaySwitch('${i.count}re');">
						<b>${lec_review.lec_r_subject}</b>
					</td>
					<td align="center">${lec_review.u_id}</td>							
					<td align="center">평점 : ${lec_review.lec_r_score}</td>
					<td align="center">
					 	 <c:if test="${lec_review.lec_r_score<=5 && lec_review.lec_r_score>4}">★★★★★</c:if>
        			 	 <c:if test="${lec_review.lec_r_score<=4 && lec_review.lec_r_score>3}">★★★★☆</c:if>
      				  	 <c:if test="${lec_review.lec_r_score<=3 && lec_review.lec_r_score>2}">★★★☆☆</c:if>
      					 <c:if test="${lec_review.lec_r_score<=2 && lec_review.lec_r_score>1}">★★☆☆☆</c:if>
         				 <c:if test="${lec_review.lec_r_score<=1 && lec_review.lec_r_score>0}">★☆☆☆☆</c:if>
					</td>
					
					<td align="center">${lec_review.lec_r_regdate}</td>
				</tr>
				<c:if test="${lec_review.lec_r_content!=null}">
					<tr>
						<td colspan="7" align="left">
							<div id="content${i.count}re" style="display:none; height:auto;">
								후기 내용&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${lec_review.lec_r_content}<br /><br />
								<hr>
							</div>					
						</td>
					</tr>
				</c:if>		
				<c:set var="index" value="${index+1}" />
			</c:forEach>
				</tbody>
		</table>
	    </div>
	    
	    
       <div id="menu2" class="tab-pane fade">
			<li class="more">› <a href="/mooc/teacher/qnaList.mooc">강의 질문 더보기</a></li>
			<table class="table">
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
			
				<c:forEach var="article" items="${lec_qeustion_list}" varStatus="i">
					<tr>
						<input type="hidden" name="index${i.index}" value="${article.lec_q_num}" id="index${i.index}" />	
												
						<td align="center">${article.lec_q_num}
					<%-- 	<input type="text" id="num${i.index}" value="${article.q_num}"/> --%>
						</td>
						<td align="center">${article.u_id}</td>
						<td align="center" onclick="displaySwitch('${i.count}');">
							<b>${article.lec_q_subject}</b>
						</td>
						<td align="center"><fmt:formatDate value="${article.lec_q_regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
						<td align="center">
							<c:if test="${article.lec_c_content==null}">
								미답
							</c:if>
							<c:if test="${article.lec_c_content!=null}">
								완료
							</c:if>
						</td>				
					</tr>
							
					<c:if test="${article.lec_q_content!=null}">
						<tr>
							<td colspan="7" align="left">
								<div id="content${i.count}" style="display:none; height:auto;">
									문의 내용 &nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${article.lec_q_content}<br /><br />
									<hr>
									<c:if test="${u_type==1}">
										<form name="contentUpdate" action="/mooc/teacher/view_ReContent2.mooc">
												<input type="hidden" name="lec_q_num" value="${article.lec_q_num}"/>
												답변 &nbsp;:&nbsp;&nbsp;
												<textarea name="lec_c_content" rows="2" cols="90">${article.lec_c_content}</textarea>
												<input type="submit" value="답변등록">			
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
	    </div>
	</div>
