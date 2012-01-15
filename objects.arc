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
  owners nil)

(deftem (user object) 
  pw nil 
  type 'user 
  sessionID nil)

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
  name nil              ; name of planet
  planet_type nil       ; type of planet
  size nil              ; size of planet
  location nil          ; 3D coordinates
  residents nil         ; list of references to players
)                       ; that live on the planet (may just be one)

(deftem (unit object)
  type 'unit
  name  nil             ; name of unit
  unit_type nil         ; type of unit
  location nil          ; reference to planet,system,space,etc
  health nil            ; health of unit
  attack nil            ; temp placeholder (defines attack value)
  armor nil             ; temp placeholder (defines armor value)
)

(deftem (building object)
  type 'building
  name nil              ; name of building
  building_type nil     ; type of building
)


; Object functions
(def save-objects ()
  "Save all objects to their respective directories"
  (ensure-dir "objects")
  (each (id o) objects*
     (let d (+ "objects/" o!type "s")
       (ensure-dir d)
       (save-table o (+ d "/" o!id)))))

(def load-objects ()
  "Load all objects from their respective directories"
  (ensure-dir "objects")
  (each d (dir "objects")
    (let f (+ "objects/" d)
      (each f (if dir?.f dir.f)
        (let o (temload (sym:trim d 'end #\s)
                        (+ "objects/" d "/" f))
          (= (objects* o!id) o))))))

(def restore-tables ()
  (maptable (fn (key val) 
              (if (isnt val!type 'object)
                (let x (eval (sym (string val!type 's*))) 
                  (= (x key) val))))
            objects*))

