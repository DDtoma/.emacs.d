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
(global-set-key (kbd "s-\\") 'llight//delete-blank-lines)
(global-set-key (kbd "C-c k") 'kill-this-buffer)
(provide 'init-keymap)
