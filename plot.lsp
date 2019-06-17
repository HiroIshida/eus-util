(load "json.lisp")

(defclass JsonPlotter 
  :super propertied-object
  :slots (idx data-pair-lst))

(defmethod JsonPlotter
  (:init ()
   (setq idx 0)
   (setq data-pair-lst nil)
   self)

  (:show ()
   (send self :dump)
   (unix:system "python3 plotter.py"))

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

;; test
(defun rgen (N)
  (let ((lst nil))
    (dotimes (i N lst)
      (push (aref (gaussian-random 1) 0) lst))))
(setq jp (instance JsonPlotter :init))
(setq a (rgen 10))
(setq b (rgen 10))
(send jp :scatter a b)
(send jp :show)



  





