<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script>
	jQuery(document).ready(function(){
		$('#orgingFileBtn').click(function(){ 
			document.getElementById("before_div").style.display="block";
			document.getElementById("after_div").style.display="none";
			jQuery("#after").replaceWith(jQuery("#after").clone(true));
		});
		
		$('#delFileBtn').click(function(){ 
			document.getElementById("before_div").style.display="none";
			document.getElementById("after_div").style.display="block";
		});
	});
	function uploadFile(){
		var url="/mooc/teacher/uploadFile.mooc?sub_lec_code="+document.inform.sub_lec_code.value;
		open(url,"post","toolbar=no ,width=300,height=200,directories=no,status=yes,scrollbars=yes,menubar=no");
	}
	function viewData(x){
		var lec_data_path="";
		var lec_data_type=0;
		lec_data_path=document.getElementsByName("lec_data_path")[x-1].value;
		lec_data_type=document.getElementsByName("lec_data_type")[x-1].value;
		
		var url="/mooc/teacher/viewData.mooc?lec_data_path="+lec_data_path;
		if(lec_data_type=="일반이미지"){
			open(url,"일반이미지");
		}else if(lec_data_type=="참조사이트"){
			open("http://"+lec_data_path,"참조사이트");
		}else if(lec_data_type=="3D이미지"){
			open("http://"+lec_data_path,"3D이미지");
		}else if(lec_data_type=="PPT"){
			open(url,"PPT");
		}
	}
	function delData(x){
		var el=document.createElement("input");
		el.type="hidden";
		el.name="deleteData";
		el.value=document.getElementsByName("lec_data_code")[x].value;
		document.inform.appendChild(el);
		$('#div_'+x).remove();
	}
	function submitCheck(){
		if(document.getElementById("after_div").style.display=="none"){ // 기존 파일 그대로 일때
			alert("기존파일 그대로");
			document.inform.getElementById("after").select();
			document.inform.selection.clear();
		}else if(document.getElementById("before_div").style.display=="none"){
			alert("새로운 파일로");
		}
	}
</script>
<div class="tableWrap">
	<form name="inform" action="/mooc/teacher/modifyRecordLec.mooc" method="post" onsubmit="return submitCheck()"  encType="multipart/form-data">
	<input type="hidden" name="currentPage" value="${beforePage}"/>
	<input type="hidden" name="main_lec_code" value="${sub_lec_dto.main_lec_code }"/>
	<c:if test="${state==0}">
		<input type="button" value="뒤로" onclick="javascript:location.href='/mooc/teacher/subLecture_list.mooc?main_lec_code=${sub_lec_dto.main_lec_code}'"/>
		<input type="button" value="편집" onclick="javascript:location='/mooc/teacher/watch.mooc?sub_lec_code=${sub_lec_dto.sub_lec_code}&state=1'"/>
	</c:if>
	<c:if test="${state==1}"><input type="button" value="취소" onclick="javascript:location='/mooc/teacher/watch.mooc?sub_lec_code=${sub_lec_dto.sub_lec_code}&state=0'"/><input type="submit" value="변경저장"/></c:if>
	<c:if test="${state==0}"><input type="button" value="자료첨부" onclick="uploadFile()"/></c:if>
		<table class="table" style="width:100%;">
		<tr>
			<td colspan="2">
				<h4>Chapter <input type="text" name="sub_lec_chapter" value="${sub_lec_dto.sub_lec_chapter}" size="1" style="border:0px;" readonly/>
				<input type="text" name="sub_lec_subject" value="${sub_lec_dto.sub_lec_subject}" <c:if test="${state==0}">style="border:0px;" readonly</c:if>/></h4>
				<input type="hidden" name="sub_lec_code" value="${sub_lec_dto.sub_lec_code}"/>
			</td>
		</tr>
		<tr>
			<td>${sub_lec_dto.sub_lec_media}
				<c:if test="${state==1}">
					<div id="before_div" style='display:block;'>
						<input type="button"  id="delFileBtn" value="파일삭제" />
						<input type="text" name="before_file" value="${sub_lec_dto.sub_lec_media}" style="border: 0px; width: auto;" readonly/>
					</div>
					<div id="after_div" style='display:none;'>
						<input type="button" id="orgingFileBtn" value="기존 파일로 변경" />
						<input type="file" name="after_file" id="after"/>
					</div>
				</c:if>
				<video controls poster="demo.jpg" width="700" height="400">
					<source src="\mooc\files${sub_lec_dto.sub_lec_media }" type="video/mp4" />
					<source src="${sub_lec_dto.sub_lec_media }" type="video/webm"/>
					<source src="${sub_lec_dto.sub_lec_media }" type="video/ogg"/>     
					<object>
						<embed src="demo.mp4" type= "application/x-shockwave-flash" allowfullscreen="false" allowscriptaccess="always" />
					</object>
				</video>
			</td>
			<td width="250px">
				<div style="overflow-y:scroll; width:250; height:350; padding:4px" >
					<c:forEach var="lec_data_dto" items="${lec_data_list}" varStatus="i">
						<div id="div_${i.index}">
							<c:if test="${lec_data_dto.lec_data_type=='일반이미지'}">
								<a href="javascript:void();" onclick="viewData('${i.count}')"><img src="/mooc/files${lec_data_dto.lec_data_path}"  width="50" height="50" style="border-radius: 10px;"/></a>
							</c:if>
							<c:if test="${lec_data_dto.lec_data_type=='PPT'}">
								<a href="javascript:void();" onclick="viewData('${i.count}')"><img src="/mooc/images/teacher/ppt_Default.png" width="50" height="50"/></a>
							</c:if>
							<c:if test="${lec_data_dto.lec_data_type=='참조사이트' ||lec_data_dto.lec_data_type=='3D이미지' }">
								<a href="javascript:void();" onclick="viewData('${i.count}')">${lec_data_dto.lec_data_path}</a>
							</c:if>
							<c:if test="${state==1}"><input type="button" value="x" width="1" height="1" onclick="delData('${i.index}')"/></c:if>
							<c:if test="${state==0}">
								<c:if test="${lec_data_dto.lec_data_type=='일반이미지' ||lec_data_dto.lec_data_type=='PPT' }">
									<a href="/mooc/Download.mooc?fileName=${lec_data_dto.lec_data_path}">다운로드</a>
								</c:if>	
							</c:if>
							<br />
							
							<input type="hidden" name="lec_data_code" value="${lec_data_dto.lec_data_code}"/>
							<input type="hidden" name="lec_data_type" value="${lec_data_dto.lec_data_type}"/>
							<input type="hidden" name="lec_data_path" value="${lec_data_dto.lec_data_path}"/>
						</div>
					</c:forEach>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
			<textArea name="sub_lec_content" cols="100" rows="3" <c:if test="${state==0}">style="border:0px;" readonly</c:if>>${sub_lec_dto.sub_lec_content}</textArea>
	
		</tr>
		</table>
	</form>
</div>