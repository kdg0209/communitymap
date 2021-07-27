<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="../../layouts/app/head.jsp"%>

<%@include file="../../layouts/app/header.jsp"%>

<style>
.activist-search-wrap {
	padding:10px 0 40px;
	width: 580px;
	margin:auto;
	text-align: center;
}
.activist-la-box {
	display:inline-block;
	position:relative;
	margin:0 2px 10px;
}
.activist-la-box .activist-search-label {
	position:relative;
	display:inline-block;
	padding:2px 10px 3px;
	font-size: 16px;
	font-weight: 300;
	border:1px solid #e5e5e5;
	border-radius: 4px;
	cursor:pointer;
}
.activist-la-box input {
	display: none;
	width:10px;
	height:10px;
	position:absolute;
	background: #fff;
	border:1px solid #ddd;
	top:0;
	left:0;
}
.activist-la-box input:checked ~ .activist-search-label {
	border-color:#1b7dff;
	color:#1b7dff;
	font-weight: 500;
}
</style>

<body>
 	<section class="service-wrapper py-3">
        <div class="container-fluid pb-3">
            <div class="row">
                <h2 class="h2 text-center col-12 py-5 semi-bold-600">지도UP</h2>
                <div class="service-header col-2 col-lg-3 text-end light-300">
                	<i class="fas fa-map-marked-alt fa-2x"></i>
                </div>
                <div class="service-heading col-10 col-lg-9 text-start float-end light-300">
                    <h2 class="h3 pb-4 typo-space-line">Community Map</h2>
                </div>
            </div>
            <p class="service-footer col-10 offset-2 col-lg-9 offset-lg-3 text-start pb-3 text-muted px-2">
                모두가 공유 가능한 세상, 그 세상을 만들기 위해 고민하는 당신은 모두의 지도입니다. <br>
            </p>
        </div>
        	
        <div class="row justify-content-center my-5">
            <div class="filter-btns shadow-md rounded-pill text-center col-auto">
                <a class="btn rounded-pill btn-outline-primary border-0 m-md-2 px-md-4  ${sort eq 'writeDate' ? 'active':''}" href="/app/mapper/up?page=1&sort=writeDate&categoryCode=${categoryCode}">최신순</a>
                <a class="btn rounded-pill btn-outline-primary border-0 m-md-2 px-md-4" href="/app/mapper/up?page=1&sort=writeDate&categoryCode=${categoryCode}">인기순</a>
                <a class="btn rounded-pill btn-outline-primary border-0 m-md-2 px-md-4 ${sort eq 'countOfMapping' ? 'active':''}" href="/app/mapper/up?page=1&sort=countOfMapping&categoryCode=${categoryCode}">데이터순</a>
            </div>
        </div>
       
    
       <div class="row justify-content-center my-5">
       		<p class="text-center h4 pb-4">분류</p>
	        <div class="filter-btns shadow-md rounded-pill text-center col-auto">
	        	<a class="btn rounded-pill btn-outline-primary border-0 m-md-2 px-md-4 ${categoryCode eq 0 ? 'active':''}" 
		        	   href="/app/mapper/up?page=${page}&sort=${sort}">ALL</a>
		        <c:forEach var="item" items="${categoryList}">
		        	<a class="btn rounded-pill btn-outline-primary border-0 m-md-2 px-md-4 ${categoryCode eq item.key ? 'active':''}" 
		        	   href="/app/mapper/up?page=${page}&sort=${sort}&categoryCode=${item.key}">${item.value}</a>
		        </c:forEach>    
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
	                        <span class="btn btn-outline-light rounded-pill mb-lg-3 px-lg-4 light-300" style="color: black; border-color: black; font-size: 12px;">
                           	  <c:if test = "${fn:contains(categoryList, item.categoryCode)}">
						         ${categoryList[item.categoryCode]}
						      </c:if>
                            </span>
	                        <p class="card-text light-300 text-dark" style="font-size: 14px;"><i class="fas fa-map-marker-alt"></i> ${item.countOfMapping}개의 저장소</p>
	                        <p class="card-text light-300 text-dark">
	                      	  <c:out value="${fn:substring(item.contents, 0, 20) }"/>
	                        </p>
	                    </div>
	                </div>
	            </a>
	        </c:forEach>
        </div>
      
        
        <div class="row" style="margin-top: 50px;">
            <div class="btn-toolbar justify-content-center pb-4" role="toolbar" aria-label="Toolbar with button groups">
             <c:choose>
		         <c:when test = "${hasPrevious}">
		            <div class="btn-group me-2" role="group" aria-label="First group">
		            	<a href="/app/mapper/up?page=${page -1}&sort=${sort}&categoryCode=${categoryCode}" class="btn btn-secondary text-white">
		              	 	Previous
		               	</a>
	                </div>
		         </c:when>
		      </c:choose>
      
               <c:forEach var="loop" begin="1" end="${getTotalPages}" step="1">
	               	<div class="btn-group me-2" role="group" aria-label="Second group">
		               	<a href="/app/mapper/up?page=${loop}&sort=${sort}&categoryCode=${categoryCode}" class="${loop eq page ? 'btn btn-secondary text-white':'btn btn-light'}">
		              	 	${loop}
		               	</a>
	                </div>
               </c:forEach>
               
              <c:choose>
		         <c:when test = "${hasNext}">
		            <div class="btn-group" role="group" aria-label="Third group">
		            	<a href="/app/mapper/up?page=${page +1}&sort=${sort}&categoryCode=${categoryCode}" class="btn btn-secondary text-white">
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