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
                       ;; (unless (apply #'derived-mode-p centaur-lsp-format-on-save-ignore-modes)
                       ;;   (add-hook 'before-save-hook #'lsp-format-buffer t t)
                       ;;   (add-hook 'before-save-hook #'lsp-organize-imports t t))
		       )))

  :bind (:map lsp-mode-map
              ("C-c C-d" . lsp-describe-thing-at-point)
              ([remap xref-find-definitions] . lsp-find-definition)
              ([remap xref-find-references] . lsp-find-references))
  :init
  ;; @see https://emacs-lsp.github.io/lsp-mode/page/performance
  (setq read-process-output-max (* 1024 1024)) ;; 1MB

  (setq lsp-keymap-prefix "C-c l"
        lsp-keep-workspace-alive nil
        lsp-signature-auto-activate nil
        lsp-modeline-code-actions-enable nil
        lsp-modeline-diagnostics-enable nil
        lsp-modeline-workspace-status-enable nil
        lsp-headerline-breadcrumb-enable nil

        lsp-enable-file-watchers nil
        lsp-enable-folding nil
        lsp-enable-symbol-highlighting nil
        lsp-enable-text-document-color nil

        lsp-enable-indentation nil
        lsp-enable-on-type-formatting nil)

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

;; Ivy integration
(use-package lsp-ivy
  :after lsp-mode
  :bind (:map lsp-mode-map
              ([remap xref-find-apropos] . lsp-ivy-workspace-symbol)
              ("C-s-." . lsp-ivy-global-workspace-symbol))
  :config
  (with-no-warnings
    (when (icons-displayable-p)
      (defvar lsp-ivy-symbol-kind-icons
        `(,(all-the-icons-material "find_in_page" :height 0.9 :v-adjust -0.15) ; Unknown - 0
          ,(all-the-icons-faicon "file-o" :height 0.9 :v-adjust -0.02) ; File - 1
          ,(all-the-icons-material "view_module" :height 0.9 :v-adjust -0.15 :face 'all-the-icons-lblue) ; Module - 2
          ,(all-the-icons-material "view_module" :height 0.95 :v-adjust -0.15 :face 'all-the-icons-lblue) ; Namespace - 3
          ,(all-the-icons-octicon "package" :height 0.9 :v-adjust -0.15) ; Package - 4
          ,(all-the-icons-material "settings_input_component" :height 0.9 :v-adjust -0.15 :face 'all-the-icons-orange) ; Class - 5
          ,(all-the-icons-faicon "cube" :height 0.9 :v-adjust -0.02 :face 'all-the-icons-purple) ; Method - 6
          ,(all-the-icons-faicon "wrench" :height 0.8 :v-adjust -0.02) ; Property - 7
          ,(all-the-icons-octicon "tag" :height 0.95 :v-adjust 0 :face 'all-the-icons-lblue) ; Field - 8
          ,(all-the-icons-faicon "cube" :height 0.9 :v-adjust -0.02 :face 'all-the-icons-lpurple) ; Constructor - 9
          ,(all-the-icons-material "storage" :height 0.9 :v-adjust -0.15 :face 'all-the-icons-orange) ; Enum - 10
          ,(all-the-icons-material "share" :height 0.9 :v-adjust -0.15 :face 'all-the-icons-lblue) ; Interface - 11
          ,(all-the-icons-faicon "cube" :height 0.9 :v-adjust -0.02 :face 'all-the-icons-purple) ; Function - 12
          ,(all-the-icons-octicon "tag" :height 0.95 :v-adjust 0 :face 'all-the-icons-lblue) ; Variable - 13
          ,(all-the-icons-faicon "cube" :height 0.9 :v-adjust -0.02 :face 'all-the-icons-purple) ; Constant - 14
          ,(all-the-icons-faicon "text-width" :height 0.9 :v-adjust -0.02) ; String - 15
          ,(all-the-icons-material "format_list_numbered" :height 0.95 :v-adjust -0.15) ; Number - 16
          ,(all-the-icons-octicon "tag" :height 0.9 :v-adjust 0.0 :face 'all-the-icons-lblue) ; Boolean - 17
          ,(all-the-icons-material "view_array" :height 0.95 :v-adjust -0.15) ; Array - 18
          ,(all-the-icons-octicon "tag" :height 0.9 :v-adjust 0.0 :face 'all-the-icons-blue) ; Object - 19
          ,(all-the-icons-faicon "key" :height 0.9 :v-adjust -0.02) ; Key - 20
          ,(all-the-icons-octicon "tag" :height 0.9 :v-adjust 0.0) ; Null - 21
          ,(all-the-icons-material "format_align_right" :height 0.95 :v-adjust -0.15 :face 'all-the-icons-lblue) ; EnumMember - 22
          ,(all-the-icons-material "settings_input_component" :height 0.9 :v-adjust -0.15 :face 'all-the-icons-orange) ; Struct - 23
          ,(all-the-icons-octicon "zap" :height 0.9 :v-adjust 0 :face 'all-the-icons-orange) ; Event - 24
          ,(all-the-icons-material "control_point" :height 0.9 :v-adjust -0.15) ; Operator - 25
          ,(all-the-icons-faicon "arrows" :height 0.9 :v-adjust -0.02) ; TypeParameter - 26
          ))

      (lsp-defun my-lsp-ivy--format-symbol-match
		 ((sym &as &SymbolInformation :kind :location (&Location :uri))
		  project-root)
		 "Convert the match returned by `lsp-mode` into a candidate string."
		 (let* ((sanitized-kind (if (< kind (length lsp-ivy-symbol-kind-icons)) kind 0))
			(type (elt lsp-ivy-symbol-kind-icons sanitized-kind))
			(typestr (if lsp-ivy-show-symbol-kind (format "%s " type) ""))
			(pathstr (if lsp-ivy-show-symbol-filename
                                     (propertize (format " · %s" (file-relative-name (lsp--uri-to-path uri) project-root))
						 'face font-lock-comment-face)
				   "")))
		   (concat typestr (lsp-render-symbol-information sym ".") pathstr)))
      (advice-add #'lsp-ivy--format-symbol-match :override #'my-lsp-ivy--format-symbol-match))))

(use-package treemacs
  :ensure t
  :bind
  (:map llight//global-map
	("t t" . treemacs)))

(when emacs/>=25.2p
  (use-package lsp-treemacs
    :ensure t
    :after treemacs
    :bind (:map lsp-mode-map
		("M-9" . lsp-treemacs-errors-list))))

(provide 'init-lsp)
