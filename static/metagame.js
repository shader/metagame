var userInfo = {
  username: "",
  password: "",
}

$(document).ready( function () {
  if(userInfo.username != "" && userInfo.password != "") {
    console.log("Username and Password loaded, don't show prompt");
    // hide prompt
  }
  
  /* Make-shift handler that converts every link into a ajax post request
   */
  /*
  $('a').bind("click", function(event) {
    event.preventDefault();
    var url = $(this).attr("href");
    $.post(url, function(data) {
      alert(data);
    });
  });*/
  
  $('input[name=login_button]').bind("click", function(event) {
    event.preventDefault();
    var url = $('input[name=fnid]').val();
    
    $.ajax({
      type: 'post',
      url: "x?fnid="+url,
      data: {
        username: $('input[name=login_username]').val(),
        password: $('input[name=login_password]').val()
      },
      success: function (data) {
        console.log(data);
      }
    });
  });
        
});

$('#login_button').live("click", function () {
  userInfo.username = $('#login_username').val();
  userInfo.password = $('#login_password').val();
  
  login(userInfo.username,userInfo.password);
});

$('#register_button').live("click", function () {
  userInfo.username = $('#login_username').val();
  userInfo.password = $('#login_password').val();
  
  register(userInfo.username,userInfo.password);
});

function login (username, password) {
  $.ajax({
    url: "http://127.0.0.1:8080/api-login",
    dataType: 'json',
    data: {
      username: username,
      password: password
    },
    success: function(data) {
      console.log(data);
    }
  });
}

function register (username, password) {
  $.ajax({
    url: "http://127.0.0.1:8080/api-register",
    dataType: 'json',
    data: {
      username: username,
      password: password
    },
    success: function(data) {
      console.log(data);
    }
  });
}

function getUsers () {
  $.ajax({
    url: "http://127.0.0.1:8080/api-admin-getUsers",
    dataType: 'json',
    success: function(data) {
      console.log(data);
    }
  });
}
