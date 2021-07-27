<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../../layouts/app/head.jsp"%>
<%@include file="../../layouts/app/header.jsp"%>

<body>
	<form action="/app/travel_destination/map" method="get">
    <div class="hero-section full-screen has-map has-sidebar" style="height: 889px;">
        <div class="map-wrapper" style="position: relative; height: 100%;">
            <div class="map-btn-area">
                                 <a href="javascript:;" class="btn btn-default geo-location">
                       <i class="far fa-crosshairs" aria-hidden="true"></i>
                       <span>내위치</span>
                   </a>
                              <div class="btn-group">
                    <div class="dropdown">
                      <button class="btn btn-default dropdown-toggle" type="button" id="dropdownCate" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                  <img src="/assets/common/img/marker/new_maker_00.png" style="height:14px;margin-right:5px;">카테고리
                                              </button>
                      <ul class="dropdown-menu" aria-labelledby="dropdownCate" style="width:150px;">
                          <li>
                            <a href="/app/travel_destination/map" class="btn-marker">
                              <img src="/assets/common/img/marker/new_maker_00.png" style="height:14px;margin-right:3px;"> 전체
                            </a>
                          </li>
                                                        <li>
                                <a href="/app/travel_destination/map?md_id=travel_destination&amp;map_category=1" class="btn-marker">
                                  <img src="/assets/common/img/marker/new_maker_01.png" style="height:14px;margin-right:3px;">
                                  식당                                </a>
                              </li>
                                                        <li>
                                <a href="/app/travel_destination/map?md_id=travel_destination&amp;map_category=2" class="btn-marker">
                                  <img src="/assets/common/img/marker/new_maker_02.png" style="height:14px;margin-right:3px;">
                                  카페                                </a>
                              </li>
                                                        <li>
                                <a href="/app/travel_destination/map?md_id=travel_destination&amp;map_category=3" class="btn-marker">
                                  <img src="/assets/common/img/marker/new_maker_03.png" style="height:14px;margin-right:3px;">
                                  술집                                </a>
                              </li>
                                                        <li>
                                <a href="/app/travel_destination/map?md_id=travel_destination&amp;map_category=4" class="btn-marker">
                                  <img src="/assets/common/img/marker/new_maker_04.png" style="height:14px;margin-right:3px;">
                                  문화시설                                </a>
                              </li>
                                                        <li>
                                <a href="/app/travel_destination/map?md_id=travel_destination&amp;map_category=5" class="btn-marker">
                                  <img src="/assets/common/img/marker/new_maker_05.png" style="height:14px;margin-right:3px;">
                                  여행지                                </a>
                              </li>
                                                </ul>
                  </div>
                    <a href="/app/travel_destination/index?md_id=travel_destination&amp;type=gallery" class="btn btn-default" role="button">
                        <i class="far fa-image hidden-xs hidden-sm" aria-hidden="true"></i>
                        <span>갤러리</span>
                    </a>
                    <a href="/app/travel_destination/index?md_id=travel_destination&amp;type=map" class="btn btn-dark" role="button">
                        <i class="far fa-map" aria-hidden="true"></i>
                        <span>지도</span>
                    </a>
                                    </div>
            </div>
            <div class="map-search">
                <div class="map-search-form">
                  <div class="input-group">
                        <input type="text" class="form-control" name="keyword" value="" placeholder="검색어를 입력해주세요.">
                        <span class="input-group-btn">
                            <button type="submit" class="search-btn">
                                    <i class="far fa-search" aria-hidden="true"></i>
                                    <span> 검색</span>
                            </button>
                        </span>
                    </div>
                </div>
            </div>
            <div id="kakao_map" style="width: 100%; overflow: hidden;"></div>
        </div>

                    <div class="results-wrapper">
              <div class="sidebar-detail">
                  <div class="tse-scrollable"><div class="tse-scrollbar" style="display: block;"><div class="drag-handle" style="top: 2px; height: 744px;"></div></div>
                      <div class="tse-scroll-content" style="width: 343px; height: 889px;"><div class="tse-content">
                          <div class="sidebar-wrapper">

<div class="sidebar-content side_bar">
  <div class="content_box detail_inline">
    <div class="title">
        <div class="back"><i class="far fa-arrow-left" aria-hidden="true"></i></div>
        <div class="map_info_name">
          <h4>단골손님</h4>
          <!-- <ul class="title-info">
              <li>
                                    무지개              </li>
              <li>
                  <i class="far fa-clock-o"></i>
                  2020-12-13              </li>
          </ul> -->
        </div>

    </div>
    <div class="btn_group_wrap">
      <div class="btn-group">
          <a href="https://map.kakao.com/link/search/36.35880370428693,127.34542048094569" role="button" class="btn btn-white">
              <i class="fa fa-map" aria-hidden="true"></i>
              <span> 지도</span>
          </a>
                </div>
    </div>
  </div>
  <div class="swiper-container tourism-top swiper-container-initialized swiper-container-horizontal">
      <div class="swiper-wrapper" style="transform: translate3d(0px, 0px, 0px);">
                                <div class="swiper-slide swiper-slide-active" style="width: 343px; margin-right: 5px;">
                  <div class="thumbs-img">
                      <img src="/files/travel_destination/7d7d82a05b1ebfbec2cbd23987ba6a99_thumb.jpg">
                  </div>
              </div>
                        <div class="swiper-slide swiper-slide-next" style="width: 343px; margin-right: 5px;">
                  <div class="thumbs-img">
                      <img src="/files/travel_destination/0fc37c7e6f64d0143977f6232e07c406_thumb.jpg">
                  </div>
              </div>
                        <div class="swiper-slide" style="width: 343px; margin-right: 5px;">
                  <div class="thumbs-img">
                      <img src="/files/travel_destination/4dd19cf67bb69d30767eb90299005b3c_thumb.jpg">
                  </div>
              </div>
                        <div class="swiper-slide" style="width: 343px; margin-right: 5px;">
                  <div class="thumbs-img">
                      <img src="/files/travel_destination/396490b386c8ee3fd388b90ae9b9512e_thumb.jpg">
                  </div>
              </div>
                        <div class="swiper-slide" style="width: 343px; margin-right: 5px;">
                  <div class="thumbs-img">
                      <img src="/files/travel_destination/3b42fb93d961ef1cafd0de1f59d64514_thumb.jpg">
                  </div>
              </div>
                        <div class="swiper-slide" style="width: 343px; margin-right: 5px;">
                  <div class="thumbs-img">
                      <img src="/files/travel_destination/cd93d230742c8350cdf88c6faa732367_thumb.jpg">
                  </div>
              </div>
                        <div class="swiper-slide" style="width: 343px; margin-right: 5px;">
                  <div class="thumbs-img">
                      <img src="/files/travel_destination/c211e96adc81882ad084def61ed87d99_thumb.jpg">
                  </div>
              </div>
                        <div class="swiper-slide" style="width: 343px; margin-right: 5px;">
                  <div class="thumbs-img">
                      <img src="/files/travel_destination/cc7978c379ed5d0048217461ae00b998_thumb.jpg">
                  </div>
              </div>
                        <div class="swiper-slide" style="width: 343px; margin-right: 5px;">
                  <div class="thumbs-img">
                      <img src="/files/travel_destination/d0b89e7ad9ca093b87ebeaa3d9067365_thumb.jpg">
                  </div>
              </div>
                        <div class="swiper-slide" style="width: 343px; margin-right: 5px;">
                  <div class="thumbs-img">
                      <img src="/files/travel_destination/206ca531e0411106bedc87b37d55cf76_thumb.jpg">
                  </div>
              </div>
                        <div class="swiper-slide" style="width: 343px; margin-right: 5px;">
                  <div class="thumbs-img">
                      <img src="/files/travel_destination/6b791e3a5548b1994d2fd6514a5c2ba4_thumb.jpg">
                  </div>
              </div>
                        <div class="swiper-slide" style="width: 343px; margin-right: 5px;">
                  <div class="thumbs-img">
                      <img src="/files/travel_destination/1f49a08b28268aaaca546d75987c91ac_thumb.jpg">
                  </div>
              </div>
                        <div class="swiper-slide" style="width: 343px; margin-right: 5px;">
                  <div class="thumbs-img">
                      <img src="/files/travel_destination/af50326bf0101ac2b66075d37e7f6446_thumb.jpg">
                  </div>
              </div>
                        </div>
  <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
  <div class="thumbs_wrap">
      <div class="swiper-container tourism-thumbs tourism-thumbs2 thumbs_width2 swiper-container-initialized swiper-container-horizontal swiper-container-free-mode swiper-container-thumbs">
          <div class="swiper-wrapper" style="transform: translate3d(0px, 0px, 0px);">
                                            <div class="swiper-slide swiper-slide-visible swiper-slide-active" style="width: 58px; margin-right: 3px;">
                      <div class="thumbs-img">
                          <img src="/files/travel_destination/7d7d82a05b1ebfbec2cbd23987ba6a99_thumb.jpg">
                      </div>
                  </div>
                                <div class="swiper-slide swiper-slide-visible swiper-slide-next" style="width: 58px; margin-right: 3px;">
                      <div class="thumbs-img">
                          <img src="/files/travel_destination/0fc37c7e6f64d0143977f6232e07c406_thumb.jpg">
                      </div>
                  </div>
                                <div class="swiper-slide swiper-slide-visible" style="width: 58px; margin-right: 3px;">
                      <div class="thumbs-img">
                          <img src="/files/travel_destination/4dd19cf67bb69d30767eb90299005b3c_thumb.jpg">
                      </div>
                  </div>
                                <div class="swiper-slide swiper-slide-visible" style="width: 58px; margin-right: 3px;">
                      <div class="thumbs-img">
                          <img src="/files/travel_destination/396490b386c8ee3fd388b90ae9b9512e_thumb.jpg">
                      </div>
                  </div>
                                <div class="swiper-slide" style="width: 58px; margin-right: 3px;">
                      <div class="thumbs-img">
                          <img src="/files/travel_destination/3b42fb93d961ef1cafd0de1f59d64514_thumb.jpg">
                      </div>
                  </div>
                                <div class="swiper-slide" style="width: 58px; margin-right: 3px;">
                      <div class="thumbs-img">
                          <img src="/files/travel_destination/cd93d230742c8350cdf88c6faa732367_thumb.jpg">
                      </div>
                  </div>
                                <div class="swiper-slide" style="width: 58px; margin-right: 3px;">
                      <div class="thumbs-img">
                          <img src="/files/travel_destination/c211e96adc81882ad084def61ed87d99_thumb.jpg">
                      </div>
                  </div>
                                <div class="swiper-slide" style="width: 58px; margin-right: 3px;">
                      <div class="thumbs-img">
                          <img src="/files/travel_destination/cc7978c379ed5d0048217461ae00b998_thumb.jpg">
                      </div>
                  </div>
                                <div class="swiper-slide" style="width: 58px; margin-right: 3px;">
                      <div class="thumbs-img">
                          <img src="/files/travel_destination/d0b89e7ad9ca093b87ebeaa3d9067365_thumb.jpg">
                      </div>
                  </div>
                                <div class="swiper-slide" style="width: 58px; margin-right: 3px;">
                      <div class="thumbs-img">
                          <img src="/files/travel_destination/206ca531e0411106bedc87b37d55cf76_thumb.jpg">
                      </div>
                  </div>
                                <div class="swiper-slide" style="width: 58px; margin-right: 3px;">
                      <div class="thumbs-img">
                          <img src="/files/travel_destination/6b791e3a5548b1994d2fd6514a5c2ba4_thumb.jpg">
                      </div>
                  </div>
                                <div class="swiper-slide" style="width: 58px; margin-right: 3px;">
                      <div class="thumbs-img">
                          <img src="/files/travel_destination/1f49a08b28268aaaca546d75987c91ac_thumb.jpg">
                      </div>
                  </div>
                                <div class="swiper-slide" style="width: 58px; margin-right: 3px;">
                      <div class="thumbs-img">
                          <img src="/files/travel_destination/af50326bf0101ac2b66075d37e7f6446_thumb.jpg">
                      </div>
                  </div>
                                    </div>
        <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
        <div class="swiper_btn2">
          <div class="swiper-button-prev swiper-button-disabled" tabindex="0" role="button" aria-label="Previous slide" aria-disabled="true"><i class="fal fa-angle-left" aria-hidden="true"></i></div>
          <div class="swiper-button-next" tabindex="0" role="button" aria-label="Next slide" aria-disabled="false"><i class="fal fa-angle-right" aria-hidden="true"></i></div>
        </div>
      </div>

    </div>
    

<div class="sidebar-body">
  <div class="cont-box detail_content">
    <div class="cont-box-wrap content_box">
      <div class="info-btn content_tit_box">
        <h4 class="tit01">기본정보</h4>
        <i style="display:none;" class="fal fa-chevron-down" aria-hidden="true"></i>
      </div>
      <div class="info_div top_p_none">
        <ul class="list-ul">
          <li class="detail_list">
              <strong>제목</strong>
              <div class="txt">단골손님</div>
          </li>
          <li class="detail_list">
              <strong>연락처</strong>
              <div class="txt">042-823-3663</div>
          </li>
          <li class="detail_list">
              <strong>영업시간</strong>
              <div class="txt">17:00 ~ 02:00</div>
          </li>
          <li class="detail_list">
              <strong>메인서비스</strong>
              <div class="txt">전골류, 육회, 꼬막, 골뱅이, 족발, 볶음류, 주먹밥, 주류</div>
          </li>
          <li class="detail_list">
              <strong>주소</strong>
              <div class="txt">대전광역시 유성구 문화원로 86</div>
          </li>
        </ul>
      </div>
    </div>
  </div>


  <div class="cont-box detail_inline">
    <div class="cont-box-wrap detail_toggle_wrap">
      <div class="parking-btn detail_toggle">
        <h4 class="tit01 detail_tit">주차장 정보</h4>
        <i class="fal fa-chevron-down" aria-hidden="true"></i>
      </div>
    </div>
    <div class="parking_div" style="display:none;">
      <ul class="list-ul">
        <li>
            <strong>주차장</strong>
            <div class="txt">없음</div>
        </li>
        <li>
            <strong>주차금액</strong>
            <div class="txt">
                                                미비                                          </div>
        </li>
        <li>
            <strong>주차할인</strong>
            <div class="txt">미비</div>
        </li>
        <li>
            <strong>장애인 주차장</strong>
            <div class="txt">미비</div>
        </li>
        <li>
            <strong>안내표시</strong>
            <div class="txt">
                                                미비                                          </div>
        </li>
      </ul>
    </div>
  </div>

  <div class="cont-box detail_inline">
    <div class="cont-box-wrap detail_toggle_wrap">
      <div class="detail_toggle slope-btn">
        <h4 class="tit01 detail_tit">주출입구 정보</h4>
        <i class="slope_i fal fa-chevron-down" aria-hidden="true"></i>
      </div>
      <div class="slope_div" style="display:none;">
        <ul class="list-ul">
          <li>
              <strong>경사</strong>
              <div class="txt">경사없음</div>
          </li>
          <li>
              <strong>출입구 문턱</strong>
              <div class="txt">턱없음</div>
          </li>
          <li>
              <strong>출입문 종류</strong>
              <div class="txt">
                                                      미닫이                                                </div>
          </li>
          <li>
              <strong>출입문 너비</strong>
              <div class="txt">90CM 이상</div>
          </li>
        </ul>
      </div>
    </div>
  </div>


  <div class="cont-box detail_inline">
    <div class="cont-box-wrap detail_toggle_wrap">
      <div class="passage-btn detail_toggle">
        <h4 class="tit01 detail_tit">통로 정보</h4>
        <i class="passage_i fal fa-chevron-down" aria-hidden="true"></i>
      </div>
      <div class="passage_div" style="display:none;">
        <ul class="list-ul">
          <li>
              <strong>통로의 경사</strong>
              <div class="txt">경사없음</div>
          </li>
          <li>
              <strong>통로의 턱</strong>
              <div class="txt">턱없음</div>
          </li>
          <li>
              <strong>통로의 너비</strong>
              <div class="txt">90CM 이상</div>
          </li>
        </ul>
      </div>
    </div>
  </div>


  <div class="cont-box detail_inline">
    <div class="cont-box-wrap detail_toggle_wrap">
      <div class="elevator-btn detail_toggle">
        <h4 class="tit01 detail_tit">엘리베이터 정보</h4>
        <i class="elevator_i fal fa-chevron-down" aria-hidden="true"></i>
      </div>
      <div class="elevator_div" style="display:none;">
          <ul class="list-ul">
            <li>
                <strong>엘리베이터</strong>
                <div class="txt">없음</div>
            </li>
            <li>
                <strong>문너비</strong>
                <div class="txt">미비</div>
            </li>
            <li>
                <strong>내부공간</strong>
                <div class="txt">미비</div>
            </li>
            <li>
                <strong>장애인용 승강기버튼</strong>
                <div class="txt">미비</div>
            </li>
          </ul>
        </div>
    </div>
  </div>
  <div class="cont-box detail_inline">
    <div class="cont-box-wrap detail_toggle_wrap">
      <div class="bathroom-btn detail_toggle">
        <h4 class="tit01 detail_tit">내부화장실 정보</h4>
        <i class="fal fa-chevron-down" aria-hidden="true"></i>
      </div>
      <div class="bathroom_div" style="display:none;">
        <ul class="list-ul">
          <li>
              <strong>화장실</strong>
              <div class="txt">있음</div>
          </li>
          <li>
              <strong>휠체어 진입가능</strong>
              <div class="txt">가능</div>
          </li>
          <li>
              <strong>장애인 화장실</strong>
              <div class="txt">없음</div>
          </li>
        </ul>
      </div>
    </div>
  </div>

  <div class="cont-box detail_inline">
    <div class="cont-box-wrap detail_toggle_wrap">
      <div class="other-btn detail_toggle">
        <h4 class="tit01 detail_tit">기타편의 정보</h4>
        <i class="fal fa-chevron-down" aria-hidden="true"></i>
      </div>
      <div class="other_div" style="display:none;">
        <ul class="list-ul">
          <li>
              <strong>대여품</strong>
              <div class="txt">
                                                      없음                                                </div>
          </li>
          <li>
              <strong>수유실</strong>
              <div class="txt">없음</div>
          </li>
          <li>
              <strong>유아놀이방</strong>
              <div class="txt">없음</div>
          </li>
        </ul>
      </div>
    </div>
  </div>

    
  <div style="display:block;">

  <div class="cont-box detail_inline">
    <div class="cont-box-wrap detail_toggle_wrap">
      <div class="table-btn detail_toggle">
        <h4 class="tit01 detail_tit">식당, 카페, 술집 정보</h4>
        <i class="fal fa-chevron-down" aria-hidden="true"></i>
      </div>
      <div class="table_div" style="display:none;">
        <ul class="list-ul">
          <li>
              <strong>테이블형태</strong>
              <div class="txt">
                                                        일반식탁                                                </div>
          </li>
        </ul>
      </div>
    </div>
  </div>
</div>
      </div>

</div>
                      </div></div>
                  </div>
              </div>
              <div class="section-title section_tit">
                  <h2 class="text-danger section_title">관광(
                    <span class="results-number section_nummer">368</span>)
                  </h2>
              </div>
                <div class="results">
                    <div class="tse-scrollable"><div class="tse-scrollbar" style="display: none;"><div class="drag-handle" style="top: 721px; height: 58px;"></div></div>
                        <div class="tse-scroll-content" style="width: 343px; height: 889px;"><div class="tse-content">
                            <div class="results-content" id="map_list"><div class="result-item result_item" data-code="522" data-longitude="127.34994641461047" data-latitude="36.35748608421552"><a href="javascript:;"><div class="result-item-detail result-flex"><div class="img"><div class="image" style="background-image: url(/files/travel_destination/c19f569c56f0316892114c0a8f7f93c7_thumb.jpg)"><img class="sr-only" src="/files/travel_destination/c19f569c56f0316892114c0a8f7f93c7_thumb.jpg"></div></div><div class="description"><h3>IN'S</h3><h5><i class="fa fa-map-marker" aria-hidden="true"></i>대전광역시 유성구 온천동로65번길 54</h5><p></p></div></div></a></div><div class="result-item result_item" data-code="521" data-longitude="127.290939391067" data-latitude="36.346406649951156"><a href="javascript:;"><div class="result-item-detail result-flex"><div class="img"><div class="image" style="background-image: url(/files/travel_destination/bd78c74f185f2c465a5d833e6d2c0b9a_thumb.jpg)"><img class="sr-only" src="/files/travel_destination/bd78c74f185f2c465a5d833e6d2c0b9a_thumb.jpg"></div></div><div class="description"><h3>흑룡산촌두부</h3><h5><i class="fa fa-map-marker" aria-hidden="true"></i>대전광역시 유성구 수통골로 65-7</h5><p></p></div></div></a></div><div class="result-item result_item" data-code="520" data-longitude="127.29208069037097" data-latitude="36.34626418331133"><a href="javascript:;"><div class="result-item-detail result-flex"><div class="img"><div class="image" style="background-image: url(/files/travel_destination/480f74e2003bc2c7382f5bed4b9e7132_thumb.jpg)"><img class="sr-only" src="/files/travel_destination/480f74e2003bc2c7382f5bed4b9e7132_thumb.jpg"></div></div><div class="description"><h3>85도씨</h3><h5><i class="fa fa-map-marker" aria-hidden="true"></i>대전광역시 유성구 수통골로 69</h5><p></p></div></div></a></div><div class="result-item result_item" data-code="519" data-longitude="127.29273514958301" data-latitude="36.34551911002235"><a href="javascript:;"><div class="result-item-detail result-flex"><div class="img"><div class="image" style="background-image: url(/files/travel_destination/d94bec36b974ea62456f430346140467_thumb.jpg)"><img class="sr-only" src="/files/travel_destination/d94bec36b974ea62456f430346140467_thumb.jpg"></div></div><div class="description"><h3>수통골 돌짜장</h3><h5><i class="fa fa-map-marker" aria-hidden="true"></i>대전광역시 유성구 수통골로 17</h5><p></p></div></div></a></div><div class="result-item result_item" data-code="518" data-longitude="127.28927276980534" data-latitude="36.34607725997282"><a href="javascript:;"><div class="result-item-detail result-flex"><div class="img"><div class="image" style="background-image: url(/files/travel_destination/b7ebc2f238924128851b7b11800b582f_thumb.jpg)"><img class="sr-only" src="/files/travel_destination/b7ebc2f238924128851b7b11800b582f_thumb.jpg"></div></div><div class="description"><h3>피제리아614</h3><h5><i class="fa fa-map-marker" aria-hidden="true"></i>대전광역시 유성구 수통골로 47-12</h5><p></p></div></div></a></div><div class="row"><div class="col-md-12" style="text-align:" center;=""><ul class="pagination"><li class="disabled"><a href="#" title="더이상없습니다.">&lt;</a></li><li><a data-loop="1" data-north_east_lat="36.435287030182096" data-north_east_lng="127.41639050608244" data-south_west_lat="36.29147639288397" data-south_west_lng="127.2885423143712" data-category_code="" data-keyword="" title="1페이지로 이동" class="pagenation">1</a></li><li><a data-loop="2" data-north_east_lat="36.435287030182096" data-north_east_lng="127.41639050608244" data-south_west_lat="36.29147639288397" data-south_west_lng="127.2885423143712" data-category_code="" data-keyword="" title="2페이지로 이동" class="pagenation">2</a></li><li><a data-loop="3" data-north_east_lat="36.435287030182096" data-north_east_lng="127.41639050608244" data-south_west_lat="36.29147639288397" data-south_west_lng="127.2885423143712" data-category_code="" data-keyword="" title="3페이지로 이동" class="pagenation">3</a></li><li><a data-loop="4" data-north_east_lat="36.435287030182096" data-north_east_lng="127.41639050608244" data-south_west_lat="36.29147639288397" data-south_west_lng="127.2885423143712" data-category_code="" data-keyword="" title="4페이지로 이동" class="pagenation">4</a></li><li class="active"><a href="#" title="현재페이지입니다.">5</a></li><li><a data-loop="6" data-north_east_lat="36.435287030182096" data-north_east_lng="127.41639050608244" data-south_west_lat="36.29147639288397" data-south_west_lng="127.2885423143712" data-category_code="" data-keyword="" title="다음5페이지 보기" class="pagenation">&gt;</a></li></ul></div></div></div>
                        </div></div>
                    </div>
                </div>
            </div>
            </div>
  </form>
   	<%@include file="../../layouts/app/footer.jsp"%>
</body>
<%@include file="../../layouts/app/script.jsp"%>

