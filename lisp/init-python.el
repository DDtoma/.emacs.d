;; (use-package lsp-python
;;   :ensure t
;;   :after lsp-mode
;;   :hook
;;   (python-mode . lsp-python-enable))

;; (use-package pipenv
;;   :ensure t
;;   :init
;;   (setq pipenv-projectile-after-switch-function #'pipenv-projectile-after-switch-extended)
;;   :hook
;;   (python-mode . pipenv-mode))

(use-package poetry
  :ensure t)

(use-package python
  :ensure nil
  :mode
  ("\\.py\\'" . python-ts-mode)
  ("\\.pyi\\'" . python-ts-mode)
  :hook
  (python-mode . (lambda () (poetry-venv-workon) (lsp-bridge-mode 1) (corfu-mode -1)))
  ;; 使用tree-siter后python-mode会被映射到python-ts-mode
  (python-ts-mode . (lambda () (poetry-venv-workon) (lsp-bridge-mode 1) (corfu-mode -1)))
  :bind
  (:map python-ts-mode-map
        ("M-," . lsp-bridge-find-def-return)
        ("M-." . lsp-bridge-find-def))
  )


(provide 'init-python)
