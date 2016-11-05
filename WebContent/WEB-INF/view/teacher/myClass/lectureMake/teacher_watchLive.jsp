<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script>
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
		if(lec_data_type=="�Ϲ��̹���"){
			open(url,"�Ϲ��̹���");
		}else if(lec_data_type=="��������Ʈ"){
			open("http://"+lec_data_path,"��������Ʈ");
		}else if(lec_data_type=="3D�̹���"){
			open("http://"+lec_data_path,"3D�̹���");
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
</script>
<div class="tableWrap">
	<form name="inform" action="/mooc/teacher/modifyLiveLec.mooc" method="post" onsubmit="return submitCheck()"  encType="multipart/form-data">
	<input type="hidden" name="currentPage" value="${beforePage}"/>
	<input type="hidden" name="main_lec_code" value="${sub_lec_dto.main_lec_code }"/>
	<c:if test="${state==0}">
		<input type="button" value="�ڷ�" onclick="javascript:location.href='/mooc/teacher/subLecture_list.mooc?main_lec_code=${sub_lec_dto.main_lec_code}'"/>
		<input type="button" value="����" onclick="javascript:location='/mooc/teacher/watch.mooc?sub_lec_code=${sub_lec_dto.sub_lec_code}&state=1'"/>
	</c:if>
	<c:if test="${state==1}"><input type="button" value="���" onclick="javascript:location='/mooc/teacher/watch.mooc?sub_lec_code=${sub_lec_dto.sub_lec_code}&state=0'"/><input type="submit" value="��������"/></c:if>
	<c:if test="${state==0}"><input type="button" value="�ڷ�÷��" onclick="uploadFile()"/></c:if>
		<table class="table" style="width:100%;">
		<tr>
			<td colspan="2">
				<h4>Chapter <input type="text" name="sub_lec_chapter" value="${sub_lec_dto.sub_lec_chapter}" size="1" style="border:0px;" readonly/>
				<input type="text" name="sub_lec_subject" value="${sub_lec_dto.sub_lec_subject}" <c:if test="${state==0}">style="border:0px;" readonly</c:if>/></h4>
				<input type="hidden" name="sub_lec_code" value="${sub_lec_dto.sub_lec_code}"/>
			</td>
		</tr>
		<tr>
			<td>
				<c:if test="${sub_lec_dto.sub_lec_type==2}">
					<c:set var="mediaArray" value="${fn:split(sub_lec_dto.sub_lec_media,',')}"/>
					<c:forEach var="sub_lec_media" items="${mediaArray}">
						<video controls poster="demo.jpg" width="700" height="400" autoplay preload="auto">
						<source src="\mooc\files${sub_lec_media }" type="video/mp4" />
						<source src="\mooc\files${sub_lec_media }" type="video/webm"/>
						<source src="\mooc\files${sub_lec_media }" type="video/ogg"/>     
						<object>
							<embed src="demo.mp4" type= "application/x-shockwave-flash" allowfullscreen="false" allowscriptaccess="always" />
						</object>
						</video>
					</c:forEach>
				</c:if>
				<!-- ���� �ڸ� -->
			</td>
			<td width="250px">
				<div style="overflow-y:scroll; width:250; height:350; padding:4px" >
					<c:forEach var="lec_data_dto" items="${lec_data_list}" varStatus="i">
						<div id="div_${i.index}">
							<c:if test="${lec_data_dto.lec_data_type=='�Ϲ��̹���'}">
								<a href="javascript:void();" onclick="viewData('${i.count}')"><img src="/mooc/files${lec_data_dto.lec_data_path}"  width="50" height="50" style="border-radius: 10px;"/></a>
							</c:if>
							<c:if test="${lec_data_dto.lec_data_type=='PPT'}">
								<a href="javascript:void();" onclick="viewData('${i.count}')"><img src="/mooc/images/teacher/ppt_Default.png" width="50" height="50"/></a>
							</c:if>
							<c:if test="${lec_data_dto.lec_data_type=='��������Ʈ' ||lec_data_dto.lec_data_type=='3D�̹���' }">
								<a href="javascript:void();" onclick="viewData('${i.count}')">${lec_data_dto.lec_data_path}</a>
							</c:if>
							<c:if test="${state==1}"><input type="button" value="x" width="1" height="1" onclick="delData('${i.index}')"/></c:if>
							<c:if test="${state==0}">
								<c:if test="${lec_data_dto.lec_data_type=='�Ϲ��̹���' ||lec_data_dto.lec_data_type=='PPT' }">
									<a href="/mooc/Download.mooc?fileName=${lec_data_dto.lec_data_path}">�ٿ�ε�</a>
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