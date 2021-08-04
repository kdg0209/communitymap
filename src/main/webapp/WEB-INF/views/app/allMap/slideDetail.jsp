<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style media="screen">
.swiper-container {
  margin-left: auto;
  margin-right: auto;
  position: relative;
  overflow: hidden;
  list-style: none;
  padding: 0;
  height: auto;
  z-index: 1;
}

.tourism-top { background: #eee; height: 250px;}
.tourism-top .swiper-slide { height: 250px; }
.thumbs-img {
  position:relative;
  width:100%;
  height: 100%;
}
.thumbs-img img {
  max-width:100%;
  width:auto;
  max-height: 100%;
  transform: translate(-50%,-50%);
  position:absolute;
  left:50%;
  top:50%;
}
.thumbs_wrap {
  width:100%;
  position:relative;
}
.tourism-thumbs .thumbs-img {
    height: 55px;
}
.tourism-thumbs .swiper-slide .thumbs-img {
    position: relative;
    cursor: pointer;
}
.tourism-thumbs .thumbs-img img {
    width: auto;
    height: auto;
    max-width: 100%;
    max-height: 100%;
    -ms-transform: translate(-50%, -50%);
    -webkit-transform: translate(-50%, -50%);
    -moz-transform: translate(-50%, -50%);
    transform: translate(-50%, -50%);
    position: absolute;
    left: 50%;
    top: 50%;
}
.tourism-thumbs .swiper-slide .thumbs-img::after {
    content: '';
    display: block;
    width: 100%;
    height: 100%;
    position: absolute;
    top: 0;
    left: 0;
}
</style>

<div class="slideDetail">
  <div class="swiper-container tourism-top">
    <div class="swiper-wrapper">
       <div class="swiper-slide">
         <div class="thumbs-img">
             <img src="/img/mappingCover/${mapping.fileName}">
         </div>
       </div>
       <c:forEach items="${mappingFilesList}" var="files">
          <div class="swiper-slide">
            <div class="thumbs-img">
                <img src="/img/mappingFiles/${files.fileName}">
            </div>
          </div>
        </c:forEach>
    </div>
  </div>

  <div class="sidebar-body">
    <div class="cont-box detail_content">
      <div class="cont-box-wrap content_box">
        <div class="info-btn content_tit_box">
          <h4 class="tit01">정보</h4>
        </div>
        <div class="info_div top_p_none">
          <ul class="list-ul">
            <c:forEach var="item" items="${namesConfigList}">
              <li class="detail_list">
                  <strong>${item.name}</strong>
                  <div class="txt">
                    <span class="NameValues"></span>
                  </div>
              </li>
            </c:forEach>
            <li class="detail_list">
                <strong>주소</strong>
                <div class="txt">
                  ${mapping.address}
                </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
 </div>

<script type="text/javascript">
  $(document).ready(function(){
	  var valueArray = new Array(); 
	  
	  <c:forEach var="item" items="${mappingHasNamesList}">
	  	valueArray.push("${item.fieldValues}");
      </c:forEach>
      
      $(".NameValues").each(function (index) {
 		 $(this).html(valueArray[index]);
 	  });
      
      var Swipes = new Swiper('.swiper-container', {
   	    navigation: {
   	        nextEl: '.swiper-button-next',
   	        prevEl: '.swiper-button-prev',
   	    },
   	    pagination: {
   	        el: '.swiper-pagination',
   	    },
   	  });
  });
</script>
