(use-package json-mode
  :ensure t
  :mode ("\\.json\\'" . json-mode))

(use-package json-reformatter-jq
  :ensure t
  :after json-mode)

(provide 'init-json)
