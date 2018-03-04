(defun current_cell (i j)
  (aref arr i j))

(defun display_trace ()
  (if (EQUAL *trace* 1) 2 0))

(defun next_cell (i j)
  (aref next_generation i j))

(defun is_alive (i j)
  (EQUAL (current_cell i j) 1))

(defun rand ()
  (dotimes (i y)
    (dotimes (j x)
	  (setf (aref arr i j) (random 2))))
  arr)

(defun is_nearby (i j)
  (if (AND (> i -1) (< i y) (> j -1) (< j x))
	  (if (equal (current_cell i j) 1) 1 0)
	0))

(defun get_neighbor (i j)
  (+ (is_nearby (+ i 1) j)
	 (is_nearby (- i 1) j)
	 (is_nearby i (+ j 1))
	 (is_nearby i (- j 1))
	 (is_nearby (- i 1) (- j 1))
	 (is_nearby (+ i 1) (+ j 1))
	 (is_nearby (- i 1) (+ j 1))
	 (is_nearby (+ i 1) (- j 1))))

(defun calc_neighbor ()
  (dotimes (i y)
    (dotimes (j x)
	  (setf (aref next_generation i j)
			(get_neighbor i j))))
  next_generation)

(defun rule1 (i j)
  (if (NOT(is_alive i j))
	  (current_cell i j)
	(if (NOT(< (next_cell i j) 2))
		1
	  (display_trace))))

(defun rule2 (i j)
  (if (NOT(is_alive i j))
	  (current_cell i j)
	(if (OR (EQUAL (next_cell i j) 2)
            (EQUAL (next_cell i j) 3))
		1
	  (display_trace))))

(defun rule3 (i j)
  (if (NOT(is_alive i j))
	  (current_cell i j)
	(if (NOT (> (next_cell i j) 3))
		1
	  (display_trace))))

(defun rule4 (i j)
  (if (is_alive i j)
	  (current_cell i j)
	(if (EQUAL (next_cell i j) 3)
		1
	  (current_cell i j))))

(defun calc_alive ()
  (dotimes (i y)
    (dotimes (j x)
	  (setf (aref arr i j)
			(rule1 i j))
	  ;; (setf (aref arr i j) (rule2 i j))
	  (setf (aref arr i j)
			(rule3 i j))
	  (setf (aref arr i j)
			(rule4 i j))))
  arr)

(defun ft_algo ()
  (setq next_generation
		(calc_neighbor))
  (setq arr (calc_alive)))
