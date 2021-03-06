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
		                         <a href="javascript:;" class="btn btn-danger btn-icon-split f-s-10" onclick="declareFn('${dataList[loop].code}');" style="float:right; font-size: 10px; color: white;">
		                           <i class="fas fa-exclamation-circle"></i>
		                           <span class="text">????????????</span>
		                         </a> 
		                          <a href="javascript:;" class="btn btn-secondary btn-icon-split f-s-10 Detail-Btn" data-code="${dataList[loop].code}" data-latitude="${dataList[loop].latitude}" data-longitude="${dataList[loop].longitude}" style="float:right; font-size: 10px; color: white; margin-right: 3%;">
		                           <i class="fas fa-search-plus"></i>
		                           <span class="text">?????? ??????</span>
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
		var container = document.getElementById('kakao_map'); //????????? ?????? ????????? DOM ????????????
	    var options = { //????????? ????????? ??? ????????? ?????? ??????
	        center: new kakao.maps.LatLng(36.3505388993078, 127.384834846753), //????????? ????????????.
	        level: 5, //????????? ??????(??????, ?????? ??????)
	        scrollwheel: true, //  ????????? ???, ????????? ????????? ????????? ?????? ??? ?????? ?????? ??????(Boolean)
	    };
	    var map = new kakao.maps.Map(container, options); //?????? ?????? ??? ?????? ??????
	      
	    var markers            = [];
	    var now_marker_array   = [];
	    var aJsonArray  	   = new Array();
	    var mapContainer = document.getElementById('kakao_map'), // ????????? ????????? div
	          mapOption = {
	              center: new kakao.maps.LatLng(36.3505388993078, 127.384834846753), // ????????? ????????????
	              level: 6 // ????????? ?????? ??????
	          };
	    var map = new kakao.maps.Map(mapContainer, mapOption); // ????????? ???????????????

	    var infowindow = new kakao.maps.InfoWindow({zIndex: 1});

	    // ?????? ?????????????????? ??????
	    var clusterer = new kakao.maps.MarkerClusterer({
	        map: map,
	        averageCenter: true, // ??????????????? ????????? ???????????? ?????? ????????? ???????????? ?????? ????????? ??????
	        minLevel: 1, // ???????????? ??? ?????? ?????? ??????
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
        * ????????? ????????? ???????????? ?????? ????????? ??????????????? ??? ??????????????? ???????????? ????????? ??????, ????????? ????????? ?????????
        *
       */
        kakao.maps.event.addListener(map, 'dragend', function() {
          var bounds   = map.getBounds();        // ????????? ?????? ????????? ???????????????
          var neLatLng = bounds.getNorthEast();  // ????????? ????????? ????????? ???????????????
          var swLatLng = bounds.getSouthWest();  // ????????? ????????? ????????? ???????????????

          displayMap(neLatLng.getLng(), neLatLng.getLat(), swLatLng.getLng(), swLatLng.getLat());
        });
	    
        /*
        *
        * ????????? ???????????? ??????
        *
       */
        function displayMap(north_east_lng, north_east_lat, south_west_lng, south_west_lat){
          var JsonData = JSON.stringify({
      		  "north_east_lng" : String(north_east_lng),
              "north_east_lat" : String(north_east_lat),
              "south_west_lng" : String(south_west_lng),
              "south_west_lat" : String(south_west_lat),
    	  });
          
          var request = $.ajax({
              url: "/app/allMap/data",
              type: "post",
           	  data: JsonData,
         	  contentType:'application/json',
              dataType: "json",
          });
          request.done(function(data) {
            var page    = '';
            $("#Map-Item-List").html('');

            resetList(page, north_east_lng, north_east_lat, south_west_lng, south_west_lat);

            //????????? ????????? ???????????? ??????
            removeMarker();

            var aJsonArray = new Array();
            for (var Loop = 0; Loop < data.dataList.length; Loop++) {
            	var aJson            = new Object();
            	aJson.code           = data.dataList[Loop].code;
     	        aJson.markerImg      = data.dataList[Loop].markerImg;
     	        aJson.latlng         = new kakao.maps.LatLng(data.dataList[Loop].latitude, data.dataList[Loop].longitude);
     	        aJson.latitude       = data.dataList[Loop].latitude;
     	        aJson.longitude      = data.dataList[Loop].longitude;
                aJsonArray.push(aJson);
            }
            
            for (var DLoop = 0; DLoop < aJsonArray.length; DLoop++) {
                displayMarker(aJsonArray[DLoop]); // ????????? ????????? ???????????? ??????
            }
          });

          request.fail(function( jqXHR, textStatus ) {
              alert( "Request failed: " + textStatus );
          });
        }  
	     	
	      
	    // ????????? ????????? ???????????? ??????
        function displayMarker(data) {
            var imageSize   = new kakao.maps.Size(22, 35);                    // ?????? ???????????? ????????? ?????? ?????????
            var markerImage = new kakao.maps.MarkerImage(data.markerImg, imageSize) // ?????? ???????????? ???????????????
            var marker = new kakao.maps.Marker({
                map: map,
                position: data.latlng,
                image : markerImage
            });
            markers.push(marker);           //?????? ???????????? ?????? array??? ??????
      		clusterer.addMarkers(markers);  // ?????????????????? ???????????? ???????????????

            kakao.maps.event.addListener(marker, 'click', function () {
            	mappingDetailFn(data.code);
            });
          }
	    
     	  // ?????? ?????? ???????????? ?????? ????????? ?????? ???????????????
          function removeMarker(type) {
              //??????????????? ????????? 
              clusterer.clear();

              for(var loop = 0; loop < markers.length; loop++){
                  markers[loop].setMap(null);
              }
              markers = []; 
              
              for(var dloop = 0; dloop < now_marker_array.length; dloop++){
                  now_marker_array[dloop].setMap(null);
              }
              now_marker_array = [];
          }
	    
     	  // ???????????? ???????????? ??????
          function resetList(page, north_east_lng, north_east_lat, south_west_lng, south_west_lat){
              var JsonData = JSON.stringify({
          		  "north_east_lng" : String(north_east_lng),
                  "north_east_lat" : String(north_east_lat),
                  "south_west_lng" : String(south_west_lng),
                  "south_west_lat" : String(south_west_lat)
        	  });
              
              var request = $.ajax({
                  url: "/app/allMap/dataList",
                  type: "post",
                  dataType: "json",
                  contentType: 'application/json',
                  data: JsonData
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
                      
                      html +=   "<a href='javascript:;' class='btn btn-danger btn-icon-split f-s-10' onclick='declareFn("+data.dataList[loop].code+");' style='float:right; font-size: 10px; color: white;'>";
                      html +=     "<i class='fas fa-exclamation-circle'></i>";
                      html +=     "<span class='text'>????????????</span>";
                      html +=   "</a>";
                      html +=   "<a href='javascript:;' class='btn btn-secondary btn-icon-split f-s-10 Detail-Btn' data-code='"+data.dataList[loop].code+"' data-latitude='"+data.dataList[loop].latitude+"' data-longitude='"+data.dataList[loop].longitude+"' style='float:right; font-size: 10px; color: white; margin-right: 3%;'>";
                      html +=     "<i class='fas fa-search-plus'></i>";
                      html +=     "<span class='text'>?????? ??????</span>";
                      html +=   "</a>";
                      html += "</div>";
                    }
                  }else{
                    html += "<div style='height:300px; text-align:center; padding-top:120px;'>";
                    html +=   "????????? ????????? ????????????.";
                    html += "</div>";
                  }
                  $("#Map-Item-List").append(html);
                  
                  $(".map_view").hover(function (e) {
                	  e.preventDefault();
                	  markerPosition($(this).data('code'), $(this).data('longitude'), $(this).data('latitude'));
                  });
                  
                  $(".Detail-Btn").click(function (e) {
                	  e.preventDefault();
                	  mappingDetailFn($(this).data('code'), $(this).data('longitude'), $(this).data('latitude'));
        		  });
              });
          }
     	  
     	  function mappingDetailFn(code, longitude, latitude) {
     		 var request = $.ajax({
                 url: "/app/allMap/slideDetail",
                 type: "post",
                 dataType: "html",
                 contentType: 'application/json',
                 data: JSON.stringify({
           		  "code" : String(code)
           	  	}) 
             });
     		 
     		request.done(function(data) {
     			 for(var dloop = 0; dloop < now_marker_array.length; dloop++){
                     now_marker_array[dloop].setMap(null);
                 }
                 now_marker_array = [];

                 var imageSize   = new kakao.maps.Size(30, 40);    // ?????? ???????????? ????????? ??????
                 var imageSrc    = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";   // ?????? ???????????? ??????
                 var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); // ?????? ???????????? ???????????????
                 var latlng      = new kakao.maps.LatLng(latitude, longitude);
                 var now_marker  = new kakao.maps.Marker({
                     map: map,
                     position: latlng,
                     image : markerImage // ?????? ?????????
                 });

                 now_marker_array.push(now_marker); //?????? ???????????? ?????? array??? ??????
                 
     			if($("#Map-List").parent().parent().find('.Map-contents').hasClass('show-detail')){
     				$(".slideDetail").remove();
     			}
     			
                $("#Map-List").parent().parent().find('.Map-contents').addClass('show-detail');
                $('#Map-List').fadeOut();
                $(".show-detail").append(data);
                $(".show-detail").fadeIn();
             });
		  }
          
          function markerPosition(code, longitude, latitude){
              for(var dloop = 0; dloop < now_marker_array.length; dloop++){
                  now_marker_array[dloop].setMap(null);
              }
              now_marker_array = [];

              var imageSize   = new kakao.maps.Size(30, 40);    // ?????? ???????????? ????????? ??????
              var imageSrc    = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";   // ?????? ???????????? ??????
              var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); // ?????? ???????????? ???????????????
              var latlng      = new kakao.maps.LatLng(latitude, longitude);
              var now_marker  = new kakao.maps.Marker({
                  map: map,
                  position: latlng,
                  image : markerImage // ?????? ?????????
              });

              now_marker_array.push(now_marker); //?????? ???????????? ?????? array??? ??????
          }
          
          $(".map_view").hover(function (e) {
        	  e.preventDefault();
        	  markerPosition($(this).data('code'), $(this).data('longitude'), $(this).data('latitude'));
          });
          
          $(".Detail-Btn").click(function (e) {
        	  e.preventDefault();
        	  mappingDetailFn($(this).data('code'), $(this).data('longitude'), $(this).data('latitude'));
		  });
	});
</script>
<script>
	function declareFn(mappingCode) {
		var request = $.ajax({
            url: "/app/mappingDeclare/write?mappingCode=" + mappingCode,
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