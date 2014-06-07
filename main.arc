($ (require web-server/private/timer))
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
  "Return t or nil depending on whether a given file exists"
  ($ (tnil (file-exists? ,path))))

(def dir? (path)
  "Return t or nil depending on whether a given directory exists"
  ($ (tnil (directory-exists? ,path))))

(git-connect git-dir* git-ref*)

;Load all objects from the repo
(load-objects)
(restore-tables)

(def start-timer-manager ()
  "Setup function required before timers can be used"
    ($ (start-timer-manager)))

(def start-timer (s f)
  "Start a timer that waits s seconds before invoking function f"
  ($ (start-timer s f)))

;money
(deftem (mine building)
  name "mine"
  type 'money
  last-update (seconds)
  cost 100
  rate 3600
  build-time 10)

(def income (prod)
  (with (t (seconds)
         last-update prod!last-update)
    (= prod!last-update t)
    (* (/ prod!rate 3600) (- t last-update))))

(def get-balance (u)
  (each p (keep [is _!type 'money] u!mines) 
        (++ u!balance
            (income p)))
  u!balance)

(def buy (u type)
  "Create an instance of an item, deducting its cost from the users balance"
  (withs (i (inst type 'owner u!id)
         bal (- u!balance i!cost))
    (when (> bal 0)
        (= u!balance bal)
        i)))

(def start-build (u type planet)
  (whenlet b (buy u type)
           (= b!location planet)
           (start-timer b!build-time [finish-build b])))

(def finish-build (b)
  (let u (get-user b!owner)
    (= b!complete t
       b!last-update (seconds)
       (buildings* b!id) b)
    ( b)))