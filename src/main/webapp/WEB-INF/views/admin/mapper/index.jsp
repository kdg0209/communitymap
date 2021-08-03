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
		               			<h4>지도 생성자 목록</h4>
		             		</div>
		             		<div class="card-body p-0">
		               			<div class="table-responsive">
		                 			<table class="table table-striped mb-0" style="font-size: 13px;">
		                   				<thead>
		                     				<tr>
						                       <th class="text-center">아이디</th>
						                       <th class="text-center">닉네임(이름)</th>
						                       <th class="text-center">이메일</th>
						                       <th class="text-center">연락처</th>
						                       <th class="text-center">가입일시</th>
						                       <th class="text-center">지도 생성수</th>
		                     				</tr>
		                   				</thead>
		                   				<tbody>
		                   					<c:forEach var="item" items="${memberList}">
		                   						<tr>
							                       <td class="text-center">
							                         	${item.id}
							                       </td>
							                       <td class="text-center">
							                         <a href="/admin/mapper/detailIndex?memberCode=${item.code}" class="font-weight-600">
							                         	${item.nickname} (${item.name})
							                         </a>
							                       </td>
							                       <td class="text-center">
							                         	${item.email}
						                           </td>
						                           <td class="text-center">
							                         	${item.phone}
						                           </td>
						                            <td class="text-center">
						                            	${fn:substring(item.write_date, 0, 10)}
						                           </td>
						                            <td class="text-center">
							                         	( ${item.mapperCount} )건
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
		       		<div class="col-sm-12 text-center">
		       			<div class="btn-toolbar justify-content-center pb-4" role="toolbar" aria-label="Toolbar with button groups">
			             <c:choose>
					         <c:when test = "${hasPrevious}">
					            <div class="btn-group me-2" role="group" aria-label="First group">
					            	<a href="admin/mapper/index?page=${page -1}" class="btn btn-secondary text-white">
					              	 	Previous
					               	</a>
				                </div>
					         </c:when>
					      </c:choose>
			      
			               <c:forEach var="loop" begin="1" end="${getTotalPages}" step="1">
				               	<div class="btn-group me-2" role="group" aria-label="Second group">
					               	<a href="/admin/mapper/index?page=${loop}" class="${loop eq page ? 'btn btn-secondary text-white':'btn btn-light'}">
					              	 	${loop}
					               	</a>
				                </div>
			               </c:forEach>
			               
			              <c:choose>
					         <c:when test = "${hasNext}">
					            <div class="btn-group" role="group" aria-label="Third group">
					            	<a href="/admin/mapper/index?page=${page +1}" class="btn btn-secondary text-white">
					              	 	Next
					               	</a>
				                </div>
					         </c:when>
					      </c:choose>
			            </div>
		       		</div>
		        </div>
	        </section>
      	</div>
    </div>
  </div>
</body>
 <%@include file="../../layouts/admin/script.jsp"%>
