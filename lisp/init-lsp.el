(use-package lsp-mode
  :diminish
  :ensure t

  :commands (lsp-enable-which-key-integration
	     lsp-format-buffer
	     lsp-organize-imports
	     lsp-install-server)

  :hook ((prog-mode . (lambda ()
                             (unless (derived-mode-p 'emacs-lisp-mode 'lisp-mode 'makefile-mode)
                               (lsp-deferred))))
              (markdown-mode . lsp-deferred)
              (lsp-mode . (lambda ()
                            ;; Integrate `which-key'
                            (lsp-enable-which-key-integration)

                            ;; Format and organize imports
                            (unless (apply #'derived-mode-p centaur-lsp-format-on-save-ignore-modes)
                              (add-hook 'before-save-hook #'lsp-format-buffer t t)
                              (add-hook 'before-save-hook #'lsp-organize-imports t t)))))

  :bind (:map lsp-mode-map
              ("C-c C-d" . lsp-describe-thing-at-point)
              ([remap xref-find-definitions] . lsp-find-definition)
              ([remap xref-find-references] . lsp-find-references))
  :init
  ;; @see https://emacs-lsp.github.io/lsp-mode/page/performance
  (setq read-process-output-max (* 1024 1024)) ;; 1MB

  )

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-doc-hide
  :custom-face (lsp-ui-doc-background ((t (:background ,(face-background 'tooltip)))))
  :bind (:map lsp-ui-mode-map
	      ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
	      ([remap xref-find-references] . lsp-ui-peek-find-references)
	      ("C-c u" . lsp-ui-imenu))
  :init (setq lsp-ui-doc-enable nil
	      lsp-ui-doc-use-webkit nil
	      lsp-ui-doc-delay 1.0
	      lsp-ui-doc-include-signature t
	      lsp-ui-doc-position 'at-point
	      lsp-ui-doc-border (face-foreground 'default)
	      lsp-ui-sideline-enable nil
	      lsp-ui-sideline-ignore-duplicate t
	      lsp-ui-peek-enable t)
  (when (not (display-graphic-p))
    (setq lsp-ui-doc-enable nil)
    (setq lsp-ui-peek-enable nil))
  :config
  (add-to-list 'lsp-ui-doc-frame-parameters '(right-fringe . 8))

  ;; `C-g'to close doc
  (advice-add #'keyboard-quit :before #'lsp-ui-doc-hide)

  ;; Reset `lsp-ui-doc-background' after loading theme
  (add-hook 'after-load-theme-hook
	    (lambda ()
	      (setq lsp-ui-doc-border (face-foreground 'default))
	      (set-face-background 'lsp-ui-doc-background
				   (face-background 'tooltip))))

  ;; WORKAROUND Hide mode-line of the lsp-ui-imenu buffer
  ;; @see https://github.com/emacs-lsp/lsp-ui/issues/243
  (defadvice lsp-ui-imenu (after hide-lsp-ui-imenu-mode-line activate)
    (setq mode-line-format nil)))

(use-package treemacs
  :ensure t
  :bind
  (:map llight//global-map
	("t t" . treemacs)))

(when emacs/>=25.2p
  (use-package lsp-treemacs
    :ensure t
    :bind (:map lsp-mode-map
		("M-9" . lsp-treemacs-errors-list))))

(provide 'init-lsp)
