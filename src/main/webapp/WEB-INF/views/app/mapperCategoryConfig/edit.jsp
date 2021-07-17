<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="modal fade modal-center" id="myLargeModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" style="margin-top: 20%; opacity: 1; overflow: inherit;">
  <div class="modal-dialog modal-lg modal-center" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">카테고리 수정</h4>
      </div>
      <div class="modal-body">
      	<div class="row">
      		<div class="col-1">
	          <select id="categoryConfigImgValue" style="width:76px; height:70px;">
			     <option value="https://moyeoyou.kr/assets/common/img/marker/new_maker_00.png" data-image="https://moyeoyou.kr/assets/common/img/marker/new_maker_00.png" style="height: 50px"></option>
			     <option value="https://moyeoyou.kr/assets/common/img/marker/new_maker_01.png" data-image="https://moyeoyou.kr/assets/common/img/marker/new_maker_01.png" style="height: 50px"></option>
			     <option value="https://moyeoyou.kr/assets/common/img/marker/new_maker_02.png" data-image="https://moyeoyou.kr/assets/common/img/marker/new_maker_02.png" style="height: 50px"></option>
			     <option value="https://moyeoyou.kr/assets/common/img/marker/new_maker_03.png" data-image="https://moyeoyou.kr/assets/common/img/marker/new_maker_03.png" style="height: 50px"></option>
			     <option value="https://moyeoyou.kr/assets/common/img/marker/new_maker_04.png" data-image="https://moyeoyou.kr/assets/common/img/marker/new_maker_04.png" style="height: 50px"></option>
			     <option value="https://moyeoyou.kr/assets/common/img/marker/new_maker_05.png" data-image="https://moyeoyou.kr/assets/common/img/marker/new_maker_05.png" style="height: 50px"></option>
			   </select>
	         </div>
	         <div class="col-11">
	            <div class="form-floating mb-4">
	                <input type="text" 
	                		class="form-control form-control-lg light-300" 
	                		id="categoryConfigNameValue" 
	                		value="${config.name}" 
	                		placeholder="카테고리">
	                <label for="floatingname light-300">카테고리</label>
	            </div>
	         </div>
      	</div>
      </div>
      <div class="modal-footer">
        <div class="col-4" style="float: right;">
         	<span class="btn btn-primary text-white light-300 CategoryConfigSubmit" style="width: 40%;">확인</span>
         	<span class="btn btn-dark text-white light-300 close" style="width: 40%;">닫기</span>
         </div>
      </div>
    </div>
  </div>
</div>
<script>
	$(document).ready(function() {
		var imgPath = "<c:out value='${config.imgPath}'/>";
		$("#categoryConfigImgValue").val(imgPath).prop("selected", true);
		$("#categoryConfigImgValue").msDropDown();
	
		$(".close").click(function() {
			$('.modal').hide();
			$(".modal").remove();
		});
		
		$(".CategoryConfigSubmit").click(function() {
			if ($("#categoryConfigNameValue").val().trim() == '') {
		          $("#categoryConfigNameValue").focus();
		          alert("카테고리의 이름을 입력해주세요.");
		          return false;
		    }
			
		  var request = $.ajax({
	            url: "/app/mapperCategoryConfig/edit",
	            type : "POST",
	            data:{
	            	code: ${config.code},
	            	name: $("#categoryConfigNameValue").val(),
	            	imgPath: $("#categoryConfigImgValue option:selected").val()
	            },
	            dataType:'json',
	        });

	        request.done(function (data) {
	            if (data == true) {
	               	window.location.href = "/app/mapper/edit?code=" + ${config.mapper.code};
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