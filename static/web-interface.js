/* Web Interface
 *
 * Simple web interface to demonstrate how various game elements work
 * such as login, registration, session ID's, ownership, among other
 * things.
 */

function metagame() {

	// Init function
	this.init = function() {
		// TODO
	}

	/* Login function, handles making the call to login
	 */
	this.login = function(usr, pwd) {
		$.get("web-login",{username: usr, password: pwd},function(data){
			alert(data)
		})
	}

}
