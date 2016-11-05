<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script language="javascript">
	var index=0;
	var init_count=true;
	jQuery(document).ready(function(){
		$('#add_btn').click(function(){
			index=document.getElementsByName("sub_lec_code").length;
			index++;
			$('#div').append('<table><tr><td><tr>'
						
						+'<td rowspan="3"><input type="text" name="sub_lec_chapter" size=1 value='+index+' style="border:0px" readonly>'
						+'<input type="hidden" name="sub_lec_code"/></td>'
						+'<td colspan="2"><select id="type" name="sub_lec_type" onclick="selType(this)">'
							+'<option>강의유형</option><option value="0">녹화</option><option value="1">실시간</option>'
						+'</select>'
						+'<input type="text" name="sub_lec_subject" size="55" placeholder="서브 강의 제목 입력."/></td>'
						
						+'<td rowspan="3"><input type="button" value="삭제" name="del_btn" onclick="delTb(this)"></td>'
					+'</tr>'
					+'<tr>'
						+'<td colspan="2">'
							+'<div name="fileDIV" style="display:none;"><input type="hidden" name="fileState" value="new">'
							+'<input type="file" name="after_file"/><input type="hidden" name="before_file"/></div>'
							+'<div name="dateDIV" style="display:none;"><input type="text" name="live_lec_date" class="DatePicker" size="25" placeholder="강의날짜(2016/01/01 20:00)"/></div>'
						+'</td>'
					+'</tr>'
					+'<tr>'
						+'<td colspan="2"><textArea name="sub_lec_content" cols="70" rows="3" placeholder="서브 강의 내용 입력"></textArea></td>'
					+'</tr></td></tr></table><br />');
			$(".DatePicker").appendDtpicker();
		});
		$('#originImgBtn').click(function(){ 
			document.getElementById("before_div").style.display="block";
			document.getElementById("after_div").style.display="none";
			jQuery("#after").replaceWith(jQuery("#after").clone(true));
		});
		
		$('#newImgBtn').click(function(){ 
			document.getElementById("before_div").style.display="none";
			document.getElementById("after_div").style.display="block";
		});
		
	});
	
	
	function selType(subType){
		var sub_lec_type=document.getElementsByName("sub_lec_type");
		var live_lec_date=document.getElementsByName("live_lec_date");
		var after_file=document.getElementsByName("after_file");
		var index;
		//현재 인덱스 찾기
		for(var i=0;i<sub_lec_type.length;i++){
			if(sub_lec_type[i].value==subType.value){ index=i;}
		}
		if(subType.value==0){ //녹화강의
			document.getElementsByName("fileDIV")[index].style.display="block";
			document.getElementsByName("dateDIV")[index].style.display="none";
			document.getElementsByName("live_lec_date")[index].value="";
				
		}else if(subType.value==1){ //실시간강의
			document.getElementsByName("fileDIV")[index].style.display="none";
			document.getElementsByName("dateDIV")[index].style.display="block";
			document.getElementsByName("before_file")[index].value="";
			jQuery("#after_file").replaceWith(jQuery("#after_file").clone(true));
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
	function modifyNewFile(sub_lec_code,i){
		document.getElementById("before_fdiv_"+sub_lec_code).style.display="none";
		document.getElementById("after_fdiv_"+sub_lec_code).style.display="block";
		document.getElementsByName("fileState")[i].value="new";
	}
	
	function modifyFile(sub_lec_code,i){
		document.getElementById("before_fdiv_"+sub_lec_code).style.display="block";
		document.getElementById("after_fdiv_"+sub_lec_code).style.display="none";
		jQuery("after_file").replaceWith(jQuery("after_file").clone(true));
		document.getElementsByName("fileState")[i].value="old";
	}
	
	
</script>

<form name="inform" action="/mooc/teacher/classModifyPro.mooc" method="post" encType="multipart/form-data" onsubmit="return submitCheck()">
	<input type="button" value="뒤로" onclick="javascript:location.href='/mooc/teacher/classList.mooc'">
	<input type="reset" value="다시입력">
	<input type="submit" value="수정"><br />
	강의코드 : <input type="text" name="main_lec_code" value="${main_lec_dto.main_lec_code}"/><br />
	강의명 : <input type="text"  name="main_lec_subject" value="${main_lec_dto.main_lec_subject}"/><br />
	<div id="before_div" style='display:block;'>
		강의이미지 :<input type="button"  id="newImgBtn"  value="새 이미지 등록"/>
		<input type="text" name="before_img" value="${main_lec_dto.main_lec_image}" size="50" style="border: 0px;" readonly/>
	</div>
	<div id="after_div" style='display:none;'>
		강의이미지 :<input type="button"  id="originImgBtn" value="기존 이미지로 변경" />
		<input type="file" name="after_img" id="after" style="valign:left;"/>
	</div>
	강의내용 : <br />
	<textArea name="main_lec_content"  rows="6" cols="60">${main_lec_dto.main_lec_content}</textArea><br />
	
	<input type="button" id="add_btn" value="강의추가"/>
	
	<input type="hidden" name="init_count" value="${fn:length(sub_lec_list)}"/>
	<c:forEach var="sub_lec_dto" items="${sub_lec_list}" varStatus="i">
			<table>
				<tr>
					<td rowspan="3">
						<input type="hidden" name="sub_lec_code" value="${sub_lec_dto.sub_lec_code}" />
						<input type="text" name="sub_lec_chapter" value="${sub_lec_dto.sub_lec_chapter}"  size=1  style="border:0px" readonly; />
					</td>
					<td colspan="2">
						<select id="type" name="sub_lec_type" onclick="selType(this)">
							<c:if test="${sub_lec_dto.sub_lec_type!=2}">
								<option>강의유형</option>
								<option value="0" <c:if test="${sub_lec_dto.sub_lec_type==0}">selected</c:if>>녹화</option>
								<option value="1" <c:if test="${sub_lec_dto.sub_lec_type==1}">selected</c:if>>실시간</option>
							</c:if>
							<c:if test="${sub_lec_dto.sub_lec_type==2}">
								<option value="2" <c:if test="${sub_lec_dto.sub_lec_type==2}">selected</c:if>>실시간(완료)</option>
							</c:if>
						</select>
						<input type="text" name="sub_lec_subject" value="${sub_lec_dto.sub_lec_subject}" size="55" placeholder="서브 강의 제목 입력."/>
					</td>
								
					<td rowspan="3"><input type="button" value="삭제" name="del_btn" onclick="delTb(this)"></td>
					
				</tr>
				<tr>
					<td colspan="2">
						
						<c:if test="${sub_lec_dto.sub_lec_type==0||sub_lec_dto.sub_lec_type==2}"><div name="fileDIV" style='display:block;'></c:if>
						<c:if test="${sub_lec_dto.sub_lec_type==1}"><div name="fileDIV"style='display:none;'></c:if>
							<input type="hidden" name="fileState" value="origin">
							<div id="before_fdiv_${sub_lec_dto.sub_lec_code}" style='display:block;'>
								<c:if test="${sub_lec_dto.sub_lec_type==0}"><input type="button" name="newFileBtn" value="동영상 변경" onclick="modifyNewFile('${sub_lec_dto.sub_lec_code}','${i.index}')"/></c:if> 
								<c:if test="${sub_lec_dto.sub_lec_type==2}">동영상: </c:if>
								<input type="text" name="before_file" value="${sub_lec_dto.sub_lec_media }" size="50" style="border:0px;" readonly/>
							</div>
							<div id="after_fdiv_${sub_lec_dto.sub_lec_code}" style='display:none;'>
								<input type="button" name="originFileBtn" value="기존 동영상으로 변경" onclick="modifyFile('${sub_lec_dto.sub_lec_code}','${i.index}')"/>
								<input type="file" name="after_file"/>
							</div>
						</div>
						<c:if test="${sub_lec_dto.sub_lec_type==0}"><div name="dateDIV" style='display:none;'></c:if>
						<c:if test="${sub_lec_dto.sub_lec_type==1||sub_lec_dto.sub_lec_type==2}"><div name="dateDIV" style='display:block;'></c:if>
								<c:if test="${sub_lec_dto.sub_lec_type==2}">강의 날짜: </c:if>
								<input type="text" name="live_lec_date" class="DatePicker" value="${sub_lec_dto.live_lec_date }" placeholder="강의날짜(ex_2016/01/01 20:00)" <c:if test="${sub_lec_dto.sub_lec_type==2}">style="border:0px;" readonly </c:if> />
						</div>	
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<textArea name="sub_lec_content" cols="70" rows="3" placeholder="서브 강의 내용 입력">${sub_lec_dto.sub_lec_content}</textArea>
					</td>
				</tr>
			</table>
			<br />
	</c:forEach>

	
	<div id="div">
    </div>
    
	
</form>