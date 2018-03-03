(defparameter *random-color* sdl:*white*)

(defun ft_print_box (x_ y_ size)
  (sdl:draw-box (sdl:rectangle-from-midpoint-*  (+ x_ (floor size 2))  (+ y_(floor size 2)) size size)
    :color *random-color*)
)

(defun ft_print_gui_board (arr x y zoom)
  (dotimes (y2 y)
    (dotimes (x2 x)
      (if (eq (eq (aref arr y2 x2) 0) T)
        (ft_print_box (+ 1 (* x2 tile_size)) (+ 1 (* y2 tile_size)) (- tile_size (floor tile_size 10))))))
  (sdl:update-display))

(defun ft_print_cli_board (arr x y)
  (terpri)
  (loop for y2 from 0 to (- y 1) do
    (loop for x2 from 0 to (- x 1) do
      (if (eq (eq (aref arr y2 x2) 0) T)
        (write '-))
      (if (eq (eq (aref arr y2 x2) 1) T)
        (write-char #\#)))
    (terpri)))

(defun ft_loop (tile_size)
  (sdl:with-init ()
  (sdl:window (* tile_size x) (* tile_size y) :title-caption "TG FDP")
  (setf (sdl:frame-rate) 60)
  (sdl:update-display)
  (sdl:with-events ()
    (:quit-event () t)
    (:video-expose-event () (sdl:update-display))
    (:key-down-event ()
      (sdl:push-quit-event))
    (:idle ()
      (when (sdl:mouse-left-p)
        (setf (aref arr (floor (sdl:mouse-y) tile_size) (floor (sdl:mouse-x) tile_size)) 1)
          (ft_print_cli_board arr x y))
        (sdl:clear-display sdl:*black*)
        (ft_print_gui_board arr x y 0)
        (sdl:update-display)))))