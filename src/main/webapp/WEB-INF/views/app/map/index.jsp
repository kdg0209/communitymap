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
	                 <a href="javascript:history.back();" class="btn btn-dark btn-icon-split f-s-10" style="float:left; font-size: 12px; margin-bottom: 8px; margin-top: -18px;">
	            	     <i class="fas fa-chevron-left"></i>
                         <span class="text">이전으로</span>
                     </a>
                     <div class="mapping-item">
                       <div class="media m-t-30">
                           <img src="https://moyeoyou.kr/files/travel_destination/d81b72fdac02b88acaf2dc720294efd5_thumb.jpg" style="width:100%; height:auto;">
                           <div class="media-body pl-3">
                             <div class="title">
                                 ${mapper.name}
                             </div>
                             <div class="address">
                             	 ${fn:substring(mapper.contents, 0, 30) }
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
                       <%if(session.getAttribute("id") != null) {%>
	                       <a href="javascript:;" class="btn btn-dark btn-icon-split f-s-10" onclick="mapperLikeFn('${mapper.code}');" style="float:right; font-size: 12px;">
	                         <i class="far fa-thumbs-up"></i>
	                         <span class="text">좋아요(${mapper.mapperRecommendCount})건</span>
	                       </a>
                       <%} %>
                     </div>
                    
	                <div id="Map-Item-List">
		                <c:if test="${not empty dataList}">
							<c:forEach var="loop" begin="0" end="${fn:length(dataList)-1}">
		                       <div class="mapping-item">
		                         <div class="media map_view m-t-30" data-code="${dataList[loop].code}" data-latitude="${dataList[loop].latitude}" data-longitude="${dataList[loop].longitude}">
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
		                         <a href="javascript:;" class="btn btn-danger btn-icon-split f-s-10" onclick="declareFn('${mapper.code}', '${dataList[loop].code}');" style="float:right; font-size: 10px; color: white;">
		                           <i class="fas fa-exclamation-circle"></i>
		                           <span class="text">신고하기</span>
		                         </a>
		                       </div>
	                        </c:forEach>
						</c:if>
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
	        aJson.markerImg      = mapList[loop].markerImg;
	        aJson.latlng         = new kakao.maps.LatLng(mapList[loop].latitude, mapList[loop].longitude);
	        aJson.latitude       = mapList[loop].latitude;
	        aJson.longitude      = mapList[loop].longitude;
	        aJsonArray.push(aJson);
	    }
	      
	    for (var Loop = 0; Loop < aJsonArray.length; Loop++) {
	        displayMarker(aJsonArray[Loop]);
	    }
	    
	    /*
        *
        * 지도가 마우스 드래그로 지도 이동이 완료되었을 때 중심좌표가 변경되면 새롭게 지도, 목록에 데이터 그려줌
        *
       */
        kakao.maps.event.addListener(map, 'dragend', function() {
          var bounds   = map.getBounds();        // 지도의 현재 영역을 얻어옵니다
          var neLatLng = bounds.getNorthEast();  // 영역의 북동쪽 좌표를 얻어옵니다
          var swLatLng = bounds.getSouthWest();  // 영역의 남서쪽 좌표를 얻어옵니다

          displayMap(neLatLng.getLng(), neLatLng.getLat(), swLatLng.getLng(), swLatLng.getLat());
        });
	    
        /*
        *
        * 지도를 그려주는 함수
        *
       */
        function displayMap(north_east_lng, north_east_lat, south_west_lng, south_west_lat){
          var request = $.ajax({
              url: "/app/map/data",
              type: "post",
              dataType: "json",
              contentType: 'application/json',
              data: JSON.stringify({
        		  "north_east_lng" : String(north_east_lng),
                  "north_east_lat" : String(north_east_lat),
                  "south_west_lng" : String(south_west_lng),
                  "south_west_lat" : String(south_west_lat),
                  "mapperCode": String(${mapper.code})
        	  })
          });
          request.done(function(data) {
        	
            var page    = '';
            $("#Map-Item-List").html('');

            resetList(page, north_east_lng, north_east_lat, south_west_lng, south_west_lat, ${mapper.code});

            //그려진 마커를 지워주는 함수
            removeMarker();

            var aJsonArray = new Array();
            for (var Loop = 0; Loop < data.dataList.length; Loop++) {
            	var aJson                  = new Object();
            	aJson.code           = data.dataList[Loop].code;
     	        aJson.markerImg      = data.dataList[Loop].markerImg;
     	        aJson.latlng         = new kakao.maps.LatLng(data.dataList[Loop].latitude, data.dataList[Loop].longitude);
     	        aJson.latitude       = data.dataList[Loop].latitude;
     	        aJson.longitude      = data.dataList[Loop].longitude;
                aJsonArray.push(aJson);
            }
            
            for (var DLoop = 0; DLoop < aJsonArray.length; DLoop++) {
                displayMarker(aJsonArray[DLoop]); // 지도에 마커를 표시하는 함수
            }
          });

          request.fail(function( jqXHR, textStatus ) {
              alert( "Request failed: " + textStatus );
          });
        }  
	     	
	      
	    // 지도에 마커를 표시하는 함수
        function displayMarker(data) {
	    	// console.log(data);
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
            	   url: "/app/map/selectMarker",
                   type: "post",
                   dataType: "json",
                   contentType: 'application/json',
                   data: JSON.stringify({
             		  "code" : String(data.code),
             	  })
              });

              request.done(function(data) {
                  $("#Map-Item-List").html('');
                  var html       = "";

                  html += "<div class='mapping-item'>";
                  html +=   "<div class='media map_view m-t-30' data-code='"+data.dataSelectOne[0].code+"' data-latitude='"+data.dataSelectOne[0].latitude+"' data-longitude='"+data.dataSelectOne[0].longitude+"'>";
                  
                  if(data.dataSelectOne[0].fileName != ""){
                    html +=   "<img src='/img/mappingCover/"+ data.dataSelectOne[0].fileName +"' style='width:100px; height:100px; margin-top: 5px;'>";
                  }else{
                    html +=   "<img src='/assets/img/default_user.jpg' style='width:100px; height:100px;'>";
                  }

                  html +=     "<div class='media-body pl-3'>";
                  html +=       "<div class='item=title'>";
                  html +=          data.dataSelectOne[0].fieldValues
                  html +=       "</div>";
                  html +=       "<div class='item-address'>"+ data.dataSelectOne[0].address +"</div>";
                  html +=       "<div class='item-category'><i class='fas fa-tags'></i> "+ data.dataSelectOne[0].categoryName +"</div>";
                  html +=     "</div>";
                  html +=   "</div>";
                  
                  html +=   "<a href='javascript:;' class='btn btn-danger btn-icon-split f-s-10' onclick='declareFn("+data.dataSelectOne[0].mapperCode+", "+data.dataSelectOne[0].code+");' style='float:right; font-size: 10px; color: white;'>";
                  html +=     "<i class='fas fa-exclamation-circle'></i>";
                  html +=     "<span class='text'>신고하기</span>";
                  html +=   "</a>";
                  html += "</div>";
                 
                  $("#Map-Item-List").append(html);
                  
                  $(".map_view").click(function (e) {
                	  e.preventDefault();
                	  markerPosition($(this).data('code'), $(this).data('longitude'), $(this).data('latitude'));
                  });
              });

              request.fail(function( jqXHR, textStatus ) {
                  console.log("Request failed: " + textStatus);
              });
            });
          }
	    
     	  // 지도 위에 표시되고 있는 마커를 모두 제거합니다
          function removeMarker(type) {
              //클러스터러 초기화 
              clusterer.clear();

              for(var loop = 0; loop < markers.length; loop++){
                  markers[loop].setMap(null);
              }
              markers = []; 

              for(var doop = 0; doop < map_view_markers.length; doop++){
                  map_view_markers[doop].setMap(null);
              }
              map_view_markers = [];
          }
	    
          function resetList(page, north_east_lng, north_east_lat, south_west_lng, south_west_lat, mapperCode){
              var request = $.ajax({
                  url: "/app/map/dataList",
                  type: "post",
                  dataType: "json",
                  contentType: 'application/json',
                  data: JSON.stringify({
                	  "page" : page,
            		  "north_east_lng" : String(north_east_lng),
                      "north_east_lat" : String(north_east_lat),
                      "south_west_lng" : String(south_west_lng),
                      "south_west_lat" : String(south_west_lat),
                      "mapperCode": String(mapperCode)
            	  }) 
              });

              request.done(function(data) {
            	  $(".slideDetail").remove();
            	  $("#Map-List").show();
                  $("#Map-Item-List").html('');
                  var html         = "";
                  
                  if(data.dataList.length > 0){
                    for (var loop = 0; loop < data.dataList.length; loop++) {
                      html += "<div class='mapping-item'>";
                      html +=   "<div class='media map_view m-t-30' data-code='"+data.dataList[loop].code+"' data-latitude='"+data.dataList[loop].latitude+"' data-longitude='"+data.dataList[loop].longitude+"'>";

                      if(data.dataList[loop].fileName != ""){
                        html +=   "<img src='/img/mappingCover/"+ data.dataList[loop].fileName +"' style='width:100px; height:100px; margin-top: 5px;'>";
                      }else{
                        html +=   "<img src='/assets/img/default_user.jpg' style='width:100px; height:100px;'>";
                      }

                      html +=     "<div class='media-body pl-3'>";
                      html +=       "<div class='item=title'>";
                      html +=          data.dataList[loop].fieldValues
                      html +=       "</div>";
                      html +=       "<div class='item-address'>"+ data.dataList[loop].address +"</div>";
                      html +=       "<div class='item-category'><i class='fas fa-tags'></i> "+ data.dataList[loop].categoryName +"</div>";
                      html +=     "</div>";
                      html +=   "</div>";
                      
                      html +=   "<a href='javascript:;' class='btn btn-danger btn-icon-split f-s-10' onclick='declareFn("+data.dataList[loop].mapperCode+", "+data.dataList[loop].code+");' style='float:right; font-size: 10px; color: white;'>";
                      html +=     "<i class='fas fa-exclamation-circle'></i>";
                      html +=     "<span class='text'>신고하기</span>";
                      html +=   "</a>";
                      html += "</div>";
                    }
                  }else{
                    html += "<div style='height:300px; text-align:center; padding-top:120px;'>";
                    html +=   "등록된 내용이 없습니다.";
                    html += "</div>";
                  }
                  $("#Map-Item-List").append(html);
                  
                  $(".map_view").click(function (e) {
                	  e.preventDefault();
                      markerPosition($(this).data('code'), $(this).data('longitude'), $(this).data('latitude'));
                  });
              });
          }
          
          function markerPosition(code, longitude, latitude){
              var request = $.ajax({
                url: "/app/map/slideDetail",
                type: "post",
                dataType: "html",
                contentType: 'application/json',
                data: JSON.stringify({
          		  "code" : String(code),
          		  "mapperCode": String(${mapper.code})
          	  	}) 
              });

              request.done(function(data) {
                var latlng      = new kakao.maps.LatLng(latitude, longitude);
                var bounds      = new kakao.maps.LatLngBounds();
                var imageSrc    = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
                var imageSize   = new kakao.maps.Size(30, 41);
                var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
             
                for(var doop = 0; doop < map_view_markers.length; doop++){
                    map_view_markers[doop].setMap(null);
                }
                
                map_view_markers = [];

                var marker = new kakao.maps.Marker({
                    map: map,
                    position: latlng,
                    image : markerImage
                });
       
                bounds.extend(latlng);
                map_view_markers.push(marker);
                map.setBounds(bounds);

                $("#Map-List").parent().parent().find('.Map-contents').addClass('show-detail');
                $('#Map-List').fadeOut();
                $(".show-detail").append(data);
                $(".show-detail").fadeIn();
              });
          }
          
          $(".map_view").click(function (e) {
        	  e.preventDefault();
        	  markerPosition($(this).data('code'), $(this).data('longitude'), $(this).data('latitude'));
          });
	});
</script>
<script>
	function mapperLikeFn(mapperCode) {
		var request = $.ajax({
            url: "/app/mapperRecommend/like",
            type: "post",
            dataType: "json",
            contentType: 'application/json',
            data: JSON.stringify({
      		  "mapperCode": String(mapperCode)
      	  	}) 
          });
		
		 request.done(function(data) {
			  if (data == true) {
	            window.location.reload();
	          } else if (data == false) {
	         	alert("잘못된 접근입니다.");
	          	return false;
	          }
          });
		
		 request.fail(function( jqXHR, textStatus ) {
             console.log("Request failed: " + textStatus);
         });
	}
</script>
<script>
	function declareFn(mapperCode, mappingCode) {
		var request = $.ajax({
            url: "/app/mappingDeclare/write?mappingCode=" + mappingCode + "&mapperCode=" + mapperCode,
            type: "get",
            dataType: "html",
          });
		
		 request.done(function(data) {
			 $('body').append(data);
	         $('.modal').show();
          });
		
		 request.fail(function( jqXHR, textStatus ) {
             console.log("Request failed: " + textStatus);
         });
	}
</script>