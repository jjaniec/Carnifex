(load "srcs/gui.lisp")

;;(main *posix-argv*))
(defun main ()
  (defvar y 10)
  (defvar x 10)
  (defvar arr)

  (setq arr (make-array (list y x) :initial-element 0))
  (ft_init_window)
  (exit)
)

(sb-int:with-float-traps-masked (:invalid :inexact :overflow)  (main))
