<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script>
	$(document).ready(function() {
		$("#lectureVideo").bind("ended", function() {
			alert("종료");
			 $.ajax({        
	             	url : '/mooc/user_progress_ajax.mooc',
	     		 	type: "post",
	                 data: {  // url 페이지도 전달할 파라미터                                    
	             	    sub_lec_code: '${sub_lec_dto.sub_lec_code}',
	    		 		main_lec_code: '${sub_lec_dto.main_lec_code}'
	                 }	                      
	           });
		});
   		 $("#report").click(function() {
   			var comment=prompt("신고내용","");
             $.ajax({        
             	url : '/mooc/report.mooc',
     		 	type: "post",
                 data: {  // url 페이지도 전달할 파라미터                                    
             	    sub_lec_code: '${sub_lec_dto.sub_lec_code}',
    				t_id: '${sub_lec_dto.t_id}',
    		 		main_lec_code: '${sub_lec_dto.main_lec_code}',
    		 		comment: comment,
                 },
                 success: function(a) {  // 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
              		if(a==0){
              			alert("신고되었습니다.");
              		}else{
              			alert("이미신고된 회원입니다.");
              		}
                 }
                      
             });
    	})

	})
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
	function noteOpen(){
		window.open("/mooc/user/user_image.mooc?sub_lec_code="+${sub_lec_dto.sub_lec_code}, "window", "width=700,height=1000");
	}

	

 
	
</script>
	<c:if test="${sessionScope.memId!=null}">
		<input type="button" value="신고하기" class="btn btn-default" id="report"/>
		<input type="button" class="btn btn-default" value="필기노트"  onclick="noteOpen();">
	</c:if>
	<form name="inform">
		<table class="table" align="center">
		<tr>
			<td colspan="2">
				<h4>${sub_lec_dto.sub_lec_chapter}강 ${sub_lec_dto.sub_lec_subject}</h4>
				<input type="hidden" name="sub_lec_code" value="${sub_lec_dto.sub_lec_code}"/>
			</td>
		</tr>
		<tr>
			<td align="center">
				<video controls poster="demo.jpg" width="700" height="400" id="lectureVideo">
					<source src="\mooc\files${sub_lec_dto.sub_lec_media }" type="video/mp4" />
					<source src="${sub_lec_dto.sub_lec_media }" type="video/webm"/>
					<source src="${sub_lec_dto.sub_lec_media }" type="video/ogg"/>     
					<object>
						<embed src="demo.mp4" type= "application/x-shockwave-flash" allowfullscreen="false" allowscriptaccess="always" />
					</object>
				</video>
			</td>
			<td>
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
								<c:if test="${lec_data_dto.lec_data_type=='일반이미지' ||lec_data_dto.lec_data_type=='PPT' }">
									<a href="/mooc/Download.mooc?fileName=${lec_data_dto.lec_data_path}">다운로드</a>
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
			<td colspan="2">${sub_lec_dto.sub_lec_content}</td>
		</tr>
		</table>
	</form>
