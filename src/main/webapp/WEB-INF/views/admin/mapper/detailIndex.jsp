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
		               			<h4>${member.name}님이 생성한 지도 (${getTotalElements})건 </h4>
		             		</div>
		             		<div class="row">
			             		<c:forEach var="item" items="${mapperList}">
			             			<div class="col-12 col-sm-6 col-md-6 col-lg-3">
						                <article class="article article-style-b">
						                  <div class="article-header">
						                    <div class="article-image" style="background-image: url(/img/mapperCover/${item.fileName});"></div>
						                    <div class="article-badge">
						                      <div class="article-badge-item bg-danger"><i class="fas fa-map-marker-alt"></i>
						                      	  <c:if test = "${fn:contains(categoryList, item.categoryCode)}">
											         ${categoryList[item.categoryCode]}
											      </c:if>
						                      </div>
						                    </div>
						                  </div>
						                  <div class="article-details">
							                    <div class="article-title">
							                      <strong>${item.name}</strong>
							                      <p style="font-size: 12px; margin-bottom: -2%;"><i class="fas fa-map-marker-alt"></i> ${item.countOfMapping}개의 저장소</p>
							                      <p style="font-size: 12px;"><i class="fas fa-exclamation-circle"></i> s${item.declareCount}개의 신고접수가 있습니다.</p>
							                    </div>
						                    	<p><c:out value="${fn:substring(item.contents, 0, 30) }"/> </p>
							                    <div class="article-cta">
							                      <a href="/admin/mapper/edit?mapperCode=${item.code}&memberCode=${member.code}">수정 <i class="fas fa-edit"></i></a>
							                      <a href="/admin/mapping/index?mapperCode=${item.code}&memberCode=${member.code}">데이터 보기 <i class="fas fa-chevron-right"></i></a>
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
			       		<a href="/admin/mapper/index" class="btn btn-primary">
	                   		<i class="fas fa-bars"></i> 목록
	                    </a>
		       		</div>
		       		<div class="col-sm-6 text-center">
		       			<div class="btn-toolbar justify-content-center pb-4" role="toolbar" aria-label="Toolbar with button groups">
			             <c:choose>
					         <c:when test = "${hasPrevious}">
					            <div class="btn-group me-2" role="group" aria-label="First group">
					            	<a href="admin/mapper/detailIndex?memberCode=${member.code}&page=${page -1}" class="btn btn-secondary text-white">
					              	 	Previous
					               	</a>
				                </div>
					         </c:when>
					      </c:choose>
			      
			               <c:forEach var="loop" begin="1" end="${getTotalPages}" step="1">
				               	<div class="btn-group me-2" role="group" aria-label="Second group">
					               	<a href="/admin/mapper/detailIndex?memberCode=${member.code}&page=${loop}" class="${loop eq page ? 'btn btn-secondary text-white':'btn btn-light'}">
					              	 	${loop}
					               	</a>
				                </div>
			               </c:forEach>
			               
			              <c:choose>
					         <c:when test = "${hasNext}">
					            <div class="btn-group" role="group" aria-label="Third group">
					            	<a href="/admin/mapper/detailIndex?memberCode=${member.code}&page=${page +1}" class="btn btn-secondary text-white">
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
