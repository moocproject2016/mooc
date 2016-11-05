<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="google-signin-scope" content="profile email">
        <meta name="google-signin-client_id" content="456250222526-ecf58h55v9rir08qd2ue3ilcpo3271r5.apps.googleusercontent.com">
        <script src="https://apis.google.com/js/platform.js" async defer></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
        
        <script>
            var i = 0;
            var j = 1;
            var z = 0;
            var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
            $(document).ready(function() {
                $("#user_id").blur(function() {
                	if (document.getElementById('user_id').value != null || document.getElementById('user_id').value != ""){
                    $.ajax({  //ajax이벤트를 실행 시킨다
                        url: '/mooc/user/loginid.mooc?id=' + document.getElementById('user_id').value,
                        type: 'post',
                        success: function(a) {
							if (document.getElementById('user_id').value.match(regExp) != null) 
                        	{
                            	if (a == 1) {
                               		$('#idcheck').html('사용할수 없는 아이디 입니다');
                            	} else {
                                	
                                	$('#idcheck').html('사용가능한 아이디 입니다<br/>'+'<input type="button" id="checkmail" onclick="EmailChecked();" value="이메일인증" />');
                            	}
                        		}else{
                        			$('#idcheck').html('잘못된 이메일 형식입니다.');
                        	}
                        }
                    })
                    }
                })
    
            })
             function EmailChecked() {
                    $.ajax({  //ajax이벤트를 실행 시킨다
                    	url: '/mooc/user/sendEmail.mooc?u_id=' + document.getElementById('user_id').value,
                        type: 'post',
                        success:  gogo,
                        })
                }
            function gogo(a) {
            	$('#idcheck').html('인증번호 :<input type="text" id="confirmEmail"  value="" /> <input type="button" onclick="Checkgo1();"  value="인증" />');
				z=a;
				
            }

            function Checkgo1(){
                if(Number(z)==document.getElementById('confirmEmail').value){
                	$('#idcheck').html('');
                	j=0;
                }else{
                	alert("잘못된 인증번호입니다.");
                }
            }
            function  logIncheck(){
            	if (document.getElementById('id').value == null || document.getElementById('id').value == "") {
                    alert("아이디를 입력하세요");
                    return false;
                }
                if (document.getElementById('pw').value == null || document.getElementById('pw').value == "") {
                    alert("비밀번호를 입력하세요");
                    return false;
                }

            }


            function onSignIn(googleUser) {
                var profile = googleUser.getBasicProfile();
                if (i == 1) {
                    $.ajax({        
                        type: "post",
                        url: "/mooc/user/loginGoogle.mooc",
                        data: {  // url 페이지도 전달할 파라미터                                    
                            	u_id: profile.getEmail(),
                                u_pw: profile.getId(),
                                u_name: profile.getName(),
                            	u_type: 0,
                                },
                        success: function(a) {  // 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
                             	if(a==1){
                        			alert("사용할수 없는 계정입니다.");
                        		}else{
                       			 window.document.location.href="/mooc/main.mooc"
                        		}
                        }
                             
                    });
                }
            };


            function go() {
                i = 1;
            }
            function subcheck()
        	{
        		if(document.getElementById('user_id').value==null||document.getElementById('user_id').value=="")
        		{
        			alert("아이디를 입력하세요");
        			return false;
        		}
        		if(document.getElementById('u_pw').value==null||document.getElementById('u_pw').value=="")
        		{
        			alert("비밀번호를 입력하세요");
        			return false;
        		}
        		if(document.getElementById('confirm').value==null||document.getElementById('confirm').value=="")
        		{
        			alert("비밀번호를 확인하세요");
        			return false;
        		}
        		if(document.getElementById('confirm').value!=document.getElementById('u_pw').value)
        		{
        			alert("비밀번호를 확인하세요");
        			return false;
        		}
        		if(document.getElementById('u_name').value==null||document.getElementById('u_name').value=="")
        		{
        			alert("이름를 입력하세요");
        			return false;
        		}
        		if(j==1)
        		{
        			alert("아이디와 인증번호를 정확하게 입력하세요");
        			return false;
        		}

        	}
        </script>
        
<div class="tableWrap">    
    
	<table class="signTable" align="center">
		<tr><td>
			<c:if test="${sessionScope.memId==null}">
		        <div role="tabpanel">
		            <!-- Nav tabs -->
		            <ul class="nav nav-tabs  nav-justified" role="tablist">
		                <li role="presentation" class="active">
		                	<a href="#home" aria-controls="home" role="tab" data-toggle="tab">SIGN IN</a></li>
		                <li role="presentation">
		                	<a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">SIGN UP</a></li>
		            </ul>
		            
		            <!-- 로그인 -->
		            <div class="tab-content">
		                <div role="tabpanel" class="tab-pane active" id="home">
			                <form class="form-inline" action="/mooc/user/loginPro.mooc" method="post" id="loginform" onsubmit="return logIncheck();">
				                <table width="100%" height="100%" align="center">
					                <tr height="90px">
					                	<td align="center" valign="bottom">
											<h3>Log Into Your Account</h3>
										</td>
									</tr>
									<tr height="50px">
										<td align="center">		                    
											<c:if test="${checked1==0}">
												<font size="2" color="grey">이메일 주소와 비밀번호를 다시 확인해주세요.</font>
											</c:if>
										</td>
									</tr>
									<tr height="50px">
										<td align="center">
											<div class="input-group bg-primary" style="width: 50%;">
			                            		    <input type="text" name="u_id" id="id" class="form-control" placeholder="Email Address" aria-describedby="sizing-addon3">
			                           	 	</div>
				                    	</td>
				                    </tr>
				                    <tr height="50px">
										<td align="center">
			                                <div class="input-group" style="width: 50%;" id="passwd">
			                                    <input type="password" id="pw" name="u_pw" class="form-control" placeholder="Password" aria-describedby="sizing-addon1">                     
			                            	</div>
			                            	<div class="input-group" style="width: 100%;" id="logcheck"></div><br/>
				                         </td>
									</tr>
									<tr height="150px">
										<td align="center">
											<input type="submit" value="SIGN IN" class="btn btn-primary btn-lg btn-block" style="width:35%;" />
											</br>
											<a onclick="location.href='/mooc/user/user_finePw.mooc'">Forgot your password?</a>
				                        </td>
									</tr>
							
									<tr>
										<td align="center">		 
					                        <div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"  onclick="go();"></div>
										</td>
									</tr>
				                </table>
			                </form>
		                </div>
		                
		                <!-- 회원가입 -->
		                <div role="tabpanel" class="tab-pane" id="profile">
		                    <form action="/mooc/user/membershipPro.mooc" method="post" onsubmit="return subcheck();">
			                    <table width="100%" height="100%" align="center">
					                <tr height="120px">
					                	<td align="center">
											<h3>Create Your Account</h3></br>
										</td>
									</tr>
									<tr height="50px">
										<td align="center">
					                        <div class="input-group" style="width: 50%">
					                            <input type="text" id="user_id" name="u_id" style="width: 100%;" class="form-control" placeholder="Email Address" aria-describedby="basic-addon1">
					                        </div>
					                        <div class="input-group" id="idcheck"></div>
				                       	</td>
			                       	</tr>
			                       	<tr height="50px">
										<td align="center">
					                        <div class="input-group" style="width: 50%;" id="passwd">
					                            <input type="password" id="u_pw" name="u_pw" style="width: 50%;" class="form-control" placeholder="Password" aria-describedby="basic-addon1">
					                            <input type="password" id="confirm" name="confirm" style="width: 50%;" class="form-control" placeholder="Confirm Password" aria-describedby="basic-addon1">
					                       </div>
				                        </td>
			                        </tr>
			                        <tr height="50px">
										<td align="center">
					                        <div class="input-group" style="width: 50%">
					                            <input type="text" id="u_name" name="u_name" style="width: 100%;" class="form-control" placeholder="User Name" aria-describedby="basic-addon1">
					                        </div>
										</td>
									</tr>
									<tr height="110px">
										<td align="center">
				                       		<input type="submit" value="SIGN UP" class="btn btn-primary btn-lg btn-block" style="width:35%"/>
				                       	</td>
				                    </tr>
			                    </table>
		                    </form>
		                </div>
		            </div>
		        </div>
			</c:if>
	 	</td></tr>
	 </table>
	 
 </div>
<c:if test="${sessionScope.memId!=null}">
         ${sessionScope.memId}님
<a href="/mooc/logout.mooc">로그아웃</a>
</c:if>