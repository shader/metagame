(= objects* (table))

(deftem object
  id (trunc (* (rand) (expt 10 10)))
  type 'object
  name nil
  parents nil
  children nil
  owners nil)

(def save-objects ()
  "Save all objects to their respective directories"
  (ensure-dir "objects")
  (each (id o) objects*
     (let d 
         (+ "objects" (if (is o!type 'object)
                          nil
                          (+ "/" o!type "s")))
       (ensure-dir d)
       (save-table o (+ d "/" o!name)))))

(def load-objects ()
  "Load all objects from their respective directories"
  (ensure-dir "objects")
  (each d (dir "objects")
    (if file?.d (temload 'object d)
        dir?.d (each f dir.d
                 (temload (sym:trim d 'end #\s)
                          (+ "objects/" d + "/" f))))))

