; Define a main page. If there is no login cookie, pop out a login prompt,
; 
; Later it will display player-relavent data such owned objects
(defop || req 
	(doctype)
	(prn (tag (html)
		(tag (head)
			(tag (script type "text/javascript")
				(pr "alert(\"hello\")")))
		(tag (body)
			(pr "STUFF!!!")))))




; prints doctype for HTML5
(def doctype ()
	(prn "<!DOCTYPE HTML>"))

