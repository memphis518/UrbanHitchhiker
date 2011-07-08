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

function loadTripsJS(){
    $( "#selectable" ).selectable();
}
