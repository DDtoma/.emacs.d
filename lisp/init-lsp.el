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

(provide 'init-lsp)
