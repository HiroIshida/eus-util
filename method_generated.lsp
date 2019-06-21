(defmethod JsonPlotter (:hist (x &key (bins 10)) (let ((data (list (cons :plottype "hist") (cons :x x) (cons :bins bins)))) (send self :add-plot data))))

(defmethod JsonPlotter (:plot (x y &key (marker "o") (color "r")) (let ((data (list (cons :plottype "plot") (cons :x x) (cons :y y) (cons :marker marker) (cons :color color)))) (send self :add-plot data))))

(defmethod JsonPlotter (:scatter (x y &key (marker "o") (color "r")) (let ((data (list (cons :plottype "scatter") (cons :x x) (cons :y y) (cons :marker marker) (cons :color color)))) (send self :add-plot data))))

(defmethod JsonPlotter (:scatter3 (x y z &key (marker "o") (color "r")) (let ((data (list (cons :plottype "scatter3") (cons :x x) (cons :y y) (cons :z z) (cons :marker marker) (cons :color color)))) (send self :add-plot data))))

