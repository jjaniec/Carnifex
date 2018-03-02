(defun ft_clear_screen_cli ()
    (format t "~C[2J" #\Esc)
)
