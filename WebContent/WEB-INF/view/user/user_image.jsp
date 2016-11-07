<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>


 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
 <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<!DOCTYPE html>

    <style>
      #myCanvas {
         cursor: pointer;
         background-image:url(${fileS});
         background-repeat:no-repeat;
         background-size:100% 100%; 
      }

    </style>
    <nav class="navbar navbar-inverse">
  		<div class="container-fluid">
    		<div class="navbar-header">
    		 <form class="navbar-form navbar-left" role="search">
				 <h4 style="font-size:20px" class="navbar-text navbar-btn">${pageSize} /</h4>
				  <div class="form-group">
				   		<input type="text" class="form-control" style="width:40px;height:23px" value="${pageNum}" onchange="pagemove();" id="pageNum"/>
				  </div>			
				  		<input type="button" class="btn btn-default navbar-btn" onclick="pagemove();" value="이동">
				</form>
    		</div>
    		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
    		

				<form class="navbar-form navbar-left" role="search">
				<a  id="writeForm" value="1" class="glyphicon glyphicon-font navbar-text" onclick="changeCheck();">글쓰기</a>
				<div id="HTMLchange" class="navbar-left">
					 
	              	 <input name="brush" id="linesizeSelect"  type="range" style="width:150px" value="2" min="0" max="100" class=" navbar-text" />		         	
	              	 <input type="color" id="lineStyleSelect" value="#FF3636" class="navbar-text">
	              	 <a onclick="opaqueStyleSelect1();" class="navbar-text">형광</a>
	              	 <a id="clearAction" value="1" class="navbar-text" onclick="clearAction();">지우기</a>
	              	 <div id="cleargenerate" class="navbar-left"></div>
	              </div>	 
	        	</form>      		
       			<form class="navbar-form navbar-right" role="search">
        		<a onclick="clearCanvas();" style="font-size:20px"  class="glyphicon glyphicon-trash navbar-text"></a>
        		<h3  style="font-size:20px" class="navbar-text">|</h3>
        		<c:if test="${1<pageNum}">
        			<a onclick="imageSave();" style="font-size:20px" class="glyphicon glyphicon-chevron-left navbar-text" href='/mooc/user/user_image.mooc?pageNum=${pageNum-1}&sub_lec_code=${sub_lec_code}'>
					</a>
				</c:if>
				<c:if test="${pageNum<pageSize}">
					<a onclick="imageSave();" style="font-size:20px" class="glyphicon glyphicon-chevron-right navbar-text" href='/mooc/user/user_image.mooc?pageNum=${pageNum+1}&sub_lec_code=${sub_lec_code}'>
					</a>
				</c:if>
        		</form>
    		</div><!-- /.navbar-collapse -->
  		</div><!-- /.container-fluid -->
	</nav>
	<input type="checkbox" id="check" style="width:0;"><!-- 보이지 않는 checkbox입니다.! -->
	 <input type="checkbox" id="clear" style="width:0;"><!-- 보이지 않는 checkbox입니다.! -->
   <div id="aa"></div>

   <center>
      <canvas id='myCanvas' style="width:80%;height:90%;">
      </canvas>
	</center>
	
		<input type="hidden" value="${canvasString}" id="loadImage"/>
		<input type="hidden" value="${pageNum}" id="pageValue"/>
	
		<input type="hidden" value="${pageSize}" id="pageSize"/>
		<input type="hidden" value="${sub_lec_code}" id="sub_lec_code"/>

      
     <script src = '/mooc/js/canvas.js'></script>


