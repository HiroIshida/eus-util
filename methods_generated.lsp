(defmethod JsonPlotter (:hist (x &key (bins 10)) (let ((data (list (cons :plottype "hist") (cons :x (to-lst-ifvec x)) (cons :bins (to-lst-ifvec bins))))) (send self :add-plot data))))

(defmethod JsonPlotter (:plot (x y &key (marker "o") (color "r")) (let ((data (list (cons :plottype "plot") (cons :x (to-lst-ifvec x)) (cons :y (to-lst-ifvec y)) (cons :marker (to-lst-ifvec marker)) (cons :color (to-lst-ifvec color))))) (send self :add-plot data))))

(defmethod JsonPlotter (:scatter (x y &key (marker "o") (color "r")) (let ((data (list (cons :plottype "scatter") (cons :x (to-lst-ifvec x)) (cons :y (to-lst-ifvec y)) (cons :marker (to-lst-ifvec marker)) (cons :color (to-lst-ifvec color))))) (send self :add-plot data))))

(defmethod JsonPlotter (:scatter3 (x y z &key (marker "o") (color "r")) (let ((data (list (cons :plottype "scatter3") (cons :x (to-lst-ifvec x)) (cons :y (to-lst-ifvec y)) (cons :z (to-lst-ifvec z)) (cons :marker (to-lst-ifvec marker)) (cons :color (to-lst-ifvec color))))) (send self :add-plot data))))

