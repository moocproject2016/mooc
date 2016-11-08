<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:if test="${stgJoinCheck==1}">
	<script>
	
	alert("본인이 생성한 스터디에 본인이 가입하실 수 없습니다.");
	history.go(-1);
	
	</script>
</c:if>

<c:if test="${stgJoinReadyCheck==1}">
	<script>
	
	alert("이미 가입한 스터디입니다.");
	history.go(-1);
	
	</script>
</c:if>
