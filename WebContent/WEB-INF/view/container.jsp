<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="jumbotron">
  <div class="container">
    <h1>Hello, W-MOOC!</h1>
   <p>W-MOOC(Whoever, Wherever, Whatever Massive Open Online Course)란 온라인을 통해서 누구나, 어디서나, 원하는 강의를 무료로 들을 수 있는 온라인 공개강좌 서비스를 말합니다.</p>
	<p>아울러, 수강인원의 제한없이 누구나 수강이 가능하여, 학습자는 배경지식이 다른 학습자간 지식 공유를 통해 대학의 울타리를 넘어 새로운 학습경험을 하게 될 것입니다.</p>
	</p>
  </div>
</div>
<div class="container">
	<div class="row">
		<div class="page-header">
			<h1>Starting Soon! <small>곧 시작되는 실시간 강의</small></h1>
			<a href="/mooc/user/user_mainMoreList.mooc#live" class="pull-right">실시간 강의 더 보기</a>
		</div>
		<table class="table" align="center">
		
		<c:set var="foot" value="1"/>
		<c:forEach	items="${main_liveLecture_List}" var="mll">
		<c:if test="${foot==1||foot==5||foot==9}">
			<tr>
		</c:if>
		<td>
			<p><img src="/mooc/files${mll.main_lec_image}" style="width:250px;height:200px" onclick="location.href='/mooc/viewMainLec.mooc?main_lec_code=${mll.main_lec_code}'" /></p>
			    <h3>${mll.sub_lec_subject}</h3>
			    ${mll.t_id}
	    	<p><a class="btn btn-default" href="/mooc/viewMainLec.mooc?main_lec_code=${mll.main_lec_code}" role="button">상세보기 &raquo;</a></p>
			  	
		</td>
		
		
		<c:if test="${foot==4||foot==8||foot==12}">
			</tr>
		</c:if>
		<c:set var="foot" value="${foot+1}"/>
		</c:forEach>
	</table>
	</div>
		
	<div class="page-header2"></div>
	
	<div class="row">
		<div class="page-header">
			<h1>Best Courses <small>베스트 강의</small></h1>
			<a href="/mooc/user/user_mainMoreList.mooc#best" class="pull-right">베스트 강의 더 보기</a>
		</div>
		<table class="table" align="center">
		
			<c:set var="foot" value="1"/>
			<c:forEach	items="${main_bestLecture_List}" var="mbl">
			<c:if test="${foot==1||foot==5||foot==9}">
				<tr>
			</c:if>
			<td>
				<p><img src="/mooc/files${mbl.main_lec_image}" style="width:250px;height:200px" onclick="location.href='/mooc/viewMainLec.mooc?main_lec_code=${mbl.main_lec_code}'" /></p>
				    <h3>${mbl.main_lec_subject}</h3>
				    ${mbl.t_id}
			    <p><a class="btn btn-default" href="/mooc/viewMainLec.mooc?main_lec_code=${mbl.main_lec_code}" role="button">상세보기 &raquo;</a></p>
			</td>
			
			<c:if test="${foot==4||foot==8||foot==12}">
				</tr>
			</c:if>
			<c:set var="foot" value="${foot+1}"/>
			</c:forEach>
		</table>
	</div>
		
	<div class="page-header2"></div>
	
	<div class="row">
		<div class="page-header">
			<h1>Popular Courses <small>인기 강의</small></h1>
			<a href="/mooc/user/user_mainMoreList.mooc#popular" class="pull-right">인기 강의 더 보기</a>
		</div>
		<table class="table" align="center">
		
			<c:set var="foot" value="1"/>
			<c:forEach	items="${main_popularLecture_List}" var="mpl">
			<c:if test="${foot==1||foot==5||foot==9}">
				<tr>
			</c:if>
			<td>
				<p><img src="/mooc/files${mpl.main_lec_image}" style="width:250px;height:200px;" onclick="location.href='/mooc/viewMainLec.mooc?main_lec_code=${mpl.main_lec_code}'" /></p>
			    <h3>${mpl.main_lec_subject}</h3>
			    ${mpl.t_id}
			    <p><a class="btn btn-default" href="/mooc/viewMainLec.mooc?main_lec_code=${mpl.main_lec_code}" role="button">상세보기 &raquo;</a></p>
		  	</td>
			
			<c:if test="${foot==4||foot==8||foot==12}">
				</tr>
			</c:if>
			<c:set var="foot" value="${foot+1}"/>
			</c:forEach>
		</table>
	</div>
</div>