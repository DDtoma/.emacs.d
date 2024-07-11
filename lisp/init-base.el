(use-package emacs
  :ensure nil
  :init
  (setq inhibit-startup-screen t
        initial-scratch-message nil
        sentence-end-double-space nil
        ring-bell-function 'ignore
        frame-resize-pixelwise t)

  (setq user-full-name "llight"
        user-mail-address "ll66456645@163.com")

  (setq read-process-output-max (* 1024 1024))

  (defalias 'yes-or-no-p 'y-or-n-p)

  (set-charset-priority 'unicode)
  (setq locale-coding-system 'utf-8
        coding-system-for-read 'utf-8
        coding-system-for-write 'utf-8)

  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (setq default-process-coding-system '(utf-8-unix . utf-8-unix))

  (show-paren-mode 1)
  (setq show-paren-style 'parenthesis)

  (when (window-system)
    (tool-bar-mode -1)
    (toggle-scroll-bar -1))

  (display-time-mode -1)
  (setq column-number-mode t)

  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 4)
  (setq tab-always-indent 'complete)
  )


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

(use-package isearch
  :ensure nil
  :bind (:map isearch-mode-map
              ([remap isearch-delete-char] . isearch-del-char)
              ([return] . my/isearch-repeat)
              ([escape] . isearch-exit)
              )
  :custom
  (isearch-lazy-count t)
  (lazy-count-prefix-format "%s/%s ")
  (lazy-highlight-cleanup nil)
  :config
  (defvar my/isearch--direction nil)
  (define-advice isearch-exit (:after nil)
    (setq-local my/isearch--direction nil))
  (define-advice isearch-repeat-forward (:after (_))
    (setq-local my/isearch--direction 'forward))
  (define-advice isearch-repeat-backward (:after (_))
    (setq-local my/isearch--direction 'backward))
  )

(use-package dired
  :ensure nil
  :custom
  (dired-kill-when-opening-new-dired-buffer t)
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

(use-package awesome-pair
  :defer nil
  ;; :quelpa ((awesome-pair :fetcher github :repo "manateelazycat/awesome-pair") :upgrade nil)
  :straight (awesome-pair :type git :host github :repo "manateelazycat/awesome-pair")
  :hook
  (emacs-lisp-mode . awesome-pair-mode)
  (c-mode-common . awesome-pair-mode)
  (c-mode . awesome-pair-mode)
  (c++-mode . awesome-pair-mode)
  (java-mode . awesome-pair-mode)
  (haskell-mode . awesome-pair-mode)
  (emacs-lisp-mode . awesome-pair-mode)
  (lisp-interaction-mode . awesome-pair-mode)
  (lisp-mode . awesome-pair-mode)
  (maxima-mode . awesome-pair-mode)
  (ielm-mode . awesome-pair-mode)
  (sh-mode . awesome-pair-mode)
  (makefile-gmake-mode . awesome-pair-mode)
  (php-mode . awesome-pair-mode)
  (python-mode . awesome-pair-mode)
  (js-mode . awesome-pair-mode)
  (go-mode . awesome-pair-mode)
  (qml-mode . awesome-pair-mode)
  (jade-mode . awesome-pair-mode)
  (css-mode . awesome-pair-mode)
  (ruby-mode . awesome-pair-mode)
  (coffee-mode . awesome-pair-mode)
  (rust-mode . awesome-pair-mode)
  (qmake-mode . awesome-pair-mode)
  (lua-mode . awesome-pair-mode)
  (swift-mode . awesome-pair-mode)
  (minibuffer-inactive-mode . awesome-pair-mode)
  :bind
  (:map awesome-pair-mode-map
        ("(" . awesome-pair-open-round)
        ("[" . awesome-pair-open-bracket)
        ("{" . awesome-pair-open-curly)
        (")" . awesome-pair-close-round)
        ("]" . awesome-pair-close-bracket)
        ("}" . awesome-pair-close-curly)
        ("=" . awesome-pair-equal)
        ("%" . awesome-pair-match-paren)
        ("\"" . awesome-pair-double-quote)
        ("S-SPC" . awesome-pair-space)
        ("M-o" . awesome-pair-backward-delete)
        ("C-d" . awesome-pair-forward-delete)
        ("C-k" . awesome-pair-kill)
        ("M-\"" . awesome-pair-wrap-double-quote)
        ("M-[" . awesome-pair-wrap-bracket)
        ("M-{" . awesome-pair-wrap-curly)
        ("M-(" . awesome-pair-wrap-round)
        ("M-)" . awesome-pair-unwrap)
        ("M-p" . awesome-pair-jump-right)
        ("M-n" . awesome-pair-jump-left)
        ("M-:" . awesome-pair-jump-out-pair-and-newline))
  )

(use-package meow
  :ensure t
  :init
  (meow-global-mode 1)
  :config
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
  (meow-setup-line-number)
  (meow-setup-indicator)
  (delete-selection-mode -1)
  )

(use-package ace-window
  :ensure t
  :init
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind
  (:map llight//global-map
        ("w w" . ace-window)))

(use-package projectile
  :ensure t
  :config
  (projectile-mode))

(use-package consult-projectile
  :ensure t)

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

(use-package diminish
  :ensure t)

(provide 'init-base)
