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

function setInitalLocation(map){
	var siberia = new google.maps.LatLng(60, 105);
	var newyork = new google.maps.LatLng(40.69847032728747, -73.9514422416687);
	var browserSupportFlag =  new Boolean();
	
	// Try W3C Geolocation (Preferred)
	if(navigator.geolocation) {
		browserSupportFlag = true;
		navigator.geolocation.getCurrentPosition(function(position) {
			initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
			map.setCenter(initialLocation);
		}, function() {
			handleNoGeolocation(browserSupportFlag);
		});
		// Try Google Gears Geolocation
	} else if (google.gears) {
		browserSupportFlag = true;
		var geo = google.gears.factory.create('beta.geolocation');
		geo.getCurrentPosition(function(position) {
			initialLocation = new google.maps.LatLng(position.latitude,position.longitude);
			map.setCenter(initialLocation);
		}, function() {
			handleNoGeoLocation(browserSupportFlag);
		});
		// Browser doesn't support Geolocation
	} else {
		browserSupportFlag = false;
		handleNoGeolocation(browserSupportFlag);
	}

	function handleNoGeolocation(errorFlag) {
		if (errorFlag == true) {
			initialLocation = newyork;
		} else {
			initialLocation = siberia;
		}
		map.setCenter(initialLocation);
	}	
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
									close: function(event, ui) { $("#modal").empty(); }});
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

