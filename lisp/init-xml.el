(use-package nxml-mode
  :ensure nil
  :hook (nxml-mode . emmet-mode)
  :config
  (use-package emmet-mode
    :ensure t))

(provide 'init-xml)
