(use-package magit
  :ensure t
  :bind
  (:map llight//global-map
	("g" . magit-status)))

(use-package diff-hl
  :ensure t
  :if (display-graphic-p)
  :after magit
  :init
  (global-diff-hl-mode)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  )


(provide 'init-git)
