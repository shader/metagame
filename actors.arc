(def -> (proc . msg)
  "Send a message to a process"
  (thread-send rep.proc msg))

(mac <- body
  "Receive a message using pattern matching"
  `(apply (p-m:fn ,@body)
          (thread-receive)))

(mac defproc (name args . body)
  `(def ,name ,args
     (annotate 'proc
        (thread ((afn ,args
                   (<- ,@(apply join 
                                (map [list car._ `(do ,cadr._ (self ,@args))] 
                                     pair.body))))
                 ,@args)))))

(defcall proc (p . msg)
  (thread-send rep.p msg))