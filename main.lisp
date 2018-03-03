(load "srcs/gui.lisp")

;;(main *posix-argv*))
(defun main ()
  (setq y 100)
  (setq x 100)
  (setq width 1000)
  (setq height 1000)
  (setq zoom 1)
  (defparameter move_x 0)
  (defparameter move_y 0)
  (setq move_speed 10)
  (setq arr (make-array (list y x) :initial-element 0))

  (ft_loop)
  (exit)
)

(sb-int:with-float-traps-masked (:invalid :inexact :overflow) (main))
