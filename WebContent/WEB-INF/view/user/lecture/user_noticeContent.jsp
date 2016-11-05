<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	function submitCheck(){
		filename = document.getElementById("file").value;	//file이라는 input name을 지닌 것을 가져옴.
	
		//파일 확장자 검사
		var arrExt=new Array(".jpg",".gif",".png",".tif",".psd",".pdd");
		if(filename!=""){ // 파일이 존재하면
			var lastDotIndex=filename.lastIndexOf(".");	//파일명에 마지막으로 .이 나오는 지점을 저장        
			var ext=filename.substring(lastDotIndex,filename.length).toLowerCase();	//파일명의 확장자를 소문자로 변경
			var arrCheck=false;
			for(var j=0;j<arrExt.length;j++){
				if(arrExt[j]==ext){
					arrCheck=true; //확장자가 배열안에 있으면 true
				}
			}
			$('#imgdiv').append("<img src='\\mooc\\files"+filename+"'/>");
		}
	}
</script>
<body onload="submitCheck()">
	<table class="table">
		<tr>
			<td>번호</td>
			<td>${lecNotice_dto.lec_n_num}</td>
		</tr>
		<tr>
			<td>강의</td>
			<td>${lecNotice_dto.main_lec_subject}</td>
		</tr>
		<tr>
			<td>제목</td>
			<td>${lecNotice_dto.lec_n_subject}</td>
		</tr>
		<tr>
			<td>작성일</td>
			<td><fmt:formatDate value="${lecNotice_dto.lec_n_regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
		</tr>
		<tr>
			<td>내용</td>
			<td>
				${lecNotice_dto.lec_n_content}
				<div id="imgdiv">
					 <input type="hidden" id="file" value="${lecNotice_dto.lec_n_file}" />
				</div>
			</td>
		</tr>
		<tr>
			<td>첨부파일</td>
			<td><a href="/mooc/teacher/noticeFileDownload.mooc?fileName=${lecNotice_dto.lec_n_file}">${lecNotice_dto.lec_n_file} 다운로드</a></td>
		</tr>
		<tr>
			<td colspan="6" align="right">
				<input type="button" value="목록" onclick="document.location.href='/mooc/userLecNoticeList.mooc?main_lec_code=${lecNotice_dto.main_lec_code}&pageNum=${pageNum }'" />
			</td>
		</tr>
	</table>
</body>
