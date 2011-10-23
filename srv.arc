; These following ops are URL based function calls that can be called
; with GET and POST calls. 

(defop web-login req
	(let id (login (alref (req 'args) "username") (alref (req 'args) "password"))
		(if id (prn "Login Success")
			(prn "Login Failed"))))

(defop web-register req
	(let id (register (alref (req 'args) "username") (alref (req 'args) "password"))
		(if id (prn "Register Success")
			(prn "Register Failed"))))

