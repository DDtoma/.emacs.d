(use-package emmet-mode
  :ensure t
  :defer t
  :hook ((sgml-mode . emmet-mode)
         (css-mode . emmet-mode))
  )

(use-package auto-rename-tag
  :ensure t
  :hook (
         (sgml-mode . auto-rename-tag-mode)
         (xml-mode . auto-rename-tag-mode)
         (nxml-mode . auto-rename-tag-mode)
         (html-mode . auto-rename-tag-mode)
         (mhtml-mode . auto-rename-tag-mode)
         )
  )


(provide 'init-web)
