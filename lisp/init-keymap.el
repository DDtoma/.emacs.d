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
  :after consult
  :bind
  (:map llight//global-map
        ("q q" . save-buffers-kill-terminal)
        :prefix-map file
        :prefix "f"
        ("f" . find-file)
        ("R" . find-file-read-only)
        ("r" . consult-recent-file)
        ("s" . save-buffer)
        ("S" . save-some-buffers)
        :prefix-map window
        :prefix "w"
        ("1" . delete-other-windows)
        ("2 "  . split-window-below)
        ("3 "  . split-window-right)
        ("k "  . kill-buffer-and-window)
        ("e "  . eval-last-sexp)
        :prefix-map buffer
        :prefix "b"
        ("k" . kill-this-buffer)
        ("K" . kill-some-buffers)
        ("B" . ibuffer)
        ("b" . consult-buffer)
   )
  )

;; build-in commad
;;;; edit
;; (bind-key "C-h" 'delete-backward-char)
;;;; file command
;; (define-key llight//global-map (kbd "f f") 'find-file)
;; (define-key llight//global-map (kbd "f R") 'find-file-read-only)
;; (define-key llight//global-map (kbd "f r") 'consult-recent-file)
;; (define-key llight//global-map (kbd "f s") 'save-buffer)
;; (define-key llight//global-map (kbd "f S") 'save-some-buffers)
;; (define-key llight//global-map (kbd "w 1") 'delete-other-windows)
;; (define-key llight//global-map (kbd "w 2") 'split-window-below)
;; (define-key llight//global-map (kbd "w 3") 'split-window-right)
;; (define-key llight//global-map (kbd "w k") 'kill-buffer-and-window)
;; (define-key llight//global-map (kbd "e e") 'eval-last-sexp)

;;;; buffer command
;; (define-key llight//global-map (kbd "b k") 'kill-this-buffer)
;; (define-key llight//global-map (kbd "b K") 'kill-some-buffers)
;; (define-key llight//global-map (kbd "b B") 'ibuffer)
;; (define-key llight//global-map (kbd "b b") 'consult-buffer)

;;;; emacs operation
;; (define-key llight//global-map (kbd "q q") 'save-buffers-kill-terminal)
;; (global-set-key (kbd "C-c o c") 'org-capture)

;;;; emacs windows
;; (bind-keys ("C-<f11>" . toggle-frame-fullscreen)
;;	   ("C-s-f" . toggle-frame-fullscreen))

(provide 'init-keymap)
