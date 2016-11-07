<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
function myFunction(i,x) {
		var u_name=document.getElementById("u_name").value;
		var sub_lec_code=document.getElementsByName("sub_lec_code")[x].value;
		var sub_lec_subject=document.getElementsByName("sub_lec_subject")[x].value;
		var sub_lec_chapter=document.getElementsByName("sub_lec_chapter")[x].value;
		var u_type=0; //학생은 0, 선생은 1
		
		//진도업데이트
		alert("ajax");
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
		 test=window.open('https://192.168.30.107:9001/doLive.html?sub_lec_code='+i+'&u_name='+u_name+'&sub_lec_subject='+sub_lec_subject+'&sub_lec_chapter='+sub_lec_chapter+'&u_type='+u_type,'_blank','width='+cw+',height='+ch+',resizable=no,scrollbars=yes');
		
}
</script>
<c:set var="currentPage" value="/mooc/viewMainLec.mooc?main_lec_code=${main_lec_dto.main_lec_code }"/> 
	<table class="table" align="center">
		<tr><td colspan="2">
				<h4>${main_lec_dto.main_lec_subject }
				<table>
					<tr>
						<c:if test="${count2==1}"><td style="color:#FF0000;font-size:17px">수강중&nbsp;</td>
						</c:if>
						<c:if test="${count1==1}"><td style="color:#FF0000;font-size:17px">관심강의&nbsp;</td>
						</c:if>
						<c:if test="${count==1}"><td style="color:#FF0000;font-size:17px">관심강사&nbsp;</td>
						</c:if>
					</tr>
				</table>
				
				<input type="hidden" name="main_lec_code" value="${main_lec_dto.main_lec_code}"/>
				</h4>
			</td>
			<td align="right">
			<button type="button" class="btn btn-default" onclick="window.history.back()" ><span class="glyphicon glyphicon-hand-left" aria-hidden="true"></span> 뒤로가기</button>
				<c:if test="${count2==0&&sessionScope.memId!=null}">
					<input type="button" class="btn btn-default" value="수강신청" onclick="window.location='/mooc/user_lectureRegister.mooc?main_lec_code=${main_lec_dto.main_lec_code}'"/>
				</c:if>
				<c:if test="${count==0&&sessionScope.memId!=null}">
				<input type="button" class="btn btn-default" value="관심강사" onclick="window.location='/mooc/user_interestTeacher.mooc?t_id=${main_lec_dto.t_id}&main_lec_code=${main_lec_dto.main_lec_code}'">
				</c:if>
				<c:if test="${count1==0&&sessionScope.memId!=null}">
				<input type="button" class="btn btn-default" value="관심강의" onclick="window.location='/mooc/user_interestLecture.mooc?main_lec_code=${main_lec_dto.main_lec_code}'">
				</c:if>
		</td></tr>
		<c:if test="${sessionScope.memId!=t_id&&count2==1}">
		<tr> 
			<td colspan="2"></td>
			<td colspan="2" align="right">
				<input type="button" class="btn btn-default" value="질문 하기" onclick="window.location='/mooc/user/user_qnaWrite.mooc?q_code=${main_lec_dto.main_lec_code}'"/>
				&nbsp;&nbsp;&nbsp;
				<input type="button" class="btn btn-default" value="강의 후기 작성" onclick="window.location='/mooc/user/user_reviewContent.mooc?main_lec_code=${main_lec_dto.main_lec_code}&main_lec_subject=${main_lec_dto.main_lec_subject}'"/>
				</td>				
		</tr>
		</c:if>
		<tr>
			<td colspan="2"></td>
			<td colspan="2" align="right"><input type="button" class="btn btn-default" value="질문 게시판" onclick="window.location='/mooc/user/user_viewQnaList.mooc?main_lec_code=${main_lec_dto.main_lec_code}'" />&nbsp;&nbsp;&nbsp;
										<input type="button" class="btn btn-default" value="강의 후기" onclick="window.location='/mooc/user/user_viewReview.mooc?main_lec_code=${main_lec_dto.main_lec_code}&main_lec_subject=${main_lec_dto.main_lec_subject}'" />
			</td>
		</tr>
		
			<td rowspan="3"><img src="${main_lec_dto.main_lec_image }" width="100" height="100"/></td>
			<td>강의내용 </td><td>${main_lec_dto.main_lec_content }</td>
		</tr>
		<tr>
			<td>강의수</td><td>${sub_lec_count}</td>
		</tr>
		<tr>
			<td>강의 생성 날짜</td><td><fmt:formatDate value="${main_lec_dto.main_lec_regdate }" pattern="yyyy-MM-dd HH:mm"/></td>
		</tr>
	</table>
	
	<table class="table" align="center">
		<c:forEach var="lectureDTO" items="${sub_lec_list}">
			<tr>
				<td width="5%">
					${lectureDTO.sub_lec_chapter}강
					<input type="hidden" name="sub_lec_code" value="${lectureDTO.sub_lec_code }"/>
				</td>
				<td width="40%">
					<c:if test="${lectureDTO.sub_lec_chapter==1||count2==1&&sessionScope.memId!=null}">
						<c:if test="${lectureDTO.sub_lec_type==0||lectureDTO.sub_lec_type==2 }"><a href="/mooc/watchLec.mooc?sub_lec_code=${lectureDTO.sub_lec_code }&currentPage=${currentPage}" target="_blank"></c:if>
						<c:if test="${lectureDTO.sub_lec_type==1 }"><a href="#" onclick="myFunction(${lectureDTO.sub_lec_code })"></c:if>
						${lectureDTO.sub_lec_subject }</a>
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
				<td width="30%">
					<c:if test="${lectureDTO.w_lec_state==1}"><font color="red"><b>학습완료(<fmt:formatDate value="${lectureDTO.w_lec_date }" pattern="yyyy-MM-dd HH:mm"/>)</b></font></c:if>
				</td>
				</tr>
			
		</c:forEach>
	</table>