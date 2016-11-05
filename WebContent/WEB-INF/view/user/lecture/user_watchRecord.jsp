<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script>
	$(document).ready(function() {
		
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
		var lec_data_path=document.inform.lec_data_path[x-1].value;
		var lec_data_type=document.inform.lec_data_type[x-1].value;
		var url="/mooc/teacher/viewData.mooc?lec_data_path="+lec_data_path;
		if(lec_data_type=="일반이미지"){
			open(url,"일반이미지","width=400,height=250");
		}else if(lec_data_type=="참조사이트"){
			alert(lec_data_path);
			open(lec_data_path,"참조사이트");
		}else if(lec_data_type=="3D이미지"){
			open(lec_data_path,"3D이미지");
		}else if(lec_data_type=="PPT"){
			open(url,"PPT");
		}
	}

	

 
	
</script>
	<input type="button" class="btn btn-default" value="뒤로" onclick="javascript:location.href='${beforePage}'"/>
	<c:if test="${sessionScope.memId!=null}">
		<input type="button" value="신고하기" class="btn btn-default" id="report"/>
		<input type="button" class="btn btn-default" value="필기노트">
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
				<video controls poster="demo.jpg" width="900" height="500">
					<source src="${sub_lec_dto.sub_lec_media }" type="video/mp4" />
					<source src="${sub_lec_dto.sub_lec_media }" type="video/webm"/>
					<source src="${sub_lec_dto.sub_lec_media }" type="video/ogg"/>     
					<object>
						<embed src="demo.mp4" type= "application/x-shockwave-flash" allowfullscreen="false" allowscriptaccess="always" />
					</object>
				</video>
			</td>
			<td>
				<div style="overflow-y:scroll; width:100%; height:350; padding:4px" >
					<h3>강의자료</h3>
					<c:forEach var="lec_data_dto" items="${lec_data_list}" varStatus="i">
						<a href="javascript:void();" onclick="viewData('${i.count}')">${lec_data_dto.lec_data_name}</a>
						<br />
						<input type="hidden" name="lec_data_code" value="${lec_data_dto.lec_data_code}"/>
						<input type="hidden" name="lec_data_type" value="${lec_data_dto.lec_data_type}"/>
						<input type="hidden" name="lec_data_path" value="${lec_data_dto.lec_data_path}"/>
						
					</c:forEach>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">${sub_lec_dto.sub_lec_content}</td>
		</tr>
		</table>
	</form>
