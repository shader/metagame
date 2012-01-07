; These following ops are URL based function calls that can be called
; with GET and POST calls. 

(defop api-login req
  (let id (login (alref (req 'args) "username") (alref (req 'args) "password"))
    (if id (prn "Login Success")
      (prn "Login Failed"))))

(defop api-register req
  (let id (register (alref (req 'args) "username") (alref (req 'args) "password"))
    (if id (prn "Register Success")
      (prn "Register Failed"))))

(defop api-admin-getUsers req
  (listUsers))