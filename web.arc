; Web init
; Starts the web page server and sets a number of variables
;(def web-init
;	(= staticdir* "../../metagame/static/"))

; Define a main page. If there is no login cookie, pop out a login prompt,
; 
; Later it will display player-relavent data such owned objects
(defopr || req "main")

(defop main req
  (doctype)
  (tag (html)
    (tag (head)
      (add-js "js/jquery.js")
      (add-js "metagame.js"))
    (tag (body)
      (tag (div)
        (login-prompt))
      (tag (div)
        (if (req 'cooks) (pr (req 'cooks))
          (pr "no cookies")))
      (tag (p)))))

(defop register req
  (doctype)
  (tag (html)
    (tag (head)
      (add-js "js/jquery.js")
      (add-js "metagame.js"))
    (tag (body)
      (tag (div)
        (register-prompt))
      (tag (div)
        (link "Go back to main page" "main")))))


; Various HTML printing functions

; prints doctype for HTML5
(def doctype ()
  (pr "<!DOCTYPE HTML>"))

(def add-js (filename) 
  (tag (script src filename type "text/javascript")))

(def login-prompt ()
  (aform web-login
    (myinput "text" "login_username")
    (myinput "password" "login_password")
    (but "Login" "login_button")
    (nbsp)
    (link "Register" "register")))

(def register-prompt ()
  (aform web-register
    (myinput "text" "register_username")
    (myinput "password" "register_password")
    (but "Register" "register_button")))

(def myinput (type name (o val "") (o size 10))
  (gentag input type type name name value val size size))