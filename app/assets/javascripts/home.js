

function initialize(lat, long) {

    //Default Location
    var latlng;
    if(lat && long){
      latlng = new google.maps.LatLng(lat, long);
    }else if (google.loader.ClientLocation) {
        latlng = new google.maps.LatLng(google.loader.ClientLocation.latitude, google.loader.ClientLocation.longitude);
    }else{
      latlng = new google.maps.LatLng(-34.397, 150.644);
    }

    // If ClientLocation was filled in by the loader, use that info instead

    var mapOptions = {
        center: latlng,
        zoom: 8,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        mapTypeControl: true
    };
    var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

    return map;
}


function addMarker(map, lat, long, trip_name, info_content) {
    var latlng = new google.maps.LatLng(lat, long);
    var marker = new google.maps.Marker({
        position: latlng,
        map: map,
        title: trip_name
        });

    var infowindow = new google.maps.InfoWindow({
        content: info_content
        });

    google.maps.event.addListener(marker, 'click', function() {
                infowindow.open(map,marker);
            });
}





