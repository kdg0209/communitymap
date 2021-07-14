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
	        <c:forEach var="item" items="${mapperList}">
		        <a href="javascript:;" class="col-sm-6 col-lg-4 text-decoration-none project marketing social business" style="margin-top: 50px;">
	                <div class="service-work overflow-hidden card mb-5 mx-5 m-sm-0">
	                    <img class="card-img-top" src="<c:url value='/img/mapperCover/${item.fileName}'/>" style="width: 100%; height: 180px;" />
	                    <div class="card-body">
	                        <h5 class="card-title light-300 text-dark"><c:out value="${item.name}"/></h5>
	                        <p class="card-text light-300 text-dark">
	                      	  <c:out value="${item.contents}"/>
	                        </p>
	                        <div style="float: right;">
	                        	<span class="text-decoration-none text-dark light-300" onclick="EditFn('${item.code}');">
	                              수정 <i class="fas fa-edit"></i>
		                        </span>
		                        <span class="text-decoration-none text-dark light-300">
		                              상세 조회 <i class="fas fa-angle-right"></i>
		                        </span>
	                        </div>
	                    </div>
	                </div>
	            </a>
	        </c:forEach>
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

<script>
	function EditFn(code) {
		window.location.href = "/app/mapper/edit?code="+code;
	}
</script>