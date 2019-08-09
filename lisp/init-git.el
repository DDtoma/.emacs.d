(use-package magit
  :ensure t
  :bind
  (:map llight//global-map
	("g" . magit-status)))

(use-package diff-hl
  :ensure t
  :if (display-graphic-p)
  :after magit
  :config
  (global-diff-hl-mode 1)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  )


(provide 'init-git)
