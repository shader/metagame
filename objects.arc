(= objects* (table))

(deftem objects
  id (trunc (* (rand) (expt 10 10)))
  type 'object
  name nil
  parents nil
  children nil
  owners nil)

(def save-objects ()
  "Save all objects to their respective directories"
  (ensure-dir "objects")
  (each obj objects*
     (let d 
          (+ "objects" (if (is obj!type 'object)
                           nil
                           (+ "/" obj!type "s")))
       (ensure-dir d)
       (w/outfile f (+ d "/" obj!name)
         (save-table obj f)))))

