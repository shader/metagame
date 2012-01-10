; These following ops are URL based function calls that can be called
; with GET and POST calls. 

(defop api-login req
  (let id (login (alref (req 'args) "username") (alref (req 'args) "password"))
    (pr (alref (req 'args) "callback") "({\"success\":")
    (if id (pr "true")
      (pr "false"))
    (pr "});")))

(defop api-register req
  (let id (register (alref (req 'args) "username") (alref (req 'args) "password"))
    (pr (alref (req 'args) "callback") "({\"success\":")
    (if id (prn "true")
      (prn "false"))
    (pr "});")))

(defop api-admin-getUsers req
  (pr (alref (req 'args) "callback") "({\"list\":\"" (listUsers) "\"});"))