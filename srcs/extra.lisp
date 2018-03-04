(defun ft_usage (&key pname)
  (let ((banner "usage: ~s [-h --help] <width:int> <height:int>
positional arguments:
  width                 width of the grid
  height                height of the grid
optional arguments:
  -h, --help            show this help message and exit~%"))
	(if (or (loop for arg in *posix-argv*
				  when (or (string-equal "-h" arg)
						   (string-equal "--help" arg))
				  return t)
			(not (equal 3 (length *posix-argv*))))
		(progn
		  (format t banner pname)
		  (sb-ext:exit))))
	'continue)