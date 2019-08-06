;; setup frame size in system desktop
(when (display-graphic-p)
  (if (eq system-type 'windows-nt)
	  (llight//set-windows-size-windows)
    (llight//set-windows-size-unix))
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  (use-package zenburn-theme
	:ensure t
	:config (load-theme 'zenburn t))
  )


;;(global-display-line-numbers-mode)
;; set default font size
(set-face-attribute 'default nil :height 150)
;; close welcome screen
(setq inhibit-splash-screen t)

;; (use-package doom-modeline
;;   :ensure t
;;   :hook (after-init . doom-modeline-mode)
;;   :init
;;   (set-face-attribute 'mode-line nil :height 140)
;;   (set-face-attribute 'mode-line-inactive nil :height 140)
;;   )

(use-package awesome-tray
  :load-path "~/.emacs.d/plugin/awesome-tray"
  :ensure nil
  :if (display-graphic-p)
  :config
  (awesome-tray-mode 1))

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


(use-package all-the-icons-ivy
  :if (display-graphic-p)
  :ensure t
  :after ivy
  :init
  (ivy-set-display-transformer 'ivy-switch-buffer 'all-the-icons-ivy--buffer-transformer)
  :config
  (all-the-icons-ivy-setup)
  (setq all-the-icons-ivy-file-commands
	'(counsel-find-file
	  counsel-file-jump
	  counsel-recentf
	  counsel-projectile-find-file
	  counsel-projectile-find-dir)))
(use-package all-the-icons
  :if (display-graphic-p)
  :ensure t)

(use-package ivy-posframe
  :ensure t
  :if (display-graphic-p)
  :after ivy
  :init
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-center)))
  :config
  (ivy-posframe-mode 1)
  )

(provide 'init-ui)
