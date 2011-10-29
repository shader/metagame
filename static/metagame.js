function metagame() {

	var userInfo = {
		"username": "",
		"password": "",
		"sessionID": ""
	}

	var isLoggedIn = false

	// Init function
	this.init = function() {
		userInfo.username = "test"
		userInfo.password = "test"
		
	}

	this.showLogin = function() {
		$('#login_prompt').slideDown('slow')
	}

	/* Login function, handles making the call to login
	 */
	this.login = function() {
		$.ajax({
			url: "web-login",
			type: "GET",
			data: {username: userInfo.username, password: userInfo.password},
			async: false,
			success: function(data) {
				console.log("Successful login call")
			},
			error: function() {
				console.log("Error when calling login function")
			}
		})
	}

	this.register = function() {
		var response = ""
		$.ajax({
			url: "web-register",
			type: "POST",
			data: {username: userInfo.username, password: userInfo.password},
			asyn: false,
			success: function(data) {
				console.log("Successful register call")
				response = data
			},
			error: function() {
				console.log("Error when calling register function")
			}
		})
		return response
	}
}
