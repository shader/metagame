; Web init
; Starts the web page server and sets a number of variables
;(def web-init
;	(= staticdir* "../../metagame/static/"))

; Define a main page. If there is no login cookie, pop out a login prompt,
; 
; Later it will display player-relavent data such owned objects
(defopr || req "index.html")

(defop main req
  (doctype)
  (tag (html)
    (tag (head)
      (add-js "jquery.js")
      (add-js "knockout.js")
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
      (add-js "jquery.js")
      (add-js "knockout.js")
      (add-js "metagame.js"))
    (tag (body)
      (tag (div)
        (register-prompt)))))


; Various HTML printing functions

; prints doctype for HTML5
(def doctype ()
  (pr "<!DOCTYPE HTML>"))

(def add-js (filename) 
  (tag (script src filename type "text/javascript")))

(def login-prompt ()
  (pr "<input type=\"text\" id=\"login_username\" />")
  (pr "<input type=\"password\" id=\"login_password\" />")
  (pr "<button id=\"login_button\">Login</button>")
  (nbsp)
  (link "Register" "register"))

(def register-prompt ()
  (pr "<input type=\"text\" id=\"register_username\" />")
  (pr "<input type=\"password\" id=\"register_password\" />")
  (pr "<a href=\"main\" id=\"register_button\">Register</button>"))