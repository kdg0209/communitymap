<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.dropbtn {
  color: white;
  padding: 16px;
  font-size: 16px;
  border: none;
}

.dropdown {
  position: relative;
  display: inline-block;
}

.dropdown-content {
  z-index: 999 !important;
  background-color: #fff!important;
  display: none;
  position: absolute;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropdown-content a:hover {background-color: #ddd;}

.dropdown:hover .dropdown-content {display: block;}
</style>

<nav id="main_nav" class="navbar navbar-expand-lg navbar-light bg-white shadow">
    <div class="container d-flex justify-content-between align-items-center">
        <a class="navbar-brand h1" href="/">
            <i class='bx bx-buildings bx-sm text-dark'></i>
            <span class="text-dark h4">Purple</span> <span class="text-primary h4">Buzz</span>
        </a>
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbar-toggler-success" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="align-self-center collapse navbar-collapse flex-fill  d-lg-flex justify-content-lg-between" id="navbar-toggler-success">
            <div class="flex-fill mx-xl-5 mb-2">
                <ul class="nav navbar-nav d-flex justify-content-between mx-xl-5 text-center text-dark">
                    <li class="nav-item">
                        <a class="nav-link btn-outline-primary rounded-pill px-3" href="/app/mapper/up">지도UP</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link btn-outline-primary rounded-pill px-3" href="/app/allMap/index">한눈에 보기</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link btn-outline-primary rounded-pill px-3" href="work.html">알립니다</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link btn-outline-primary rounded-pill px-3" href="pricing.html">랭킹</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link btn-outline-primary rounded-pill px-3" href="/app/join/index">회원가입</a>
                    </li>
                </ul>
            </div>
            
            
            <div class="navbar align-self-center d-flex">
                <a class="nav-link" href="#"><i class='bx bx-bell bx-sm bx-tada-hover text-primary'></i></a>
                <a class="nav-link" href="#"><i class='bx bx-cog bx-sm text-primary'></i></a>
                <%if(session.getAttribute("id") != null) {%>
                	<div class="dropdown">
                		<a class="nav-link dropbtn" href="javascript:;"><i class='bx bx-user-circle bx-sm text-primary'></i></a>
	                	 <div class="dropdown-content">
	                	 	<a href="/admin/main/index">관리자</a>
						    <a href="/app/mypage/index">마이페이지</a>
						    <a href="/app/mapper/index?page=1">나의 지도 관리</a>
						    <a href="/app/login/logout">로그아웃</a>
						  </div>
				    </div>
                <%}else{ %>
               	 	<a class="nav-link" href="/app/login/index" style="font-size: 12px;"><i class="fas fa-sign-in-alt fa-2x  text-primary"></i></a>
                <%} %>
            </div>
        </div>
    </div>
</nav>