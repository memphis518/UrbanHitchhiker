// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.ui.all
//= require twitter/bootstrap
//= require bootstrap-wysihtml5
//= require_tree .


// GOOGLE MAPS FUNCTIONALITY
function initializeMap(lat, long) {

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


function addMapMarker(map, lat, long, trip_name, info_content) {
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

function displayDirectionsOnMap(map, origin, destination)
{
    var directionsService = new google.maps.DirectionsService();
    directionsDisplay = new google.maps.DirectionsRenderer();
    directionsDisplay.setMap(map);

    var request = {
        origin: origin,
        destination: destination,
        travelMode: google.maps.TravelMode.DRIVING
    };
    directionsService.route(request, function(response, status) {
        if (status == google.maps.DirectionsStatus.OK) {
            directionsDisplay.setDirections(response);
        }
    });

}

//JQUERY HELPERS
function initializeTableLinks(){
    $("tr[data-link]").click(function() {
        window.location = this.dataset.link;
    })
}




