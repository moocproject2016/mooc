<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<input type="button" value="뒤로" onclick="javascript:location.href='${beforePage}'"/>
	<input type="button" value="필기노트"/>
	<form name="inform">
	<table class="table" align="center">
		<tr>
			<td colspan="2">
				<h4>${sub_lec_dto.sub_lec_chapter}강 ${sub_lec_dto.sub_lec_subject}</h4>
				<input type="hidden" name="sub_lec_code" value="${sub_lec_dto.sub_lec_code}"/>
			</td>
		</tr>
		<tr>
			<td align="center">
				<video controls poster="demo.jpg" width="900" height="500">
					<source src="${sub_lec_dto.sub_lec_media }" type="video/mp4" />
					<source src="${sub_lec_dto.sub_lec_media }" type="video/webm"/>
					<source src="${sub_lec_dto.sub_lec_media }" type="video/ogg"/>     
					<object>
						<embed src="demo.mp4" type= "application/x-shockwave-flash" allowfullscreen="false" allowscriptaccess="always" />
					</object>
				</video>
			</td>
			<td>
				<div style="overflow-y:scroll; width:100%; height:350; padding:4px" >
					채팅창
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div style="overflow-y:scroll; width:100%; height:350; padding:4px" >
					<c:forEach var="lec_data_dto" items="${lec_data_list}" varStatus="i">
						<a href="javascript:void();" onclick="viewData('${i.count}')">${lec_data_dto.lec_data_name}</a>
						<input type="hidden" name="lec_data_code" value="${lec_data_dto.lec_data_code}"/>
						<input type="hidden" name="lec_data_type" value="${lec_data_dto.lec_data_type}"/>
						<input type="hidden" name="lec_data_path" value="${lec_data_dto.lec_data_path}"/>

					</c:forEach>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">${sub_lec_dto.sub_lec_content}</td>
		</tr>
	</table>
	</form>
