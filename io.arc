(def file? (path)
  ($ (tnil (file-exists? ,path))))

(def dir? (path)
  ($ (tnil (directory-exists? ,path))))