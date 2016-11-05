<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/view/common.jsp" flush="false"/>
 
    <jsp:include page="_admin_main_head.jsp" flush="false"/>
    	
   	<div id="admin_MainWrap">
		<div class="admin_MainContainer">
			<jsp:include page="${admin_main_content}" flush="false"/>
		</div>	
	</div>
	
	<script src="/mooc/js/jquery.js"></script>
    <script src="/mooc/js/bootstrap.js"></script>
    <script src="/mooc/js/scripts.js"></script>
   </body>
</html>