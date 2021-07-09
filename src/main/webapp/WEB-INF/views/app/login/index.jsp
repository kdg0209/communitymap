<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../layouts/app/head.jsp"%>

<%@include file="../../layouts/app/header.jsp"%>

<style>
    .main {
        background-color: #FFFFFF;
        width: 400px;
        height: 400px;
        margin: -3em auto;
        border-radius: 1.5em;
        box-shadow: 0px 11px 35px 2px rgba(0, 0, 0, 0.14);
    }
    .sign {
        padding-top: 40px;
        color: #4232c2;
        font-family: 'Ubuntu', sans-serif;
        font-weight: bold;
        font-size: 23px;
    }
    .input-id {
	    width: 76%;
	    color: rgb(38, 50, 56);
	    font-weight: 700;
	    font-size: 14px;
	    letter-spacing: 1px;
	    background: rgba(136, 126, 126, 0.04);
	    padding: 10px 20px;
	    border: none;
	    border-radius: 20px;
	    outline: none;
	    box-sizing: border-box;
	    border: 2px solid rgba(0, 0, 0, 0.02);
	    margin-bottom: 50px;
	    margin-left: 46px;
	    text-align: center;
	    margin-bottom: 27px;
	    font-family: 'Ubuntu', sans-serif;
    }
    form.form {
        padding-top: 40px;
    }
    .input-password {
        width: 76%;
	    color: rgb(38, 50, 56);
	    font-weight: 700;
	    font-size: 14px;
	    letter-spacing: 1px;
	    background: rgba(136, 126, 126, 0.04);
	    padding: 10px 20px;
	    border: none;
	    border-radius: 20px;
	    outline: none;
	    box-sizing: border-box;
	    border: 2px solid rgba(0, 0, 0, 0.02);
	    margin-bottom: 50px;
	    margin-left: 46px;
	    text-align: center;
	    margin-bottom: 27px;
	    font-family: 'Ubuntu', sans-serif;
    }
    .input-id:focus, .input-password:focus {
        border: 2px solid rgba(0, 0, 0, 0.18) !important;
        
    }
    .submit {
      cursor: pointer;
        border-radius: 5em;
        color: #fff;
        background: linear-gradient(to right, #4232c2, #E040FB);
        border: 0;
        padding-left: 40px;
        padding-right: 40px;
        padding-bottom: 10px;
        padding-top: 10px;
        font-family: 'Ubuntu', sans-serif;
        margin-left: 35%;
        font-size: 13px;
        box-shadow: 0 0 20px 1px rgba(0, 0, 0, 0.04);
    }
    .forgot {
        text-shadow: 0px 0px 3px rgba(117, 117, 117, 0.12);
        color: #E1BEE7;
        padding-top: 15px;
    }
    .forgot-password {
        text-shadow: 0px 0px 3px rgba(117, 117, 117, 0.12);
        color: #E1BEE7;
        text-decoration: none
    }
    @media (max-width: 600px) {
        .main {
            border-radius: 0px;
        }
     }
</style>
<body>

    <section class="service-wrapper py-3">
        <div class="container-fluid pb-3">
            <div class="row">
                <h2 class="h2 text-center col-12 py-5 semi-bold-600">로그인</h2>
                <div class="service-header col-2 col-lg-3 text-end light-300">
                	<i class="fas fa-sign-in-alt fa-2x"></i>
                </div>
                <div class="service-heading col-10 col-lg-9 text-start float-end light-300">
                    <h2 class="h3 pb-4 typo-space-line">Community Map</h2>
                </div>
            </div>
            <p class="service-footer col-10 offset-2 col-lg-9 offset-lg-3 text-start pb-3 text-muted px-2">
                로그인 후 다양한 서비스를 이용해보세요.
            </p>
        </div>
    </section>
     <section class="container py-5">
        <div class="row pb-4">
        	<div class="col-lg-2"></div>
            <div class="col-lg-8">
                <div class="main">
    				<p class="sign" align="center">로그인</p>
    				<form class="form" action="/app/login/index" method="post" onSubmit="return doSubmit(this);">
      					<input type="text" 
      							name="id" 
      							id="id"
      							class="input-id" 
      							align="center" 
      							placeholder="UserID">
      					<input type="password" 
      							name="password" 
      							id="password"
      							class="input-password" 
      							align="center" 
      							placeholder="Password">
      					<button type="submit" class="submit" align="center">로그인</button>
      					<p class="forgot" align="center">
      						<a href="/app/join/index" class="forgot-password">회원가입</a>
      						<a href="#" class="forgot-password">비밀번호 찾기</a>
      					</p>
      				</form>        
   			 	</div>
            </div>
            <div class="col-lg-2"></div>
        </div>
    </section>
	<%@include file="../../layouts/app/footer.jsp"%>
</body>

<%@include file="../../layouts/app/script.jsp"%>
<script>
function doSubmit(frm){
	  if ($("#id").val().trim() == '') {
          $("#id").focus();
          alert("아이디를 입력해주세요.");
          return false;
      }
      if ($("#password").val().trim() == '') {
          $("#password").focus();
          alert("비밀번호를 입력해주세요.");
          return false;
      }
    
      $(frm).find('button:submit').attr('disabled', 'disabled');
      return true;
}
</script>
