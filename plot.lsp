(unless (find-package 'IPLOT) (make-package 'IPLOT))
(in-package 'IPLOT)
(export 'JsonPlotter)
(load "json.lsp")

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
   (let* ((dir (unix:getwd))
          (pyfile (concatenate string (unix:getwd) "/plotter.py"))
          (shell-command (concatenate string "python3 " pyfile)))
     (unix:system shell-command)))

  (:dump ()
   (let* ((json-data-dump (cons "data" data-pair-lst))
         (string-data-dump (ijson:parse-json json-data-dump)))
     (ijson:save-string string-data-dump)))

  (:plot (x-lst y-lst)
   (let ((data
           (list (cons :plottype "plot")
                 (cons :x x-lst)
                 (cons :y y-lst))))
     (send self :add-plot data)))

  (:scatter (x-lst y-lst)
   (let ((data
           (list (cons :plottype "scatter")
                 (cons :x x-lst)
                 (cons :y y-lst))))
     (send self :add-plot data)))

  (:scatter3 (x-lst y-lst z-lst)
   (let ((data
           (list (cons :plottype "scatter3")
                 (cons :x x-lst)
                 (cons :y y-lst)
                 (cons :z z-lst))))
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
      (push (aref (user::gaussian-random 1) 0) lst))))
(setq jp (instance JsonPlotter :init))
(setq N 1000)
(setq data (list (rgen N) (rgen N) (rgen N)))
;(send jp :scatter3 (rgen N) (rgen N) (rgen N))
;(send jp :show)


(provide :ishida-plot)

  





