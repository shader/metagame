; These following ops are URL based function calls that can be called
; with GET and POST calls. 

(def web-login (req)
  (let info (login (arg req "username") (arg req "password"))
    (pr (tostring (write-json info)))))

(def web-register (req)
  (let info (register (arg req "username") (arg req "password"))
    (pr (tostring (write-json info)))))

(defop api-admin-getUsers req
  (pr "{\"list\":\"" (listUsers) "\"}"))