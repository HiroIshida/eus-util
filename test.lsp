
(defclass test 
  :super propertied-object
  :slots (a b c))

(defmethod test
  (:init ()
   (setq a 1)
   (setq b 2)
   (setq c 3))
  (:get-a () a)
  (:get-b () b))

(defmacro (name)
  (let ((method-name (intern (string-upcase (concatenate string ":get-" name)))))
  `(defmethod test
    (method-name ()
      (make-symbol name)))))


; pprint macroexpand 
(defmacro mac (form)
  `(pprint (macroexpand ',form)))

;(mac (dotimes (i 10) (print "giga")))
;;(:get-a () a
;; (generate :a)
;; describe
;; with-gensyms


(defmacro generate (a)
  `(defmethod test
    (,(intern (concatenate string "GET-" (symbol-pname a)) *keyword-package*)
     ()
     ,(intern (symbol-pname a) *package*))))

(generate :c)
(setq tester (instance test :init))
(send tester :get-c)

;; (generate :get-a a)
;(defmacro generate (meth res)
;  `(,meth () ,res))

;(defmacro generate (meth)
;  `(,meth () ,(intern (subseq (symbol-pname meth) 5) *package*)))
  

