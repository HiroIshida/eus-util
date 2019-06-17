(load "plot.lsp")
(in-package "USER")

(defun rgen (N)
  (let ((lst nil))
    (dotimes (i N lst)
      (push (aref (user::gaussian-random 1) 0) lst))))

(setq plotter (instance iplot:JsonPlotter :init))
(setq N 1000)
(send plotter :scatter3 (rgen N) (rgen N) (rgen N) :marker "+" :color "b")
(send plotter :show)
