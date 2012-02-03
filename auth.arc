(def add-user (name)
  " Create an empty user object with the given username. "
  (unless (find-user name)
    (let u (inst 'user 'name name)
      (= (users* u!id) u
         (objects* u!id) u)
      u!id)))

(def set-pw (id pass)
  " Set password for a specific user "
  (= users*.id!pw pass))

(def register (name pass)
  " Add a user and assign them a password "
  (awhen (add-user name)
    (set-pw it pass)
    it))

(def login (name pass)
  " Return session id upon successfully providing a valid username and password, otherwise return nil "
  (let u (find-user name)
    (and u (is u!pw pass)
      (set-session-id u!id))))

(def user-id (name)
  " Get the id of the user with the given username "
  (aif (find-user name)
       it!id))

(def find-user (name)
  " Find a user object by name "
  (catch
    (each (k v) users* 
          (if (is v!name name)
              throw.v))))

(def get-user (id)
  " Get a user object by id "
  users*!id)

(def set-session-id (id)
  " Assign the user a new session-id, and return it "
  (let sid (trunc (* (rand) (expt 10 10)))
    (= users*.id!session-id sid)))

