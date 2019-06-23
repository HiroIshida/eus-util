(unless (find-package "IPLOT") (make-package "IPLOT"))
(in-package "IPLOT")
(export 'JsonPlotter)
(load "package://roseus_mongo/euslisp/json/json-encode.l")
(load "/home/h-ishida/documents/eusutil/util.lsp")
;; ref:
;; https://matplotlib.org/3.1.0/api/pyplot_summary.html

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
          (pyfile "/home/h-ishida/documents/eusutil/plotter.py");; TODO FIX IT!!!!
          (shell-command (concatenate string "python2 " pyfile)))
     (unix:system shell-command)))

  (:dump ()
   (save-json data-pair-lst "/tmp/tmp.json"))

  (:data ()
   data-pair-lst)

  (:add-plot (data)
   (push (cons (intern (string idx) "KEYWORD") data) data-pair-lst)
   (setq idx (1+ idx)))

  (:clear ()
   (setq data-pair-lst nil))

  ;; end methods
  )

(load "methods_generated.lsp")






