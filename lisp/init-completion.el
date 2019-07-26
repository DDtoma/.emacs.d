(use-package lsp-mode
  :init)

(use-package company
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  )

(use-package company-lsp
  :init
  (push 'company-lsp company-backends)
  )


(provide 'init-completion)
