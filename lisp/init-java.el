(require 'cc-mode)

(use-package lsp-java
  :ensure t
  :after lsp
  :config
  (add-hook 'java-mode-hook 'lsp)
  (add-hook 'lsp-mode-hook #'lsp-lens-mode)
  ;;(add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)
  )

(use-package dap-mode
  :ensure t :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t))

(use-package dap-java :after (lsp-java))

(provide 'init-java)
