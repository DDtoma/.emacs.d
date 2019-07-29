(if (display-graphic-p)
    (progn
      (setq initial-frame-alist
	    '((width . 120)
	      (height . 60)
	      (left . 70)
	      (top . 30)))
      (setq default-frame-alist
	    '((width . 120)
	      (height . 60)
	      (left . 70)
	      (left . 30)))
      (tool-bar-mode 0)
      (scroll-bar-mode 0)))


;;(global-display-line-numbers-mode)
;; set default font size
(set-face-attribute 'default nil :height 150)
;; close welcome screen
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
  (if (display-graphic-p)
      (load-theme 'kaolin-light t)
      )
  ;;(kaolin-treemacs-theme)
  )

;; (use-package whitespace
;;   :init
;;   (dolist (hook '(prog-mode-hook text-mode-hook))
;;     (add-hook hook #'whitespace-mode))
;;   (add-hook 'before-save-hook #'whitespace-cleanup)
;;   (setq whitespace-display-mappings
;;         ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
;;         '(
;;           (space-mark 32 [183] [46]) ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
;;           (newline-mark 10 [182 10]) ; LINE FEED,
;;           (tab-mark 9 [9655 9] [92 9]) ; tab
;;	  ))
;;   :config
;;   (setq whitespace-line-column 80) ;; limit line length
;;   (setq whitespace-style '(face spaces tabs newline space-mark tab-mark newline-mark))
;;   )

(use-package whitespace
  :ensure t
  :init
  (add-hook 'before-save-hook #'whitespace-cleanup))

(provide 'init-ui)
