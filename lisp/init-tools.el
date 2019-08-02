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


(when (display-graphic-p)
  (add-to-list 'load-path "~/.emacs.d/plugin/snails")
  (use-package snails
    :config
    (push 'snails snails-backend-imenu)
    (push 'snails snails-backend-rg)	;ripgrep
    (when (eq system-type 'darwin)
      (push 'snails snails-backend-mdfind))
    (when (eq system-type 'windows-nt)
      (push 'snails snails-backend-everything))
    :bind (:map llight//global-map
		("S s" . snails)
		("S p" . snails-search-point)))
  )


(provide 'init-tools)
