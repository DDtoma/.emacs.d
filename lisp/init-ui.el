
;; set default font size
(set-face-attribute 'default nil :height 150)

(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq inhibit-splash-screen t)

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :init
  (set-face-attribute 'mode-line nil :height 140)
  (set-face-attribute 'mode-line-inactive nil :height 140)
  )

(use-package kaolin-themes
  :config
  (load-theme 'kaolin-dark t)
  ;;(kaolin-treemacs-theme)
  )

(provide 'init-ui)
