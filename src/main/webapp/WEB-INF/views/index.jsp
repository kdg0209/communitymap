<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="./layouts/app/head.jsp"%>
<%@include file="./layouts/app/header.jsp"%>

<body>
    <div class="banner-wrapper bg-light">
        <div id="index_banner" class="banner-vertical-center-index container-fluid pt-5">
            <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
                <ol class="carousel-indicators">
                    <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active"></li>
                    <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"></li>
                    <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"></li>
                </ol>
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <div class="py-5 row d-flex align-items-center">
                            <div class="banner-content col-lg-8 col-8 offset-2 m-lg-auto text-left py-5 pb-5">
                                <h1 class="banner-heading h1 text-secondary display-3 mb-0 pb-5 mx-0 px-0 light-300 typo-space-line">
                                   나만의 지도를 만들어 보세요.
                              	</h1>
                                <p class="banner-body text-muted py-3 mx-0 px-0">
                                	지도를 만들어 사람들과 공유해보세요.!
                                </p>
                                <a class="banner-button btn rounded-pill btn-outline-primary btn-lg px-4" href="/app/mapper/write" role="button">나의 지도 만들기</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <section class="service-wrapper py-3">
        <div class="container-fluid pb-3">
            <div class="row">
                <h2 class="h2 text-center col-12 py-5 semi-bold-600">Community Map</h2>
                <div class="service-header col-2 col-lg-3 text-end light-300">
                    <i class='bx bx-gift h3 mt-1'></i>
                </div>
                <div class="service-heading col-10 col-lg-9 text-start float-end light-300">
                    <h2 class="h3 pb-4 typo-space-line">공유하는 지도 만들기</h2>
                </div>
            </div>
            <p class="service-footer col-10 offset-2 col-lg-9 offset-lg-3 text-start pb-3 text-muted px-2">
               모두가 공유 가능한 세상, 그 세상을 만들기 위해 고민하는 당신은 모두의 지도입니다. <br>
               커뮤니티 지도는 나만의 장소를 공유하여 함께 추억을 쌓아가는 사이트입니다.
            </p> 
        </div>

        <div class="service-tag py-5 bg-secondary">
            <div class="col-md-12">
                <ul class="nav d-flex justify-content-center">
                    <li class="nav-item mx-lg-4">
                        <a href="?sort=writeDate" class="nav-link btn-outline-primary rounded-pill text-light px-4 light-300 ${sort eq 'writeDate' ? 'active shadow':''}">최신순</a>
                    </li>
                    <li class="nav-item mx-lg-4">
                  	    <a href="?sort=mapperRecommendCount" class="nav-link btn-outline-primary rounded-pill text-light px-4 light-300 ${sort eq 'mapperRecommendCount' ? 'active shadow':''}">인기순</a>
                    </li>
                    <li class="nav-item mx-lg-4">
                        <a href="?sort=countOfMapping" class="nav-link btn-outline-primary rounded-pill text-light px-4 light-300 ${sort eq 'countOfMapping' ? 'active shadow':''}">데이터순</a>
                    </li>
                </ul>
            </div>
        </div>
    </section>
    
    <section class="container overflow-hidden py-5">
    	<div class="row gx-5 gx-sm-3 gx-lg-5 gy-lg-5 gy-3 pb-3 projects">
	    	<c:forEach var="item" items="${mapperList}">
	            <div class="col-xl-3 col-md-4 col-sm-6 project ui branding">
	                <a href="/app/map/index?mapperCode=${item.code}" class="service-work card border-0 text-white shadow-sm overflow-hidden mx-5 m-sm-0">
	                    <img class="service card-img" src="<c:url value='/img/mapperCover/${item.fileName}'/>" style="width: 243px; height: 243px;">
	                    <div class="service-work-vertical card-img-overlay d-flex align-items-end">
	                        <div class="service-work-content text-left text-light">
	                            <span class="btn btn-outline-light rounded-pill mb-lg-3 px-lg-4 light-300">
	                            	 <c:if test = "${fn:contains(categoryList, item.categoryCode)}">
								         ${categoryList[item.categoryCode]}
								      </c:if>
	                            </span>
	                            <p class="card-text"><i class="fas fa-user"></i> by ${item.name}</p>
	                            <p class="card-text" style="font-size: 14px;"><i class="fas fa-map-marker-alt"></i> ${item.countOfMapping}개의 저장소</p>
	                            <p class="card-text">${fn:substring(item.contents, 0, 10) }</p>
	                        </div>
	                    </div>
	                </a>
	            </div>
	    	</c:forEach>
    	</div>
    </section>


    <!-- Start View Work -->
    <section class="bg-secondary">
        <div class="container py-5">
            <div class="row d-flex justify-content-center text-center">
                <div class="col-lg-2 col-12 text-light align-items-center">
                    <i class='display-1 bx bxs-box bx-lg'></i>
                </div>
                <div class="col-lg-7 col-12 text-light pt-2">
                    <h3 class="h4 light-300">Great transformations successful</h3>
                    <p class="light-300">Quis ipsum suspendisse ultrices gravida.</p>
                </div>
                <div class="col-lg-3 col-12 pt-4">
                    <a href="#" class="btn btn-primary rounded-pill btn-block shadow px-4 py-2">View Our Work</a>
                </div>
            </div>
        </div>
    </section>
    <!-- End View Work -->

    <!-- Start Recent Work -->
    <section class="py-5 mb-5">
        <div class="container">
            <div class="recent-work-header row text-center pb-5">
                <h2 class="col-md-6 m-auto h2 semi-bold-600 py-5">Recent Works</h2>
            </div>
            <div class="row gy-5 g-lg-5 mb-4">

                <!-- Start Recent Work -->
                <div class="col-md-4 mb-3">
                    <a href="#" class="recent-work card border-0 shadow-lg overflow-hidden">
                        <img class="recent-work-img card-img" src="../resources/assets/img/recent-work-01.jpg" alt="Card image">
                        <div class="recent-work-vertical card-img-overlay d-flex align-items-end">
                            <div class="recent-work-content text-start mb-3 ml-3 text-dark">
                                <h3 class="card-title light-300">Social Media</h3>
                                <p class="card-text">Ullamco laboris nisi ut aliquip ex</p>
                            </div>
                        </div>
                    </a>
                </div><!-- End Recent Work -->

                <!-- Start Recent Work -->
                <div class="col-md-4 mb-3">
                    <a href="#" class="recent-work card border-0 shadow-lg overflow-hidden">
                        <img class="recent-work-img card-img" src="../resources/assets/img/recent-work-02.jpg" alt="Card image">
                        <div class="recent-work-vertical card-img-overlay d-flex align-items-end">
                            <div class="recent-work-content text-start mb-3 ml-3 text-dark">
                                <h3 class="card-title light-300">Web Marketing</h3>
                                <p class="card-text">Psum officia anim id est laborum.</p>
                            </div>
                        </div>
                    </a>
                </div><!-- End Recent Work -->

                <!-- Start Recent Work -->
                <div class="col-md-4 mb-3">
                    <a href="#" class="recent-work card border-0 shadow-lg overflow-hidden">
                        <img class="recent-work-img card-img" src="../resources/assets/img/recent-work-03.jpg" alt="Card image">
                        <div class="recent-work-vertical card-img-overlay d-flex align-items-end">
                            <div class="recent-work-content text-start mb-3 ml-3 text-dark">
                                <h3 class="card-title light-300">R & D</h3>
                                <p class="card-text">Sum dolor sit consencutur</p>
                            </div>
                        </div>
                    </a>
                </div><!-- End Recent Work -->

                <!-- Start Recent Work -->
                <div class="col-md-4 mb-3">
                    <a href="#" class="recent-work card border-0 shadow-lg overflow-hidden">
                        <img class="recent-work-img card-img" src="../resources/assets/img/recent-work-04.jpg" alt="Card image">
                        <div class="recent-work-vertical card-img-overlay d-flex align-items-end">
                            <div class="recent-work-content text-start mb-3 ml-3 text-dark">
                                <h3 class="card-title light-300">Public Relation</h3>
                                <p class="card-text">Lorem ipsum dolor sit amet</p>
                            </div>
                        </div>
                    </a>
                </div><!-- End Recent Work -->

                <!-- Start Recent Work -->
                <div class="col-md-4 mb-3">
                    <a href="#" class="recent-work card border-0 shadow-lg overflow-hidden">
                        <img class="recent-work-img card-img" src="../resources/assets/img/recent-work-05.jpg" alt="Card image">
                        <div class="recent-work-vertical card-img-overlay d-flex align-items-end">
                            <div class="recent-work-content text-start mb-3 ml-3 text-dark">
                                <h3 class="card-title light-300">Branding</h3>
                                <p class="card-text">Put enim ad minim veniam</p>
                            </div>
                        </div>
                    </a>
                </div><!-- End Recent Work -->

                <!-- Start Recent Work -->
                <div class="col-md-4 mb-3">
                    <a href="#" class="recent-work card border-0 shadow-lg overflow-hidden">
                        <img class="recent-work-img card-img" src="../resources/assets/img/recent-work-06.jpg" alt="Card image">
                        <div class="recent-work-vertical card-img-overlay d-flex align-items-end">
                            <div class="recent-work-content text-start mb-3 ml-3 text-dark">
                                <h3 class="card-title light-300">Creative Design</h3>
                                <p class="card-text">Mollit anim id est laborum.</p>
                            </div>
                        </div>
                    </a>
                </div><!-- End Recent Work -->

            </div>
        </div>
    </section>
	
	<%@include file="./layouts/app/footer.jsp"%>
</body>

</html>
<%@include file="./layouts/app/script.jsp"%>