(unless (find-package 'ishida-json) (make-package 'ishida-json))
(in-package 'ishida-json)
(export 'save-string)
(export 'parse-json)

(defun dotp (something)
  (symbolp (car something)))

(defun alistp (alist)
  (and (listp alist)           
       (every #'consp alist))) 

(defun slist+ (slist_)
  (setq slist (reverse slist_))
  (let ((N (length slist)) (ret ""))
    (dotimes (i N ret)
      (setq ret (concatenate string (car slist) ret))
      (setq slist (cdr slist)))))

(defun s+ (&rest args)
  (slist+ args))

(defun tweak (something) (s+  "\"" (string something) "\""));; ishida -> "ishida" 

(defun list->json (lst);; (1 2 3) -> ["1", "2", "3"]
  (let ((left (tweak (car lst)))
        (right (slist+ (mapcar #'(lambda (str) (s+ ", " (tweak str))) (cdr lst)))))
    (s+ "[" left right "]")))

(defun convert (element)
  (if (listp element)
      (if (dotp element) 
          (dot->json element)
          (if (alistp element)
              (alist->json element)
              (list->json element)))
      (tweak element)))

(defun dot->json (dot)
  (let ((key (car dot))(val (cdr dot)))
    (s+ (tweak key) ": " (convert val))))

(defun alist->json (alist)
  (let ((left-pair (dot->json (car alist)))
        (right-pairs (slist+ (mapcar #'(lambda (pair) (s+ ", " (dot->json pair)) ) (cdr alist)))))
    (s+ "{" left-pair right-pairs "}")))

(defun parse-json (data);; note that outer { } has alyways single dotted pair
  (s+ "{" (dot->json data) "}"))

(defun save-string (str &optional (filename "tmp.json"))
  (let ((out (open filename :direction :output)))
    (dotimes (i (length str))
      (write-byte (char str i) out))
    (close out)))

;(setq jdata 
;     (list 
;       (cons :debug "on")
;       (cons :window (list 
;                        (cons :title "sample-------------")
;                        (cons :name "main_window")
;                        (cons :width (list 1 2 3 4))
;                        (cons :height 500)))))
;(save-string (alist->json jdata))
   





