<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.memId==null }">
	<script>
		alert("로그인이 필요합니다.");
		location.href="/mooc/user/userSign.mooc";
	</script>
</c:if>
<c:if test="${sessionScope.memId!=null }">	
    <div id="wrapper">
        <div id="sidebar-wrapper">
			<ul class="sidebar-nav">
				<li class="sidebar-brand"><a href="/mooc/teacher/myClass.mooc">My Class</a></li>
	            <li><a href="/mooc/teacher/classWrite.mooc">새 강의 업로드</a></li>
	            <li><a href="/mooc/teacher/classList.mooc">강의 관리</a></li>
	            <li><a href="/mooc/teacher/studentList.mooc">수강생 관리</a></li>
				<li><a href="/mooc/teacher/noticeList.mooc">강의 공지관리</a></li>
				<li><a href="/mooc/teacher/qnaList.mooc">학생 질의관리</a></li>
				<li><a href="/mooc/teacher/reviewList.mooc">강의 후기목록</a></li><br />
				<li><a href="/mooc/teacher/teacherDelete.mooc">강사 탈퇴하기</a></li>
	        </ul>
		</div>

        <div id="page-content-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                    	<jsp:include page="_teacher_myClass_head.jsp" flush="false" />
						<jsp:include page="${teacher_myClass_content}" flush="false" />
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

</c:if>