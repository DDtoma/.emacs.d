(use-package lsp-mode
;;     :diminish lsp-mode
     :hook (prog-mode . lsp-deferred)
     :bind (:map lsp-mode-map
	    ("C-c C-d" . lsp-describe-thing-at-point))
     :init (setq lsp-auto-guess-root t       ; Detect project root
		 lsp-prefer-flymake nil      ; Use lsp-ui and flycheck
		 flymake-fringe-indicator-position 'right-fringe)
     :config
     ;; Configure LSP clients
     (use-package lsp-clients
       :ensure nil
       :init (setq lsp-clients-python-library-directories '("/usr/local/" "/usr/"))))

(use-package lsp-ui
     :commands lsp-ui-doc-hide
     :custom-face (lsp-ui-doc-background ((t (:background ,(face-background 'tooltip)))))
     :bind (:map lsp-ui-mode-map
	    ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
	    ([remap xref-find-references] . lsp-ui-peek-find-references)
	    ("C-c u" . lsp-ui-imenu))
     :init (setq lsp-ui-doc-enable t
		 lsp-ui-doc-use-webkit nil
		 lsp-ui-doc-delay 1.0
		 lsp-ui-doc-include-signature t
		 lsp-ui-doc-position 'at-point
		 lsp-ui-doc-border (face-foreground 'default)

		 lsp-ui-sideline-enable nil
		 lsp-ui-sideline-ignore-duplicate t)
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
  :bind
  (:map llight//global-map
	 ("t t" . treemacs)))

(when emacs/>=25.2p
     (use-package lsp-treemacs
       :bind (:map lsp-mode-map
	      ("M-9" . lsp-treemacs-errors-list))))

(provide 'init-lsp)
