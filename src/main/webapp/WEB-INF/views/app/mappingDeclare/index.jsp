<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="../../layouts/app/head.jsp"%>

<%@include file="../../layouts/app/header.jsp"%>

<body>
    <section class="service-wrapper py-3">
        <div class="container-fluid pb-3">
            <div class="row">
                <h2 class="h2 text-center col-12 py-5 semi-bold-600">신고 내역 조회</h2>
                <div class="service-header col-2 col-lg-3 text-end light-300">
              	    <i class="fas fa-exclamation-circle fa-2x"></i>
                </div>
                <div class="service-heading col-10 col-lg-9 text-start float-end light-300">
                    <h2 class="h3 pb-4 typo-space-line">Community Map</h2>
                </div>
            </div>
            <p class="service-footer col-10 offset-2 col-lg-9 offset-lg-3 text-start pb-3 text-muted px-2">
                해당 문제를 해결하여 사용자들의 불편함을 줄여주세요.!
            </p>
        </div>
    </section>
    
     <section class="container py-5">
        <div class="row pb-4" style="margin-top: -70px;">
        	<div class="col-lg-2"></div>
            <div class="col-lg-8">
         	    <div style="float: left;">
           		  <a href="javascript:history.back();" class="btn btn-dark btn-icon-split f-s-10"  style="float:right; font-size: 12px;">
           			   <i class="fas fa-angle-left"></i>
                       <span class="text">이전으로</span>
                  </a>
            	</div>
            	
            	<div style="float: right;">
           		  <a href="/app/mapping/edit?code=${mappingCode}&mapperCode=${mapperCode}" class="btn btn-dark btn-icon-split f-s-10"  style="float:right; font-size: 12px;">
                       <span class="text">해당 게시물로 이동</span>
                       <i class="fas fa-location-arrow"></i>
                  </a>
            	</div>
            	
               <div class="dashed-line"></div>
             
               <c:forEach var="item" items="${declareList}">
				    <div class="d-flex" style="margin-bottom: 3%;">
				        <div class="comment-body" style="width: 100%;">
				            <div class="comment-header d-flex justify-content-between ms-3">
				                <div class="header text-start">
				                    <p class="text-muted light-300">${item.writeDate}</p>
				                </div>
				            </div>
				            <div class="footer">
				                <div class="card-body border ms-3 light-300">
				                   ${item.memo}
				                </div>
				            </div>
				        </div>
				    </div>
               </c:forEach>
            </div>
            <div class="col-lg-2"></div>
        </div>
        
        <div class="row" style="margin-top: 50px;">
            <div class="btn-toolbar justify-content-center pb-4" role="toolbar" aria-label="Toolbar with button groups">
             <c:choose>
		         <c:when test = "${hasPrevious}">
		            <div class="btn-group me-2" role="group" aria-label="First group">
		            	<a href="/app/mappingDeclare/index?mappingCode=${mappingCode}&mapperCode=${mapperCode}&page=${page -1}" class="btn btn-secondary text-white">
		              	 	Previous
		               	</a>
	                </div>
		         </c:when>
		      </c:choose>
      
               <c:forEach var="loop" begin="1" end="${getTotalPages}" step="1">
	               	<div class="btn-group me-2" role="group" aria-label="Second group">
		               	<a href="/app/mappingDeclare/index?mappingCode=${mappingCode}&mapperCode=${mapperCode}&page=${loop}" class="${loop eq page ? 'btn btn-secondary text-white':'btn btn-light'}">
		              	 	${loop}
		               	</a>
	                </div>
               </c:forEach>
               
              <c:choose>
		         <c:when test = "${hasNext}">
		            <div class="btn-group" role="group" aria-label="Third group">
		            	<a href="/app/mappingDeclare/index?mappingCode=${mappingCode}&mapperCode=${mapperCode}&page=${page +1}" class="btn btn-secondary text-white">
		              	 	Next
		               	</a>
	                </div>
		         </c:when>
		      </c:choose>
            </div>
        </div>
    </section>
	<%@include file="../../layouts/app/footer.jsp"%>
</body>

<%@include file="../../layouts/app/script.jsp"%>
