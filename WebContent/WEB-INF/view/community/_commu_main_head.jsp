<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
			<span class="sr-only">Toggle navigation</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="/mooc/community.mooc">COMMUNITY</a>
	</div>
	<div id="navbar" class="navbar-collapse collapse">
		<ul class="nav navbar-nav">
			<li class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown">스터디 채널<strong class="caret"></strong></a>
				<ul class="dropdown-menu" role="menu">
					<ul class="dropdown-ctg" role="menu">
	                <c:forEach var="topCtgDTO" items="${topCtgList}">
	                	<ul class="dropdown-menu-menu">
							<li class="dropdown-header"><a href="#">${topCtgDTO.top_ctg_name}</a></li>
							<c:forEach var="subCtgDTO" items="${subCtgList}">
								<c:if test="${topCtgDTO.top_ctg_code==subCtgDTO.top_ctg_code}">
									<li><a href="/mooc/study/studylist.mooc?sub_ctg_code=${subCtgDTO.sub_ctg_code}">${subCtgDTO.sub_ctg_name }</a></li>
								</c:if>
							</c:forEach>
						</ul>	
					</c:forEach>
					</ul>
	        	</ul>
			</li>
	        <li><a href="/mooc/study/StudyWrite.mooc">스터디 만들기</a></li>
	        <li><a href="/mooc/study/myStudyList.mooc">나의 스터디 목록</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<c:if test="${sessionScope.memId!=null }">
				<li class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown"><b>${u_name}님</b><strong class="caret"></strong></a>
					<ul class="dropdown-menu" role="menu">
						<ul class="dropdown-subTap" role="menu">
						<ul class="dropdown-menu-menu">
						<p><b>스터디 바로가기</b></p>
							<c:forEach var="stglist" items="${mystudylist_main}" varStatus="i">
								<li><a href="/mooc/study/myStudyRoomMain.mooc?stg_code=${stglist.stg_code}">${stglist.stg_name}</a></li>
							</c:forEach>
						</ul>
					</ul>
						
		        	</ul>
				</li>
			</c:if>
			<li><a href="/mooc/main.mooc">MOOC</a></li>
		</ul>
	</div>
</nav>