;; auto pair
;;; http://ergoemacs.org/emacs/emacs_insert_brackets_by_pair.html
;; (electric-pair-mode 1)
;; (setq electric-pair-pairs '(
;;			    (?\{ . ?\})
;;			    (?\< . ?\>)
;;			    ))
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)

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


(use-package hideshow
  ;; 隐藏、显示结构化数据，如{ }里的内容。对于单函数较长的情况比较有用。
  :ensure nil
  :diminish hs-minor-mode
  :hook (prog-mode . hs-minor-mode)
  :config
  (defconst hideshow-folded-face '((t (:inherit 'font-lock-comment-face :box t))))
  (defun hideshow-folded-overlay-fn (ov)
    (when (eq 'code (overlay-get ov 'hs))
      (let* ((nlines (count-lines (overlay-start ov) (overlay-end ov)))
	     (info (format " ... #%d " nlines)))
	(overlay-put ov 'display (propertize info 'face hideshow-folded-face)))))
  (setq hs-set-up-overlay 'hideshow-folded-overlay-fn))

(use-package whitespace
  :ensure nil
  :hook (after-init . global-whitespace-mode)
  :config
  ;; Don't use different background for tabs.
  (face-spec-set 'whitespace-tab
		 '((t :background unspecified)))
  ;; Only use background and underline for long lines, so we can still have
  ;; syntax highlight.

  ;; For some reason use face-defface-spec as spec-type doesn't work.  My guess
  ;; is it's due to the variables with the same name as the faces in
  ;; whitespace.el.  Anyway, we have to manually set some attribute to
  ;; unspecified here.
  (face-spec-set 'whitespace-line
		 '((((background light))
		    :background "#d8d8d8" :foreground unspecified
		    :underline t :weight unspecified)
		   (t
		    :background "#404040" :foreground unspecified
		    :underline t :weight unspecified)))

  ;; Use softer visual cue for space before tabs.
  (face-spec-set 'whitespace-space-before-tab
		 '((((background light))
		    :background "#d8d8d8" :foreground "#de4da1")
		   (t
		    :inherit warning
		    :background "#404040" :foreground "#ee6aa7")))

  (setq
   whitespace-line-column nil
   whitespace-style
   '(face             ; visualize things below:
     empty            ; empty lines at beginning/end of buffer
     lines-tail       ; lines go beyond `fill-column'
     space-before-tab ; spaces before tab
     trailing         ; trailing blanks
     tabs             ; tabs (show by face)
     tab-mark         ; tabs (show by symbol)
     )))

(use-package so-long
  :ensure nil
  :config (global-so-long-mode 1))

(use-package subword
  ;; subword可以处理CamelCasesName这种驼峰式的单词，M-f后，光标会依次停在大写的词上。
  :ensure nil
  :hook (after-init . global-subword-mode))

(use-package delsel
  ;; 选中文本后，直接输入就可以，省去了删除操作
  :ensure nil
  :hook (after-init . delete-selection-mode))

(use-package autorevert
  ;; 启用autorevert的话可以自动更新对应的buffer
  :ensure nil
  :hook (after-init . global-auto-revert-mode))

(use-package ace-window
  :ensure t
  :init
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind
  (:map llight//global-map
	("w" . ace-window)))

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
    (dired-mode . my-dired-init)))

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
	))

(use-package swiper
  :ensure t
  :after ivy
  :bind
  (("\C-s" . swiper)))

(use-package projectile
  :ensure t
  :after ivy
  :init
  (setq projectile-completion-system 'ivy)
  :config
;;  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (projectile-mode +1))

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
	("s i" . counsel-imenu)
	("f r" . counsel-recentf)
	("f b" . counsel-bookmark)
	("f f" . counsel-find-file)
	("x" . counsel-M-x)))

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
	("p s g" . counsel-projectile-grep)))

(use-package diminish
  :ensure t)

(provide 'init-base)
