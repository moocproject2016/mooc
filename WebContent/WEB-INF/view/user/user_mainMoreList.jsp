<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<div class="container">
	<div class="row" id="live">
		<div class="page-header">
			<h1>Starting Soon! <small>곧 시작되는 실시간 강의 TOP 8</small></h1>
		</div>
		<table class="table" align="center">
		
		<c:set var="foot" value="1"/>
		<c:forEach	items="${liveLecture_List}" var="mll">
		<c:if test="${foot==1||foot==5||foot==9}">
			<tr>
		</c:if>
		<td>
			<p><img src="/mooc/files${mll.main_lec_image}" style="width:250px;height:200px"  onclick="location.href='/mooc/viewMainLec.mooc?main_lec_code=${mll.main_lec_code}'" /></p>
		    <h2>${mll.sub_lec_subject}</h2>
		    <p>${mll.sub_lec_content}</p>
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
	
		<div class="row" id="best">
		<div class="page-header">
			<h1>Best Courses <small>베스트 강의 TOP 12</small></h1>
		</div>
		<table class="table" align="center">
		
		<c:set var="foot" value="1"/>
		<c:forEach	items="${bestLecture_List}" var="mbl">
		<c:if test="${foot==1||foot==5||foot==9}">
			<tr>
		</c:if>
		<td>
			<p><img src="/mooc/files${mbl.main_lec_image}" style="width:250px;height:200px"  onclick="location.href='/mooc/viewMainLec.mooc?main_lec_code=${mbl.main_lec_code}'" /></p>
		    <h2>${mbl.main_lec_subject}</h2>
		    <p>${mbl.main_lec_content}</p>
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
	
	
	<div class="row" id="popular">
		<div class="page-header">
			<h1>Popular Courses <small>인기 강의 TOP 12</small></h1>
		</div>
		<table class="table" align="center">
		
		<c:set var="foot" value="1"/>
		<c:forEach	items="${popularLecture_List}" var="mpl">
		<c:if test="${foot==1||foot==5||foot==9}">
			<tr>
		</c:if>
		<td>
			<p><img src="/mooc/files${mpl.main_lec_image}" style="width:250px;height:200px"  onclick="location.href='/mooc/viewMainLec.mooc?main_lec_code=${mpl.main_lec_code}'" /></p>
		    <h2>${mpl.main_lec_subject}</h2>
		    <p>${mpl.main_lec_content}</p>
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