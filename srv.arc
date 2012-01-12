; These following ops are URL based function calls that can be called
; with GET and POST calls. 

(def web-login (req)
  (let sid (login (arg req "username") (arg req "password"))
    (pr "{\"success\":")
    (if sid 
      (do
        (pr "true")
        (pr ",\"sessionID\":" sid))
      (pr "false"))
    (pr "}")))

(def web-register (req)
  (register (arg req "username") (arg req "password"))
  (pr "main"))

(defop api-admin-getUsers req
  (pr "{\"list\":\"" (listUsers) "\"}"))