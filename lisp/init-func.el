(defun llight//set-windows-size-unix ()
  "setup frame size"
  (setq initial-frame-alist
	    '((width . 120)
	      (height . 60)
	      (left . 70)
	      (top . 30)))
  (setq default-frame-alist
	    '((width . 120)
	      (height . 60)
	      (left . 70)
	      (left . 30)))
  )

(defun llight//set-windows-size-windows ()
  "setup frame size in windwos"
  (setq initial-frame-alist
	    '((width . 120)
	      (height . 40)
	      (left . 70)
	      (top . 30)))
  (setq default-frame-alist
	    '((width . 120)
	      (height . 60)
	      (left . 40)
	      (left . 30)))
  )


;;----------------------------------------------------
(provide 'init-func)
