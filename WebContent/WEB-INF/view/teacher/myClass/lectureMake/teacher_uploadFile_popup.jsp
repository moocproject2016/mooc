<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script>
	jQuery(document).ready(function(){
		$('#dataType').change(function(){
			var type=$("#dataType option:selected").val();
			if(type=="PPT" ||type=="일반이미지"){ 
				document.getElementById("urlDiv").style.display="none";
				document.getElementById("fileDiv").style.display="block";
			}else if(type=="3D이미지"||type=="참조사이트"){
				document.getElementById("fileDiv").style.display="none";
				document.getElementById("urlDiv").style.display="block";
			}
		});
	});
</script>
<div class="tableWrap">
	<table class="table" align="center">
		<tr><td>
				<h2>강의 자료 업로드</h2>
		</td></tr>
		<tr><td>
			<c:if test="${state==0 }">
			    <form name="inform" action="/mooc/teacher/uploadFilePro.mooc" method="post" encType="multipart/form-data">
			    	<input type="text" name="sub_lec_code" value="${sub_lec_code}"/>
			    	<select name="lec_data_type" id="dataType">
			    		<option>자료종류</option>
			    		<option value="PPT">PPT</option>
			    		<option value="일반이미지">일반이미지</option>
			    		<option value="3D이미지">3D이미지</option>
			    		<option value="참조사이트">참조사이트</option>
			    	</select>
			    	<div id="fileDiv" style="display:none;"><input type="file" name="save"/></div>
			    	<div id="urlDiv" style="display:none;">
			    		<input type="text" name="lec_data_path" size="40" placeholder="www.example.com or p3d.in/e0Hp3"/>
			    		*3D이미지 갤러리 사이트 : <a href="http://p3d.in" target="_blank">p3d.in</a>
			    	</div>
			    	<br /><center><input type="submit" value="업로드"/></center>
			    </form>
			</c:if>
			<c:if test="${state==1 }">
				<script>
					alert("파일 등록 성공!");
					self.close();
					opener.document.location.reload();  
				</script>
			</c:if>
		</td></tr>
	</table>
</div>