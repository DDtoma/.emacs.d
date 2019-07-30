;; Key Modifiers
(with-no-warnings
  (cond
   (sys/win32p
    ;; make PC keyboard's Win key or other to type Super or Hyper
    ;; (setq w32-pass-lwindow-to-system nil)
    (setq w32-lwindow-modifier 'super     ; Left Windows key
	  w32-apps-modifier 'hyper)       ; Menu/App key
    (w32-register-hot-key [s-t]))
   ((and sys/macp (eq window-system 'mac))
    ;; Compatible with Emacs Mac port
    (setq mac-option-modifier 'super
	  mac-command-modifier 'meta)
    (bind-keys ([(super a)] . mark-whole-buffer)
	       ([(super c)] . kill-ring-save)
	       ([(super l)] . goto-line)
	       ([(super q)] . save-buffers-kill-emacs)
	       ([(super s)] . save-buffer)
	       ([(super v)] . yank)
	       ([(super w)] . delete-frame)
	       ([(super z)] . undo)))))

;; S-shift s-super m-meta <delete>
(global-set-key (kbd "M-|") 'llight//delete-blank-lines)

;; build-in commad
;;;; file command
(define-key llight//global-map (kbd "f f") 'find-file)
(define-key llight//global-map (kbd "f R") 'find-file-read-only)
(define-key llight//global-map (kbd "f s") 'save-buffer)
(define-key llight//global-map (kbd "f S") 'save-some-buffers)
(define-key llight//global-map (kbd "d") 'dired)

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

(provide 'init-keymap)
