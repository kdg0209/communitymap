<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../../layouts/app/head.jsp"%>

<%@include file="../../layouts/app/header.jsp"%>

<body>
	<section class="service-wrapper py-3">
        <div class="container-fluid pb-3">
            <div class="row">
                <h2 class="h2 text-center col-12 py-5 semi-bold-600">나의 지도 관리</h2>
            </div>
        </div>
    </section>
    
 	<section class="container py-5">
        <div class="row projects gx-lg-5">
	        <c:forEach var="item" items="${mappingList}">
		        <a href="javascript:;" class="col-sm-6 col-lg-4 text-decoration-none project marketing social business" style="margin-top: 50px;">
	                <div class="service-work overflow-hidden card mb-5 mx-5 m-sm-0">
	                    <img class="card-img-top" src="<c:url value='/img/mapperCover/77cd376a-b7d5-403f-b1e8-fc51d70d6e9f_PS21060200161.jpg'/>" style="width: 100%; height: 180px;" />
	                    <div class="card-body">
	                        <h5 class="card-title light-300 text-dark">1111</h5>
	                        <p class="card-text light-300 text-dark">
	                      	 	222222
	                        </p>
	                        <div style="float: right;">
	                        	<span class="text-decoration-none text-dark light-300" onclick="EditFn('${item.code}');">
	                              수정 <i class="fas fa-edit"></i>
		                        </span>
		                        <span class="text-decoration-none text-dark light-300" onclick="DetailFn('${item.code}');">
	                              상세 조회 <i class="fas fa-angle-right"></i> 
		                        </span>
	                        </div>
	                    </div>
	                </div>
	            </a>
	        </c:forEach>
        </div>
        
        <div class="row">
        	 <div class="col-md-12 col-12 m-auto text-right">
        	 <a href="/app/mapping/write?mapperCode=${mapperCode}" class="btn btn-info rounded-pill px-md-5 px-4 py-2 radius-0 text-light light-300">작성하기</a>
              </div>
        </div>
        
        <div class="row" style="margin-top: 50px;">
            <div class="btn-toolbar justify-content-center pb-4" role="toolbar" aria-label="Toolbar with button groups">
                <div class="btn-group me-2" role="group" aria-label="First group">
                    <button type="button" class="btn btn-secondary text-white">Previous</button>
                </div>
                <div class="btn-group me-2" role="group" aria-label="Second group">
                    <button type="button" class="btn btn-light">1</button>
                </div>
                <div class="btn-group me-2" role="group" aria-label="Second group">
                    <button type="button" class="btn btn-secondary text-white">2</button>
                </div>
                <div class="btn-group" role="group" aria-label="Third group">
                    <button type="button" class="btn btn-secondary text-white">Next</button>
                </div>
            </div>
        </div>
    </section>
    
     
   	<%@include file="../../layouts/app/footer.jsp"%>
</body>
<%@include file="../../layouts/app/script.jsp"%>
