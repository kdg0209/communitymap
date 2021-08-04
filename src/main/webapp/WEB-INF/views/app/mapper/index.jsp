<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="../../layouts/app/head.jsp"%>

<%@include file="../../layouts/app/header.jsp"%>

<body>
	<section class="service-wrapper py-3">
        <div class="container-fluid pb-3">
            <div class="row">
                <h2 class="h2 text-center col-12 py-5 semi-bold-600">나의 지도 관리</h2>
            </div>
        </div>
        
        <div class="row justify-content-center my-5">
            <div class="filter-btns shadow-md rounded-pill text-center col-auto">
                <a class="btn rounded-pill btn-outline-primary border-0 m-md-2 px-md-4  ${sort eq 'writeDate' ? 'active':''}" href="/app/mapper/index?page=1&sort=writeDate">최신순</a>
                <a class="btn rounded-pill btn-outline-primary border-0 m-md-2 px-md-4 ${sort eq 'mapperRecommendCount' ? 'active':''}" href="/app/mapper/index?page=1&sort=mapperRecommendCount">인기순</a>
                <a class="btn rounded-pill btn-outline-primary border-0 m-md-2 px-md-4 ${sort eq 'countOfMapping' ? 'active':''}" href="/app/mapper/index?page=1&sort=countOfMapping">데이터순</a>
                <a class="btn rounded-pill btn-outline-primary border-0 m-md-2 px-md-4 ${sort eq 'declareCount' ? 'active':''}" href="/app/mapper/index?page=1&sort=declareCount">신고건수순</a>
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
	                        <p class="card-text" style="font-size: 14px;"><i class="fas fa-map-marker-alt"></i> ${item.countOfMapping}개의 저장소</p>
	                   		<p class="card-text ${item.declareCount > 0 ? 'text-danger':''}" style="font-size: 14px;"><i class="fas fa-exclamation-circle"></i>${item.declareCount}개의 신고접수가 있습니다.</p>
	                        <p class="card-text light-300 text-dark">
	                      	  <c:out value="${fn:substring(item.contents, 0, 25) }"/>
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
        
        <div class="row" style="margin-top: 50px;">
        	 <div class="col-md-12 col-12 m-auto text-right">
        	 <a href="/app/mapper/write" class="btn btn-info rounded-pill px-md-5 px-4 py-2 radius-0 text-light light-300">추가하기</a>
              </div>
        </div>
        
        <div class="row" style="margin-top: 50px;">
            <div class="btn-toolbar justify-content-center pb-4" role="toolbar" aria-label="Toolbar with button groups">
             <c:choose>
		         <c:when test = "${hasPrevious}">
		            <div class="btn-group me-2" role="group" aria-label="First group">
		            	<a href="/app/mapper/index?page=${page -1}&sort=${sort}" class="btn btn-secondary text-white">
		              	 	Previous
		               	</a>
	                </div>
		         </c:when>
		      </c:choose>
      
               <c:forEach var="loop" begin="1" end="${getTotalPages}" step="1">
	               	<div class="btn-group me-2" role="group" aria-label="Second group">
		               	<a href="/app/mapper/index?page=${loop}&sort=${sort}" class="${loop eq page ? 'btn btn-secondary text-white':'btn btn-light'}">
		              	 	${loop}
		               	</a>
	                </div>
               </c:forEach>
               
              <c:choose>
		         <c:when test = "${hasNext}">
		            <div class="btn-group" role="group" aria-label="Third group">
		            	<a href="/app/mapper/index?page=${page +1}&sort=${sort}" class="btn btn-secondary text-white">
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

<script>
	function EditFn(code) {
		window.location.href = "/app/mapper/edit?code="+code;
	}
	
	function DetailFn(code) {
		window.location.href = "/app/mapping/index?mapperCode="+code+"&page=1";
	}
</script>