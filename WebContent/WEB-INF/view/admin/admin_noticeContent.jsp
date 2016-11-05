<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

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
<body onload="submitCheck();">

	<table class="table" align="center">
		<tr>
			<th width="10%">${dto.notice_num}</th>
			<th width="60%" colspan="3" align="left">${dto.notice_subject }</th>
			<th width="20%"><fmt:formatDate value="${dto.notice_regdate}" pattern="yyyy-MM-dd HH:mm"/></th>
		</tr>
		<tr>
			<td align="center" colspan="5" height="300" align="left" >
			<div id="imgdiv">
				<input type="hidden" id="file" value="${dto.notice_file}" />
			</div>
				${dto.notice_content }
			</td>
		</tr>
		<tr>
			<td>
				<a href="/mooc/notice_download.mooc?fileName=${dto.notice_file}">${dto.notice_file} 다운로드</a>
			</td>
		</tr>
		<tr>
			<td colspan="6" align="right">
				<input type="button" value="수정" onclick="document.location.href='noticeModify.mooc?notice_num=${dto.notice_num }&pageNum=${pageNum}'" />	
				<input type="button" value="삭제" onclick="document.location.href='noticeDelete.mooc?notice_num=${dto.notice_num }&pageNum=${pageNum}'" />
				<input type="button" value="목록" onclick="document.location.href='noticeList.mooc?pageNum=${pageNum}'" />
			</td>
		</tr>
	</table>
</body>