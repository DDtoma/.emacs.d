;; define my global key map
(define-prefix-command 'llight//global-map)
(global-set-key (kbd "M-m") llight//global-map)
(defalias 'yes-or-no-p 'y-or-n-p)

;; auto pair
;;; http://ergoemacs.org/emacs/emacs_insert_brackets_by_pair.html
;; (electric-pair-mode 1)
;; (setq electric-pair-pairs '(
;;			    (?\{ . ?\})
;;			    (?\< . ?\>)
;;			    ))
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)

;; close voice
(setq ring-bell-function 'ignore)

;; Buackup
;; (setq make-backup-files nil)
(setq auto-save-default nil)
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
(use-package exec-path-from-shell
  :ensure t
  :if (or sys/mac-x-p sys/linux-x-p)
  :init
  (setq exec-path-from-shell-check-startup-files nil
	exec-path-from-shell-variables '("PATH" "MANPATH" "PYTHONPATH" "GOPATH")
	exec-path-from-shell-arguments '("-l" "-i"))
  (exec-path-from-shell-initialize))


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
  :ensure nil
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
  (setq enable-recursive-minibuffers t))

(use-package ivy-rich
  :ensure t
  :after ivy
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
  (:map llight//global-map
	("b b" . ivy-switch-buffer)
	("X" . ivy-resume)
	)
  )

(use-package swiper
  :ensure t
  :after ivy
  :bind
  (("\C-s" . swiper))
  )

(use-package projectile
  :ensure t
  :after ivy
  :init
  (setq projectile-completion-system 'ivy)
  :config
;;  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (projectile-mode +1)
  )

(use-package ibuffer-projectile
  :ensure t
  :after projectile
  :config

  (setq ibuffer-formats
	'((mark modified read-only " "
		(name 18 18 :left :elide)
		" "
		(size 9 -1 :right)
		" "
		(mode 16 16 :left :elide)
		" "
		project-relative-file)))
  :hook
  (ibuffer . (lambda ()
	       (ibuffer-projectile-set-filter-groups)
	       (unless (eq ibuffer-sorting-mode 'alphabetic)
		 (ibuffer-do-sort-by-alphabetic)))))

(use-package counsel
  :ensure t
  :init
  (when (commandp 'counsel-M-x)
    (global-set-key [remap execute-extended-command] #'counsel-M-x))
  :bind
  ("M-x" . counsel-M-x)
  ("C-x C-f" . counsel-find-file)
  ("M-y" . counsel-yank-pop)
  (:map llight//global-map
	("s f" . counsel-fzf)
	("s a" . counsel-ag)
	("s r" . counsel-rg)
	("s k" . counsel-ack)
	("s c" . counsel-cd)
	("s K" . counsel-describes)
	("s e" . counsel-minor)
	("f r" . counsel-recentf)
	("f b" . counsel-bookmark)
	("f f" . counsel-find-file)
	("x" . counsel-M-x))
  )

(use-package counsel-projectile
  :ensure t
  :after counsel projectile
  :init
  (counsel-projectile-mode +1)
  :bind
  (:map llight//global-map
	("p f" . counsel-projectile-find-file)
	("p d" . counsel-projectile-find-dir)
	("p c" . counsel-projectile-switch-project)
	("p s a" . counsel-projectile-ag)
	("p s g" . counsel-projectile-grep)
	))

(use-package helpful
  :ensure t
  :defines ivy-initial-inputs-alist
  :after ivy
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

(provide 'init-base)
