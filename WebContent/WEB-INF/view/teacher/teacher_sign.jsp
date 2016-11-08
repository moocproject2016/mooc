<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
 <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
 <!DOCTYPE html>
 <script>
	function back(){
		history.go(-1);
	}
	window.onload=function(){
		var i=${check}
		if(i==0){
			window.location='/mooc/teacher/teacherProfilePro.mooc?check=1';
		}else if(i==1){
			alert("정지당한강사입니다");
			history.go(-1);
		}else if(i==2){
			window.location='/mooc/teacher/teacherProfilePro.mooc?check=1';
		}
	}
</script>


<center>
	<form action="/mooc/user/teacherinfoPro.mooc" method="post" onsubmit="enter();">
	아이디 ${sessionScope.memId}<br/>
	학력
	<textarea class="form-control" id="t_education" name="t_education" rows="3"></textarea>
	자격증
	<textarea class="form-control" name="t_certificate"  rows="3"></textarea>
	수상내역
	<textarea class="form-control" name="t_prize" rows="3"></textarea>
	보유기술
	<textarea class="form-control" name="t_skill" rows="3"></textarea>
	소개
	<textarea class="form-control" name="t_other" rows="3"></textarea>
	</br>
	<input type="submit" class="btn btn-primary" value="강사시작">
</form>
</center>
