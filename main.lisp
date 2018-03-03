(load "srcs/gui.lisp")

;;(main *posix-argv*))
(defun main ()
  (setq y 100)
  (setq x 100)
  (setq zoom 1)
  (setq arr (make-array (list y x) :initial-element 0))

  (ft_loop)
  (exit)
)

(sb-int:with-float-traps-masked (:invalid :inexact :overflow) (main))