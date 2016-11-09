<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script>
function qnaOpen(){
	window.open("/mooc/user/user_viewQnaList.mooc?main_lec_code="+${main_lec_dto.main_lec_code}, "window", "width=1000,height=600,scrollbars=no,location=no");
}

function noticeOpen(){
	window.open("/mooc/user/user_notice.mooc?main_lec_code="+${main_lec_dto.main_lec_code}, "window", "width=1000,height=600,scrollbars=no,location=no");
}


function myFunction(i,x) {
	var u_id=document.getElementById("u_id").value;
	var u_name=document.getElementById("u_name").value;
	var sub_lec_code=document.getElementsByName("sub_lec_code")[x].value;
	var sub_lec_subject=document.getElementsByName("sub_lec_subject")[x].value;
	var sub_lec_chapter=document.getElementsByName("sub_lec_chapter")[x].value;
	var sub_lec_content=document.getElementsByName("sub_lec_content")[x].value;
	var u_type=0; //학생은 0, 선생은 1
	
	//진도업데이트
	 $.ajax({        
     	url : '/mooc/user_progress_ajax.mooc',
		type: "post",
       data: {  // url 페이지도 전달할 파라미터                                    
     	    sub_lec_code: sub_lec_code,
		 	main_lec_code: '${main_lec_dto.main_lec_code}'
       }	                      
   });
	 cw=screen.availWidth;
	 ch=screen.availHeight;
	 test=window.open('https://192.168.30.107:9001/doStart.html?sub_lec_code='+i+'&u_name='+encodeURI(encodeURIComponent(u_name))+'&sub_lec_subject='+encodeURI(encodeURIComponent(sub_lec_subject))+'&sub_lec_chapter='+sub_lec_chapter+'&sub_lec_content='+encodeURI(encodeURIComponent(sub_lec_content))+'&u_type='+u_type+'&u_id='+u_id,'_blank','width='+cw+',height='+ch+',resizable=no,scrollbars=yes');
}

function displaySwitch(num){
	content = document.getElementById("content"+num)
	if(content.style.display=="none"){
		content.style.display="block";
	}else{
		content.style.display="none";
	}
	
}

</script>
<c:set var="currentPage" value="/mooc/viewMainLec.mooc?main_lec_code=${main_lec_dto.main_lec_code }"/>
	<input type="hidden" id="u_id" name="u_id" value="${sessionScope.memId}"/>
	<input type="hidden" id="u_name" name="u_name" value="${sessionScope.memName}"/>
	<table class="table" align="center" style="width:1000px;">
		<tr><td colspan="2">
			<h2>${main_lec_dto.main_lec_subject}</h2>
			<table >
				<tr>
					<c:if test="${count2==1}"><td style="color:#999;font-size:17px">수강중&nbsp;</td>
					</c:if>
					<c:if test="${count1==1}"><td style="color:#999;font-size:17px">관심강의&nbsp;</td>
					</c:if>
					<c:if test="${count3==1}"><td style="color:#999;font-size:17px">관심강사&nbsp;</td>
					</c:if>
				</tr>
			</table>
			<input type="hidden" name="main_lec_code" value="${main_lec_dto.main_lec_code}"/>
			</h4>
			</td>
			<td align="right">
				<c:if test="${count2==0&&sessionScope.memId!=null}">
					<input type="button" class="btn btn-default" value="수강신청" onclick="window.location='/mooc/user_lectureRegister.mooc?main_lec_code=${main_lec_dto.main_lec_code}'"/>
				</c:if>
				<c:if test="${count1==0&&sessionScope.memId!=null}">
					<input type="button" class="btn btn-default" value="관심강의" onclick="window.location='/mooc/user_interestLecture.mooc?main_lec_code=${main_lec_dto.main_lec_code}'">
				</c:if>
				<c:if test="${count3==0&&sessionScope.memId!=null}">
					<input type="button" class="btn btn-default" value="관심강사" onclick="window.location='/mooc/user_interestTeacher.mooc?t_id=${main_lec_dto.t_id}&main_lec_code=${main_lec_dto.main_lec_code}'">
				</c:if>
			</td>
		</tr>
		<c:if test="${sessionScope.memId!=t_id&&count2==1}">
		<tr> 
			<td colspan="2"></td>
			<td colspan="2" align="right">
				<input type="button" class="btn btn-default" value="질문 하기" onclick="window.location='/mooc/user/user_qnaWrite.mooc?q_code=${main_lec_dto.main_lec_code}'"/>
			</td>				
		</tr>
		</c:if>
		<tr>
			<td colspan="2"></td>
			<td colspan="2" align="right"><input type="button" class="btn btn-default" value="질문 게시판" onclick="qnaOpen()" />&nbsp;&nbsp;&nbsp;
					<input type="button" class="btn btn-default" value="강의 공지" onclick="noticeOpen()"/>				
			</td>
		</tr>
		<tr>
			<td rowspan="3" align="center"><img src="/mooc/files${main_lec_dto.main_lec_image }" width="300" height="200"/></td>
			<td>강의 개요 </td><td>${main_lec_dto.main_lec_content }</td>
		</tr>
		<tr>
			<td>구성</td><td>${sub_lec_count}강</td>
		</tr>
		<tr>
			<td colspan="2"><fmt:formatDate value="${main_lec_dto.main_lec_regdate }" pattern="yyyy년  MM월 dd일"/>시작</td>
		</tr>
	</table>
	<table align="center">
		<tr>
			<td align="center">
	<ul class="nav nav-tabs">
		<li class="active"><a data-toggle="tab" href="#home">강의 보기</a></li>
		<li><a data-toggle="tab" href="#menu1">강사 소개</a></li>
		<li><a data-toggle="tab" href="#menu2">강의 후기</a></li>
	</ul>
		<div class="tab-content">
			<div id="home" class="tab-pane fade in active">
				<table class="table" align="center">
					<c:forEach var="lectureDTO" items="${sub_lec_list}" varStatus="i">
						<tr>
							<td width="20%">
								<input type="hidden" name="sub_lec_chapter" value="${lectureDTO.sub_lec_chapter}"/>${lectureDTO.sub_lec_chapter}강
								<input type="hidden" name="sub_lec_code" value="${lectureDTO.sub_lec_code }"/>
							</td>
							<td width="50%">
								<input type="hidden" name="sub_lec_type" value="${lectureDTO.sub_lec_type }"/>
								<input type="hidden" name="sub_lec_subject" value="${lectureDTO.sub_lec_subject}"/>
								<input type="hidden" name="sub_lec_content" value="${lectureDTO.sub_lec_content}"/>
								<c:if test="${lectureDTO.sub_lec_chapter==1||count2==1&&sessionScope.memId!=null}">
									<c:if test="${lectureDTO.sub_lec_type==0||lectureDTO.sub_lec_type==2 }"><a href="/mooc/watchLec.mooc?sub_lec_code=${lectureDTO.sub_lec_code }&currentPage=${currentPage}" target="_blank"></c:if>
									<c:if test="${lectureDTO.sub_lec_type==1 }"><a href="#" onclick="myFunction(${lectureDTO.sub_lec_code },'${i.index }')"></c:if>
									${lectureDTO.sub_lec_subject }
									<input type="hidden" value="${lectureDTO.sub_lec_type }"/>
								</c:if>
								<c:if test="${count2!=1&&lectureDTO.sub_lec_chapter!=1}">
									${lectureDTO.sub_lec_subject }
									<input type="hidden" value="${lectureDTO.sub_lec_type }"/>
								</c:if>
							</td>
							<td width="25%">
								<c:if test="${lectureDTO.sub_lec_type==0}">녹화</c:if>
								<c:if test="${lectureDTO.sub_lec_type==1}">실시간(${lectureDTO.live_lec_date})</c:if>
								<c:if test="${lectureDTO.sub_lec_type==2}">실시간(종료)</c:if>
							</td>
							</tr>
					</c:forEach>
				</table>
		    </div>
		    
			<div id="menu1" class="tab-pane fade">
				<table class="table" align="center">
					<tr>
						<td>강사 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${main_lec_code_tInfo.t_id}</td>
					</tr>
					<tr>
					 	<td>학력&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${main_lec_code_tInfo.t_education}</td>
					</tr>
				  	<tr>
						<td>자격증&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${main_lec_code_tInfo.t_certificate}</td>
					</tr>
					<tr>
						<td>수상내역&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${main_lec_code_tInfo.t_prize}</td>
					</tr>
					<tr>
						<td>기술&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${main_lec_code_tInfo.t_skill}</td>
					</tr>
					<tr>
						<td>소개&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${main_lec_code_tInfo.t_other}</td>
					</tr>
				</table>
		    </div>
				
		    <div id="menu2" class="tab-pane fade">
		    	<c:if test="${reviewCheck != 0}">
			    	<ul>
			    		<li class="pull-right"><a href="/mooc/user/user_viewReview.mooc?main_lec_code=${main_lec_dto.main_lec_code}">강의평 더 보기</a></li>
			    	</ul>
			    	<table class="table" align="center">
						<thead>
							<tr class="theadtop">
								<th>번호</th>
								<th>작성자</th>
								<th>별점</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="lec_review" items="${view_review}" varStatus="i">
							<tr onclick="displaySwitch('${i.count}re');">
								
								<td align="center">${lec_review.main_lec_code}<input type="hidden" name="main_lec_code" value="${lec_review.main_lec_code}"/><input type="hidden" name="index" value="${index}" id="${index}"/></td>
								<td align="center">${lec_review.u_id}</td>							
								<td align="center">
								 	 <c:if test="${lec_review.lec_r_score<=5 && lec_review.lec_r_score>4}">★★★★★</c:if>
			        			 	 <c:if test="${lec_review.lec_r_score<=4 && lec_review.lec_r_score>3}">★★★★☆</c:if>
			      				  	 <c:if test="${lec_review.lec_r_score<=3 && lec_review.lec_r_score>2}">★★★☆☆</c:if>
			      					 <c:if test="${lec_review.lec_r_score<=2 && lec_review.lec_r_score>1}">★★☆☆☆</c:if>
			         				 <c:if test="${lec_review.lec_r_score<=1 && lec_review.lec_r_score>0}">★☆☆☆☆</c:if>
								</td>
								
								<td align="center">
									<fmt:formatDate value="${lec_review.lec_r_regdate}" pattern="YY-MM-dd"/>
									<c:if test="${sessionScope.memId==lec_review.u_id}"><a href=""></a></c:if>
								</td>
							</tr>
							<c:if test="${lec_review.lec_r_content!=null}">
								<tr>
									<td colspan="8" align="left">
										<div id="content${i.count}re" style="display:none; height:auto;">
											${lec_review.lec_r_content}<br /><br />
										</div>					
									</td>
									
								</tr>
							</c:if>		
							<c:set var="index" value="${index+1}" />
						</c:forEach>
							<tr>
								<td colspan="4" align="right">
								<c:if test="${sessionScope.memId!=t_id&&count2==1}">
									<a href="/mooc/user/user_reviewContent.mooc?main_lec_code=${main_lec_dto.main_lec_code}&main_lec_subject=${main_lec_dto.main_lec_subject}">강의후기 작성</a>
								</c:if>
								</td>
							</tr>
						</tbody>
					</table>
				</c:if>
				<c:if test="${reviewCheck == 0}">
					<table class="table" align="center"><tr><td>등록된 강의 후기가 없습니다.</td></tr>
					<c:if test="${sessionScope.memId!=t_id&&count2==1}">
						<tr> 
							<td>
								<input type="button" class="btn btn-default" value="강의 후기 작성" onclick="window.location='/mooc/user/user_reviewContent.mooc?main_lec_code=${main_lec_dto.main_lec_code}&main_lec_subject=${main_lec_dto.main_lec_subject}'"/>
							</td>				
						</tr>
					</c:if>
				</c:if>
		    </div>
		</div>
</td></tr></table>
	
