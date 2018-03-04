(ql:quickload "lispbuilder-sdl")
(defparameter *white* sdl:*white*)
(defparameter *red* (sdl:color :r 137 :g 137 :b 137))

(defun ft_print_box (x_ y_ size color)
  (sdl:draw-box (sdl:rectangle-from-midpoint-*
				 (+ x_ (floor size 2))
				 (+ y_(floor size 2)) size size)
				:color color))

(defun invert_color ()
  (if (EQUAL *invert* 1) 1 0))

(defun ft_print_gui_board (arr x y tile_size)
  (sdl:clear-display sdl:*black*)
  (dotimes (y2 y)
    (dotimes (x2 x)
      (if (eq (eq (aref arr y2 x2) (invert_color)) T)
		  (ft_print_box (+ 1 (* x2 tile_size ) move_x)
						(+ 1 (* y2 tile_size) move_y) (- tile_size (floor tile_size 10)) *white*))
	  (if (eq (aref arr y2 x2) 2)
		  (ft_print_box (+ 1 (* x2 tile_size) move_x)
						(+ 1 (* y2 tile_size) move_y) (- tile_size (floor tile_size 10)) *red*))
	  ))
  (sdl:update-display))

(defun ft_zoom ()
  (if (< tile_size 400)
	  (progn
		(setf tile_size (+ tile_size zoom_dec_speed))
		(setf move_x (- move_x 50))
		(setf move_y (- move_y 50)))))

(defun ft_dezoom ()
  (if (> tile_size zoom_dec_speed)
	  (progn
		(setf tile_size (- tile_size zoom_dec_speed))
		(setf move_x (+ move_x 50))
		(setf move_y (+ move_y 50)))))

(defun ft_speed_game (arg)
  (if (eq arg T)
	  (progn
		(if (>= speed_game 20)
			(setf speed_game
				  (- speed_game change_speed_game))))
	(progn
	  (if (<= speed_game 100)
		  (setf speed_game (+ speed_game change_speed_game))))))

(defun ft_handle_event (key)
  (if (sdl:key= key :sdl-key-escape)
	  (sdl:push-quit-event))
  (if (or (sdl:key= key :sdl-key-left) (sdl:key= key :sdl-key-a))
	  (setf move_x (+ move_x move_speed)))
  (if (or (sdl:key= key :sdl-key-right) (sdl:key= key :sdl-key-d))
	  (setf move_x (- move_x move_speed)))
  (if (or (sdl:key= key :sdl-key-up) (sdl:key= key :sdl-key-w))
	  (setf move_y (+ move_y move_speed)))
  (if (or (sdl:key= key :sdl-key-down) (sdl:key= key :sdl-key-s))
	  (setf move_y (- move_y move_speed)))
  (if (sdl:key= key :sdl-key-period)
	  (ft_speed_game T))
  (if (sdl:key= key :sdl-key-comma)
	  (ft_speed_game nil))
  (if (or (sdl:key= key :sdl-key-q) (sdl:key= key :sdl-key-kp-minus))
	  (ft_dezoom))
  (if (or (sdl:key= key :sdl-key-e) (sdl:key= key :sdl-key-kp-plus))
	  (ft_zoom))
  (if (or (sdl:key= key :sdl-key-r))
	  (setq arr (make-array (list y x) :initial-element 0)))
  (if (or (sdl:key= key :sdl-key-p) (sdl:key= key :sdl-key-space))
	  (if (= pause 0)
		  (setf pause 1)
		(setf pause 0)))
  (ft_print_gui_board arr x y tile_size))

(defun ft_mouse_event ()
  (if (sdl:mouse-left-p)
	  (progn
		(if (or (sdl:key-down-p :sdl-key-lctrl) (sdl:key-down-p :sdl-key-rctrl))
			(progn
			  (if (and (eq last_x 0) (eq last_y 0))
				  (progn
					(setf last_x (sdl:mouse-x))
					(setf last_y (sdl:mouse-y)))
				(progn
				  (let
					  ((x_act (sdl:mouse-x))
					   (y_act (sdl:mouse-y)))
					(setf move_x (+ move_x (- x_act last_x)))
					(setf move_y (+ move_y (- y_act last_y)))
					(setf last_x x_act)
					(setf last_y y_act)))))
		  (let ((i_tab (floor (- (sdl:mouse-y) move_y) tile_size))
				(j_tab (floor (- (sdl:mouse-x) move_x) tile_size)))
			(if (eq (and (>= i_tab 0) (< i_tab y) (>= j_tab 0) (< j_tab x)) T)
				(setf (aref arr i_tab j_tab) 1))))))
  (if (sdl:mouse-right-p)
	  (let
		  ((i_tab (floor (- (sdl:mouse-y) move_y) tile_size))
		   (j_tab (floor (- (sdl:mouse-x) move_x) tile_size)))
		(if (eq (and (>= i_tab 0) (< i_tab y) (>= j_tab 0) (< j_tab x)) T)
			(setf (aref arr i_tab j_tab) 0))))
  (ft_print_gui_board arr x y tile_size))

(defun ft_loop ()
  (sdl:with-init ()
    (sdl:window width height :title-caption "Carnifex")
	(setf (sdl:frame-rate) 60)
	(sdl:update-display)
	(sdl:enable-key-repeat nil nil)
	(sdl:with-events ()
	  (:quit-event () t)
	  (:video-expose-event ()
	    (sdl:update-display))
	  (:mouse-button-up-event
	    (:button button :x mouse-x :y mouse-y)
		(if (= button 4) ; When down
			(if (or (sdl:key-down-p :sdl-key-lshift)
					(sdl:key-down-p :sdl-key-rshift))
				(ft_speed_game nil) ; shifted
			  (ft_dezoom)))
		(if (= button 5) ; When up
			(if (or (sdl:key-down-p :sdl-key-lshift)
					(sdl:key-down-p :sdl-key-rshift))
				(ft_speed_game t) ; shifted
			  (ft_zoom)))
		(if (= button 1)
			(progn
			  (setf last_x 0)
			  (setf last_y 0))))
	  (:key-down-event (:key key)
	    (ft_handle_event key))
	  (:idle ()
	    (ft_mouse_event)
		(if (eq (eq pause 0) T)
			(progn
			  (setf cur_time (get-internal-run-time))
			  (let ((time_wait (- last_time (- cur_time speed_game))))
				(if (> time_wait 0)
					(sleep (/ time_wait 100))))
			  (ft_algo) ; This is the meat
			  (setf last_time cur_time)))))))
