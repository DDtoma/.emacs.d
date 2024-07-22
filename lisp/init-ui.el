(eval-when-compile
  (require 'init-const)
  (require 'init-func)
  (require 'init-custom)
  )

;; set default font size
;; (set-face-attribute 'default nil :height 120)

;; (when (eq system-type 'gnu/linux)
;;      (setq fonts '("Sarasa Nerd Font" "Sarasa Nerd Font"))
;;      (set-face-attribute 'default nil :font
;;			(format "%s:pixelsize=%d" (car fonts) 20))
;;      (setq face-font-rescale-alist '(("Sarasa Nerd Font". 1.0))))

;; (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;      (set-fontset-font (frame-parameter nil 'font) charset
;;			(font-spec :family (car (cdr fonts)))))

;; setup frame size in system desktop
(when (display-graphic-p)
  (if (eq system-type 'windows-nt)
	  (llight//set-windows-size-windows)
    (llight//set-windows-size-unix))
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (scroll-bar-mode 0))

;; Fullscreen
;; WORKAROUND: To address blank screen issue with child-frame in fullscreen
(when (and sys/mac-x-p emacs/>=26p)
  (setq ns-use-native-fullscreen nil))

;;(global-display-line-numbers-mode)
(use-package display-line-numbers
  :ensure nil
  :defer nil
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

;; (use-package hl-line
;;   :ensure nil
;;   :defer nil
;;   :when llight-hl-active
;;   :if (display-graphic-p)
;;   :hook ((after-init . global-hl-line-mode)
;;          ((dashboard-mode eshell-mode shell-mode term-mode vterm-mode) .
;;           (lambda () (setq-local global-hl-line-mode nil))))
;;   :config
;;   (set-face-background hl-line-face "gray44")
;;   )

(use-package ef-themes
  :ensure t
  :config
  (load-theme 'ef-elea-light)
  )

(provide 'init-ui)
