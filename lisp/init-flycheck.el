(eval-when-compile
  (require 'init-const))

(use-package flycheck
  :ensure t
  :if (display-graphic-p)
  :hook (after-init . global-flycheck-mode)
  :config
  (setq flycheck-emacs-lisp-load-path 'inherit)
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

  ;; Only check while saving and opening files
  (setq flycheck-check-syntax-automatically '(save mode-enabled))

  ;; Set fringe style
  (setq flycheck-indication-mode 'right-fringe)
  (when (fboundp 'define-fringe-bitmap)
    (define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
      [16 48 112 240 112 48 16] nil nil 'center))

  ;; Display Flycheck errors in GUI tooltips
  ;; (if (display-graphic-p)
  ;;     (if emacs/>=26p
  ;;	  (use-package flycheck-posframe
  ;;	    :ensure t
  ;;	    :hook (flycheck-mode . flycheck-posframe-mode)
  ;;	    :config (add-to-list 'flycheck-posframe-inhibit-functions
  ;;				 #'(lambda () (bound-and-true-p company-backend))))
  ;;	(use-package flycheck-pos-tip
  ;;	  :ensure t
  ;;	  :defines flycheck-pos-tip-timeout
  ;;	  :hook (global-flycheck-mode . flycheck-pos-tip-mode)
  ;;	  :config (setq flycheck-pos-tip-timeout 30)))
  ;;   (use-package flycheck-popup-tip
  ;;     :ensure t
  ;;     :hook (flycheck-mode . flycheck-popup-tip-mode)))
  )

(provide 'init-flycheck)
