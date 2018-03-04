(load "srcs/algo.lisp")
(load "srcs/gui.lisp")
(load "srcs/cli.lisp")
(load "srcs/extra.lisp")

(defun main ()
  (ft_usage :pname
    (car sb-ext:*posix-argv*))
  (setq y (parse-integer
    (nth 1 *posix-argv*)))
  (setq x (parse-integer
    (nth 2 *posix-argv*)))
  (setq width 1000)
  (setq height 1000)
  (setq zoom_dec_speed 2)
  (setq move_speed 10)
  (defparameter tile_size 15)
  (defparameter last_x 0)
  (defparameter last_y 0)
  (defparameter move_x 0)
  (defparameter move_y 0)
  (defparameter pause 1)
  (defparameter speed_game 20)
  (setq change_speed_game 5)
  (defparameter cur_time 0)
  (defparameter last_time 0)
  (setq arr (make-array
    (list y x) :initial-element 0))
  (setq next_generation (make-array
    (list y x) :initial-element 0))
  ;;(setq arr (rand)) <-- random mode
  (ft_loop)
  (exit))

(sb-int:with-float-traps-masked
 (:invalid :inexact :overflow) (main))
