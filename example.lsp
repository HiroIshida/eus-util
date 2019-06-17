(load "plot.lsp")

(defun rgen (N)
  (let ((lst nil))
    (dotimes (i N lst)
      (push (aref (user::gaussian-random 1) 0) lst))))

(setq plotter (instance iplot:JsonPlotter :init))
(setq N 100)
(send plotter :scatter3 (rgen N) (rgen N) (rgen N))
(send plotter :show)
