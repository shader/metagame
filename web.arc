; Web init
; Starts the web page server and sets a number of variables
;(def web-init
;	(= staticdir* "../../metagame/static/"))

; Define a main page. If there is no login cookie, pop out a login prompt,
; 
; Later it will display player-relavent data such owned objects
(defop || req 
  (doctype)
  (tag (html)
    (tag (head)
      (add-js "jquery-1.6.4.min.js")
      (add-js "web-interface.js")
    (tag (body)
      (if (req 'cooks) (pr (req 'cooks))
         (pr "no cookies"))))))


; Various HTML printing functions

; prints doctype for HTML5
(def doctype ()
  (pr "<!DOCTYPE HTML>"))

(def add-js (filename) 
  (tag (script src filename type "text/javascript")))
