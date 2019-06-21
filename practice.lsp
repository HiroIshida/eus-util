
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
  

(defmacro gen0 (str)
  `(defun ,(intern (string-upcase str) *package*) () (print "hello world")))
(gen1 "hello"); worked

(defmacro gen1 ()
  (let ((str-lst (list "foo" "bar")))
    `(defun ,(intern (string-upcase (car str-lst))) () (print "foo"))))
(gen1)

; as for passing list to macro
;https://stackoverflow.com/questions/13196080/how-to-pass-a-list-to-macro-in-common-lisp
(defmacro gen (str-lst)
  `(defun ,(intern (string-upcase (car str-lst))) () (print "foo")))
(mac (gen '("foo" "bar")))

(defparameter strs '("foo" "bar"))
(gen 'strs)


(defmacro easy-one (str-lst)
  `(mapc #'(lambda (str) (print str)) ,str-lst))
(easy-one '("foo" "bar"))





;; about probelm around symbol as argument
(defmacro test1 ();; worked!
  (let ((name 'aho)) 
    `(defun ,name () (print "hellp"))))

(defmacro test2 ();; worked!
  (let* ((name-sring "HO")
         (name (intern name-sring)))
    `(defun ,name () (print "hello"))))

(defmacro test3 (name_);; worked!
  (let ((name (intern (string-upcase (string name_)))))
    `(defun ,name () (print "hellp"))))
(test3 aho) ;worked
(test3 'aho) ;does not work

(defmacro test4 ()
  (let ((fn-name-lst (list 'foo 'bar)))
    `(progn
       (defun ,(car fn-name-lst) () (print "foo"))
       (defun ,(cadr fn-name-lst) () (print "bar")))))
(test4);worked

(defmacro test2 (sym-lst)
  (let ((fn-name-lst (mapcar 
                       #'(lambda (x) (intern (string-upcase (string x))))
                       ,sym-lst)))
    `(progn
       (defun ,(car fn-name-lst) () (print "foo"))
       (defun ,(cadr fn-name-lst) () (print "bar")))))


