(unless (find-package "IPLOT") (make-package "IPLOT"))
(in-package "IPLOT")
(export 'JsonPlotter)
(load "package://roseus_mongo/euslisp/json/json-encode.l")

(defun save-json (obj filename) 
  (let ((out (open filename :direction :output)))
    (json::encode-element obj out)
    (close out)))

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
   (save-json data-pair-lst "./tmp.json"))

  (:data ()
   data-pair-lst)

  (:plot (x-lst y-lst &key (marker "o") (color "r"))
   (let ((data
           (list (cons :plottype "plot")
                 (cons :x x-lst)
                 (cons :y y-lst)
                 (cons :marker marker)
                 (cons :color color)
                 )))
     (send self :add-plot data)))

  (:scatter (x-lst y-lst &key (marker "o") (color "r"))
   (let ((data
           (list (cons :plottype "scatter")
                 (cons :x x-lst)
                 (cons :y y-lst)
                 (cons :marker marker)
                 (cons :color color)
                 )))
     (send self :add-plot data)))

  (:scatter3 (x-lst y-lst z-lst &key (marker "o") (color "r"))
   (let ((data
           (list (cons :plottype "scatter3")
                 (cons :x x-lst)
                 (cons :y y-lst)
                 (cons :z z-lst)
                 (cons :marker marker)
                 (cons :color color)
                 )))
     (send self :add-plot data)))

  (:add-plot (data)
   (push (cons (intern (string idx) "KEYWORD") data) data-pair-lst)
   (setq idx (1+ idx)))

  (:clear ()
   (setq data-pair-lst nil))

  ;; end methods
  )

  





