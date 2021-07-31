<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="modal fade modal-center" id="myLargeModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" style="margin-top: 20%; opacity: 1; overflow: inherit;">
  <div class="modal-dialog modal-lg modal-center" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">
     	   <i class="fas fa-exclamation-circle"></i>신고하기
        </h4>
      </div>
      <div class="modal-body">
      	<div class="row">
	         <div class="col-12">
	            <div class="form-floating mb-4">
	            <textarea class="form-control light-300 memo" 
	            		  name="memo" 
	            		  rows="5" 
	            		  placeholder="신고접수 내용" id="floatingtextarea"
	            		  style="height: calc(6.5rem + 2px);"></textarea>
	                <label for="floatingtextarea light-300">신고접수 내용</label>
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
			if($(".memo").val() == ""){
				$(".memo").focus();
				return false;
			}
			
			var request = $.ajax({
	            url: "/app/mappingDeclare/write",
	            type: "post",
	            dataType: "json",
	            contentType: 'application/json',
	            data: JSON.stringify({
	      		  "mappingCode": String(${mapping.code}),
	      		  "mapperCode": String(${mapping.mapper.code}),
	      		  "memo": $(".memo").val()
	      	  	}) 
	          });
			
			 request.done(function(data) {
				  if (data == true) {
				  	alert("정상적으로 접수되었습니다.");
		            window.location.reload();
		          } else if (data == false) {
		         	alert("잘못된 접근입니다.");
		          	return false;
		          }
	          });
			
			 request.fail(function( jqXHR, textStatus ) {
	             console.log("Request failed: " + textStatus);
	         });
		});
	});
</script>