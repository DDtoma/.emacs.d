(use-package lsp-python
  :ensure t
  :after lsp-mode
  :hook
  (python-mode . lsp-python-enable))

(use-package pipenv
  :ensure t
  :init
  (setq pipenv-projectile-after-switch-function #'pipenv-projectile-after-switch-extended)
  :hook
  (python-mode . pipenv-mode))

(provide 'init-python)
