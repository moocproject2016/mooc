<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="tableWrap">     
  
	<h2>방 만들기</h2>

<form method="post" action="/mooc/study/myStudymodifyPro.mooc"  onSubmit="return checktIt()">
	<table class="table" align="center">
		<tr>
			<td width="100"  height="30" align="center"><b>*대화방 제목</b></td>
			<td width="400">
	          <input type="text" name="stg_name"  maxlength="12"  value="${dto.stg_name}">
	          <input type="hidden" name="stg_code"  maxlength="12"  value="${dto.stg_code}">
			</td>
		</tr>
		<tr>
			<td width="100"  height="30" align="center"><b>*개설 시간</b></td>
			<td width="400">
				<input type="text"   maxlength="12"  value="${dto.stg_regdate}" style="border: 0px" readonly>
			</td>
		</tr>
	  	<tr>
			<td width="100"  height="40" align="center"><b>*참여인원</b></td>
			<td width="400">
		       <select  name="stg_limit" style="width: 90px;">
					<option value="2" <c:if test="${dto.stg_limit==2}">selected</c:if>>2</option>
					<option value="3" <c:if test="${dto.stg_limit==3}">selected</c:if>>3</option>
					<option value="4" <c:if test="${dto.stg_limit==4}">selected</c:if>>4</option>
					<option value="5" <c:if test="${dto.stg_limit==5}">selected</c:if>>5</option>
					<option value="6" <c:if test="${dto.stg_limit==6}">selected</c:if>>6</option>
				</select>
			</td>
		</tr>
		<tr>
			<td width="100"  height="30" align="center"><b>*공개선택</b></td>
			<td width="400">
				<c:if test="${dto.stg_type=='1'}">
					<input type ="radio" name="stg_type" value="${dto.stg_type}" checked="checked"/>공개방
					<input type ="radio" name="stg_type" value="${dto.stg_type}"/>비공개방
				</c:if>
				<c:if test="${dto.stg_type=='0'}">
					<input type ="radio" name="stg_type" value="${dto.stg_type}"/>공개방
					<input type ="radio" name="stg_type" value="${dto.stg_type}" checked="checked"//>비공개방
				</c:if>
			</td> 
	       
	  </tr>
	  <tr>
	      <td width="100"  height="30" align="center"><b>*비밀번호</b></td>
	      <td width="400">
	         <input type="password"  name="stg_password" size="10" value="${dto.stg_password}">(4~6자 이내) <br />
	     </td>
	    
	  </tr>
	  <tr>
	  	<td width="100" heught="30" align="center"><b>*스터디 내용</b></td>
	  	<td width="400">
	  	<textArea name="stg_purpose" style="width: 200px";>${dto.stg_purpose}</textArea>
	  	</td>
	  </tr>
	  <tr><td colspan="2" align="center">
	  	  *장기간 사용하지 않는 대화방은 관리자에 의해 삭제될 수 있습니다.
	    </td></tr>
	  
	<tr> 
		<td colspan="2" align="center" > 
	          <input type="submit"  value="수정" >
	          <input type="button" value="취소" onclick="javascript:window.location='/mooc/community/_commu_main.jsp'"><br/>
		</td>
	    </tr>
	  
	  </table>	
</form>

</div>