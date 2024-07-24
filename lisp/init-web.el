(use-package emmet-mode
  :ensure t
  :defer t
  :hook ((sgml-mode . emmet-mode)
         (css-mode . emmet-mode))
  )


(provide 'init-web)
