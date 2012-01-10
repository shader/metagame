; These following ops are URL based function calls that can be called
; with GET and POST calls. 

(defop api-login req
  (let sid (login (alref (req 'args) "username") (alref (req 'args) "password"))
    (pr "{\"success\":")
    (if sid 
      (do
        (pr "true")
        (pr ",\"sessionID\":" sid))
      (pr "false"))
    (pr "}")))

(defop api-register req
  (let id (register (alref (req 'args) "username") (alref (req 'args) "password"))
    (pr "{\"success\":")
    (if id (prn "true")
      (prn "false"))
    (pr "}")))

(defop api-admin-getUsers req
  (pr "{\"list\":\"" (listUsers) "\"}"))