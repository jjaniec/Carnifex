(defun ft_print_cli_board (arr x y)
  (terpri)
  (loop for y2 from 0 to (- y 1) do
		(loop for x2 from 0 to (- x 1) do
			  (if (eq (eq (aref arr y2 x2) 0) T)
				  (write '-))
			  (if (eq (eq (aref arr y2 x2) 1) T)
				  (write-char #\#)))
		(terpri)))
