<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>
        jQuery(document).ready(function() {
            $('#top_ctg').change(function() {
                var top_ctg_code = $(this).val();
                $.ajax({
                    type: 'post',
                    url: "/mooc/study/getSubCtg.mooc",
                    data: {
                        top_ctg_code: top_ctg_code
                    },
                    success: aa,
                    error: bb
                });
            });

            function aa(data) {
                var subCtgList = data.split(',');
                $('#sub_ctg').empty().data('options'); // selectbox 초기화
                $('#sub_ctg').append('<option>소분류</option>'); // 첫번째 option 추가

                for (var i = 0; i < subCtgList.length; i++) {
                    $('#sub_ctg').append('<option value="' + subCtgList[i] + '">' + subCtgList[i] + '</option>');
                }
            }

            function bb(data) {
                alert("소분류 가져오기가 실패하였습니다.");
            }

        });
    </script>
    
    <form method="post" action="/mooc/study/myStudyWritePro.mooc" name="studywrite" onSubmit="return checktIt()">
        <table class="talbe" align="center">
            <tr height="50px" valign="top"><td><h3>스터디 생성</h3></td></tr>
            <tr height="100px">
                <td>
                    <select id="top_ctg" style="width: 50%" class="form-control">
				        <option selected="selected">채널 대분류</option>
						<c:forEach var="ctgdto" items="${list}">
							<option value="${ctgdto.top_ctg_code}">${ctgdto.top_ctg_name}</option> 
				        </c:forEach>
					</select>
                    <select id="sub_ctg" name="sub_ctg_name" style="width: 40%" class="form-control">
	        			<option>소분류</option>
					</select>
                </td>
            </tr>
			<tr>
                <td>
                    <input type="text" name="stg_name" class="form-control" size="25" placeholder="스터디 제목">
                </td>
            </tr>
             <tr>
                 <td>
					<div class="input-group" style="width: 50%;" id="passwd">
						<input type="password" name="stg_password" size="5" class="form-control" placeholder="비밀번호(4~6자 이내)">
					</div>
                 </td>
             </tr>
             <tr height="80px">
                <td>
                    <select name="stg_limit" style="width: 50%" class="form-control">
				        <option selected="selected">참여 인원</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
						<option value="6">6</option>
					</select>
                 </td>
			</tr>
             <tr>
                 <td>
                     <textArea name="stg_purpose" rows="10" cols="8" class="form-control" placeholder="스터디 소개"></textArea>
                </td>
            </tr>
            <tr>
                 <td>
                     <input type="radio" name="stg_type" value="1" checked="checked" />공개
                     <input type="radio" name="stg_type" value="0" />비공개
                 </td>
            </tr>
            <tr height="100px">
                <td colspan="2" align="center">
                    <font size="2" color="grey">*장기간 사용하지 않는 대화방은 관리자에 의해 삭제될 수 있습니다.</font>
                </td>
            </tr>

            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="확인">
                    <input type="button" value="취소" onclick="javascript:window.location='/mooc/community.mooc'"><br/>
                </td>
            </tr>
        </table>
    </form>
