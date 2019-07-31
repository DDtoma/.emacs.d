(use-package which-key
  :ensure t
  :init
  (setq which-key-idle-delay 0.3)
  :bind (:map help-map ("C-h" . which-key-C-h-dispatch))
  :hook (after-init . which-key-mode)
  )

(use-package avy
  :ensure t
  :bind
  (:map llight//global-map
	("j j" . avy-goto-char)
	("j l" . avy-goto-line)))




(provide 'init-tools)
