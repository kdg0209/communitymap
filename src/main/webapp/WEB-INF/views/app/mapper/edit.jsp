<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../../layouts/app/head.jsp"%>

<%@include file="../../layouts/app/header.jsp"%>

<body>

    <section class="service-wrapper py-3">
        <div class="container-fluid pb-3">
            <div class="row">
                <h2 class="h2 text-center col-12 py-5 semi-bold-600">지도 수정</h2>
                <div class="service-header col-2 col-lg-3 text-end light-300">
                	<i class="fas fa-map-marked-alt fa-2x"></i>
                </div>
                <div class="service-heading col-10 col-lg-9 text-start float-end light-300">
                    <h2 class="h3 pb-4 typo-space-line">Community Map2221</h2>
                </div>
            </div>
            <p class="service-footer col-10 offset-2 col-lg-9 offset-lg-3 text-start pb-3 text-muted px-2">
                나만의 지도를 만들어 사람들과 공유해보세요.!
            </p>
        </div>
    </section>
     <section class="container py-5">
        <div class="row pb-4" style="margin-top: -70px;">
        	<div class="col-lg-2"></div>
            <div class="col-lg-8">
                <form id="submitForm" class="contact-form row" role="form">
                	<input type="hidden" name="code" value="${mapper.code}" />
                	<input type="hidden" name="mapperNameCount" id="mapperNameCount" value="0" />
                	<input type="hidden" name="mapperCategoryCount" id="mapperCategoryCount" value="0" />
                	<input type="hidden" name="filename" id="filename"/>
                	<input type="hidden" name="cover" id="cover" />
                	
                	<div class="col-12">
                        <div class="form-floating mb-4">
                            <div class="profile-pic-wrapper">
							  <div class="pic-holder">
							    <img id="profilePic" class="pic" src="/img/mapperCover/${mapper.fileName}">
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
                            		value="${mapper.name}" 
                            		placeholder="이름">
                            <label for="floatingname light-300">이름</label>
                            <div class="is_name_val text-danger" style="display:none; font-size: 13px;">이름을 입력해주세요.</div>
                        </div>
                    </div>

                    
                    <div class="col-12">
                        <div class="form-floating mb-3">
                            <textarea class="form-control light-300" 
                            		  id="contents"
                            		  name="contents"
                            		  rows="8" 
                            		  placeholder="지도에 대한 소개를 적어주세요.">${mapper.contents}</textarea>
                            <label for="floatingtextarea light-300">지도에 대한 소개</label>
                        </div>
                    </div>
                    
                    <div class="dashed-line"></div>
                    
                    <div class="col-12">
                        <label for="floatingname light-300">카테고리</label>
                        <div class="form-floating mb-4">
                            <c:forEach var="category" items="${categoryList}">
                           		<span>
                           			<input type="radio" name="categoryCode" value="${category.key}" ${category.key eq mapper.categoryCode ? "checked":""} />
                           			${category.value}
                           		</span>
                            </c:forEach>
                        </div>
                    </div>
                    
                    <div class="dashed-line"></div>
                    
                    <div class="col-12">
                        <label for="floatingname light-300">접근 권한</label>
                        <div class="form-floating mb-4">
                            <c:forEach var="item" items="${editAuth}">
                           		<span>
                           			<input type="radio" name="editAuth" class="editAuth" value="${item.key}" ${item.key eq mapper.editAuth ? "checked":""} />
                           			${item.value}
                           		</span>
                            </c:forEach>
                        </div>
                    </div>
                    
                     <div class="col-12 editPassword_div" style="display: none;">
                        <div class="form-floating mb-4">
                            <input type="password" 
                            		class="form-control form-control-lg light-300" 
                            		id="editPassword" 
                            		name="editPassword" 
                            		placeholder="비밀번호">
                            <label for="floatingname light-300">비밀번호</label>
                            <div class="is_editPassword_val text-danger" style="display:none; font-size: 13px;">비밀번호를 입력해주세요.</div>
                        </div>
                    </div>
                    
                    <div class="dashed-line"></div>
                    
                    <c:forEach var="item" items="${nameConfigList}">
	                    <div class="col-8">
	                        <div class="form-floating mb-4">
	                        	<span class="form-control form-control-lg light-300 nameConfig">${item.name}</span>
	                        	<label for="floatingname light-300">항목</label>
	                        </div>
	                    </div>
	                    
	                    <div class="col-4">
	                    	<button type="button" class="btn btn-primary text-white light-300" onclick="nameConfigEdit('${item.code}');" style="width: 47.5%; margin-top: 4%;">수정</button>
	                    	<button type="button" class="btn btn-danger text-white light-300" onclick="nameConfigDelete('${item.code}', '${mapper.code}');" style="width: 47.5%; margin-top: 4%;">삭제</button>
	                    </div>
                    </c:forEach>
                    
                    <div id="mapperNameConfigDiv"></div>
                    
                    <div class="dashed-line"></div>
                    
                    <div class="col-12">
                    	<button type="button" class="btn btn-dark text-white light-300" onclick="mapperNameIncrease();" style="width:100%; margin-bottom: 5%;">추가</button>
                    </div>
                    
                    <c:forEach var="item" items="${categoryConfigList}">
                    	<div class="col-1">
	                     	<select class="mapperCategoryImg" style="width:76px; height:70px;">
							     <option value="${item.imgPath}" data-image="${item.imgPath}" style="height: 50px"></option>
							</select>
	                     </div>
	                     
	                     <div class="col-7">
	                        <div class="form-floating mb-4">
	                            <div class="form-floating mb-4">
		                        	<span class="form-control form-control-lg light-300 categoryConfig">${item.name}</span>
		                        	<label for="floatingname light-300">카테고리</label>
		                        </div>
	                        </div>
	                    </div>
	                    
	                    <div class="col-4">
	                    	<button type="button" class="btn btn-primary text-white light-300" onclick="categoryConfigEdit('${item.code}');" style="width: 47.5%; margin-top: 4%;">수정</button>
	                    	<button type="button" class="btn btn-danger text-white light-300" onclick="categoryConfigDelete('${item.code}', '${mapper.code}');" style="width: 47.5%; margin-top: 4%;">삭제</button>
	                    </div>
                    </c:forEach>
                     
                    <div id="mapperCategoryConfigDiv"></div>
                    
                    <div class="col-12">
                    	<button type="button" class="btn btn-dark text-white light-300" onclick="mapperCategoryIncrease();" style="width:100%; margin-bottom: 5%;">추가</button>
                    </div>
                    
                    <div class="dashed-line"></div>
                	
                	
                	<div class="col-md-4 col-4 m-auto">
                		<a href="/app/mapper/index" class="btn btn-dark rounded-pill px-md-5 px-4 py-2 radius-0 text-light light-300">목록</a>
                    </div>
                	
                    <div class="col-md-4 col-4 m-auto text-center">
                        <button type="button" id="submit" class="btn btn-secondary rounded-pill px-md-5 px-4 py-2 radius-0 text-light light-300">확인</button>
                    </div>
                    
                    <div class="col-md-4 col-4 m-auto text-right">
                		<a href="/app/mapper/delete?code=${mapper.code}" class="btn btn-danger rounded-pill px-md-5 px-4 py-2 radius-0 text-light light-300">삭제</a>
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
		$('.mapperCategoryImg').msDropDown();
		
		$(".editAuth").change(function() {
			if($(this).val() == '2'){
				$(".editPassword_div").show();
			}else{
				$("#editPassword").val('');
				$(".editPassword_div").hide();
			}
		});
		
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
                url: "/app/mapper/edit",
                type : "POST",
                data:JSON.stringify(data),
                enctype: "multipart/form-data",
           	 	contentType:'application/json',
                dataType:'json',
            });

            request.done(function (data) {
                if (data == true) {
                   	window.location.href = "/app/mapper/index?page=1";
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
<script>
	function mapperNameIncrease() {
		var number = $("#mapperNameConfigDiv").find('.row').length;
		var count  = $(".nameConfig").length;
		
		if(count == 5){
			alert("최대 5개까지 설정가능합니다.");
			return;
		}
		
		var html = "";
		html += "<div class='row'>";
		html += 	"<div class='col-8'>";
		html += 		"<div class='form-floating mb-4'>";
		html += 			"<input type='text' class='form-control form-control-lg light-300 nameConfig' name='mapperName["+ number +"][name]' placeholder='항목' />";
		html += 			"<label for='floatingname light-300'>항목</label>";
		html += 		"</div>";
		html += 	"</div>";
		html += 	"<div class='col-4'>";
		html += 		"<button type='button' class='btn btn-danger text-white light-300' onclick='mapperNameDecrease(this);' style='width: 95%; margin-top: 4%;'>삭제</button>";
		html += 	"</div>";
		html += "</div>";
		
		$("#mapperNameConfigDiv").append(html);
		
		var mapperNameCount = $("#mapperNameConfigDiv").find('.row').length;
		$("#mapperNameCount").val(mapperNameCount);
	}
	
	function mapperNameDecrease(obj) {
		$(obj).parent().parent().remove();
		
		var count = $("#mapperNameConfigDiv").find('.row').length;
		$("#mapperNameCount").val(count);
	}
</script>
           
<script>
	function mapperCategoryIncrease() {
		var number = $("#mapperCategoryConfigDiv").find('.row').length;
		var count  = $(".categoryConfig").length;
		
		if(count == 5){
			alert("최대 5개까지 설정가능합니다.");
			return;
		}
		var html = "";
		html += "<div class='row'>";
		html += 	"<div class='col-1'>";
		html += 		"<select class='mapperCategoryImg' name='mapperCategoryImgPath["+ number +"][name]' style='width: 76px; height: 70px;'>";
		html += 			"<option value='https://moyeoyou.kr/assets/common/img/marker/new_maker_00.png' data-image='https://moyeoyou.kr/assets/common/img/marker/new_maker_00.png' style='height: 50px' selected='selected'></option>";
		html += 			"<option value='https://moyeoyou.kr/assets/common/img/marker/new_maker_01.png' data-image='https://moyeoyou.kr/assets/common/img/marker/new_maker_01.png' style='height: 50px'></option>";
		html += 			"<option value='https://moyeoyou.kr/assets/common/img/marker/new_maker_02.png' data-image='https://moyeoyou.kr/assets/common/img/marker/new_maker_02.png' style='height: 50px'></option>";
		html += 			"<option value='https://moyeoyou.kr/assets/common/img/marker/new_maker_03.png' data-image='https://moyeoyou.kr/assets/common/img/marker/new_maker_03.png' style='height: 50px'></option>";
		html += 			"<option value='https://moyeoyou.kr/assets/common/img/marker/new_maker_04.png' data-image='https://moyeoyou.kr/assets/common/img/marker/new_maker_04.png' style='height: 50px'></option>";
		html += 			"<option value='https://moyeoyou.kr/assets/common/img/marker/new_maker_05.png' data-image='https://moyeoyou.kr/assets/common/img/marker/new_maker_05.png' style='height: 50px'></option>";
		html += 		"</select>";
		html += 	"</div>";
		html += 	"<div class='col-7'>";
		html += 		"<div class='form-floating mb-4'>";
		html += 			"<input type='text' class='form-control form-control-lg light-300 categoryConfig' name='mapperCategory["+ number +"][name]' placeholder='카테고리' />";
		html += 			"<label for='floatingname light-300'>카테고리</label>";
		html += 		"</div>";
		html += 	"</div>";
		html += 	"<div class='col-4'>";
		html += 		"<button type='button' class='btn btn-danger text-white light-300' onclick='mapperCategoryDecrease(this);' style='width: 95%; margin-top: 4%;'>삭제</button>";
		html += 	"</div>";
		html += "</div>";
		
		$("#mapperCategoryConfigDiv").append(html);
		
		var mapperCategoryCount = $("#mapperCategoryConfigDiv").find('.row').length;
		$("#mapperCategoryCount").val(mapperCategoryCount);
		
		$('.mapperCategoryImg').msDropDown();
	}
	
	function mapperCategoryDecrease(obj) {
		$(obj).parent().parent().remove();
		
		var count = $("#mapperCategoryConfigDiv").find('.row').length;
		$("#mapperCategoryCount").val(count);
	}
</script>
<script>
	function nameConfigEdit(code) {
		 var request = $.ajax({
             url: "/app/mapperNameConfig/edit",
             type : "Get",
             data:{code: code},
             dataType:'html',
         });

         request.done(function (data) {
             $('body').append(data);
             $('.modal').show();
         });

         request.fail(function (jqXHR, textStatus) {
             alert("Request failed: " + textStatus);
         });
	}
	
	function nameConfigDelete(code, mapperCode) {
		if(confirm("삭제시 등록되어 있는 데이터도 함께 삭제됩니다. \n삭제하시겠습니까?")){
			window.location.href = "/app/mapperNameConfig/delete?code="+code+"&mapperCode="+mapperCode;
		}
	}
</script>
<script>
	function categoryConfigEdit(code) {
		var request = $.ajax({
            url: "/app/mapperCategoryConfig/edit",
            type : "Get",
            data:{code: code},
            dataType:'html',
        });

        request.done(function (data) {
            $('body').append(data);
            $('.modal').show();
        });

        request.fail(function (jqXHR, textStatus) {
            alert("Request failed: " + textStatus);
        });
	}
	
	function categoryConfigDelete(code, mapperCode) {
		if(confirm("삭제시 등록되어 있는 데이터도 함께 삭제됩니다. \n삭제하시겠습니까?")){
			window.location.href = "/app/mapperCategoryConfig/delete?code="+code+"&mapperCode="+mapperCode;
		}
	}
</script>
