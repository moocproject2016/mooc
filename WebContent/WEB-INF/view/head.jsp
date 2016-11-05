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
		<a class="navbar-brand" href="/mooc/main.mooc">MOOC</a>
	</div>
	<div id="navbar" class="navbar-collapse collapse">
		<ul class="nav navbar-nav">
			<li class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown">카테고리<strong class="caret"></strong></a>
				<ul class="dropdown-menu" role="menu">
					<ul class="dropdown-ctg" role="menu">
					<c:forEach var="topCtgDTO" items="${topCtgList}">
						<ul class="dropdown-menu-menu">
							<li class="dropdown-header"><a href="#">${topCtgDTO.top_ctg_name}</a></li>
							<c:forEach var="subCtgDTO" items="${subCtgList}">
								<c:if test="${topCtgDTO.top_ctg_code==subCtgDTO.top_ctg_code}">
									<li class="dropdown-sub"><a href="/mooc/user/user_lectureList.mooc?sub_ctg_code=${subCtgDTO.sub_ctg_code }">${subCtgDTO.sub_ctg_name }</a></li>
								</c:if>
							</c:forEach>
						</ul>
					</c:forEach>
					</ul>
				</ul>
			</li>
		</ul>
		<form class="navbar-form navbar-left" action="/mooc/user/user_categorySearchList.mooc" role="search">
			<div class="form-group">
				<input type="hidden" name="recentlyList">
				<input type="text" class="search-form-control" name="mainSearchValue" placeholder="배우고 싶은 것을 검색하세요!">
                <button class="btn btn-default btn-primary" type="submit"><img src="/mooc/images/user/search_icon.png"></button>
			</div>
		</form>
		<ul class="nav navbar-nav navbar-right">
			<c:if test="${sessionScope.memId!=null }">
				<li><a><b>${u_name}님</b></a></li>
				<li><a href="/mooc/logout.mooc">LOGOUT</a></li>
			</c:if>
			<li><a href="/mooc/admin.mooc">ADMIN</a></li>
			<li><a href="/mooc/community.mooc">COMMUNITY</a></li>
			<c:if test="${sessionScope.memId==null }"><li><a href="/mooc/user/userSign.mooc">SIGN IN</a></li></c:if>
			<c:if test="${sessionScope.memId!=null }">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">User<strong class="caret"></strong></a>
					<ul class="dropdown-menu">
						<li><a href="/mooc/user/myStudy.mooc">MyStudy</a></li>
						<li><a href="/mooc/user/userProfile.mooc">Setting</a></li>
					</ul>
				</li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">Teacher<strong class="caret"></strong></a>
					<ul class="dropdown-menu">
						<li><a href="/mooc/teacher/myClass.mooc">MyClass</a></li>
						<li><a href="/mooc/teacher/teacherProfile.mooc">Profile</a></li>
					</ul>
				</li>
			</c:if>
		</ul>
	</div>
</nav>
