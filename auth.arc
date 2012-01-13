; Authentication functions

; use the code (that works) from the existing app.arc file
; as inspiration when writing the user authentication, and
; registration, using the new object framework.
(= users* (table))

(deftem (user object) pw nil type 'user sessionID nil)

(maptable (fn (key val) 
            (if (is val!type 'user)
              (= (users* key) val)))
          objects*)

; add-user
; creates a new user object that contains the username. Passwords
; and other related information should be added later.
(def add-user (name)
  (if (find-user name) -1
      (let u (inst 'user 'name name)
	(= (users* u!id) u)
	(= (objects* u!id) u)
	u!id)))

; set-pw
; sets password for specific user
(def set-pw (id pass)
  (= users*.id!pw pass)
  (= objects*.id!pw pass))

; register
; Function that straps everything together into one
; function that can be run together when a user fills
; in a registration form
; NOTE: Probably not needed.
(def register (name pass)
  (let id (add-user name)
    (if (is id -1) 
      nil
      (do (set-pw id pass)
          (obj "name" users*.id!name "id" id)))))

; login
; Function that will return a session id upon successfully
; providing a valid username and password. Otherwise,
; return nil
; NOTE: Currently returns user ID
(def login (name pass)
  (let u (find-user name)
    (if u 
      (if (is u!pw pass)
        (do (setSessionID u!id) (obj "id" u!id "sessionID" u!sessionID))
        nil)
      nil)))

; user-id
; gets the id based off of the user name
; NOTE:  Slow more than 5-10k users
(def user-id (name)
  (let u (find-user name)
    u!id))

; find-username
; returns the object entry from the user table
; NOTE:  Slow
(def find-user (name)
  (find [is _!name name] vals.users*))

(def listUsers ()
  users*)

(def setSessionID (id)
  (let sid (trunc (* (rand) (expt 10 10)))
    (= users*.id!sessionID sid)
    (= objects*.id!sessionID sid)))

