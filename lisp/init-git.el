(use-package diff-hl
  :init
  (global-diff-hl-mode)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  )

(use-package magit
  :bind
  (:map llight//global-map
	("g" . magit-status)))


(provide 'init-git)
