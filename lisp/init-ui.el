(eval-when-compile
  (require 'init-const)
  (require 'init-func))

;; set default font size
;; (set-face-attribute 'default nil :height 120)

(when (eq system-type 'gnu/linux)
      (setq fonts '("Sarasa Nerd Font" "Sarasa Nerd Font"))
      (set-face-attribute 'default nil :font
			(format "%s:pixelsize=%d" (car fonts) 20))
      (setq face-font-rescale-alist '(("Sarasa Nerd Font". 1.0))))

(dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font) charset
			(font-spec :family (car (cdr fonts)))))

;; setup frame size in system desktop
(when (display-graphic-p)
  (if (eq system-type 'windows-nt)
	  (llight//set-windows-size-windows)
    (llight//set-windows-size-unix))
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (scroll-bar-mode 0)
  (use-package zenburn-theme
	:ensure t
	:config (load-theme 'zenburn t))
  )

;; Fullscreen
;; WORKAROUND: To address blank screen issue with child-frame in fullscreen
(when (and sys/mac-x-p emacs/>=26p)
  (setq ns-use-native-fullscreen nil))

;;(global-display-line-numbers-mode)
(use-package display-line-numbers
  :ensure nil
  :hook
  (emacs-lisp-mode . display-line-numbers-mode)
  (python-mode . display-line-numbers-mode)
  (c-mode . display-line-numbers-mode)
  (c++-mode . display-line-numbers-mode)
  (lisp-mode . display-line-numbers-mode)
  (js-mode . display-line-numbers-mode)
  (java-mode . display-line-numbers-mode)
  )

;; close welcome screen
(setq inhibit-splash-screen t)

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :init
  (set-face-attribute 'mode-line nil :height 100)
  (set-face-attribute 'mode-line-inactive nil :height 100)
  (setq doom-modeline-major-mode-icon t
	doom-modeline-mu4e nil
	doom-modeline-icon (display-graphic-p)
	; Whether display the environment version.
	doom-modeline-env-enable-python t
	)
  (set-fontset-font t 'unicode (font-spec :family "Source Code Pro" :size 20))
  (setq
   doom-font (font-spec :family "Source Code Pro" :size 20 :weight 'regular)
   doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 20)
   doom-unicode-font (font-spec :family "Source Code Pro")
   doom-big-font (font-spec :family "Source Code Pro" :size 20)
   )
  ;; built-in `project' on 26+
  (setq doom-modeline-project-detection 'ffip)

  (use-package nyan-mode
    :ensure t
    :hook (doom-modeline-mode . nyan-mode)
    :init
    (setq nyan-animate-nyancat nil)
    )
  )

;; (use-package awesome-tray
;;   :load-path "~/.emacs.d/plugin/awesome-tray"
;;   :ensure nil
;;   :if (display-graphic-p)
;;   :config
;;   (awesome-tray-mode 1))

;; (use-package whitespace
;;   :init
;;   (dolist (hook '(prog-mode-hook text-mode-hook))
;;     (add-hook hook #'whitespace-mode))
;;   (add-hook 'before-save-hook #'whitespace-cleanup)
;;   (setq whitespace-display-mappings
;;	;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
;;	'(
;;	  (space-mark 32 [183] [46]) ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
;;	  (newline-mark 10 [182 10]) ; LINE FEED,
;;	  (tab-mark 9 [9655 9] [92 9]) ; tab
;;	  ))
;;   :config
;;   (setq whitespace-line-column 80) ;; limit line length
;;   (setq whitespace-style '(face spaces tabs newline space-mark tab-mark newline-mark))
;;   )

(use-package whitespace
  :ensure t
  :init
  (add-hook 'before-save-hook #'whitespace-cleanup))


;; (use-package all-the-icons-ivy
;;   :if (display-graphic-p)
;;   :ensure t
;;   :after ivy
;;   :init
;;   (ivy-set-display-transformer 'ivy-switch-buffer 'all-the-icons-ivy--buffer-transformer)
;;   :config
;;   (all-the-icons-ivy-setup)
;;   (setq all-the-icons-ivy-file-commands
;;	'(counsel-find-file
;;	  counsel-file-jump
;;	  counsel-recentf
;;	  counsel-projectile-find-file
;;	  counsel-projectile-find-dir)))
;; (use-package all-the-icons
;;   :if (display-graphic-p)
;;   :ensure t)

(use-package hl-line
  :ensure nil
  :if (display-graphic-p)
  :hook (after-init . global-hl-line-mode))

(provide 'init-ui)
