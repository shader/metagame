(deftem ship
  type 'ship
  unit-type nil         ; type of unit
  weapons nil            ; temp placeholder (defines attack value)
  hull nil             ; temp placeholder (defines armor value)
)

(deftem weapon
  type 'weapon
  weapon-type nil
  damage nil
  speed 1
  )

(= weapons* (table))
(mac defweap (name offense speed)
  `(= weapons.name (inst 'weapon 'weapon-type ,name 'damage ,damage 'speed ,speed)))

(= weapons*!laser (inst 'weapon 'weapon-type 'laser 'damage 1 'speed 1))

(deftem (frigate ship)
  unit-type 'frigate
  weapons (list weapons*!laser)
  hull 2
)

(def fire (weapon target)
  (-- target!hull weapon!damage))

(def choose (xs)
  (let l len.xs
    (xs rand.l)))

(def alternate (f a b)
  (f a b)
  (f b a))

(def barrage (red blue)
  (each s red
    (each w s!weapons
      (repeat w!speed (fire w choose.blue)))))

(def triage (fleet)
  (pull [< _!hull 1] fleet))

(= prepare idfn)

(def engage (red blue)
  (prepare red)
  (barrage red blue)
  red)

(mac multizap (op . xs)
  `(do
     ,@(accum acc 
       (each x xs
         (acc `(zap ,op ,x))))))

(def battle (red blue)
  (alternate engage red blue)
  (map triage (list red blue)))

(def status (army)
  (let c (counts army)
    (map (fn ((t n)) (list t!unit-type t!hull n)) tablist.c)))

(def list-of (n f)
  (accum acc
    (repeat n (acc (f)))))

(def fleet units
  (mappend (fn ((t n)) (list-of n [inst t])) pair.units))