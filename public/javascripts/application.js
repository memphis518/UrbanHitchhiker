function setHomeElementEvents (){
	$("#signupbutton").click(function() { signUp(this); } );
	$("#signupbutton").hover(function(){ $("#signupbutton").addClass('signupbuttonhover');    }, 
		      			     function(){ $("#signupbutton").removeClass('signupbuttonhover'); });
	
	$("#password").focusin(function(){  togglePassword(); });
	$("#password").focusout(function(){ togglePassword(); });

	$("#username").focusin(function(){  toggleUsername(); });
	$("#username").focusout(function(){ toggleUsername(); });
	
	$("#loginbutton").click(function() {login( $("#username"), $("#password") );});
	$("#loginbutton").hover(function(){ $("#loginbutton").addClass('loginbuttonhover');    }, 
		      			    function(){ $("#loginbutton").removeClass('loginbuttonhover'); });
	
}

function togglePassword(){
	var passwordEle = document.getElementById('password');
	if(passwordEle.value == '' || passwordEle.value == 'password'){
		if(passwordEle.type == 'text'){
			passwordEle.type  = 'password';
			passwordEle.value = '';
		}else{
			passwordEle.type  = 'text';
			passwordEle.value = 'password';
		}
	}
}

function toggleUsername(){
	var usernameEle = document.getElementById('username');
	if(usernameEle.value == 'username'){
		usernameEle.value = '';
	}else if(usernameEle.value == ''){
		usernameEle.value = 'username';
	}
}


function login(usernameEle, passwordEle){
	$("#login").submit();
}

function signUp(){        
        document.location = "/users/new";
}

function aJaxModal(url, modalTitle, params){	
	$.get(url, params, function(data, textStatus, jqXHR){ 
				$("#modal").empty();
				$("#modal").html(data);
				$("#modal").dialog({modal:true, 
									width:700, 
									position:[150,75], 
									title: modalTitle, 
									resizable: false, 
									close: function(event, ui) { $("#modal").empty(); }
								});
	});
	
}

function loadTripsJS(){
    newtriplink = $("#newtriplink").attr("href");
 	$("#newtriplink").attr("href", "javascript:aJaxModal('" + newtriplink + "', 'New Trip')");
    $("a[id ^= edittriplink]").each(function(index, link){
        edittriplink = $(link).attr("href");
        $(link).attr("href", "javascript:aJaxModal('" + edittriplink + "', 'Edit Trip')");
    });
	$("a[id ^= destroytriplink]").each(function(index, link){
        destroytriplink = $(link).attr('href');
        $(link).attr("href", "javascript:deleteTripConfirm('" + destroytriplink + "')");
    });
    $("a[id ^= maptriplink]").each(function(index, link){
        maptriplink = $(link).attr('href');
        $(link).attr("href", "javascript:aJaxModal('" + maptriplink + "', 'Trip Map')");
    });
}

function deleteTripConfirm(url){
	$( "#dialog-confirm" ).dialog({
				resizable: false,
				height:175,
				modal: true,
				position:[400,175],
				buttons: {
					"Delete Trip": function() {
						$.post(url, { _method: 'delete' });
						$( this ).dialog( "close" );
					},
					Cancel: function() {
						$( this ).dialog( "close" );
					}
				}
			});
}

function loadTripFormJS(type){
	$("#trip_start_date").datepicker();
	var formObj;
	if(type == 'new'){
		formObj = $(".new_trip");
	}else if(type == 'edit'){
		formObj = $(".edit_trip");
	}
	if(formObj){
		formObj
		    .bind("ajax:success", function(event, data, status, xhr) {
	            $("#modal").html(data);
		});
	}
}

function tripSaveSuccessful(){
	$("#modal").empty();
	$("#modal").dialog("close");
	document.location = "/trips";
}

function loadTripMap(origin_lat, origin_lng, destination_lat, destination_lng){
	if(!$('#map').is(":visible")){
		setTimeout(function(){loadTripMap(origin_lat, origin_lng, destination_lat, destination_lng)},5);
	}else{
		var origin = new google.maps.LatLng(origin_lat, origin_lng);
		var destination = new google.maps.LatLng(destination_lat, destination_lng);

		var mapOptions = {
				zoom: 8,
				mapTypeId: google.maps.MapTypeId.ROADMAP,
				center: origin
		};

		var map = new google.maps.Map($('#map').get(0), mapOptions);
		var directionsService = new google.maps.DirectionsService();
		var directionsDisplay = new google.maps.DirectionsRenderer();
		directionsDisplay.setMap(map);

		var request = {
		  origin:origin,
		  destination:destination,
		  travelMode: google.maps.TravelMode.DRIVING
		};
		directionsService.route(request, function(result, status) {
		  if (status == google.maps.DirectionsStatus.OK) {
		    directionsDisplay.setDirections(result);
		  }
		});
	}
}	