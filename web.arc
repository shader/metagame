; Web init
; Starts the web page server and sets a number of variables
;(def web-init
;	(= staticdir* "../../metagame/static/"))

; Define a main page. If there is no login cookie, pop out a login prompt,
; 
; Later it will display player-relavent data such owned objects
(defop || req 
	(doctype)
	(prn (tag (html)
		(tag (head)
			(tag (script src "jquery-1.6.4.min.js" type "text/javascript"))
			(tag (script src "web-interface.js" type "text/javascript")))
		(tag (body)
			(if (req 'cooks) nil (pr "no cookies")
				(req 'cooks))))))

; Web API function to login
(defop web-login req
	(let id (login (alref (req 'args) "username") (alref (req 'args) "password"))
		(if id (prn "Login Success")
			(prn "Login Failed"))))

; 
(defop web-register req
	(let id (register (alref (req 'args) "username") (alref (req 'args) "password"))
		(if id (prn "Register Success")
			(prn "Register Failed"))))



; prints doctype for HTML5
(def doctype ()
	(prn "<!DOCTYPE HTML>"))

