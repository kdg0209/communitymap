<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../layouts/app/head.jsp"%>

<%@include file="../../layouts/app/header.jsp"%>
<body>

    <section class="service-wrapper py-3">
        <div class="container-fluid pb-3">
            <div class="row">
                <h2 class="h2 text-center col-12 py-5 semi-bold-600">회원가입</h2>
                <div class="service-header col-2 col-lg-3 text-end light-300">
                	<i class="fas fa-map-marked-alt fa-2x"></i>
                </div>
                <div class="service-heading col-10 col-lg-9 text-start float-end light-300">
                    <h2 class="h3 pb-4 typo-space-line">Community Map</h2>
                </div>
            </div>
            <p class="service-footer col-10 offset-2 col-lg-9 offset-lg-3 text-start pb-3 text-muted px-2">
                회원가입 후 나만의 커뮤니티 지도를 만들어 보세요.
            </p>
        </div>
    </section>
     <section class="container py-5">
        <div class="row pb-4">
        	<div class="col-lg-2"></div>
            <div class="col-lg-8">
                <form action="/app/join/join" method="post" class="contact-form row" role="form">
                	<input type="hidden" id="id_checker" value="N"/>
                	<input type="hidden" id="nickname_checker" value="N"/>
                	<input type="hidden" id="phone_checker" value="N"/>
                	<input type="hidden" id="email_checker" value="N"/>
                	<div class="col-12">
                        <div class="form-floating mb-4">
                            <input type="text" 
                            		class="form-control form-control-lg light-300" 
                            		id="id" 
                            		name="id" 
                            		placeholder="아이디">
                            <label for="floatingname light-300">아이디</label>
                              <div class="is_id_null_chk text-danger" style="display:none; font-size: 13px;">아이디를 입력해주세요.</div>
	                          <div class="is_id_validation_chk text-danger" style="display:none; font-size: 13px;">4자~15자 사이의 영문 또는 숫자를 입력해주세요.</div>
	                          <div class="is_id_chk text-danger" style="display:none; font-size: 13px;">이미 가입된 아이디입니다. 변경해주세요.</div>
                        </div>
                    </div>
                    
                    <div class="col-12">
                        <div class="form-floating mb-4">
                            <input type="password" 
                            		class="form-control form-control-lg light-300" 
                            		id="password" 
                            		name="password" 
                            		placeholder="비밀번호">
                            <label for="floatingname light-300">비밀번호</label>
                        </div>
                    </div>
                    
                    <div class="col-12">
                        <div class="form-floating mb-4">
                            <input type="password" 
                            		class="form-control form-control-lg light-300" 
                            		id="password_confirm" 
                            		name="password_confirm" 
                            		placeholder="비밀번호 확인">
                            <label for="floatingname light-300">비밀번호 확인</label>
                            <div class="is_password_confirm_val text-danger" style="display:none; font-size: 13px;">비밀번호 확인은 필수입니다.</div>
	                        <div class="is_password_confirm_chk text-danger" style="display:none; font-size: 13px;">비밀번호 확인은 6자 이상 입력해주세요.</div>
	                        <div class="is_password_confirm text-danger" style="display:none; font-size: 13px;">비밀번호가 일치하지 않습니다.</div>
                        </div>
                    </div>
                	
                    <div class="col-lg-6">
                        <div class="form-floating mb-4">
                            <input type="text" 
                            		class="form-control form-control-lg light-300" 
                            		id="name" 
                            		name="name" 
                            		placeholder="이름">
                            <label for="floatingname light-300">이름</label>
                        </div>
                    </div>
                    
                    <div class="col-lg-6">
                        <div class="form-floating mb-4">
                            <input type="text" 
                            		class="form-control form-control-lg light-300" 
                            		id="nickname" 
                            		name="nickname" 
                            		placeholder="닉네임">
                            <label for="floatingname light-300">닉네임</label>
                             <div class="is_nickname_null_chk text-danger" style="display:none; font-size: 13px;">닉네임을 입력해주세요.</div>
	                         <div class="is_nickname_chk text-danger" style="display:none; font-size: 13px;">이미 가입된 닉네임입니다. 변경해주세요.</div>
                        </div>
                    </div>

                    <div class="col-12">
                        <div class="form-floating mb-4">
                            <input type="text" 
                            		class="form-control form-control-lg light-300" 
                            		id="phone" 
                            		name="phone" 
                            		placeholder="연락처">
                            <label for="floatingemail light-300">연락처</label>
                             <div class="is_phone_null_chk text-danger" style="display:none; font-size: 13px;">연락처를 입력해주세요.</div>
	                         <div class="is_phone_chk text-danger" style="display:none; font-size: 13px;">이미 가입된 연락처입니다. 변경해주세요.</div>
                        </div>
                    </div>

                    <div class="row">
                    	<div class="col-10">
	                        <div class="form-floating mb-4">
	                            <input type="text" 
	                            		class="form-control form-control-lg light-300" 
	                            		id="email" 
	                            		name="email" 
	                            		placeholder="이메일">
	                            <label for="floatingphone light-300">이메일</label>
	                             <div class="is_email_null_chk text-danger" style="display:none; font-size: 13px;">이메일을 입력해주세요.</div>
	                             <div class="is_email_val_chk text-danger" style="display:none; font-size: 13px;">이메일 형식이 옳바르지 않습니다.</div>
		                         <div class="is_email_chk text-danger" style="display:none; font-size: 13px;">이미 가입된 이메일입니다. 변경해주세요.</div>
	                        </div>
	                    </div>
	                    
	                    <div class="col-2">
	                    	<button type="button" id="email-send-btn" class="btn btn-secondary text-light" style="font-size: 13px;">인증번호 발송</button>
	                    </div>
                    </div>
                    
                    <div class="row" id="email-div" style="display:none;">
                    	<div class="col-10">
	                        <div class="form-floating mb-4">
	                            <input type="text" 
	                            		class="form-control form-control-lg light-300" 
	                            		id="emailvalue" 
	                            		name="emailvalue" 
	                            		placeholder="인증 번호 입력">
	                            <label for="floatingemail light-300">인증 번호</label>
	                            <div id="countdown"></div>
                        	</div>
	                    </div>
	                    
	                    <div class="col-2">
	                    	<button type="button" id="email-check-btn" class="btn btn-secondary text-light" style="font-size: 13px;">확인</button>
	                    </div>
                    </div>
                    
                    <div class="col-md-12 col-12 m-auto text-center">
                        <button type="submit" class="btn btn-secondary rounded-pill px-md-5 px-4 py-2 radius-0 text-light light-300">회원가입</button>
                    </div>

                </form>
            </div>
            <div class="col-lg-2"></div>
        </div>
    </section>
	<%@include file="../../layouts/app/footer.jsp"%>
</body>

<%@include file="../../layouts/app/script.jsp"%>
<script>
	$(document).ready(function(){
		$('#id').bind("keyup keypress keydown click", function () {
            if ($(this).val() == '') {
                $('.is_id_null_chk').show();
                $('.is_id_validation_chk').hide();
                $('.is_id_chk').hide();
            } else if ($(this).val().length < 4) {
                $('.is_id_null_chk').hide();
                $('.is_id_validation_chk').show();
                $('.is_id_chk').hide();
            } else {
                var request = $.ajax({
               	 	contentType:'application/json',
                    dataType:'json',
                    data:JSON.stringify({column: 'id', value: $(this).val()}),
                    url: "/app/join/idverification",
                    type : "POST"
                });

                request.done(function (data) {
                    if (data == true) {
                        $('#id_checker').val('Y');
                        $('.is_id_null_chk').hide();
                        $('.is_id_validation_chk').hide();
                        $('.is_id_chk').hide();
                    } else if (data == false) {
                        $('#id_checker').val('N');
                        $('.is_id_null_chk').hide();
                        $('.is_id_validation_chk').hide();
                        $('.is_id_chk').show();
                    }
                });

                request.fail(function (jqXHR, textStatus) {
                    alert("Request failed: " + textStatus);
                });
            }
        });
		
		$('#password').bind("keyup keypress keydown click", function () {
            if ($(this).val() == '') {
                $(".is_password_val").show();
                $(".is_password_chk").hide();
            }
            else if ($(this).val() != '' && $(this).val().length < 6) {
                $(".is_password_chk").show();
                $(".is_password_val").hide();
            } else {
                $(".is_password_chk").hide();
                $(".is_password_val").hide();
            }
        });

        $('#password_confirm').bind("keyup keypress keydown click", function () {
            if ($(this).val() == '') {
                $(".is_password_confirm_val").show();
                $(".is_password_confirm_chk").hide();
                $(".is_password_confirm").hide();
            }
            else if ($(this).val() != '' && $(this).val().length < 6) {
                $(".is_password_confirm_chk").show();
                $(".is_password_confirm_val").hide();
                $(".is_password_confirm").hide();
            }
            else if ($("#password").val() != $("#password_confirm").val()) {
                $(".is_password_confirm_val").hide();
                $(".is_password_confirm_chk").hide();
                $(".is_password_confirm").show();;
            }
            else if ($("#password").val() == $("#password_confirm").val()) {
                $(".is_password_confirm_val").hide();
                $(".is_password_confirm_chk").hide();
                $(".is_password_confirm").hide();
            }
        });
        
        $('#nickname').bind("keyup keypress keydown click", function () {
            if ($(this).val() == '') {
                $('.is_nickname_null_chk').show();
                $('.is_nickname_chk').hide();
            } else {
                var request = $.ajax({
               	 	contentType:'application/json',
                    dataType:'json',
                    data:JSON.stringify({column: 'nickname', value: $(this).val()}),
                    url: "/app/join/nicknameverification",
                    type : "POST"
                });

                request.done(function (data) {
                    if (data == true) {
                        $('#nickname_checker').val('Y');
                        $('.is_nickname_null_chk').hide();
                        $('.is_nickname_chk').hide();
                    } else if (data == false) {
                        $('#nickname_checker').val('N');
                        $('.is_nickname_null_chk').hide();
                        $('.is_nickname_chk').show();
                    }
                });

                request.fail(function (jqXHR, textStatus) {
                    alert("Request failed: " + textStatus);
                });
            }
        });
        
        $('#phone').bind("keyup keypress keydown click", function () {
            if ($(this).val() == '') {
                $('.is_phone_null_chk').show();
                $('.is_phone_chk').hide();
            } else {
                var request = $.ajax({
               	 	contentType:'application/json',
                    dataType:'json',
                    data:JSON.stringify({column: 'phone', value: $(this).val()}),
                    url: "/app/join/phoneverification",
                    type : "POST"
                });

                request.done(function (data) {
                    if (data == true) {
                        $('#phone_checker').val('Y');
                        $('.is_phone_null_chk').hide();
                        $('.is_phone_chk').hide();
                    } else if (data == false) {
                        $('#phone_checker').val('N');
                        $('.is_phone_null_chk').hide();
                        $('.is_phone_chk').show();
                    }
                });

                request.fail(function (jqXHR, textStatus) {
                    alert("Request failed: " + textStatus);
                });
            }
        });
        
        $('#email').bind("keyup keypress keydown click", function () {
        	var get_EMail = RegExp(/[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
        	
            if ($(this).val() == '') {
                $('.is_email_null_chk').show();
                $('.is_email_chk').hide();
                $('.is_email_val_chk').hide();
            } else if(!get_EMail.test($(this).val())) {
            	$('.is_email_val_chk').show();
            	$('.is_email_null_chk').hide();
            	$('.is_email_chk').hide();
            } else {
                var request = $.ajax({
               	 	contentType:'application/json',
                    dataType:'json',
                    data:JSON.stringify({column: 'email', value: $(this).val()}),
                    url: "/app/join/emailverification",
                    type : "POST"
                });

                request.done(function (data) {
                    if (data == true) {
                        $('#email_checker').val('Y');
                        $('.is_email_null_chk').hide();
                        $('.is_email_val_chk').hide();
                        $('.is_email_chk').hide();
                    } else if (data == false) {
                        $('#email_checker').val('N');
                        $('.is_email_null_chk').hide();
                        $('.is_email_val_chk').hide();
                        $('.is_email_chk').show();
                    }
                });

                request.fail(function (jqXHR, textStatus) {
                    alert("Request failed: " + textStatus);
                });
            }
        });
        
        let emailStatus = false;
        $("#email-send-btn").click(function(){
        	$("#email-send-btn").attr("disabled", true);
        	
        	var request = $.ajax({
        		url: "/app/join/mailsend",
                type : "POST",
               	data:JSON.stringify({email: $('#email').val()}),
        		contentType:'application/json',
                dataType:'json'
            });
        	
        	request.done(function (data) {
        		console.log(data);
                if (data == true) {
                 	alert("이메일이 발송되었습니다. \n이메일을 확인해주세요.");
                 	$("#email-div").show();
                 	$("#email-send-btn").attr("disabled", true);
                 	countdown("countdown", 3, 0);
                 	emailStatus = true;
                } else if (data == false) {
                	alert("잘못된 접근입니다. \n다시 시도해주세요.");
                	$("#email-div").hide();
                	$("#email-send-btn").attr("disabled", false);
                	emailStatus = false;
                }
            });

            request.fail(function (jqXHR, textStatus) {
                alert("Request failed: " + textStatus);
            });
        });
    
        $("#email-check-btn").click(function(){
        	$("#email-check-btn").attr("disabled", true);
        	var email = $("#email").val();
        	var emailvalue = $("#emailvalue").val();
        	
        	if(emailStatus){
        		var request = $.ajax({
            		url: "/app/join/mailsendcheck",
                    type : "POST",
                   	data:JSON.stringify({email: email, emailvalue: emailvalue}),
            		contentType:'application/json',
                    dataType:'text'
                });
        		
        		request.done(function (data) {
            		console.log(data);
                    if (data == 'true') {
                    	alert("정상적으로 처리되었습니다.");
                    	$("#email-check-btn").attr("disabled", true);
                    	$("#email-send-btn").attr("disabled", true);
                    	$("#emailvalue").attr("disabled", true);
                    	countdown("countdown", null);
                    } else if(data == 'pass'){
                    	alert("시간이 초과되었습니다. \n다시 인증해주세요.");
                    	$("#email-div").hide();
                    	$("#emailvalue").val('');
                    	$("#email-check-btn").attr("disabled", false);
                    	$("#email-send-btn").attr("disabled", false);
                    	$("#emailvalue").attr("disabled", false);
                    	countdown("countdown", null);
                    	emailStatus = false;
                    }
                });

                request.fail(function (jqXHR, textStatus) {
                    alert("Request failed: " + textStatus);
                });
        	}
        });
        
        function countdown( elementName, minutes, seconds ){
            var element, endTime, hours, mins, msLeft, time;

            function twoDigits( n ){
                return (n <= 9 ? "0" + n : n);
            }

            function updateTimer(){
                msLeft = endTime - (+new Date);
                if ( msLeft < 1000 ) {
                    alert("시간을 초과하였습니다. \n다시 시도해주세요.");
                    $("#email-div").hide();
                	$("#emailvalue").val('');
                	$("#email-check-btn").attr("disabled", false);
                	$("#email-send-btn").attr("disabled", false);
                	$("#emailvalue").attr("disabled", false);
                	emailStatus = false;
                } else {
                    time = new Date( msLeft );
                    hours = time.getUTCHours();
                    mins = time.getUTCMinutes();
                    element.innerHTML = (hours ? hours + ':' + twoDigits( mins ) : mins) + ':' + twoDigits( time.getUTCSeconds() );
                    setTimeout( updateTimer, time.getUTCMilliseconds() + 500 );
                }
            }

            element = document.getElementById( elementName );
            endTime = (+new Date) + 1000 * (60*minutes + seconds) + 500;
            updateTimer();
        }
	});
</script>
