<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="../../layouts/app/head.jsp"%>

<%@include file="../../layouts/app/header.jsp"%>

<body>
	<section class="service-wrapper py-3">
        <div class="container-fluid pb-3">
            <div class="row">
                <h2 class="h2 text-center col-12 py-5 semi-bold-600">나의 데이터 관리</h2>
            </div>
        </div>
    </section>
    
 	<section class="container py-5">
        <div class="row projects gx-lg-5">
	        <c:forEach var="item" items="${mappingList}">
		        <a href="javascript:;" class="col-sm-6 col-lg-4 text-decoration-none project marketing social business" style="margin-top: 50px;">
	                <div class="service-work overflow-hidden card mb-5 mx-5 m-sm-0" style="positon :relative;">    
		                <div  style="position: absolute; margin-top: 3%; ${fn:contains(item.is_declare, 'Y') ? 'margin-left: 22%;':'margin-left: 3%;'}">
						   <span class="btn btn-outline-light rounded-pill mb-lg-3 px-lg-4 light-300" style="color: black; border-color: black; font-size: 12px;">
							 <c:forEach var="category" items="${categoryConfigList}">
								 <c:if test = "${category.code == item.mapperCategoryConfig.code}">
	                            	 ${category.name}
							     </c:if>
							 </c:forEach>
                           </span>
						</div>
		                <c:if test="${fn:contains(item.is_declare, 'Y')}">
		                	<div class="btn btn-danger btn-icon-split f-s-10" style="margin-top: 3%; margin-left: 3%; font-size: 10px; color: white; position: absolute;">
		                	   <i class="fas fa-exclamation-circle"></i>
	                           <span class="text">신고</span>
		                	</div>
						</c:if>
	                    <img class="card-img-top" src="<c:url value='/img/mappingCover/${item.fileName}'/>" style="width: 100%; height: 180px;" />
	                    <div class="card-body">
	                        <h5 class="card-title light-300 text-dark">${item.address}</h5>
	                        <p class="card-text light-300 text-dark">
	                        	<c:if test="${empty item.mapperCategoryConfig}">
									<i class="fas fa-exclamation-circle"></i>
								</c:if>
	                      	 	${item.writeDate}
	                        </p>
	                        <div style="float: right;">
		                        <c:if test="${fn:contains(item.is_declare, 'Y')}">
				                	 <span class="text-decoration-none text-dark light-300" onclick="DeclareFn('${item.code}', '${item.mapper.code}');">
		                              신고내역 조회 <i class="fas fa-angle-right"></i> 
			                        </span>
								</c:if>
							
	                        	<span class="text-decoration-none text-dark light-300" onclick="EditFn('${item.code}', '${item.mapper.code}');">
	                              수정 <i class="fas fa-edit"></i>
		                        </span>
	                        </div>
	                    </div>
	                </div>
	            </a>
	        </c:forEach>
        </div>
        
        <div class="row" style="margin-top: 50px;">
        	<div class="col-md-4 col-4 m-auto">
       			<a href="/app/mapper/index?page=1" class="btn btn-dark rounded-pill px-md-5 px-4 py-2 radius-0 text-light light-300">목록</a>
            </div>
            <div class="col-md-4 col-4 m-auto text-center"></div>
            <div class="col-md-4 col-4 m-auto text-right">
            	<a href="/app/mapping/write?mapperCode=${mapperCode}" class="btn btn-info rounded-pill px-md-5 px-4 py-2 radius-0 text-light light-300">작성하기</a>
            </div>
        </div>
        
        <div class="row" style="margin-top: 50px;">
            <div class="btn-toolbar justify-content-center pb-4" role="toolbar" aria-label="Toolbar with button groups">
             <c:choose>
		         <c:when test = "${hasPrevious}">
		            <div class="btn-group me-2" role="group" aria-label="First group">
		            	<a href="/app/mapping/index?mapperCode=${mapperCode}&page=${page -1}" class="btn btn-secondary text-white">
		              	 	Previous
		               	</a>
	                </div>
		         </c:when>
		      </c:choose>
      
               <c:forEach var="loop" begin="1" end="${getTotalPages}" step="1">
	               	<div class="btn-group me-2" role="group" aria-label="Second group">
		               	<a href="/app/mapping/index?mapperCode=${mapperCode}&page=${loop}" class="${loop eq page ? 'btn btn-secondary text-white':'btn btn-light'}">
		              	 	${loop}
		               	</a>
	                </div>
               </c:forEach>
               
              <c:choose>
		         <c:when test = "${hasNext}">
		            <div class="btn-group" role="group" aria-label="Third group">
		            	<a href="/app/mapping/index?mapperCode=${mapperCode}&page=${page +1}" class="btn btn-secondary text-white">
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
	function EditFn(code, mapperCode) {
		window.location.href = "/app/mapping/edit?code="+code+"&mapperCode="+mapperCode;
	}
</script>
<script>
	function DeclareFn(code, mapperCode) {
		window.location.href = "/app/mappingDeclare/index?mappingCode="+code+"&mapperCode="+mapperCode;
	}
</script>

