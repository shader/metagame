(def hash-object (str)
  (readline (pipe-from (+ "echo \"" str "\" | git hash-object -w --stdin"))))

(def read-object (hash)
  (read (pipe-from (+ "git cat-file -p " hash))))

(def add (hash path)
  (system (+ "git update-index --add --cacheinfo 100644 " hash " " path)))

(def remove (hash path)
  (system (+ "git update-index --remove --cacheinfo 100644 " hash " " path)))

(def write-tree ()
  (readline:pipe-from "git write-tree"))

(def commit-tree (hash msg)
  (readline:pipe-from:+ "echo '" msg "' | git commit-tree"))