<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
<title>Home</title>
</head>

<body>
	<h1>Hello world!</h1>
	<div id="map" style="width: 100%; height: 350px;"></div>
	<p><em>지도를 클릭해주세요!</em></p> 
	<div id="clickLatlng"></div>
</body>


<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1c2a046cf6a6a021a58548b3102ac046"></script>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.4.1.min.js"></script>
<script>
		$(document).ready(async () => {
			const key = "1c2a046cf6a6a021a58548b3102ac046";
			let lat = "", lon = "";
			lat = await getLocation("latitude");
			lon = await getLocation("longitude");
			console.log(lat, lon)
			
			getMap(lat, lon);
		});

		function getLocation(pos) {
			return new Promise(resolve => {
				if(navigator.geolocation) {
					navigator.geolocation.getCurrentPosition(function(position) {
		                // 위치를 가져오는데 성공할 경우
		                $.each(position.coords, function(key, item) {
			                if(key === pos) {
			                	resolve(item);
				            }
		                });
		            }, function(error) {
		                consol.log(error.message);
		                pos(error.message);
		            });
				}
			});	
		}
		
		function getMap(lat, lon) {
			console.log(lat, lon)
			// 지도를 표시할 div
			var mapContainer = document.getElementById('map');  
			// 지도 Option
		    var mapOption = { 
		    	// 지도의 중심좌표
		        center: new kakao.maps.LatLng(lat, lon),
		     	// 지도의 확대 레벨 
		        level: 3
		    };

			// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
			var map = new kakao.maps.Map(mapContainer, mapOption); 


			// 지도를 클릭한 위치에 표출할 마커입니다
			var marker = new kakao.maps.Marker({ 
			    // 지도 중심좌표에 마커를 생성합니다 
			    position: map.getCenter() 
			}); 
			// 지도에 마커를 표시합니다
			marker.setMap(map);

			// 지도에 클릭 이벤트를 등록합니다
			// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
			kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
			    
			    // 클릭한 위도, 경도 정보를 가져옵니다 
			    var latlng = mouseEvent.latLng; 
			    
			    // 마커 위치를 클릭한 위치로 옮깁니다
			    marker.setPosition(latlng);
			    
			    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
			    message += '경도는 ' + latlng.getLng() + ' 입니다';
			    
			    var resultDiv = document.getElementById('clickLatlng'); 
			    resultDiv.innerHTML = message;
			});
		} 


	</script>
</html>
