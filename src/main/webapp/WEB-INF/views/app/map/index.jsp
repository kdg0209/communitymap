<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="../../layouts/app/head.jsp"%>
<%@include file="../../layouts/app/header.jsp"%>


<style media="screen">
h2{float:left; width:100%; color:#fff; margin-bottom:40px; font-size: 14px; position:relartive; z-index:3; margin-top:30px}
h2 span{font-family: 'Libre Baskerville', serif; display:block; font-size:45px; text-transform:none; margin-bottom:20px; margin-top:30px; font-weight:700}
h2 a{color:#fff; font-weight:bold;}

.Map-contents{
  background:#fff;
  height:844px;
  padding-top:20px;
  overflow-y:scroll;
}
.map-box{
  background-color:#A3CCFF;
}
.title{
  font-weight: bold;
  font-size: 17px;
}
.address{
  font-size: 13px;
}
.address img{
  width: 13px;
  height: 22px;
}
.category{
  font-size: 13px;
}
.mapping-item {
    border-bottom: 1px solid #eee;
    padding-bottom: 40px;
}
.item-title, .item-address, .item-category {
  font-size: 14px;
}
</style>

<body>
	<section class="service-wrapper py-3">
	  <div class="row">
	    <section class="search-box">
	        <div class="container-fluid">
	          <div class="row">
	            <div class="col-sm-3 col-md-3 Map-contents">
	              <div id="Map-List">
	                <div id="Map-Item-List">
                       <div class="mapping-item">
                         <div class="media map_view m-t-30">
                             <img src="https://moyeoyou.kr/files/travel_destination/d81b72fdac02b88acaf2dc720294efd5_thumb.jpg" style="width:100%; height:auto;">
                             <div class="media-body pl-3">
                               <div class="title">
                                   ${mapper.name}
                               </div>
                               <div class="address">
                                 ${mapper.contents}
                                </div>
                               <div class="category">
                                 <i class="fas fa-tags"></i>
                                 <span>
                                 	 <c:if test = "${fn:contains(categoryList, mapper.categoryCode)}">
								         ${categoryList[mapper.categoryCode]}
								      </c:if>
                                 </span>
                               </div>
                             </div>
                         </div>
                         <a href="javascript:;" class="btn btn-dark btn-icon-split f-s-10" style="float:right; font-size: 12px;">
                           <i class="far fa-thumbs-up"></i>
                           <span class="text">좋아요(10)</span>
                         </a>
                       </div>
	                </div>
	         
	                <div id="Map-Item-List">
	                 <c:forEach var="loop" begin="0" end="${fn:length(dataList)-1}">
                       <div class="mapping-item">
                         <div class="media map_view m-t-30">
                             <img src="/img/mappingCover/${dataList[loop].fileName}" style="width:100px; height:100px; margin-top: 5px;">
                             <div class="media-body pl-3">
                               <div class="item-title">
                                   ${dataList[loop].fieldValues}
                               </div>
                               <div class="item-address">
                                	${dataList[loop].address}
                                </div>
                               <div class="item-category">
                                 <i class="fas fa-tags"></i>
                                 ${dataList[loop].categoryName}
                               </div>
                             </div>
                         </div>
                         <a href="javascript:;" class="btn btn-danger btn-icon-split f-s-10" style="float:right; font-size: 10px; color: white;">
                           <i class="fas fa-exclamation-circle"></i>
                           <span class="text">신고하기</span>
                         </a>
                       </div>
                      </c:forEach>
                	</div>
	              </div>
	            </div>
	            <div class="col-sm-9 col-md-9 map-box mx-0 px-0">
	                <div id="kakao_map" style="width:100%; height:844px;"></div>
	            </div>
	          </div>
	        </div>
	    </section>
	  </div>
	</section>

   	<%@include file="../../layouts/app/footer.jsp"%>
</body>
<%@include file="../../layouts/app/script.jsp"%>

<script>
	$(document).ready(function () {
		var mapList = ${json};
		var container = document.getElementById('kakao_map'); //지도를 담을 영역의 DOM 레퍼런스
	    var options = { //지도를 생성할 때 필요한 기본 옵션
	        center: new kakao.maps.LatLng(36.3505388993078, 127.384834846753), //지도의 중심좌표.
	        level: 5, //지도의 레벨(확대, 축소 정도)
	        scrollwheel: true, //  마우스 휠, 모바일 터치를 이용한 확대 및 축소 가능 여부(Boolean)
	    };
	    var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	      
	    var markers          = [];
	    var map_view_markers = [];
	    var mapper_code 	   = ${mapper.code};
	    var aJsonArray  	   = new Array();
	    var mapContainer = document.getElementById('kakao_map'), // 지도를 표시할 div
	          mapOption = {
	              center: new kakao.maps.LatLng(36.3505388993078, 127.384834846753), // 지도의 중심좌표
	              level: 6 // 지도의 확대 레벨
	          };
	    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

	    var infowindow = new kakao.maps.InfoWindow({zIndex: 1});

	    // 마커 클러스터러를 생성
	    var clusterer = new kakao.maps.MarkerClusterer({
	        map: map,
	        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정
	        minLevel: 1, // 클러스터 할 최소 지도 레벨
	        gridSize : 60
	    });
	      
	    for (var loop = 0; loop < mapList.length; loop++) {
	    	var aJson            = new Object();
	        aJson.code           = mapList[loop].code;
	        aJson.mapperCode     = mapList[loop].mapperCode;
	        aJson.categoryCode   = mapList[loop].categoryCode;
	        aJson.categoryName   = mapList[loop].categoryName;
	        aJson.address   	   = mapList[loop].address;
	        aJson.markerImg      = mapList[loop].markerImg;
	        aJson.latlng         = new kakao.maps.LatLng(mapList[loop].latitude, mapList[loop].longitude);
	        aJson.latitude       = mapList[loop].latitude;
	        aJson.longitude      = mapList[loop].longitude;
	        aJsonArray.push(aJson);
	    }
	      
	    for (var Loop = 0; Loop < aJsonArray.length; Loop++) {
	        displayMarker(aJsonArray[Loop], 'dragendMap');
	    }
	      
	     	
	      
	    // 지도에 마커를 표시하는 함수
        function displayMarker(data, type) {
            var imageSize   = new kakao.maps.Size(22, 35);                    // 마커 이미지의 이미지 크기 입니다
            var markerImage = new kakao.maps.MarkerImage(data.markerImg, imageSize) // 마커 이미지를 생성합니다
            var marker = new kakao.maps.Marker({
                map: map,
                position: data.latlng,
                image : markerImage
            });

            markers.push(marker);           //마커 삭제하기 위해 array에 담음
            clusterer.addMarkers(markers);  // 클러스터러에 마커들을 추가합니다

            kakao.maps.event.addListener(marker, 'click', function () {
              var request = $.ajax({
                  url: "/app/mapping/map_view",
                  type: "get",
                  dataType: "json",
                  data: {
                    code : data.code
                  }
              });

              request.done(function(data) {
                if(data.result == 'true'){
                	$("#Map-Item-List").html('');
                    var html       = "";

                    if(data.data.code != ""){
                      html += "<div class='media map_view'>";
                      html +=   "<div class='media-body pl-3'>";
                      html +=     "<div class='title' data-code='"+data.data.code+"' data-title='"+data.data.title+"' data-address='"+data.data.address+"' data-longitude='"+data.data.longitude+"' data-latitude='"+data.data.latitude+"'>"+data.data.title+"</div>";
                      html +=     "<div class='address'><i class='fas fa-map-marker-alt'></i> "+data.data.title+"</div>";
                      html +=     "<div class='write_date'><i class='fas fa-calendar-week'></i> "+data.data.write_date+"</div>";
                      html +=   "</div>";
                      html += "</div>";
                    }else{
                      html += "<div style='height:300px; text-align:center; padding-top:120px;'>";
                      html +=   "등록된 내용이 없습니다.";
                      html += "</div>";
                    }
                    $("#Map-Item-List").append(html);

                    $(".map_view").click(function () {
                      markerPosition($(this).data('code'), $(this).data('title'), $(this).data('address'), $(this).data('longitude'), $(this).data('latitude'));
                    });
                }
              });

              request.fail(function( jqXHR, textStatus ) {
                  console.log("Request failed: " + textStatus);
              });
            });
          }
	      
	});
</script>