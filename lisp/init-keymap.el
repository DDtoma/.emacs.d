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
	  mac-command-modifier 'meta)
    )
   ))

;; build-in commad
;;;; edit
(bind-key "C-h" 'delete-backward-char)
;;;; file command
(define-key llight//global-map (kbd "f R") 'find-file-read-only)
(define-key llight//global-map (kbd "f s") 'save-buffer)
(define-key llight//global-map (kbd "f S") 'save-some-buffers)
(define-key llight//global-map (kbd "d") 'dired)
(define-key llight//global-map (kbd "w 1") 'delete-other-windows)
(define-key llight//global-map (kbd "w 2") 'split-window-below)
(define-key llight//global-map (kbd "w 3") 'split-window-right)
(define-key llight//global-map (kbd "w k") 'kill-buffer-and-window)
(define-key llight//global-map (kbd "e e") 'eval-last-sexp)

;;;; buffer command
(define-key llight//global-map (kbd "b k") 'kill-this-buffer)
(define-key llight//global-map (kbd "b K") 'kill-some-buffers)
(define-key llight//global-map (kbd "b B") 'ibuffer)

;;;; help command
(define-key llight//global-map (kbd "h k") 'describe-key)
(define-key llight//global-map (kbd "h f") 'describe-function)
(define-key llight//global-map (kbd "h v") 'describe-variable)
(define-key llight//global-map (kbd "h s") 'describe-symbol)

;;;; emacs operation
(define-key llight//global-map (kbd "q q") 'save-buffers-kill-terminal)
(global-set-key (kbd "C-c c") 'org-capture)

;;;; emacs windows
;; (bind-keys ("C-<f11>" . toggle-frame-fullscreen)
;;	   ("C-s-f" . toggle-frame-fullscreen))

(provide 'init-keymap)
