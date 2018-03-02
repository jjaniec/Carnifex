(load "srcs/ft_clear_screen.lisp")
(load "srcs/ft_gen_arr.lisp")
(load "srcs/cli.lisp")

(ft_clear_screen_cli)
(ft_gen_arr 10 10)
(setf (aref arr 5 5) 1)
(setf (aref arr 7 7) 1)
(setf (aref arr 7 2) 1)
(write arr)
(ft_print_cli_board arr 10 10)

(exit)
