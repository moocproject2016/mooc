<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
                        
	<h3>최근 게시물</h3>
	<ul class="nav nav-tabs">
		<li class="active"><a data-toggle="tab" href="#home">알림</a></li>
		<li><a data-toggle="tab" href="#menu1">강의 공지사항</a></li>
		<li><a data-toggle="tab" href="#menu3">문의 답변</a></li>
	</ul>

	<div class="tab-content">
		<div id="home" class="tab-pane fade in active">
			<li class="more">› <a href="#">알림 더보기</a></li>
			<li>목록1</li>
			<li>목록2</li>
			<li>목록3</li>
	    </div>
		<div id="menu1" class="tab-pane fade">
			<li class="more">› <a href="#">강의 공지사항 더보기</a></li>
			<li>목록1</li>
			<li>목록2</li>
			<li>목록3</li>
	    </div>
	    <div id="menu3" class="tab-pane fade">
			<li class="more">› <a href="#">문의 답변 더보기</a></li>
			<li>목록1</li>
			<li>목록2</li>
			<li>목록3</li>
	    </div>
	</div>
