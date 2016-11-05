<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 

<nav class="navbar navbar-default navbar-inverse navbar-fixed-top" role="navigation">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
			 <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
		</button> <a class="navbar-brand" href="/mooc/admin.mooc">ADMINISTRATOR</a>
	</div>
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
	        <li><a href="/mooc/admin/ctgList.mooc">카테고리 관리</a></li>
	       	
			<li class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown">회원 관리<strong class="caret"></strong></a>
				<ul class="dropdown-menu" role="menu">
					<li><a href="/mooc/admin/userList.mooc">유저 관리</a></li>	
					<li><a href="/mooc/admin/accessList.mooc">휴면계정 관리</a></li>
	                <li><a href="/mooc/admin/blackList.mooc">불량유저 관리</a></li>				               
	        	</ul>
			</li>
			<li class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown">게시판 관리<strong class="caret"></strong></a>
				<ul class="dropdown-menu" role="menu">
	                <li><a href="/mooc/admin/noticeList.mooc">공지사항 관리</a></li>
	                <li><a href="/mooc/admin/qnaList.mooc">문의 관리</a></li>
	        	</ul>
			</li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="/mooc/main.mooc">MOOC</a></li>
		</ul>
	</div>
</nav>