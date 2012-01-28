(load "git-db.arc")
(load "objects.arc")
(load "auth.arc")
(load "srv.arc")
(load "web.arc")

; Loads JSON utils
($ (require (file "lib/json.ss")))
($ (xdef read-json read-json))
($ (xdef write-json write-json))

(= git-dir* "./db"
   git-ref* "master"
   objects* (table))

(def file? (path)
  ($ (tnil (file-exists? ,path))))

(def dir? (path)
  ($ (tnil (directory-exists? ,path))))

(git-connect git-dir* git-ref*)

;Load all objects from the repo
(load-objects)
(restore-tables)