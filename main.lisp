(load "srcs/gui.lisp")

;;(main *posix-argv*))
(defun main ()
  (setq y 100)
  (setq x 100)
  (setq tile_size 15)
  (setq zoom_dec_speed 2)
  (setq arr (make-array (list y x) :initial-element 0))

  (ft_loop tile_size)
  (exit)
)

(sb-int:with-float-traps-masked (:invalid :inexact :overflow) (main))