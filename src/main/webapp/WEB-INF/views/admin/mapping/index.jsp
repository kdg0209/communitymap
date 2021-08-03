<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="../../layouts/admin/head.jsp"%>

<body>
  <div id="app">
    <div class="main-wrapper">
    	<%@include file="../../layouts/admin/header.jsp"%>
    	<%@include file="../../layouts/admin/sidebar.jsp"%>
      
      	<div class="main-content">
	        <section class="section">
	        	<div class="row">
		         	<div class="col-lg-12 col-md-12 col-12 col-sm-12">
		           		<div class="card">
		             		<div class="card-header">
		               			<h4>${mapper.name}에 관한 지도 (${getTotalElements})건 </h4>
		             		</div>
		             		<div class="row">
			             		<c:forEach var="item" items="${mappingList}">
			             			<div class="col-12 col-sm-6 col-md-6 col-lg-3">
						                <article class="article article-style-b">
						                  <div class="article-header">
						                    <div class="article-image" style="background-image: url(/img/mappingCover/${item.fileName});"></div>
						                  </div>
						                  <div class="article-details">
						                    <div class="article-title">
						                      <strong>${item.address}</strong>
						                    </div>
						                    <div class="article-cta">
							                     <c:if test="${fn:contains(item.is_declare, 'Y')}">
							                     	  <a href="/admin/mapping/index?mapperCode=${item.code}">
							                     	  	 신고내역 조회 <i class="fas fa-angle-right"></i> 
							                     	  </a>
												 </c:if>
							                      <a href="/admin/mapper/edit?mapperCode=${item.code}&memberCode=${member.code}">
								                       수정 <i class="fas fa-edit"></i>
							                      </a>
						                    </div>
						                  </div>
						                </article>
					              	</div>
			             		</c:forEach>
				            </div>
		           		</div>
		         	</div>
		       	</div>
		       	
		       	
		       	<div class="row" style="margin-top: 50px;">
		       		<div class="col-sm-3 text-left">
			       		<a href="/admin/mapper/detailIndex?memberCode=${memberCode}" class="btn btn-primary">
	                   		<i class="fas fa-bars"></i> 목록
	                    </a>
		       		</div>
		       		<div class="col-sm-6 text-center">
		       			<div class="btn-toolbar justify-content-center pb-4" role="toolbar" aria-label="Toolbar with button groups">
			             <c:choose>
					         <c:when test = "${hasPrevious}">
					            <div class="btn-group me-2" role="group" aria-label="First group">
					            	<a href="/admin/mapping/index?mapperCode=${mapper.code}&memberCode=${memberCode}&page=${page -1}" class="btn btn-secondary text-white">
					              	 	Previous
					               	</a>
				                </div>
					         </c:when>
					      </c:choose>
			      
			               <c:forEach var="loop" begin="1" end="${getTotalPages}" step="1">
				               	<div class="btn-group me-2" role="group" aria-label="Second group">
					               	<a href="/admin/mapping/index?mapperCode=${mapper.code}&memberCode=${memberCode}&page=${loop}" class="${loop eq page ? 'btn btn-secondary text-white':'btn btn-light'}">
					              	 	${loop}
					               	</a>
				                </div>
			               </c:forEach>
			               
			              <c:choose>
					         <c:when test = "${hasNext}">
					            <div class="btn-group" role="group" aria-label="Third group">
					            	<a href="/admin/mapping/index?mapperCode=${mapper.code}&memberCode=${memberCode}&page=${page +1}" class="btn btn-secondary text-white">
					              	 	Next
					               	</a>
				                </div>
					         </c:when>
					      </c:choose>
			            </div>
		       		</div>
		       		<div class="col-sm-3"></div>
		        </div>
	        </section>
      	</div>
    </div>
  </div>
</body>
 <%@include file="../../layouts/admin/script.jsp"%>
