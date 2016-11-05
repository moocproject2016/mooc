<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

     	<meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="/mooc/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script src="/mooc/js/bootstrap.min.js"></script>
        <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script>
		var z=0;
		function EmailChecked() {
                    $.ajax({  //ajax이벤트를 실행 시킨다
                    	url: '/mooc/user/sendEmail.mooc?u_id=' + document.getElementById('user_id').value,
                        type: 'post',
                        success:  gogo,
                        })
                }
            function gogo(a) {
            	$('#idcheck').html('</br><input type="text" id="confirmEmail"  value=""  placeholder="임시 비밀번호 입력" class="form-control" aria-describedby="sizing-addon1" /> </br> <input type="button" onclick="Checkgo1();" value="SIGN IN" class="btn btn-primary btn-lg btn-block" style="width:150px;" />');
				z=a;
				
            }

            function Checkgo1(){
            	i = document.getElementById('confirmEmail').value;
            	v = document.getElementById('user_id').value;
            	alert("로그인 성공");
            	
                if(z=i){
                	location.replace("/mooc/user/loginPro.mooc?u_id="+v+"&u_pw="+z);

                }else{
                	alert("다시 입력해주세요.");
                }
            }

            </script>

<div class="tableWrap"> 
	<form name="form">     
		<table class="signTable" align="center">
			<tr height="100px"><td align="center">
				<h3>비밀번호 찾기</h3></br>
			</td></tr>
			<tr><td align="center">
				<div id="checkPw">
					<div class="input-group bg-primary" style="width: 50%;">
		         		<input type="text" id="user_id" name="u_id" style="width: 100%;" class="form-control" placeholder="Email Address" aria-describedby="basic-addon1">
	               	</div>
	            	<div class="input-group" id="idcheck"></div>
	            </div>
	        </td></tr>
	        <tr height="90px"><td align="center"> 
					<input type="button" value="전송요청" onclick="EmailChecked();" class="btn btn-primary btn-lg btn-block" style="width:35%;" />
			</td></tr>
		</table>
	</form>  
</div>	
