<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../../layouts/app/head.jsp"%>

<%@include file="../../layouts/app/header.jsp"%>

<body>
    <section class="service-wrapper py-3">
        <div class="container-fluid pb-3">
            <div class="row">
                <h2 class="h2 text-center col-12 py-5 semi-bold-600">정보 등록하기</h2>
                <div class="service-header col-2 col-lg-3 text-end light-300">
                	<i class="fas fa-map-marked-alt fa-2x"></i>
                </div>
                <div class="service-heading col-10 col-lg-9 text-start float-end light-300">
                    <h2 class="h3 pb-4 typo-space-line">Community Map</h2>
                </div>
            </div>
            <p class="service-footer col-10 offset-2 col-lg-9 offset-lg-3 text-start pb-3 text-muted px-2">
                나의 정보를 등록하여 사람들과 공유해보세요.!
            </p>
        </div>
    </section>
     <section class="container py-5">
        <div class="row pb-4" style="margin-top: -70px;">
        	<div class="col-lg-2"></div>
            <div class="col-lg-8">
                <form id="submitForm" class="contact-form row" role="form">
                	<input type="hidden" name="filename" id="filename" />
                	<input type="hidden" name="cover" id="cover" />
                	
                	<div class="col-12">
                        <div class="form-floating mb-4">
                            <div class="profile-pic-wrapper">
							  <div class="pic-holder">
							    <img id="profilePic" class="pic" src="https://source.unsplash.com/random/150x150">
							    <label for="newProfilePhoto" class="upload-file-block">
							      <div class="text-center">
							        <div class="mb-2">
							          <i class="fa fa-camera fa-2x"></i>
							        </div>
							        <div class="text-uppercase">
							          Update <br />
							          Photo
							        </div>
							      </div>
							    </label>
							    <Input class="uploadProfileInput" type="file" id="newProfilePhoto" accept="image/*" style="display: none;" />
							  </div>
							  <p class="text-info text-center small">커버 이미지를 설정해보세요!</p>
							</div>
                        </div>
                    </div>
                    
                    <div class="col-12">
                        <div class="form-floating mb-4">
                            <input type="text" 
                            		class="form-control form-control-lg light-300" 
                            		id="name" 
                            		name="name" 
                            		placeholder="이름">
                            <label for="floatingname light-300">이름</label>
                            <div class="is_name_val text-danger" style="display:none; font-size: 13px;">이름을 입력해주세요.</div>
                        </div>
                    </div>

                    <div class="dashed-line"></div>
                    
                    
                    
                    <div class="dashed-line"></div>
                    
                    
                    
                    <div class="dashed-line"></div>
                    
                    
                    <div class="dashed-line"></div>
                    
                     
                    
                    <div class="dashed-line"></div>
                	
                	
               		<div class="col-md-4 col-4 m-auto">
               			<a href="/app/mapping/index?mapperCode=${mapperCode}" class="btn btn-dark rounded-pill px-md-5 px-4 py-2 radius-0 text-light light-300">목록</a>
                    </div>
                    <div class="col-md-4 col-4 m-auto text-center">
                        <button type="button" id="submit" class="btn btn-secondary rounded-pill px-md-5 px-4 py-2 radius-0 text-light light-300">확인</button>
                    </div>
                    <div class="col-md-4 col-4 m-auto"></div>
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
		$(document).on("change", ".uploadProfileInput", function () {
		  var triggerInput = this;
		  var currentImg = $(this).closest(".pic-holder").find(".pic").attr("src");
		  var holder = $(this).closest(".pic-holder");
		  var wrapper = $(this).closest(".profile-pic-wrapper");
		  $(wrapper).find('[role="alert"]').remove();
		  
		  var files = !!this.files ? this.files : [];
		  if (!files.length || !window.FileReader) {
		    return;
		  }
		  if (/^image/.test(files[0].type)) {
		    var reader = new FileReader(); // instance of the FileReader
		    reader.readAsDataURL(files[0]); // read the local file
		
		    var file = $("#newProfilePhoto")[0].files[0];
			var filename = file.name;
		    
		    reader.onloadend = function () {
		    	var base64data = reader.result;
				var data = base64data.split(',')[1];
				
			    $(holder).addClass("uploadInProgress");
			    $(holder).find(".pic").attr("src", this.result);
			    $(holder).append(
			      '<div class="upload-loader"><div class="spinner-border text-primary" role="status"><span class="sr-only">Loading...</span></div></div>'
			    );
		
		      setTimeout(() => {
		        $(holder).removeClass("uploadInProgress");
		        $(holder).find(".upload-loader").remove();
		        // If upload successful
		        if (Math.random() < 0.9) {
		          $(wrapper).append(
		            '<div class="snackbar show" role="alert"><i class="fa fa-check-circle text-success"></i> 성공적으로 업로드를 하였습니다.</div>'
		          );
		          
		          $("#filename").val(filename);
				  $("#cover").val(data);
		
		          // Clear input after upload
		          $(triggerInput).val("");
		
		          setTimeout(() => {
		            $(wrapper).find('[role="alert"]').remove();
		          }, 3000);
		        } else {
		          $(holder).find(".pic").attr("src", currentImg);
		          $(wrapper).append(
		            '<div class="snackbar show" role="alert"><i class="fa fa-times-circle text-danger"></i> 다시 시도해주세요.</div>'
		          );
		
		          $(triggerInput).val("");
		          setTimeout(() => {
		            $(wrapper).find('[role="alert"]').remove();
		          }, 3000);
		        }
		      }, 1500);
		    };
		    
		  } else {
		    $(wrapper).append(
		      '<div class="alert alert-danger d-inline-block p-2 small" role="alert">Please choose the valid image.</div>'
		    );
		    setTimeout(() => {
		      $(wrapper).find('role="alert"').remove();
		    }, 3000);
		  }
		});
		
		jQuery.fn.serializeObject = function() { 
		    var obj = null; 
		    try { 
		        if(this[0].tagName && this[0].tagName.toUpperCase() == "FORM" ) { 
		            var arr = this.serializeArray(); 
		            if(arr){ obj = {}; 
		            jQuery.each(arr, function() { 
		                obj[this.name] = this.value; }); 
		            } 
		        } 
		    }catch(e) { 
		        alert(e.message); 
		    }
		    return obj; 
		}
	
		$("#submit").click(function() {
			if ($("#name").val().trim() == '') {
		          $("#name").focus();
		          alert("지도의 이름을 입력해주세요.");
		          return false;
		    }
		      
	        if ($("#contents").val().trim() == '') {
	              $("#contents").focus();
	              alert("지도의 설명을 입력해주세요.");
	              return false;
	        }
		      
	        if($("input[name='editAuth']:checked").val() == '2'){
	    	      if ($("#editPassword").val().trim() == '') {
	                 $("#editPassword").focus();
	                 alert("비밀번호를 입력해주세요.");
	                 return false;
	              }
	        }
		  
	        var data = $("#submitForm").serializeObject();
	        
	        var request = $.ajax({
                url: "/app/mapper/write",
                type : "POST",
                data:JSON.stringify(data),
                enctype: "multipart/form-data",
           	 	contentType:'application/json',
                dataType:'json',
            });

            request.done(function (data) {
                if (data == true) {
                   	window.location.href = "/app/mapper/index";
                } else if (data == false) {
                	alert("잘못된 접근입니다. 다시 시도해주세요.");
                	return false;
                }
            });

            request.fail(function (jqXHR, textStatus) {
                alert("Request failed: " + textStatus);
            });
		});
	});
</script>
