<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script>
var first=0;
$(document).ready(function(){
callAjax();
window.setInterval(callAjax, 10000);
	});
function callAjax(){
		$.ajax({	
		url : '/mooc/user/new_alram.mooc',
		type : "post",
		success : test
	});
}


function test(a)
{
	var j='<a href="/mooc/user/AlramPage.mooc" id="jungman">Alram</span></a>';
	if(a==1){
		if(first==0){
			first=1;
			
		}
		j='<a href="/mooc/user/AlramPage.mooc" id="jungman">Alram <b><font color="red">●</font></b></a>';
	}else{
		first=0;
		j='<a href="/mooc/user/AlramPage.mooc" id="jungman">Alram</span></a>';
	}
	 $('#clearz').html(j);
}
function  search_blank_check(){
	if (document.getElementById('searchForm').value == null || document.getElementById('searchForm').value == "") {
        alert("검색어를 입력하세요");
        return false;
    }

}
</script>
   <nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
			<span class="sr-only">Toggle navigation</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="/mooc/main.mooc">W-MOOC</a>
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
		<form class="navbar-form navbar-left" action="/mooc/user/user_categorySearchList.mooc" role="search" onsubmit="return search_blank_check();">
			<div class="form-group">
				<input type="hidden" name="recentlyList">
				<input type="text" id="searchForm" class="search-form-control" name="mainSearchValue" placeholder="배우고 싶은 것을 검색하세요!">
                <button class="btn btn-default btn-primary"  type="submit" ><img src="/mooc/images/user/search_icon.png"></button>
			</div>
		</form>
		<ul class="nav navbar-nav navbar-right">
			<c:if test="${sessionScope.memId!=null }">
				<li><a><b>${u_name}님</b></a></li>
				<li><a href="/mooc/logout.mooc">LOGOUT</a></li>
			</c:if>
			<c:if test='${t_idCount==2}'>
				<li><a href="/mooc/admin.mooc">ADMIN</a></li>
			</c:if>
			<li><a href="/mooc/community.mooc">COMMUNITY</a></li>
			<c:if test="${sessionScope.memId==null }"><li><a href="/mooc/user/userSign.mooc">SIGN IN</a></li></c:if>
			<c:if test="${sessionScope.memId!=null }">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">User<strong class="caret"></strong></a>
					<ul class="dropdown-menu">
						<li id="clearz">
							<c:if test="${sessionScope.alram==1 && sessionScope.memId != null}">
							<a href="/mooc/user/AlramPage.mooc"> Alram &nbsp;&nbsp;&nbsp;<b>new<font color="red">♥</font></b></a>
							</c:if>
							<c:if test="${sessionScope.alram==0 && sessionScope.memId != null}">
							<a href="/mooc/user/AlramPage.mooc"> Alram</span></a>
							</c:if>
						</li>
						<li><a href="/mooc/user/myStudy.mooc">MyStudy</a></li>
						<li><a href="/mooc/user/userProfile.mooc">Setting</a></li>
					</ul>
				</li>
				<c:if test="${t_idCount==1||t_idCount==2}">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">Teacher<strong class="caret"></strong></a>
						<ul class="dropdown-menu">
							<li><a href="/mooc/teacher/myClass.mooc">MyClass</a></li>
							<li><a href="/mooc/teacher/teacherProfile.mooc">Profile</a></li>
						</ul>
					</li>
				</c:if>
			</c:if>
		</ul>
	</div>
</nav>
