<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script type="text/javascript" src="jquery.simple-dtpicker.js"></script>
	<link type="text/css" href="jquery.simple-dtpicker.css" rel="stylesheet" />
	<script type="text/javascript">
	jQuery(document).ready(function(){
		$(".DatePicker").appendDtpicker();	
	});
	
	</script>
	<form action="testPro.mooc" method="post">
		<input type="text" name="num" id="add_btn" value="1">
		<input type="text" name="regdate" disabled="disabled" class="DatePicker" value="">
		<input type="submit">
	</form>
