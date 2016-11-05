<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<link type="text/css" href="jquery.simple-dtpicker.css" rel="stylesheet" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script type="text/javascript" src="jquery.simple-dtpicker.js"></script>

<script>
	var index=0;
	jQuery(document).ready(function(){
		
		$('#add_btn').click(function(){
			index++;
			$('#div').append('<table><tr>'
						+'<td rowspan="3"><input type="text" name="sub_lec_chapter" size=1 value='+index+' style="border:0px" readonly></td>'
						+'<td colspan="2"><select name="sub_lec_type" onclick="selType(this)">'
							+'<option>강의유형</option><option value="0">녹화</option><option value="1">실시간</option>'
						+'</select>'
						+'<input type="text" name="sub_lec_subject" size="55" placeholder="서브 강의 제목 입력."/></td>'
						
						+'<td rowspan="3"><input type="button" value="삭제" name="del_btn" onclick="delTb(this)"></td>'
					+'</tr>'
					+'<tr>'
						+'<td><input type="file" name="save" disabled="disabled"/></td>'
						+'<td><input type="text" name="live_lec_date" class="DatePicker" size="25" disabled="disabled" placeholder="강의날짜(2016/01/01 20:00)"/></td>'
					+'</tr>'
					+'<tr>'
						+'<td colspan="2"><textArea name="sub_lec_content" cols="70" rows="3" placeholder="서브 강의 내용 입력"></textArea></td>'
					+'</tr></table>');
			$(".DatePicker").appendDtpicker();
		});
		
	});
	
	function selType(subType){
		var index;
		//현재 인덱스 찾기
		for(var i=0;i<document.getElementsByName("sub_lec_type").length;i++){
			if(document.getElementsByName("sub_lec_type")[i].value==subType.value){ index=i;}
		}
		if(subType.value==0){ //녹화강의
			document.getElementsByName("save")[index].disabled=false;
			document.getElementsByName("live_lec_date")[index].value="";
			document.getElementsByName("live_lec_date")[index].disabled=true;
				
		}else if(subType.value==1){ //실시간강의
			document.getElementsByName("save")[index].disabled=true;
			document.getElementsByName("save")[index].value="";
			document.getElementsByName("live_lec_date")[index].disabled=false;
		}
		
	}
	
	function delTb(delBtn){
		index--;
		var sub_lec_chapter=document.getElementsByName("sub_lec_chapter");
		
		$(delBtn).parent().parent().parent().remove();
		for(var i=0;i<sub_lec_chapter.length;i++){
			sub_lec_chapter[i].value=i+1;
		}	
		
	}
	function submitCheck(){
		//파일 확장자 검사
		var arrExt=new Array(".avi",".mp4",".mpeg",".wmv",".swf",".mp3");
		var state=true;
		var fileCount=0;
		for(var i=0;i<document.inform.sub_lec_chapter.length;i++){
			var filename=document.inform.save[i].value;
			if(filename!=""){ // 파일이 존재하면
				fileCount++;
				var lastDotIndex=filename.lastIndexOf(".");
				var ext=filename.substring(lastDotIndex,filename.length).toLowerCase();
				var arrCheck=false;
				for(var j=0;j<arrExt.length;j++){
					if(arrExt[j]==ext){
						arrCheck=true; //확장자가 배열안에 있으면 true
					}
				}
				if(arrCheck==false){ //확장자가 배열 안에 없으면 상태를 false로 변경
					state=false; 
					errorIndex=i+1;
				}
			}
		}
		if(fileCount==0){ state=true; }
		if(state==false){ alert("동영상 파일이 아닙니다."); }
		return state;
	}
</script>
<div class="tableWrap">
	<form name="inform" action="/mooc/teacher/makeSubLecturePro.mooc" method="post" encType="multipart/form-data" onsubmit="return submitCheck()">
		<table>
			<thead>
				<tr>
					<th colspan=6>강의코드 : <input type="text" name="main_lec_code" value="${lectureDTO.main_lec_code}" style="border:0px;" readonly/>
					강의명 : <input type="text"  value="${lectureDTO.main_lec_subject}" style="border:0px;" readonly/>
					<input type="button" id="add_btn" value="강의추가"/></th>
				</tr>
			</thead>
			<tbody>
				<tr><td>
					<div id="div">
				    </div>
			    </td></tr>
			    <tr><td>
					<input type="button" value="나중에 입력" onclick="javascript:location.href='/mooc/teacher/subLecture_list.mooc?main_lec_code=${lectureDTO.main_lec_code}'">
					<input type="reset" value="다시입력">
					<input type="submit" value="등록">
				</td></tr>
			</tbody>
		</table>
	</form>
	
</div>