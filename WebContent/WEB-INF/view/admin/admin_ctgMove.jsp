<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>	

jQuery(document).ready(function(){
	$('#top_ctg').change(function(){
		var top_ctg_code=$(this).val();
		$.ajax({
			type: 'post',
			url: "/mooc/getSubCtg.mooc",
			data: {
				top_ctg_code:top_ctg_code
			},			
			success: aa,
			error: bb
		});
	});
	function aa(data){
		var subCtgList=data.split(',');
		$('#sub_ctg').empty().data('options');  // selectbox 초기화
		$('#sub_ctg').append('<option>소분류</option>');   // 첫번째 option 추가
		
		for(var i=0;i<subCtgList.length;i++){
			$('#sub_ctg').append('<option value="'+subCtgList[i]+'">'+subCtgList[i]+'</option>');
		}
	}
	function bb(data){
		alert("소분류 가져오기가 실패하였습니다.");
	}
	
});

	function allCheck(){
		checkbox=document.getElementsByName("checkbox");
		if(form.allcheck.checked){  
			for(var i=0;i<checkbox.length;i++){
				checkbox[i].checked=true;
			}
		}else{
			for(var i=0;i<checkbox.length;i++){
				checkbox[i].checked=false;
			}
		}
	}
	
	function deleteSubCtgs(){
		topUpdateForm.action='/mooc/admin/ctgDelete.mooc';
		topUpdateForm.submit();
		}
	
	function moveSubCtgs(){
		topUpdateForm.action='/mooc/admin/ctgSubMove.mooc';
		topUpdateForm.submit();
		}
	
	function deleteSubCtg_mainLec(c){
		subUpdateForm.action='/mooc/admin/ctgSub_mainLecDelete.mooc?ctg_code='+c;
		subUpdateForm.submit();
		}
	
	function moveSubCtg_mainLec(c){
		subUpdateForm.action='/mooc/admin/ctgSub_mainLecMove.mooc?ctg_code='+c;
		subUpdateForm.submit();
		}
	</script>
	
<form name="form">
	<input type="checkbox" name="allcheck" onclick="allCheck()"/>전체 선택<br />
</form>

<!-- 대분류 삭제 폼  -->

	<c:if test="${subCount!=null && subCount!=0}">
		<form name="topUpdateForm" method="post">
			대분류를 삭제하려면 해당 대분류가 비어있어야 합니다.<br />
			대분류에 포함된 소분류를 먼저 삭제하거나 다른 대분류로 이동해주세요.<br />
				<c:forEach var="c" items="${subCtgList}">
					<input type="checkbox" name="checkbox" value="${c.sub_ctg_code}"/>${c.sub_ctg_name}<br />
				</c:forEach>
			<input type="button" value="삭제" onclick="deleteSubCtgs()"/>
			<select name="top_ctg_code">
				<option>대분류</option>
	   			<c:forEach var="topCtgDto" items="${topCtgList}">
	   				<option value="${topCtgDto.top_ctg_code}">
	   					${topCtgDto.top_ctg_name}
	   				</option>
	   			</c:forEach>
	   		</select>
	   		<input type="hidden" name="tcheck" value="${ctg_code}" />
			<input type="button" value="이동" onclick="moveSubCtgs()"/>
			<input type="button" value="목록" onclick="document.location.href='/mooc/admin/ctgList.mooc'"/>
		</form>
	</c:if>
	

<!-- 소분류 삭제 폼  -->

	<c:if test="${sub_MainLec_Count!=null && sub_MainLec_Count!=0}">
		<form name="subUpdateForm" method="post">
	 		소분류를 삭제하려면 해당 소분류가 비어있어야 합니다.<br />
	 		소분류에 들어있는 강의를 삭제하거나 다른 소분류로 이동해주세요.<br />
			<c:forEach var="m" items="${subCtg_mainLecList}">
				<input type="checkbox" name="checkbox" value="${m.main_lec_code}"/>${m.t_id} : ${m.main_lec_subject}<br />
			</c:forEach>
			<input type="button" value="삭제" onclick="deleteSubCtg_mainLec(${ctg_code})"/>
			<select id="top_ctg" name="top_category">
	 			<option>대분류</option>
	 			<c:forEach var="topCtgDto" items="${topCtgList}">
	  				<option value="${topCtgDto.top_ctg_code }">${topCtgDto.top_ctg_name }</option>
	  			</c:forEach>
	   		</select>
	   		<select id="sub_ctg" name="sub_ctg_name">
	     			<option>소분류</option>
	   		</select>
			<input type="button" value="이동" onclick="moveSubCtg_mainLec(${ctg_code})"/>
			<input type="button" value="목록" onclick="document.location.href='/mooc/admin/ctgList.mooc'"/>
		</form>
	</c:if>
