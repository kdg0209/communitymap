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
		               			<h4>신고 목록</h4>
		             		</div>
		             		<div class="card-body p-0">
		               			<div class="table-responsive">
		                 			<table class="table table-striped mb-0" style="font-size: 13px;">
		                   				<thead>
		                     				<tr>
						                       <th>내용</th>
						                       <th class="text-right">신고 일시</th>
		                     				</tr>
		                   				</thead>
		                   				<tbody>
		                   					<c:forEach var="item" items="${declareList}">
		                   						<tr>
							                       <td>
							                         	${item.memo}
							                       </td>
							                       <td class="text-right">
							                         ${item.writeDate}
							                       </td>
							                     </tr>
		                   					</c:forEach>
		                   				</tbody>
		                 			</table>
		               			</div>
		             		</div>
		           		</div>
		         	</div>
		       	</div>
		       	
		       	<div class="row text-center" style="margin-top: 50px;">
		       		<div class="col-sm-3 text-left">
			       		<a href="/admin/mapping/index?mapperCode=${mapperCode}&memberCode=${memberCode}" class="btn btn-primary">
	                   		<i class="fas fa-bars"></i> 목록
	                    </a>
		       		</div>
		       		<div class="col-sm-6 text-center">
		       			<div class="btn-toolbar justify-content-center pb-4" role="toolbar" aria-label="Toolbar with button groups">
			             <c:choose>
					         <c:when test="${hasPrevious}">
					            <div class="btn-group me-2" role="group" aria-label="First group">
					            	<a href="/admin/mappingDeclare/index?mappingCode=${mappingCode}&mapperCode=${mapperCode}&page=${page -1}" class="btn btn-secondary text-white">
					              	 	Previous
					               	</a>
				                </div>
					         </c:when>
					      </c:choose>
			      
			               <c:forEach var="loop" begin="1" end="${getTotalPages}" step="1">
				               	<div class="btn-group me-2" role="group" aria-label="Second group">
					               	<a href="/admin/mappingDeclare/index?mappingCode=${mappingCode}&mapperCode=${mapperCode}&page=${loop}" class="${loop eq page ? 'btn btn-secondary text-white':'btn btn-light'}">
					              	 	${loop}
					               	</a>
				                </div>
			               </c:forEach>
			               
			              <c:choose>
					         <c:when test="${hasNext}">
					            <div class="btn-group" role="group" aria-label="Third group">
					            	<a href="/admin/mappingDeclare/index?mappingCode=${mappingCode}&mapperCode=${mapperCode}&page=${page +1}" class="btn btn-secondary text-white">
					              	 	Next
					               	</a>
				                </div>
					         </c:when>
					      </c:choose>
			            </div>
		       		</div>
		       		<div class="col-sm-3">
		       			<a href="/admin/mapping/edit?code=${mappingCode}&memberCode=${memberCode}" class="btn btn-dark btn-icon-split f-s-10" style="float:right; font-size: 12px;">
	                       해당 게시물로 이동
                  		</a>	
		       		</div>
		        </div>
	        </section>
      	</div>
    </div>
  </div>
</body>
 <%@include file="../../layouts/admin/script.jsp"%>
