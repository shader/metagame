; Authentication functions

; use the code (that works) from the existing app.arc file
; as inspiration when writing the user authentication, and
; registration, using the new object framework.
(= users* (table))

(deftem (user objects) pw nil type 'user)

; add-user
; creates a new user object that contains the username. Passwords
; and other related information should be added later.
(def add-user (name)
  (let u (inst 'user 'name name)
    (= (users* u!id) u)
    (= (objects* u!id) u)
    u!id))

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
    (set-pw id pass)
    id))

; user-id
; gets the id based off of the user name
; NOTE:  Slow more than 5-10k users
(def user-id (name)
  ((find [is _!name name] vals.users*) 'id))
