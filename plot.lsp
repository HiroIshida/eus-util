(load "json.lisp")

(defclass JsonPlotter 
  :super propertied-object
  :slots (idx data-pair-lst))

(defmethod JsonPlotter
  (:init ()
   (setq idx 0)
   (setq data-pair-lst nil)
   self)

  (:dump ()
   (let* ((json-data-dump (cons "data" data-pair-lst))
         (string-data-dump (parse-json json-data-dump)))
     (save-string string-data-dump)))



  (:scatter (x-lst y-lst)
   (let ((data
           (list (cons :pltstyle "scatter")
                 (cons :x x-lst)
                 (cons :y y-lst))))
     (send self :add-plot data)))

  (:add-plot (data)
   (push (cons (make-symbol (string idx)) data) data-pair-lst)
   (setq idx (+ idx 1)))
  ;; end methods
  )

(setq jp (instance JsonPlotter :init))
(send jp :scatter '(1 2 3) '(4 5 6))
(send jp :scatter '(1 2 3) '(4 5 6))
(setq data (send jp :dump))



  





