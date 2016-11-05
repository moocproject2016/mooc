<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
        
<c:if test="${u_id==null}">
	<script>
        alert("로그인을 해주세요.");
        window.location='/mooc/user/userSign.mooc';
	</script>
</c:if>
        
<c:if test="${u_id!=null}">

<div class="tableWrap">  
<form action="/mooc/user/user_modifyPro.mooc" method="post" onsubmit="checksub();">
	<table class="signTable" align="center">
	<thead>
		<tr height="100px">
			<td align="center">
		    	<div class="form-group">
	    			${dto.u_id}
		  		</div>
		  	</td>
		</tr>
	</thead>
  		<tr>
  			<td align="center">
  			<h4>Change Password</h4>
		    	<div class="form-group">
		    		<input type="password" value="" name="u_pw" class="form-control" id="exampleInputPassword1" placeholder="New Password" style="width:20%">
		    		<input type="password" name="confirm" class="form-control" id="exampleInputPassword1" placeholder="Verify Password" style="width:20%">
		  		</div>
		  	</td>
		</tr>
		<tr>
			<td align="center">	
				<h4>Basic Information</h4>	 
		  		<div class="form-group">
		    		<input type="text" value="${dto.u_name}" name="u_name" class="form-control" id="exampleInputPassword1" placeholder="이름" style="width:20%">
		  		</div>
		  	</td>
		</tr>
		<tr height="150px">
			<td align="center">
				<button type="submit" class="btn btn-default">개인정보 변경</button>
		  	</td>
		</tr>
	</table>
</form>
</div> 
</c:if>