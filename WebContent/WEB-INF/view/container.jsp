<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="jumbotron">
  <div class="container">
    <h1>Hello, MOOC!</h1>
    <p>This is a template for a simple marketing or informational website. It includes a large callout called a jumbotron and three supporting pieces of content. Use it as a starting point to create something more unique.</p>
    <p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more &raquo;</a></p>
  </div>
</div>

<div class="container">
	<div class="row">
		<div class="page-header">
			<h1>Starting Soon! <small>곧 시작되는 실시간 강의</small></h1>
			<a href="#" class="pull-right">실시간 강의 더 보기</a>
		</div>
		<c:forEach	items="${main_liveLecture_List}" var="mll">
			<div class="col-md-4">
				<p><img src="${mll.main_lec_image}" style="width:250px;height:250px"  class="img-rounded"  onclick="location.href='/mooc/viewMainLec.mooc?main_lec_code=${mll.main_lec_code}'" /></p>
			    <h2>${mll.sub_lec_subject}</h2>
			    <p>${mll.sub_lec_content}</p>
			    <p><a class="btn btn-default" href="/mooc/viewMainLec.mooc?main_lec_code=${mll.main_lec_code}" role="button">상세보기 &raquo;</a></p>
		  	</div>
		</c:forEach>  	
	</div>
		
	<div class="page-header"></div>
		
	<div class="row">
		<div class="page-header">
			<h1>Best Courses <small>베스트 강의<small></h1>
			<a href="#" class="pull-right">베스트 강의 더 보기</a>
		</div>
		<c:forEach	items="${main_bestLecture_List}" var="mbl">
			<div class="col-md-4">
				<p><img src="${mbl.main_lec_image}" style="width:250px;height:250px"  class="img-rounded"  onclick="location.href='/mooc/viewMainLec.mooc?main_lec_code=${mbl.main_lec_code}'" /></p>
			    <h2>${mbl.main_lec_subject}</h2>
			    <p>${mbl.main_lec_content}</p>
			    <p><a class="btn btn-default" href="/mooc/viewMainLec.mooc?main_lec_code=${mbl.main_lec_code}" role="button">상세보기 &raquo;</a></p>
		  	</div>
		</c:forEach>
	</div>
	
	<div class="page-header"></div>
	
	<div class="row">
		<div class="page-header">
			<h1>Popular Courses <small>인기 강의<small></h1>
			<a href="#" class="pull-right">인기 강의 더 보기</a>
		</div>
		<c:forEach	items="${main_popularLectureList}" var="mpl">
			<div class="col-md-4">
				<p><img src="${mpl.main_lec_image}" style="width:250px;height:250px"  class="img-rounded"  onclick="location.href='/mooc/viewMainLec.mooc?main_lec_code=${mpl.main_lec_code}'" /></p>
			    <h2>${mpl.main_lec_subject}</h2>
			    <p>${mpl.main_lec_content}</p>
			    <p><a class="btn btn-default" href="/mooc/viewMainLec.mooc?main_lec_code=${mpl.main_lec_code}" role="button">상세보기 &raquo;</a></p>
		  	</div>
		</c:forEach>  	
	</div>
</div>