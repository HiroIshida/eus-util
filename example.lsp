(load "plot.lsp")
(in-package "USER")

(defun rgen (N)
  (let ((lst nil))
    (dotimes (i N lst)
      (push (aref (user::gaussian-random 1) 0) lst))))

(setq plotter (instance iplot:JsonPlotter :init))
(setq N 300)
(send plotter :scatter (rgen N) (rgen N) :marker "+" :color "b")
(send plotter :scatter (rgen N) (rgen N) :marker "*" :color "r")
(send plotter :show)
