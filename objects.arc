(= objects* (table))
(= users* (table))
(= systems* (table))
(= planets* (table))
(= units* (table))
(= buildings* (table))

(deftem object
  id (trunc (* (rand) (expt 10 10)))
  type 'object
  name nil
  parents nil
  children nil
  owner nil)

(deftem (user object) 
  pw nil 
  type 'user 
  session-id nil
  balance 0)

; Systems contain at least one high-mass object that
; other masses orbit (star, singularity, etc)
; Contains a list of references to objects that
; reside in the system
(deftem (system object)
  type 'system
  name nil              ; name of system
  location nil          ; 3D coordinates
  contents nil          ; list of residing objects
)

(deftem (planet object) 
  type 'planet 
  system nil            ; reference to system
  planet_type nil       ; type of planet
  size nil              ; size of planet
  location nil          ; 3D coordinates
  residents nil         ; list of references to players
)                       ; that live on the planet (may just be one)

(deftem (unit object)
  type 'unit
  unit_type nil         ; type of unit
  location nil          ; reference to planet,system,space,etc
  health nil            ; health of unit
  attack nil            ; temp placeholder (defines attack value)
  armor nil             ; temp placeholder (defines armor value)
)

(deftem (building object)
  type 'building
  location nil
  status nil
  cost 0)

; Object functions
(def load-objects ()
  (each o (git-load-all)
        (= (objects* o!id) o)))

(def save-objects ()
  (batch-save vals.objects*))

(def restore-tables ()
  (maptable (fn (key val) 
              (if (isnt val!type 'object)
                (let x (eval (sym (string val!type 's*))) 
                  (= (x key) val))))
            objects*))

