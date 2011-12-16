var userInfo = {
  "username": "",
  "password": "",
  "sessionID": ""
}

var isLoggedIn = false

function alertUserInfo () {
  alert(userInfo.username + " " + userInfo.password)
}

function showLogin () {
  $('#login_prompt').slideDown('slow')
}

/* Login function, handles making the call to login
 */
this.login = function() {
  $.ajax({
    url: "web-login",
    type: "GET",
    data: {username: userInfo.username, password: userInfo.password},
    success: function(data) {
      console.log("Successful login call")
    },
    error: function() {
      console.log("Error when calling login function")
    }
  })
}

function register () {
  $.ajax({
    url: "web-register",
    type: "POST",
    data: {username: userInfo.username, password: userInfo.password},
    success: function(data) {
      console.log("Successful register call")
      alert(data)
    },
    error: function() {
      console.log("Error when calling register function")
    }
  })
}
