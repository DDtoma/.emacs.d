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

;; Configure network proxy
(setq my-proxy "http://127.0.0.1:8118")

(defun show-proxy ()
  "Show http/https proxy."
  (interactive)
  (if url-proxy-services
      (message "Current proxy is \"%s\"" my-proxy)
    (message "No proxy")))

(defun set-proxy ()
  "Set http/https proxy."
  (interactive)
  (setq url-proxy-services `(("http" . ,my-proxy)
                             ("https" . ,my-proxy)))
  (show-proxy))

(defun unset-proxy ()
  "Unset http/https proxy."
  (interactive)
  (setq url-proxy-services nil)
  (show-proxy))

(defun toggle-proxy ()
  "Toggle http/https proxy."
  (interactive)
  (if url-proxy-services
      (unset-proxy)
    (set-proxy)))



;;----------------------------------------------------
(provide 'init-func)
