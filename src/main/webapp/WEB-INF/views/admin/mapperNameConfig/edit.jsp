<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="modal fade modal-center" id="myLargeModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" style="margin-top: 20%; opacity: 1; overflow: inherit;">
  <div class="modal-dialog modal-lg modal-center" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="myModalLabel">항목 수정</h5>
      </div>
      <div class="modal-body">
         <div class="col-12">
            <div class="form-floating mb-4">
                <input type="text" 
                		class="form-control form-control-lg light-300" 
                		id="nameConfigValue" 
                		value="${config.name}" 
                		placeholder="이름">
                <div class="is_name_val text-danger" style="display:none; font-size: 13px;">이름을 입력해주세요.</div>
            </div>
         </div>
      </div>
      <div class="modal-footer">
        <div class="col-4" style="float: right;">
         	<span class="btn btn-primary text-white light-300 NameConfigSubmit" style="width: 40%;">확인</span>
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
		
		$(".NameConfigSubmit").click(function() {
			if ($("#nameConfigValue").val().trim() == '') {
		          $("#nameConfigValue").focus();
		          alert("항목의 이름을 입력해주세요.");
		          return false;
		    }
			
		  var request = $.ajax({
	            url: "/app/mapperNameConfig/edit",
	            type : "POST",
	            data:{
	            	code: ${config.code},
	            	name: $("#nameConfigValue").val()
	            },
	            dataType:'json',
	        });

	        request.done(function (data) {
	        	console.log(data);
	            if (data == true) {
	               	window.location.href = "/admin/mapper/edit?mapperCode="+ ${config.mapper.code} +"&memberCode=" + ${memberCode};
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