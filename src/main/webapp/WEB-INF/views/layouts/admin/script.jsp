  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  
  <!-- General JS Scripts -->
  <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.nicescroll/3.7.6/jquery.nicescroll.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
  
  
  <script src="../../resources/admin/js/stisla.js"></script>

  <!-- Template JS File -->
  <script src="../../resources/admin/js/scripts.js"></script>
  <script src="../../resources/admin/js/custom.js"></script>
  
  <!-- category selectbox -->
  <script src="../../resources/common/app/plugun/categorySelect/categorySelectbox.js"></script>
  
  <script src="/resources/common/app/plugun/dropzone-5.7.0/dist/dropzone.js"></script>
  <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5436855d2d9c321ad418af5de00f3d90&libraries=services,clusterer,drawing"></script>

  
  <script>
  	$(document).ready(function () {
  		 $('.delete').click(function(event) {
  	        event.preventDefault();

  	        if (confirm('삭제하시겠습니까?')) {
  	            document.location.replace($(this).attr('href'));
  	        }
  	        return false;
  	    });
	});
  
  </script>