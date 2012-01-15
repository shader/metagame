(load "io.arc")
(load "objects.arc")
(load "auth.arc")
(load "srv.arc")
(load "web.arc")

; Loads JSON utils
($ (require (file "lib/json.ss")))
($ (xdef read-json read-json))
($ (xdef write-json write-json))

(load-objects)
(restore-tables)