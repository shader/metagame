(= git-dir* "./db"
   git-ref* "master")

(def git args
  "Invoke a git command"
  (pipe-from (apply string (join (list "GIT_DIR=" git-dir* " git ") args))))

(def git-connect (d ref)
  "Choose or create a git repo"
  (= git-dir* d
     git-ref* ref)
  (if (no:dir-exists git-dir*)
      (aand (git "init --bare")
            (git-write-tree)
            (git-commit-tree it "Initialize repository")
            (git-update-ref git-ref* it))))

(def git-hash-object (str (o db git-dir*))
  "Store a string to a git object"
  (readline (fromstring str (git "hash-object -w --stdin"))))

(def git-read-object (hash)
  "Read object from file"
  (read (git "cat-file -p " hash)))

(def git-add (hash path)
  "Add object to index"
  (git "update-index --add --cacheinfo 100644 " hash " " path))

(def git-remove (hash path)
  "Remove object from index"
  (git "update-index --remove --cacheinfo 100644 " hash " " path))

(def git-write-tree ()
  "Save index"
  (readline:git "write-tree"))

(def git-commit-tree (hash msg (o p nil) (o db git-dir*))
  "Create commit from specified tree"
  (readline:fromstring msg (git "commit-tree " hash (if p (+ " -p " p)))))

(def git-update-ref (ref hash)
  (git "update-ref refs/heads/" ref " " hash))

(def git-commit (msg)
  "Wrapper to save and commit index with message"
  (aand (git-write-tree)
        (git-commit-tree it msg git-ref*)
        (git-update-ref git-ref* it)))

(def save (o)
  "Save and commit a single object to the database"
  (aand (git-hash-object (tostring:write o))
        (git-add it (string o!type "s/" o!id))
        (git-commit (+ "Save " o!type " " o!name " with id " o!id " to database."))))

(def batch-save (l)
  "Save all objects in a list to the git database"
  (each o l
        (aand (git-hash-object (tostring:write o))
              (git-add it (string o!type "s/" o!id))))
  (git-commit "Batch save objects to database."))

(def git-find (f)
  "Lookup the current hash for a file in the git database"
  ((tokens:readline:git "ls-files -s \\*" f "\\*") 1))

(def git-load (id)
  "Load a single object by id"
  (git-read-object:git-find id))

(def git-load-all ()
  "Load all objects from the database, returning a list"
  (map [git-read-object ((tokens _) 1)]
       (readlines (git "ls-files -s"))))