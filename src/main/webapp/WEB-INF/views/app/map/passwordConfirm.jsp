<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="modal fade modal-center" id="myLargeModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" style="margin-top: 20%; opacity: 1; overflow: inherit;">
  <div class="modal-dialog modal-lg modal-center" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">
     	   <i class="fas fa-unlock-alt"></i> 비밀번호 인증
        </h4>
      </div>
      <div class="modal-body">
      	<div class="row">
	         <div class="col-12">
	            <div class="form-floating mb-4">
	            	<input type="password" 
	                	   class="form-control form-control-lg light-300" 
	                	   name="editPassword"
	                	   id="editPassword" 
	                	   placeholder="이름">
	                <label for="floatingname light-300">비밀번호</label>
	                <div class="is_editPassword_val text-danger" style="display:none; font-size: 13px;">비밀번호를 입력해주세요.</div>
	            </div>
	         </div>
      	</div>
      </div>
      
      <div class="modal-footer">
        <div class="col-4" style="float: right;">
         	<span class="btn btn-primary text-white light-300 Submit" style="width: 40%;">확인</span>
         	<span class="btn btn-dark text-white light-300 close" style="width: 40%;">닫기</span>
         </div>
      </div>
    </div>
  </div>
</div>
<script>
	$(document).ready(function() {
		$(".close").click(function() {
			$('.modal').hide();
			$(".modal").remove();
		});
		
		$(".Submit").click(function() {
			if($("#editPassword").val() == ""){
				$("#editPassword").focus();
				$(".is_editPassword_val").show();
				return false;
			}
			
			var request = $.ajax({
	            url: "/app/map/passwordConfirm",
	            type : "POST",
	            dataType:'json',
	            contentType: 'application/json',
	            data:JSON.stringify({
	            	"mapperCode": String(${mapperCode}),
	            	"editPassword": $("#editPassword").val()
	      	  	}) 
	        });

	        request.done(function (data) {
	        	if(data.result == true){
	        		window.location.href = "/app/mapping/write?mapperCode="+${mapperCode}+"&key=" + data.key;
	        	}
	        	if(data.result == false){
	        		alert("잘못된 접근입니다.");
	        		window.location.reload();
	        	}
	        });

	        request.fail(function (jqXHR, textStatus) {
	            alert("Request failed: " + textStatus);
	        });
		});
	});
</script>