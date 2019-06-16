(defun dotp (something)
  (if (listp (cdr something)) nil t))

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
  (unless (listp element) 
    (setq element (list element)));; convert to list so that  
  (if (alistp element)
      (alist->json element)
      (list->json element)))

(defun dot->json (dot)
  (let ((key (car dot))(val (cdr dot)))
    (s+ (tweak key) ": " (convert val))))

(defun alist->json (alist)
  (let ((left-pair (dot->json (car alist)))
        (right-pairs (slist+ (mapcar #'(lambda (pair) (s+ ", " (dot->json pair)) ) (cdr alist)))))
    (s+ "{" left-pair right-pairs "}")))

(defun save-string (str &optional (filename "tmp.json"))
  (let ((out (open filename :direction :output)))
    (dotimes (i (length str))
      (write-byte (char str i) out))
    (close out)))

(setq jdata 
      (list 
        (cons "debug" "on")
        (cons "window" (list 
                         (cons "title" "sample-------------")
                         (cons "name" "main_window")
                         (cons "width" 500)
                         (cons "height" 500)))))
(save-string (alist->json jdata))
   





