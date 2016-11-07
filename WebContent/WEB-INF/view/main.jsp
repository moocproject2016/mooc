<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<jsp:include page="common.jsp" flush="false" />
	<body>
		<jsp:include page="head.jsp" flush="false" />
	   	<div id="MainWrap">
			<div id="MainContainer">
				<jsp:include page="${main_content}" flush="false"/>
			</div>	
			<div id="MainFoot">  
				<jsp:include page="foot.jsp" flush="false"/>
			</div>
		</div>
			<script src="/mooc/js/jquery.js"></script>
		    <script src="/mooc/js/bootstrap.js"></script>
		    <script src="/mooc/js/scripts.js"></script>
		    
	</body>
	<script src="/mooc/js/jquery.simple-dtpicker.js"></script>
	<link type="text/css" href="/mooc/css/jquery.simple-dtpicker.css" rel="stylesheet" />
