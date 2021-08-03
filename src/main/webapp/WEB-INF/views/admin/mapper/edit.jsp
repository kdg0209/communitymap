<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="../../layouts/admin/head.jsp"%>


<body>
  <div id="app">
    <div class="main-wrapper">
    	<%@include file="../../layouts/admin/header.jsp"%>
    	<%@include file="../../layouts/admin/sidebar.jsp"%>

      	<div class="main-content">
	        <section class="section">
	          <div class="section-header">
	            <h1>회원 정보 수정</h1>
	            <div class="section-header-breadcrumb">
	              <div class="breadcrumb-item active">회원</div>
	              <div class="breadcrumb-item">정보 수정</div>
	            </div>
	          </div>
	
	          <div class="section-body">
	            <h2 class="section-title">Editor</h2>
	            <p class="section-lead">${mapper.code}님의 정보 수정</p>
	
	            <form id="submitForm">
	            	<input type="hidden" name="code" value="${mapper.code}" />
                	<input type="hidden" name="mapperNameCount" id="mapperNameCount" value="0" />
                	<input type="hidden" name="mapperCategoryCount" id="mapperCategoryCount" value="0" />
                	<input type="hidden" name="filename" id="filename"/>
                	<input type="hidden" name="cover" id="cover" />
	            	<div class="row">
		              <div class="col-12">
		                <div class="card">
		                  <div class="card-body">
		                  
		                  	<div class="form-group row mb-4" style="display: flex; justify-content: center;">
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
		                  	
		                  	<div class="form-group row mb-4">
		                      <label class="col-form-label col-2">제목</label>
		                      <div class="col-sm-10">
		                        <input type="text" 
		                        	   id="name"
		                        	   name="name"
		                        	   value="${mapper.name}"
		                        	   class="form-control">
		                      </div>
		                    </div>
		                    
		                    <div class="form-group row mb-4">
		                      <label class="col-form-label col-2">지도에 대한 소개</label>
		                      <div class="col-sm-10">
		                            <textarea class="form-control summernote-simple"
		                            		  id="contents" 
		                            		  name="contents"
		                            	      style="margin-top: 0px; margin-bottom: 0px; height: 100%;">${mapper.contents}</textarea>
		                      </div>
		                    </div>
		                  
		                  	<div class="form-group row">
	                          <label class="col-form-label col-2">카테고리</label>
	                          <div class="col-sm-10">
	                            <div class="selectgroup w-100">
		                            <c:forEach var="item" items="${categoryList}">
		                          		<label class="selectgroup-item">
			                                <input type="radio" 
			                                	   name="categoryCode" 
			                                	   value="${item.key}" 
			                                	   class="selectgroup-input"
			                                	   ${item.key eq mapper.categoryCode ? 'checked' : ''}>
			                                <span class="selectgroup-button">${item.value}</span>
		                              </label>
		                          	</c:forEach>
	                            </div>
	                          </div>
	                        </div>
	                        
	                        <div class="form-group row">
	                          <label class="col-form-label col-2">접근권한</label>
	                          <div class="col-sm-10">
	                            <div class="selectgroup w-100">
		                            <c:forEach var="item" items="${editAuth}">
		                          		<label class="selectgroup-item">
			                                <input type="radio" 
			                                	   name="editAuth" 
			                                	   value="${item.key}" 
			                                	   class="selectgroup-input editAuth"
			                                	   ${item.key eq mapper.editAuth ? 'checked' : ''}>
			                                <span class="selectgroup-button">${item.value}</span>
		                              </label>
		                          	</c:forEach>
	                            </div>
	                          </div>
	                        </div>
		                
		                    <div class="form-group row mb-4 editPassword_div" style="display: none;">
		                      <label class="col-form-label col-2">비밀번호</label>
		                      <div class="col-sm-10">
		                        <input type="password" 
		                        	   id="editPassword"
		                        	   name="editPassword"
		                        	   value="${item.editPassword}"
		                        	   class="form-control">
		                      </div>
		                    </div>
		                    
		                    <div class="dashed-line"></div>
		                    
		                    <c:forEach var="item" items="${nameConfigList}" varStatus="status">
		                    	<div class="form-group row mb-4">
			                    	  <label class="col-form-label col-2">${status.index == 0 ? '항목':''}</label>
				                      <div class="${status.index == 0 ? 'col-sm-10':'col-sm-6'}">
				                        <input type="text" 
				                        	   value="${item.name}"
				                        	   class="form-control nameConfig"
				                        	   readonly="readonly"
				                        	   style="background-color: white;">
				                      </div>
				                    
					                   <c:if test="${status.index >= 1}">
						                   <div class="${status.index >= 1 ? 'col-sm-4':''}">
							                   	<button type="button" class="btn btn-primary text-white light-300" onclick="nameConfigEdit('${item.code}');" style="width: 47.5%; margin-top: 4%;">수정</button>
							                   	<button type="button" class="btn btn-danger text-white light-300" onclick="nameConfigDelete('${item.code}', '${mapper.code}', '${memberCode}');" style="width: 47.5%; margin-top: 4%;">삭제</button>
						                    </div>
					                   </c:if>
				                 </div>
		                     </c:forEach>
		                     
		                     <div id="mapperNameConfigDiv"></div>
		                     <div class="col-12">
		                    	<button type="button" class="btn btn-dark text-white light-300" onclick="mapperNameIncrease();" style="width:100%;">추가</button>
		                     </div>
		                       <div class="dashed-line"></div>
		                    
			                 
			                 <c:forEach var="item" items="${categoryConfigList}" varStatus="status">
		                    	<div class="form-group row mb-4">
		                    		<label class="col-form-label col-2">${status.index == 0 ? '카테고리':''}</label>
		                    		<div class="col-sm-1">
		                    			<img src="${item.imgPath}" style="width:33px; height:43px;">
		                    		</div>
		                    		
		                    		<div class="col-sm-5">
				                        <input type="text" 
				                        	   value="${item.name}"
				                        	   class="form-control categoryConfig"
				                        	   readonly="readonly"
				                        	   style="background-color: white;">
			                      	</div>
			                      	
			                      	<div class="col-4">
				                    	<button type="button" class="btn btn-primary text-white light-300" onclick="categoryConfigEdit('${item.code}');" style="width: 47.5%; margin-top: 4%;">수정</button>
				                    	<button type="button" class="btn btn-danger text-white light-300" onclick="categoryConfigDelete('${item.code}', '${mapper.code}', '${memberCode}');" style="width: 47.5%; margin-top: 4%;">삭제</button>
				                    </div>
			                     </div>
		                    </c:forEach>   
		                  
		                  	<div id="mapperCategoryConfigDiv"></div>
                    
		                    <div class="col-12">
		                    	<button type="button" class="btn btn-dark text-white light-300" onclick="mapperCategoryIncrease();" style="width:100%; margin-bottom: 5%;">추가</button>
		                    </div>
		                    
		                    <div class="form-group row mb-4">
		                      <div class="col-sm-4">
			                        <a href="/admin/mapper/detailIndex?memberCode=${memberCode}" class="btn btn-primary">
			                        	<i class="fas fa-bars"></i> 목록
			                        </a>
		                      </div>
		                       <div class="col-sm-4 text-center">
			                       	<button type="button" id="submit" class="btn btn-primary">
			                       		확인
			                       	</button>
		                      </div>
		                       <div class="col-sm-4 text-right">
		                       		<a href="/admin/mapper/delete?mapperCode=${mapper.code}&memberCode=${memberCode}" class="btn btn-danger delete">
		                        		<i class="far fa-trash-alt"></i> 삭제
		                        	</a>
		                      </div>
		                    </div>
		                  </div>
		                </div>
		              </div>
		            </div>
	            </form>
	          </div>
	        </section>
      	</div>
    </div>
  </div>
</body>
 <%@include file="../../layouts/admin/script.jsp"%>
 
 <script>
 	$(document).ready(function () {
 		$(".editAuth").change(function() {
			if($(this).val() == '2'){
				$(".editPassword_div").show();
			}else{
				$("#editPassword").val('');
				$(".editPassword_div").hide();
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
	        data.memberCode = String(${memberCode});
	        
	        var request = $.ajax({
                url: "/admin/mapper/edit",
                type : "POST",
                data:JSON.stringify(data),
           	 	contentType:'application/json',
                dataType:'json',
            });

            request.done(function (data) {
               if (data == true) {
                   	window.location.href = "/admin/mapper/detailIndex?memberCode=" + ${memberCode};
                } else if (data == false) {
                	alert("잘못된 접근입니다. 다시 시도해주세요.");
                	return false;
                }
            });

            request.fail(function (jqXHR, textStatus) {
                alert("Request failed: " + textStatus);
            });
		});
	})
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
		html += "<div class='form-group row mb-4'>";
		html += 	"<label class='col-form-label col-2'></label>";
		html += 	"<div class='col-sm-6'>";
		html += 		"<input type='text' class='form-control nameConfig' name='mapperName["+ number +"][name]' placeholder='항목' />";
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
		html += "<div class='form-group row mb-4'>";
		html += 	"<label class='col-form-label col-2'></label>";
		html += 	"<div class='col-sm-1'>";
		html += 		"<select class='mapperCategoryImg' name='mapperCategoryImgPath["+ number +"][name]' style='width: 76px; height: 70px;'>";
		html += 			"<option value='https://moyeoyou.kr/assets/common/img/marker/new_maker_00.png' data-image='https://moyeoyou.kr/assets/common/img/marker/new_maker_00.png' style='height: 50px' selected='selected'></option>";
		html += 			"<option value='https://moyeoyou.kr/assets/common/img/marker/new_maker_01.png' data-image='https://moyeoyou.kr/assets/common/img/marker/new_maker_01.png' style='height: 50px'></option>";
		html += 			"<option value='https://moyeoyou.kr/assets/common/img/marker/new_maker_02.png' data-image='https://moyeoyou.kr/assets/common/img/marker/new_maker_02.png' style='height: 50px'></option>";
		html += 			"<option value='https://moyeoyou.kr/assets/common/img/marker/new_maker_03.png' data-image='https://moyeoyou.kr/assets/common/img/marker/new_maker_03.png' style='height: 50px'></option>";
		html += 			"<option value='https://moyeoyou.kr/assets/common/img/marker/new_maker_04.png' data-image='https://moyeoyou.kr/assets/common/img/marker/new_maker_04.png' style='height: 50px'></option>";
		html += 			"<option value='https://moyeoyou.kr/assets/common/img/marker/new_maker_05.png' data-image='https://moyeoyou.kr/assets/common/img/marker/new_maker_05.png' style='height: 50px'></option>";
		html += 		"</select>";
		html += 	"</div>";
		html += 	"<div class='col-sm-5'>";
		html += 		"<div class='form-floating mb-4'>";
		html += 			"<input type='text' class='form-control categoryConfig' name='mapperCategory["+ number +"][name]' placeholder='카테고리' />";
		html += 		"</div>";
		html += 	"</div>";
		html += 	"<div class='col-sm-4'>";
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
             url: "/admin/mapperNameConfig/edit",
             type : "Get",
             data:{
            	 code: code,
            	 memberCode: ${memberCode}
           	 },
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
	
	function nameConfigDelete(code, mapperCode, memberCode) {
		if(confirm("삭제시 등록되어 있는 데이터도 함께 삭제됩니다. \n삭제하시겠습니까?")){
			window.location.href = "/admin/mapperNameConfig/delete?code="+code+"&mapperCode="+mapperCode+"&memberCode="+memberCode;
		}
	}
</script>
<script>
	function categoryConfigEdit(code) {
		var request = $.ajax({
            url: "/admin/mapperCategoryConfig/edit",
            type : "Get",
            data:{
	           	 code: code,
	           	 memberCode: ${memberCode}
          	 },
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
	
	function categoryConfigDelete(code, mapperCode, memberCode) {
		if(confirm("삭제시 등록되어 있는 데이터도 함께 삭제됩니다. \n삭제하시겠습니까?")){
			window.location.href = "/admin/mapperCategoryConfig/delete?code="+code+"&mapperCode="+mapperCode+"&memberCode="+memberCode;
		}
	}
</script>

