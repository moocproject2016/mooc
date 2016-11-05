<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form action="/mooc/user/user_deletePro.mooc" method="post">
${sessionScope.memId}가 삭제됩니다.<br/>
정말로 삭제하시겠습니까?<br/>
<input type="submit" value="삭제">
</form>