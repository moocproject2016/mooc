<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${List!=null}">
	<select name="sub_lec_code" id="subselectbox" class="form-control">
		<c:forEach items="${List}" var="dto">
			<option value="${dto.sub_lec_code}">${dto.sub_lec_chapter} / ${dto.sub_lec_subject}</option>	
		</c:forEach>
	</select>
</c:if>    
 
${check}
