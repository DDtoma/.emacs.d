(use-package diff-hl
  :init
  (global-diff-hl-mode)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  )

(use-package magit
  :bind(
	("C-x g" . magit-status)))


(provide 'init-git)
