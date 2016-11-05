<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<button onclick="">${stg_code}번 회의방 만들기</button>
<button onclick="myFunction(${stg_code})">${stg_code}번 회의방이 열렸습니다</button>

<script>
function myFunction(i) {
	 cw=screen.availWidth;
	 ch=screen.availHeight;
	 sw=900;
	 sh=600;
	 ml=(cw-sw)/2; 
	 mt=(ch-sh)/2;
	 test=window.open('/mooc/conferenceRoom.mooc?stg_code='+i,'_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}
</script>