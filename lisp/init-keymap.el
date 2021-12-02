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


(require 'meow)
(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . mode-line-other-buffer)))
(meow-setup)
(meow-global-mode 1)
(meow-setup-line-number)
(meow-setup-indicator)
(delete-selection-mode -1)

(provide 'init-keymap)
