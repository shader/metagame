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
       (save-table o (+ d "/" o!id)))))

(def load-objects ()
  "Load all objects from their respective directories"
  (ensure-dir "objects")
  (each d (dir "objects")
    (let path (+ "objects/" d)
      (if file?.path (let o (temload 'object path)
                       (= (objects* o!id) o))
          dir?.path (each f dir.path
                      (let o (temload (sym:trim path 'end #\s)
                                      (+ "objects/" path + "/" f))
                        (= (objects* o!id) o)))))))
