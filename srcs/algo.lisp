;gnu clisp 2.49

(defun current_cell (i j)
    (aref arr i j))

(defun next_cell (i j)
    (aref next_generation i j))

(defun is_alive (i j)
    (EQUAL (current_cell i j) 1))

(defun rand ()
  (dotimes (i x)
    (dotimes (j y)
        (setf (aref arr i j) (random 2)))) arr)

(defun range (i) (AND (> i -1) (< i x)))

(defun is_nearby (i j)
    (if (AND (range i) (range j))
        (if (equal (current_cell i j) 1) 1 0)
        0
    )
)

(defun get_neighbor (i j)
    (+ (is_nearby (+ i 1) j) 
       (is_nearby (- i 1) j) 
       (is_nearby i (+ j 1)) 
       (is_nearby i (- j 1)) 
       (is_nearby (- i 1) (- j 1)) 
       (is_nearby (+ i 1) (+ j 1)) 
       (is_nearby (- i 1) (+ j 1)) 
       (is_nearby (+ i 1) (- j 1))
       ))

(defun calc_neighbor ()
  (dotimes (i x)
    (dotimes (j y)
        (setf (aref next_generation i j) (get_neighbor i j)))) next_generation)

;; const rule1 = rule((n, a) => !a ? a : !(n < 2)) // underpopulation
;; const rule2 = rule((n, a) => !a ? a : (n === 2 || n === 3)) // survive
;; const rule3 = rule((n, a) => !a ? a : !(n > 3)) // overpopulation
;; const rule4 = rule((n, a) => a ? a : (n === 3)) // reproduction

(defun rule1 (i j)
    (if (NOT(is_alive i j))
        (current_cell i j)
        (if (NOT(< (next_cell i j) 2))
            1
            0)
        ))

(defun rule2 (i j)
    (if (NOT(is_alive i j))
        (current_cell i j)
        (if (OR (EQUAL (next_cell i j) 2) (EQUAL (next_cell i j) 3))
            1
            0)
        ))

(defun rule3 (i j)
    (if (NOT(is_alive i j))
        (current_cell i j)
        (if (NOT (> (next_cell i j) 3))
            1
            0)
        ))

(defun rule4 (i j)
    (if (is_alive i j)
        (current_cell i j)
        (if (EQUAL (next_cell i j) 3)
            1
            0)
        ))

(defun calc_alive ()
  (dotimes (i x)
    (dotimes (j y)
        (setf (aref arr i j) (rule1 i j)) 
        (setf (aref arr i j) (rule2 i j)) 
        (setf (aref arr i j) (rule3 i j))
        (setf (aref arr i j) (rule4 i j))
        )) 
    arr)
   

(defun ft_algo ()
  (setq next_generation (calc_neighbor))
  ;; (print "Current generation")
  ;; (print arr)
  ;; (print "Neighbor Array")
  ;; (print next_generation)
  (setq arr (calc_alive))
  ;; (print "New generation")
  ;; (print arr)
)
