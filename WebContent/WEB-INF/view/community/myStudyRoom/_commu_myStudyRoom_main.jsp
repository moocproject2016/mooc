<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <script>
function myFunction(i) {
	var u_id=document.getElementById("u_id").value;
	var u_name=document.getElementById("u_name").value;
	cw=screen.availWidth;
	ch=screen.availHeight;
	test=window.open('https://192.168.30.107:9001/doStartCon.html?stg_code='+i+'&u_id='+u_id+'&u_name='+encodeURI(encodeURIComponent(u_name)),'_blank','width='+cw+',height='+ch+',resizable=no,scrollbars=yes');
}
</script>

	
	<input type="hidden" id="u_id" name="u_id" value="${sessionScope.memId}"/>
	<input type="hidden" id="u_name" name="u_name" value="${sessionScope.memName}"/>
    <div id="wrapper">
        <div id="sidebar-wrapper">
			<ul class="sidebar-nav">
				<li class="sidebar-brand"><a href="/mooc/study/myStudyRoomMain.mooc?stg_code=${sessionScope.code}">${stg_code}/ StudyRoom</a></li>
	            <li><a href="/mooc/study/myStudyBoardList.mooc">게시판</a></li>
				<li><a onclick="myFunction(${stg_code})">회의방</a></li>
	        </ul>
		</div>

        <div id="page-content-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                    	<jsp:include page="_commu_myStudyRoom_head.jsp" flush="false" />
						<jsp:include page="${commu_myStudy_content}" flush="false" />
					</div>
                </div>
            </div>
        </div>
    </div>

		<script src="/mooc/js/jquery.js"></script>
	    <script src="/mooc/js/scripts.js"></script>

    <script>
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });
    </script>

</body>

</html>
