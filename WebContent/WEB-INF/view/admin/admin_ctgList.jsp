<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">

	function go_url(i){
		if(i==0){window.location="/mooc/admin/ctgList.mooc"}
		else{
		window.location="/mooc/admin/ctgList.mooc?ctg_code="+i;}
	}
	
	function allCheck(){
		checkbox=document.getElementsByName("checkbox");
		if(formCheck.allcheck.checked){  
			for(var i=0;i<checkbox.length;i++){
				checkbox[i].checked=true;
			}
		}else{
			for(var i=0;i<checkbox.length;i++){
				checkbox[i].checked=false;
			}
		}
	}
	
	function selectCheck(){
		var state=false;
		if(updateForm.checkbox.checked==true){state=true;}
		for(var i=0;i<updateForm.checkbox.length;i++){
			if(updateForm.checkbox[i].checked==true){ state=true; }
		}
		return state;
	}
	function displayTop(){
		content = document.getElementById("topCtgInsertForm")
		if(content.style.display=="none"){
			content.style.display="block";
		}else{
			content.style.display="none";
		}
	}
	function displaySub(){
		content = document.getElementById("subCtgInsertForm")
		if(content.style.display=="none"){
			content.style.display="block";
		}else{
			content.style.display="none";
		}
	}

	function modifySubCtg(){
		updateForm.action='/mooc/admin/ctgSubModify.mooc';
		updateForm.submit();
	}

	function deleteSubCtgList(){
		updateForm.action='/mooc/admin/ctgDelete.mooc';
		updateForm.submit();
	}
	
	function insertTopCtg(){insertTopForm.submit();}
	
	function insertSubCtg(){insertSubForm.submit();}
		
	function inputTopCtg(){
		$("#topInput").append('<input type="text" name="top_ctg_name" />');
		}
	
	function inputSubCtg(){
		$("#subInput").append('<input type="text" name="sub_ctg_name" />');
		}
	
	function modifyTopCtg(){
		updateTopForm.action='/mooc/admin/ctgTopModify.mooc';
		updateTopForm.submit();
		}
	
	function moveSubCtgs(){
		checkbox=document.getElementsByName("checkbox")
		c = '';
		for(var i=0;i<checkbox.length;i++){
			if(checkbox[i].checked){
				c = c + 'checkbox='+ checkbox[i].value;
				if(i!=checkbox.length-1){c += '&';}
			}
		}
		moveForm.action='/mooc/admin/ctgSubMove.mooc?'+c;
		moveForm.submit(); 
		}

</script>
<c:if test="${x!=null}">
	<script>
		alert("검색 결과가 없습니다");
	</script>
</c:if>
<div class="section">
	<div class="leftTable30">
		<jsp:include page="admin_ctgWrite.jsp" flush="false"/>
	</div>
	<div class="rightTable70">
		<jsp:include page="admin_ctgModify.jsp" flush="false"/>
	</div>
</div>