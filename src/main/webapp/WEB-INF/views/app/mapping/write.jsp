<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="../../layouts/app/head.jsp"%>

<%@include file="../../layouts/app/header.jsp"%>

<body>
    <section class="service-wrapper py-3">
        <div class="container-fluid pb-3">
            <div class="row">
                <h2 class="h2 text-center col-12 py-5 semi-bold-600">정보 등록하기</h2>
                <div class="service-header col-2 col-lg-3 text-end light-300">
                	<i class="fas fa-map-marked-alt fa-2x"></i>
                </div>
                <div class="service-heading col-10 col-lg-9 text-start float-end light-300">
                    <h2 class="h3 pb-4 typo-space-line">Community Map</h2>
                </div>
            </div>
            <p class="service-footer col-10 offset-2 col-lg-9 offset-lg-3 text-start pb-3 text-muted px-2">
                나의 정보를 등록하여 사람들과 공유해보세요.!
            </p>
        </div>
    </section>
     <section class="container py-5">
        <div class="row pb-4" style="margin-top: -70px;">
        	<div class="col-lg-2"></div>
            <div class="col-lg-8">
                <form id="submitForm" class="contact-form row" role="form">
                	<input type="hidden" name="timestamp" id="timestamp" value="${timestamp}"/>
                	<input type="text" name="filename" id="filename" />
                	<input type="text" name="cover" id="cover" />
                	
                	<div class="col-12">
                        <div class="form-floating mb-4">
                            <div class="profile-pic-wrapper">
							  <div class="pic-holder">
							    <img id="profilePic" class="pic" src="https://source.unsplash.com/random/150x150">
							    <label for="newProfilePhoto" class="upload-file-block">
							      <div class="text-center">
							        <div class="mb-2">
							          <i class="fa fa-camera fa-2x"></i>
							        </div>
							        <div class="text-uppercase">
							          Update <br />
							          Photo
							        </div>
							      </div>
							    </label>
							    <Input class="uploadProfileInput" type="file" id="newProfilePhoto" accept="image/*" style="display: none;" />
							  </div>
							  <p class="text-info text-center small">커버 이미지를 설정해보세요!</p>
							</div>
                        </div>
                    </div>
                    
                    <div class="form-group row">
					    <label class="col-sm-2">이미지 슬라이드</label>    
					    <div class="col-sm-10">
					        <div class="dropzone" id="fileDropzone">
					            <div class="dz-message needsclick">
					                여기에 파일을 끌어 놓거나 업로드하려면 클릭하십시오.
					            </div>
					        </div>
					    </div>
					</div>
                    
                    <div class="dashed-line"></div>
                    
                    <div class="form-group row">
                    	<label class="col-sm-2">지도</label>    
			            <div class="col-sm-10">
			                <div id="kakao_map" style="width:100%; height:300px; float:right;"></div>
			            </div>
			        </div>
			        
			        <div class="dashed-line"></div>

			        <div class="form-group row">
			        	<label class="col-sm-2">지도 검색 선택</label>    
			            <div class="col-sm-10">
			                <a class="btn btn-white" id="is_search">
			                    <i class="fa fa-search"></i>
			                    <span> 검색으로 주소찾기</span>
			                </a>
			                <a class="btn btn-white" id="is_marker">
			                    <i class="fa fa-map-marker"></i>
			                    <span> 지도 클릭으로 주소찾기</span>
			                </a>
			            </div>
			        </div>
			        
			        <div class="dashed-line"></div>

			        <div class="form-group row address_search_div">
			        	<label class="col-sm-2">주소 검색</label>    
			            <div class="col-sm-10">
			                <input
			                        type="text"
			                        id="address_search"
			                        class="form-control"
			                        title="주소를 입력하세요.">
			                <span class="address_method text-danger f-s-16" style="display:none;">주소 검색을 해주세요.</span>
			            </div>
			            
			            <div class="dashed-line"></div>
			        </div>
			        
			        <div class="form-group row" style="margin-top: 10px; display:none;">
			            <label class="col-sm-2 hidden-xs control-label" for="latitude">경도</label>
			            <div class="col-sm-4">
			                <input type="text"
			                       id="latitude"
			                       name="latitude"
			                       class="form-control"
			                       readonly>
			            </div>
			            <label class="col-sm-2 hidden-xs control-label" for="longitude">위도</label>
			            <div class="col-sm-4">
			                <input type="text"
			                       id="longitude"
			                       name="longitude"
			                       class="form-control"
			                       readonly>
			            </div>
			        </div>
			        
			        <div class="form-group row">
			        	<label class="col-sm-2">주소</label>   
			            <div class="col-sm-10">
			                <input
		                        type="text"
		                        id="address"
		                        name="address"
		                        class="form-control"
		                        readonly>
			            </div>
			        </div>
			        
			        <div class="dashed-line"></div>
			        
			        <div class="form-group row">
                    	<label class="col-sm-2">공개 유무</label>   
	                    <div class="col-sm-10">
	                    	<c:forEach var="item" items="${statusConfig}">
	                    		<label class="btn btn-white m-t-5">
	   								<input type="radio" 
	   									   class="status" 
	   									   name="status" 
	   									   value="${item.key}"> ${item.value}                            
	   					   		</label>
	                    	</c:forEach>
	                    </div>
                    </div>
			        
			        <div class="dashed-line"></div>
                    
                    <div class="form-group row">
                    	<label class="col-sm-2">카테고리</label>   
	                    <div class="col-sm-10">
	                    	<c:forEach var="item" items="${categoryConfigList}">
	                    		<label class="btn btn-white m-t-5">
	   								<input type="radio" 
	   									   class="categoryCode" 
	   									   name="categoryCode" 
	   									   value="${item.code}"> ${item.name}                            
	   					   		</label>
	                    	</c:forEach>
	                    </div>
                    </div>
                    
                    
                    <div class="dashed-line"></div>
                    
                    <c:forEach var="item" items="${namesConfigList}">
	                    <div class="form-group row">
						    <label class="col-sm-2">${item.name}</label>    
						    <div class="col-sm-10">
						    		<input type="text"
						    				data-code="${item.code}" 
		                            		class="form-control form-control-lg light-300 NameValues"
		                            		style="font-size: 15px;"
		                            		placeholder="${item.name} 입력">
						    </div>
						</div>
						
						<div class="dashed-line"></div>
					 </c:forEach>
                	
               		<div class="col-md-4 col-4 m-auto">
               			<a href="/app/mapping/index?mapperCode=${mapperCode}" class="btn btn-dark rounded-pill px-md-5 px-4 py-2 radius-0 text-light light-300">목록</a>
                    </div>
                    <div class="col-md-4 col-4 m-auto text-center">
                        <button type="button" id="submit" class="btn btn-secondary rounded-pill px-md-5 px-4 py-2 radius-0 text-light light-300">확인</button>
                    </div>
                    <div class="col-md-4 col-4 m-auto"></div>
                    
                </form>
            </div>
            <div class="col-lg-2"></div>
        </div>
    </section>
	<%@include file="../../layouts/app/footer.jsp"%>
</body>

<%@include file="../../layouts/app/script.jsp"%>

<script>
	$(document).ready(function(){
		$(document).on("change", ".uploadProfileInput", function () {
		  var triggerInput = this;
		  var currentImg = $(this).closest(".pic-holder").find(".pic").attr("src");
		  var holder = $(this).closest(".pic-holder");
		  var wrapper = $(this).closest(".profile-pic-wrapper");
		  $(wrapper).find('[role="alert"]').remove();
		  
		  var files = !!this.files ? this.files : [];
		  if (!files.length || !window.FileReader) {
		    return;
		  }
		  if (/^image/.test(files[0].type)) {
		    var reader = new FileReader(); // instance of the FileReader
		    reader.readAsDataURL(files[0]); // read the local file
		
		    var file = $("#newProfilePhoto")[0].files[0];
			var filename = file.name;
		    
		    reader.onloadend = function () {
		    	var base64data = reader.result;
				var data = base64data.split(',')[1];
				
			    $(holder).addClass("uploadInProgress");
			    $(holder).find(".pic").attr("src", this.result);
			    $(holder).append(
			      '<div class="upload-loader"><div class="spinner-border text-primary" role="status"><span class="sr-only">Loading...</span></div></div>'
			    );
		
		      setTimeout(() => {
		        $(holder).removeClass("uploadInProgress");
		        $(holder).find(".upload-loader").remove();
		        // If upload successful
		        if (Math.random() < 0.9) {
		          $(wrapper).append(
		            '<div class="snackbar show" role="alert"><i class="fa fa-check-circle text-success"></i> 성공적으로 업로드를 하였습니다.</div>'
		          );
		          
		          $("#filename").val(filename);
				  $("#cover").val(data);
		
		          // Clear input after upload
		          $(triggerInput).val("");
		
		          setTimeout(() => {
		            $(wrapper).find('[role="alert"]').remove();
		          }, 3000);
		        } else {
		          $(holder).find(".pic").attr("src", currentImg);
		          $(wrapper).append(
		            '<div class="snackbar show" role="alert"><i class="fa fa-times-circle text-danger"></i> 다시 시도해주세요.</div>'
		          );
		
		          $(triggerInput).val("");
		          setTimeout(() => {
		            $(wrapper).find('[role="alert"]').remove();
		          }, 3000);
		        }
		      }, 1500);
		    };
		    
		  } else {
		    $(wrapper).append(
		      '<div class="alert alert-danger d-inline-block p-2 small" role="alert">Please choose the valid image.</div>'
		    );
		    setTimeout(() => {
		      $(wrapper).find('role="alert"').remove();
		    }, 3000);
		  }
		});
		
		jQuery.fn.serializeObject = function() { 
		    var obj = null; 
		    try { 
		        if(this[0].tagName && this[0].tagName.toUpperCase() == "FORM" ) { 
		            var arr = this.serializeArray(); 
		            if(arr){ obj = {}; 
		            jQuery.each(arr, function() { 
		                obj[this.name] = this.value; }); 
		            } 
		        } 
		    }catch(e) { 
		        alert(e.message); 
		    }
		    return obj; 
		}
		
		 console.log("222");
		$("#submit").click(function() {
			if ($("#latitude").val().trim() == '' || $("#longitude").val().trim() == '') {
		          $("#address").focus();
		          alert("주소를 입력해주세요.");
		          return false;
		    }
			
			if ($("input[name='status']:checked").val() == undefined) {
		          $(".status").focus();
		          alert("공개유무를 선택해주세요.");
		          return false;
		    }
			
			if ($("input[name='categoryCode']:checked").val() == undefined) {
		          $(".categoryCode").focus();
		          alert("카테고리를 선택해주세요.");
		          return false;
		    }
			
			let nameValuesArray = [];
	        $(".NameValues").each(function (index) {
	        	let nameValuesObj 	 = {};
	        	
	        	var code             = $(this).data('code');
	        	nameValuesObj.key 	 = String(index + 1);
	        	nameValuesObj.code 	 = String(code);
	        	nameValuesObj.values = $(this).val();
	        	nameValuesArray.push(nameValuesObj);
			});
	        
	        var data = $("#submitForm").serializeObject();
	        data.NameValues   = nameValuesArray;
	        data.mapperCode	  = String(${mapperCode});
	       
	        console.log(data);
	        
	        var request = $.ajax({
                url: "/app/mapping/write",
                type : "POST",
                data:JSON.stringify(data),
                enctype: "multipart/form-data",
           	 	contentType:'application/json',
                dataType:'json',
            });

            request.done(function (data) {
            	console.log(data);
               
            });

            request.fail(function (jqXHR, textStatus) {
                alert("Request failed: " + textStatus);
            });
		});
	});
</script>

<script type="text/javascript">
  $(document).ready(function(){
      Dropzone.autoDiscover = false;
      var myDropzone = new Dropzone(".dropzone", {
        url: '/app/mappingfiles/do_upload', // 파일 업로드할 url
        method: "POST",
        paramName: 'files',
        params: {
            timestamp:${timestamp}
        },
        addRemoveLinks: true,
        dictRemoveFile: "삭제",
        removedfile: function(file) { // 파일 삭제 시
          var code = file.code == undefined ? file.temp : file.code; // 파일 업로드시 return 받은 code값
          
          console.log('code: ' + code);
            $.ajax({
                type: 'POST',
                url: '/app/mappingfiles/do_delete', // 파일 삭제할 url
                data: {code: code},
                success: function(data) {
                    console.log('success: ' + data);
                }
            });
     
            var _ref;
            return (_ref = file.previewElement) != null ? _ref.parentNode.removeChild(file.previewElement) : void 0;
        }
        , success: function (file, response) {	// 파일 업로드 성공 시
           file.temp = JSON.parse(response); // 파일을 삭제할 수도 있으므로 변수로 저장
        }
      });
      
      var is_search  = "N";
      var is_marker  = "N";
      var markers	 = [];
      var place		 = new kakao.maps.services.Places();      //장소 검색
      var Overlay	 = new kakao.maps.CustomOverlay();        //마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
      var geocoder   = new kakao.maps.services.Geocoder();    // 주소-좌표 변환 객체를 생성합니다
      var marker	 = new kakao.maps.Marker();               // 클릭한 위치를 표시할 마커입니다
      var infowindow = new kakao.maps.InfoWindow({zindex: 1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

      var container = document.getElementById('kakao_map'); //지도를 담을 영역의 DOM 레퍼런스
      var options = { //지도를 생성할 때 필요한 기본 옵션
          center: new kakao.maps.LatLng(36.3505388993078, 127.384834846753), //지도의 중심좌표.
          level: 5, //지도의 레벨(확대, 축소 정도)
          scrollwheel: true, //  마우스 휠, 모바일 터치를 이용한 확대 및 축소 가능 여부(Boolean)
      };
      var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
      
      $("#is_search").click(function () {
          is_search = "Y";
          is_marker = "N";
          $("#address_search").val('');
          $(".address_search_div").show();
      });
      
      $("#is_marker").click(function () {
          is_marker = "Y";
          is_search = "N";
          $("#address_search").val('');
          $(".address_search_div").hide();

          if (is_marker == 'Y') {
              // 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
              kakao.maps.event.addListener(map, 'click', function (mouseEvent) {
                  if (is_marker == 'Y') {
                      for (var loop = 0; loop < markers.length; loop++) {
                          markers[loop].setMap(null);
                      }
                      
                      markers = [];
                      searchDetailAddrFromCoords(mouseEvent.latLng, function (result, status) {
                          if (status === kakao.maps.services.Status.OK) {
                              var address = !!result[0].road_address ? result[0].road_address.address_name : result[0].address.address_name;

                              var marker = new kakao.maps.Marker({
                                  map: map,
                                  position: mouseEvent.latLng
                              });

                              markers.push(marker); //마커 삭제하기 위해 array에 담음

                              $("#latitude").val(mouseEvent.latLng.Ma);
                              $("#longitude").val(mouseEvent.latLng.La);
                              $("#address").val(address);
                              $(".wrap").remove();
                          }
                      });
                  }
              });

              function searchDetailAddrFromCoords(coords, callback) {
                  // 좌표로 상세 주소 정보를 요청합니다
                  geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
              }
          }
      });
      
      //검색어 입력 후 값을 넘겨줌
      $("#address_search").bind('keyup keypress keydown', function () {
          var status = $(".address_search_div").css("display");

          if (is_search == 'Y' || status == 'inline' || status == 'block') {

              for (var loop = 0; loop < markers.length; loop++) {
                  markers[loop].setMap(null);
              }
              markers = [];

              var search = $("#address_search").val();
              var options = {
                  size: 1 //지도에 나타낼 갯수
              };
              place.keywordSearch(search, placesSearch, options);
          }
      });
      
   	  // 키워드 검색 완료 시 호출되는 콜백함수 입니다
      function placesSearch(data, status, pagination) {
          if (status === daum.maps.services.Status.OK) {
              // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
              // LatLngBounds 객체에 좌표를 추가합니다
              var bounds = new kakao.maps.LatLngBounds();
              for (var i = 0; i < data.length; i++) {
                  displayMarker(data[i], data.length, i);
                  //인수로 주어진 좌표를 포함하도록 영역 정보를 확장한다.
                  bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
              }
              // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
              map.setBounds(bounds);
          }
      }
   	  
   	  // 지도에 마커를 표시하는 함수입니다
      function displayMarker(place, total_count) {
          var marker = new kakao.maps.Marker({
              map: map,
              position: new kakao.maps.LatLng(place.y, place.x)
          });

          markers.push(marker); //마커 삭제하기 위해 array에 담음

          kakao.maps.event.addListener(marker, 'click', function () {
              //출력할 content
              var content = document.createElement('div');
              content.classList.add("wrap");
              content.innerHTML += '<div class=info>' +
					                  '<div class=title>' + place.place_name +
					                  	  '<div class=body>' +
					                  			'<div class=desc>' +
					                  				'<div class=ellipsis>' +
					                  					place.address_name +
					                  				'</div>' +
					                  				'<div class=jibun ellipsis>' +
					                  					place.category_name +
					                  				'</div>' +
						                  			'<div class=select-btn-box>' +
						                  				'<a href="javascript:;" id=ad data-address_name="' + place.address_name + '" data-longitude=' + place.x + ' data-latitude=' + place.y + ' onclick="select_location(this);">선택</a>' +
						                  			'</div>' +
					                  			'</div>' +
					                  		'</div>' +
					                  	 '</div>' +
					                  '</div>';

              //삭제 버튼 생성
              var closeBtn = document.createElement('class');
              closeBtn.style.cssText = 'position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png)';
              closeBtn.onclick = function () {
                  overlay.setMap(null);
              };
              content.appendChild(closeBtn);

              // 마커에 클릭이벤트를 등록합니다
              var overlay = new kakao.maps.CustomOverlay({
                  content: content,
                  map: map,
                  position: marker.getPosition()
              });
              overlay.setMap(map);
          });
      }

  });
</script>

<script type="text/javascript">
    function select_location(obj) {
        $("#latitude").val($(obj).data('latitude'));
        $("#longitude").val($(obj).data('longitude'));
        $("#address").val($(obj).data('address_name'));
        $(".wrap").remove();
        $(".address_method").hide();
    }
</script>
