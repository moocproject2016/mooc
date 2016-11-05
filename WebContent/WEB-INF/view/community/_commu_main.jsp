<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${u_id==null}">
	<script>
        alert("로그인을 해주세요.");
        window.location='/mooc/user/userSign.mooc';
	</script>
</c:if>


<jsp:include page="/WEB-INF/view/common.jsp" flush="false"/>
 
    <jsp:include page="_commu_main_head.jsp" flush="false"/>
    	
	<div id="MainWrap">
		<div id="MainContainer">
			<jsp:include page="${community_main_content}" flush="false"/>
		</div>	
		<div id="MainFoot">
			<jsp:include page="/WEB-INF/view/foot.jsp" flush="false"/>
		</div>
	</div>
	
	
	<script src="/mooc/js/jquery.js"></script>
    <script src="/mooc/js/bootstrap.js"></script>
    <script src="/mooc/js/scripts.js"></script>
   </body>
</html>