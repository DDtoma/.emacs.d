;; define my global key map
(define-prefix-command 'llight//global-map)
(global-set-key (kbd "M-m") llight//global-map)

;; Buackup
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

(use-package ace-window
  :ensure t
  :init
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind
  (:map llight//global-map
	("w" . ace-window))
  )

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
  (require 'dired-x)
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
  )

(use-package ivy
  :ensure t
  :init
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  :bind
  (:map llight//global-map
	("j j" . avy-goto-char)
	("j l" . avy-goto-line))
  :config
  (use-package all-the-icons-ivy
    :ensure t
    :init
    (ivy-set-display-transformer 'ivy-switch-buffer 'all-the-icons-ivy--buffer-transformer))
  )

(use-package ivy-rich
  :ensure t
  :init
  (ivy-rich-mode 1)
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
  ;; For better performance
  (setq ivy-rich-parse-remote-buffer nil)

  ;; Setting tab size to 1, to insert tabs as delimiters
  (add-hook 'minibuffer-setup-hook
	    (lambda ()
	      (setq tab-width 1)))
  :bind
  ("M-x" . counsel-M-x)
  (:map llight//global-map
	("b b" . ivy-switch-buffer)
	("f r" . counsel-recentf)
	("f b" . counsel-bookmark)
	("x" . counsel-M-x))
  )

(use-package swiper
  :bind
  (("\C-s" . swiper))
  )

(use-package projectile
  :ensure t
  :init
  (setq projectile-completion-system 'ivy)
  :config
;;  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (projectile-mode +1)
  :bind
  (:map llight//global-map
	("p" . projectile-command-map)))

(use-package counsel
  :init
  (when (commandp 'counsel-M-x)
    (global-set-key [remap execute-extended-command] #'counsel-M-x))
  :bind
  (:map llight//global-map
	("s f" . counsel-fzf)
	("s a" . counsel-ag)
	("f r" . counsel-recentf))
  )

(use-package helpful
  :defines ivy-initial-inputs-alist
  :bind
  (:map llight//global-map
	("h p" . helpful-at-point))
  :config
  (with-eval-after-load 'ivy
    (dolist (cmd '(helpful-callable
		   helpful-variable
		   helpful-function
		   helpful-macro
		   helpful-command))
      (cl-pushnew `(,cmd . "^") ivy-initial-inputs-alist))))

;; Fullscreen
;; WORKAROUND: To address blank screen issue with child-frame in fullscreen
(when (and sys/mac-x-p emacs/>=26p)
  (setq ns-use-native-fullscreen nil))
(bind-keys ("C-<f11>" . toggle-frame-fullscreen)
	   ("C-s-f" . toggle-frame-fullscreen))

(provide 'init-base)
