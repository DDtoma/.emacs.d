(eval-when-compile
  (require 'init-const))

;; Key Modifiers
(with-no-warnings
  (cond
   (sys/win32p
    ;; make PC keyboard's Win key or other to type Super or Hyper
    ;; (setq w32-pass-lwindow-to-system nil)
    (setq w32-lwindow-modifier 'super     ; Left Windows key
          w32-apps-modifier 'hyper)       ; Menu/App key
    (w32-register-hot-key [s-t]))
   (sys/macp
    (setq mac-option-modifier 'super
          mac-command-modifier 'meta))))

(use-package llight//general-keymap
  :ensure nil
  :defer nil
  :bind
  (:map llight//global-map
        ("q q" . save-buffers-kill-terminal)
        :prefix-map @file
        :prefix "f"
        ("f" . find-file)
        ("R" . find-file-read-only)
        ("r" . consult-recent-file)
        ("s" . save-buffer)
        ("S" . save-some-buffers)
        :prefix-map @window
        :prefix "w"
        ("1" . delete-other-windows)
        ("2" . split-window-below)
        ("3" . split-window-right)
        ("k" . kill-buffer-and-window)
        ("w" . ace-window)
        ("e"  . eval-last-sexp)
        :prefix-map @buffer
        :prefix "b"
        ("k" . kill-this-buffer)
        ("K" . kill-some-buffers)
        ("B" . ibuffer)
        ("b" . consult-buffer)
   )
  )

;;;; emacs windows
;; (bind-keys ("C-<f11>" . toggle-frame-fullscreen)
;;	   ("C-s-f" . toggle-frame-fullscreen))

(provide 'init-keymap)
