$.getScript('http://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.3/leaflet.js', function()
{
	var reservoir =  new L.LayerGroup();

	var mbAttr = 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
			'<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
			'Imagery © <a href="http://mapbox.com">Mapbox</a>',
		mbUrl = 'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiYmlnYnl0ZSIsImEiOiJjaXM5ejEzMzkwMDZiMm9vZjNhbWZhejYwIn0.GKqsUdM5SNhJ_JelmqAOGQ';

    var satellite   = L.tileLayer(mbUrl, {id: 'mapbox.satellite', attribution: mbAttr}),onclick
	    streets  = L.tileLayer(mbUrl, {id: 'mapbox.streets',   attribution: mbAttr});


	var mymap = L.map('mapid', {
		center: [19.9088, 99.83414],
		zoom: 11,
		layers: [streets, reservoir]
	});

	var baseLayers = {
		"Streets": streets,
		"Satellite": satellite			
	};

	var overlays = {
		// "": reservoir
	};
	
	L.control.layers(baseLayers, overlays).addTo(mymap);

	var clickCircle;
	var marker;
		function onMapClick(e) {
				var Point = e.latlng;
				var lat = e.latlng.lat.toString();
				var lng = e.latlng.lng.toString();				
				var latlng = { 
					lat:lat,
					lng:lng
				}

				$.ajax({
				  type: "GET",
				  url: 'infomaps/point',
				  data: latlng})
				  .done(function(data){	
				  	// alert(data.flooddata.id);
				  	//data = JSON.parse(data);
				  	//console.log(data.lat);
				  	//var info = 	JSON.parse(data);	 	  	
				  	if (marker != undefined) {
						mymap.removeLayer(marker);
					};
				  	var popup = L.popup();
					marker = L.marker([lat.toString(),lng.toString()]).addTo(mymap);
					marker.bindPopup("ชื่อสถานี:"+data.flooddata.name_station+"<br>ระดับน้ำ:"+data.flooddata.water_level+"<br>ระดับน้ำวิกฤต:"+data.flooddata.critical_level).openPopup();
				  	
				  	// console.log(result);
				  })				   
        			.error(function(jqXHR, textStatus, errorThrown) {
            		alert("Error=" + errorThrown);
        			});
				
						
		}mymap.on('click', onMapClick);		
});

