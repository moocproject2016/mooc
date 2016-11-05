<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
    <div id="wrapper">
        <div id="sidebar-wrapper">
			<ul class="sidebar-nav">
				<li class="sidebar-brand"><a href="/mooc/user/myStudy.mooc">My Study</a></li>
	            <li><a href="/mooc/user/lectureList.mooc">강의목록</a></li>
				<li><a href="/mooc/user/planList.mooc">학습계획</a></li>
				<li><a href="/mooc/user/noteList.mooc">필기목록</a></li>
				<li><a href="/mooc/user/likeLectureList.mooc">관심 강의</a></li>
				<li><a href="/mooc/user/likeTeacherList.mooc">관심 강사</a></li>
				<li><a href="/mooc/user/myStgWriter.mooc">내가 쓴 게시글</a></li><br />

				<li><a href="/mooc/user/userDelete.mooc">회원탈퇴하기</a></li>
	        </ul>
		</div>

        <div id="page-content-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                    	<jsp:include page="_user_myStudy_head.jsp" flush="false" />
						<jsp:include page="${user_myStudy_content}" flush="false" />
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
