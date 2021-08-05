<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="navbar-bg"></div>
  <nav class="navbar navbar-expand-lg main-navbar">
  	<form class="form-inline mr-auto">
      <ul class="navbar-nav mr-3">
        <li>
        	<a href="#" data-toggle="sidebar" class="nav-link nav-link-lg"><i class="fas fa-bars"></i></a>
        </li>
      </ul>
    </form>
    <ul class="navbar-nav navbar-right">
      <li class="dropdown">
        <a href="#" data-toggle="dropdown" class="nav-link dropdown-toggle nav-link-lg nav-link-user">
           <div class="d-sm-none d-lg-inline-block">관리자님</div>
        </a>
        <div class="dropdown-menu dropdown-menu-right">
          <div class="dropdown-title">Logged in 5 min ago</div>
          <a href="/" class="dropdown-item has-icon">
            <i class="fas fa-home"></i> 메인으로
          </a>
      
          <div class="dropdown-divider"></div>
          <a href="/app/login/logout" class="dropdown-item has-icon text-danger">
            <i class="fas fa-sign-out-alt"></i> Logout
          </a>
        </div>
      </li>
    </ul>
  </nav>