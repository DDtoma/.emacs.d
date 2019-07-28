;; (setq make-backup-files nil)
;; (setq auto-save-default nil)
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

(defun my-backup-file-name (fpath)
  "Return a new file path of a given file path.
If the new path's directories does not exist, create them."
  (let* (
	(backupRootDir "~/.emacs.d/backup/")
	(filePath (replace-regexp-in-string "[A-Za-z]:" "" fpath )) ; remove Windows driver letter in path, for example, “C:”
	(backupFilePath (replace-regexp-in-string "//" "/" (concat backupRootDir filePath "~") ))
	)
    (make-directory (file-name-directory backupFilePath) (file-name-directory backupFilePath))
    backupFilePath
  )
  )

(setq make-backup-file-name-function 'my-backup-file-name)

;; Environment
(when (or sys/mac-x-p sys/linux-x-p)
  (use-package exec-path-from-shell
    :init
    (setq exec-path-from-shell-check-startup-files nil
	  exec-path-from-shell-variables '("PATH" "MANPATH" "PYTHONPATH" "GOPATH")
	  exec-path-from-shell-arguments '("-l" "-i"))
    (exec-path-from-shell-initialize)))

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

(use-package recentf
  :ensure nil
  :hook (after-init . recentf-mode)
  :init (setq recentf-max-saved-items 200
	      recentf-exclude '((expand-file-name package-user-dir)
				".cache"
				".cask"
				".elfeed"
				"bookmarks"
				"cache"
				"ido.*"
				"persp-confs"
				"recentf"
				"undo-tree-hist"
				"url"
				"COMMIT_EDITMSG\\'")))

(use-package windmove
  :config
  (windmove-default-keybindings))

;; http://lifegoo.pluskid.org/wiki/EnhanceDired.html
(use-package dired
  :config
  ;; dired - reuse current buffer by pressing 'a'
  (put 'dired-find-alternate-file 'disabled nil)

  ;; always delete and copy recursively
  (setq dired-recursive-deletes 'always)
  (setq dired-recursive-copies 'always)

  ;; if there is a dired buffer displayed in the next window, use its
  ;; current subdir, instead of the current subdir of this dired buffer
  (setq dired-dwim-target t)

  ;; enable some really cool extensions like C-x C-j(dired-jump)
  (require 'dired-x))

(use-package dired-single
  :ensure t
  :init
  (defun my-dired-init ()
    (define-key dired-mode-map [return] 'dired-single-buffer)
    (define-key dired-mode-map [mouse-1] 'dired-single-buffer-mouse)
    (define-key dired-mode-map "^" 'dired-single-up-directory))
  :hook
  (dired-mode . my-dired-init)
  )


(use-package ivy
  :ensure t
  :init
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  :bind
  (("C-x c" . avy-goto-char)
   ("C-x l" . avy-goto-line))
  )

(use-package all-the-icons-ivy
  :ensure t
  :init
  (ivy-set-display-transformer 'ivy-switch-buffer 'all-the-icons-ivy--buffer-transformer))

(use-package swiper
  :bind
  (("\C-s" . swiper))
  )

(use-package projectile
  :ensure t
  :init
  (setq projectile-completion-system 'ivy)
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (projectile-mode +1))

(use-package counsel
  :init
  (global-unset-key (kbd "C-j"))
  :bind
  (("C-c s f" . counsel-fzf)
   ("C-c s a" . counsel-ag)
   ("C-c C-r" . counsel-recentf)
   ("C-x C-b" . counsel-ibuffer))
  )

(use-package smartparens
  :init
  (show-smartparens-global-mode t)
  (sp-local-pair '(emacs-lisp-mode) "'" "'" :actions nil)
  :hook
  (prog-mode . turn-on-smartparens-strict-mode)
  )

;; Fullscreen
;; WORKAROUND: To address blank screen issue with child-frame in fullscreen
(when (and sys/mac-x-p emacs/>=26p)
  (setq ns-use-native-fullscreen nil))
(bind-keys ("C-<f11>" . toggle-frame-fullscreen)
	   ("C-s-f" . toggle-frame-fullscreen))

(provide 'init-base)
