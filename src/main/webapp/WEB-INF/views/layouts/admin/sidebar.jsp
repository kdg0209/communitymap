<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="main-sidebar">
  <aside id="sidebar-wrapper">
    <div class="sidebar-brand">
      <a href="/">Community Map</a>
    </div>
    <ul class="sidebar-menu">
        <li class="menu-header">Dashboard</li>
        <li class="nav-item dropdown">
          <a href="#" class="nav-link has-dropdown"><i class="fas fa-fire"></i><span>Dashboard</span></a>
        </li>
        <li class="menu-header">회원</li>
        <li class="nav-item dropdown">
          <a href="javascript:;" class="nav-link has-dropdown" data-toggle="dropdown"><i class="fas fa-users"></i> <span>회원</span></a>
          <ul class="dropdown-menu">
            <li><a href="/admin/member/index" class="nav-link">회원 목록</a></li>
          </ul>
        </li>
        <li class="menu-header">지도 생성자</li>
        <li class="nav-item dropdown">
          <a href="javascript:;" class="nav-link has-dropdown" data-toggle="dropdown"><i class="fas fa-map-marked-alt"></i> <span>지도 생성자</span></a>
          <ul class="dropdown-menu">
            <li><a href="/admin/mapper/index" class="nav-link">지도 생성자 목록</a></li>
          </ul>
        </li>
      </ul>
  </aside>
</div>