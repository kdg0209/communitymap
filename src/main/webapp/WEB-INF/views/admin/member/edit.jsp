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
	          <div class="section-header">
	            <h1>회원 정보 수정</h1>
	            <div class="section-header-breadcrumb">
	              <div class="breadcrumb-item active">회원</div>
	              <div class="breadcrumb-item">정보 수정</div>
	            </div>
	          </div>
	
	          <div class="section-body">
	            <h2 class="section-title">Editor</h2>
	            <p class="section-lead">${member.name}님의 정보 수정</p>
	
	            <form action="/admin/member/edit" method="post">
	            	<input type="hidden" name="code" value="${member.code}">
	            	<div class="row">
		              <div class="col-12">
		                <div class="card">
		                  <div class="card-body">
		                  	<div class="form-group row">
	                          <label class="col-form-label col-2">관리자 유무</label>
	                          <div class="col-sm-10">
	                            <div class="selectgroup w-100">
		                            <c:forEach var="item" items="${isAdminConfigList}">
		                          		<label class="selectgroup-item">
			                                <input type="radio" 
			                                	   name="isAdmin" 
			                                	   value="${item.key}" 
			                                	   class="selectgroup-input"
			                                	   ${item.key eq member.isAdmin ? 'checked' : ''}>
			                                <span class="selectgroup-button">${item.value}</span>
		                              </label>
		                          	</c:forEach>
	                            </div>
	                          </div>
	                        </div>
	                        
	                        <div class="form-group row">
	                          <label class="col-form-label col-2">거부 유무</label>
	                          <div class="col-sm-10">
	                            <div class="selectgroup w-100">
		                            <c:forEach var="item" items="${isDenieConfigList}">
		                          		<label class="selectgroup-item">
			                                <input type="radio" 
			                                	   name="isDenie" 
			                                	   value="${item.key}" 
			                                	   class="selectgroup-input"
			                                	   ${item.key eq member.isDenie ? 'checked' : ''}>
			                                <span class="selectgroup-button">${item.value}</span>
		                              </label>
		                          	</c:forEach>
	                            </div>
	                          </div>
	                        </div>
		                
		                    <div class="form-group row mb-4">
		                      <label class="col-form-label col-2">이름</label>
		                      <div class="col-sm-10">
		                        <input type="text" 
		                        	   id="name"
		                        	   value="${member.name}"
		                        	   class="form-control"
		                        	   readonly="readonly"
		                        	   style="background-color: white;">
		                      </div>
		                    </div>
		                    
		                    <div class="form-group row mb-4">
		                      <label class="col-form-label col-2">아이디</label>
		                      <div class="col-sm-10">
		                        <input type="text" 
		                        	   id="id"
		                        	   value="${member.id}"
		                        	   class="form-control"
		                        	   readonly="readonly"
		                        	   style="background-color: white;">
		                      </div>
		                    </div>
		                    
		                    <div class="form-group row mb-4">
		                      <label class="col-form-label col-2">비밀번호</label>
		                      <div class="col-sm-10">
		                        <input type="password" 
		                        	   name="password"
		                        	   id="password"
		                        	   class="form-control">
		                      </div>
		                    </div>
		                    
		                     <div class="form-group row mb-4">
		                      <label class="col-form-label col-2">닉네임</label>
		                      <div class="col-sm-10">
		                        <input type="text" 
		                        	   id="nickname"
		                        	   value="${member.nickname}"
		                        	   class="form-control"
		                        	   readonly="readonly"
		                        	   style="background-color: white;">
		                      </div>
		                    </div>
		                    
		                    <div class="form-group row mb-4">
		                      <label class="col-form-label col-2">연락처</label>
		                      <div class="col-sm-10">
		                        <input type="text" 
		                        	   id="phone"
		                        	   name="phone"
		                        	   value="${member.phone}"
		                        	   class="form-control">
		                      </div>
		                    </div>
		                    
		                    <div class="form-group row mb-4">
		                      <label class="col-form-label col-2">이메일</label>
		                      <div class="col-sm-10">
		                        <input type="text" 
		                        	   id="email"
		                        	   value="${member.email}"
		                        	   class="form-control"
		                        	   readonly="readonly"
		                        	   style="background-color: white;">
		                      </div>
		                    </div>
		                    
		                    <div class="form-group row mb-4">
		                      <div class="col-sm-4">
			                        <a href="/admin/member/index" class="btn btn-primary">
			                        	<i class="fas fa-bars"></i> 목록
			                        </a>
		                      </div>
		                       <div class="col-sm-4 text-center">
			                       	<button type="submit" class="btn btn-primary">
			                       		확인
			                       	</button>
		                      </div>
		                       <div class="col-sm-4 text-right">
		                       		<a href="/admin/member/delete?memberCode=${member.code}" class="btn btn-danger delete">
		                        		<i class="far fa-trash-alt"></i> 삭제
		                        	</a>
		                      </div>
		                    </div>
		                  </div>
		                </div>
		              </div>
		            </div>
	            </form>
	          </div>
	        </section>
      	</div>
    </div>
  </div>
</body>
 <%@include file="../../layouts/admin/script.jsp"%>
