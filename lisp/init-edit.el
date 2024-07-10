(eval-when-compile
  (require 'init-const))

(use-package avy
  :ensure t
  :bind
  (:map llight//global-map
        ("j j" . avy-goto-char)
        ("j l" . avy-goto-line)))

(use-package paren
  :ensure nil
  :hook (after-init . show-paren-mode)
  :config
  (setq show-paren-when-point-inside-paren t
        show-paren-when-point-in-periphery t))

;; (use-package smartparens
;;   :ensure t
;;   :bind
;;   ("C-c k" . sp-kill-hybrid-sexp)
;;   ("C-c r" . sp-rewrap-sexp)
;;   ("C-c d" . sp-unwrap-sexp)
;;   )

;; https://github.com/hrehfeld/emacs-smart-hungry-delete
(use-package smart-hungry-delete
  :ensure t
  :bind (([remap backward-delete-char-untabify] . smart-hungry-delete-backward-char)
         ([remap delete-backward-char] . smart-hungry-delete-backward-char)
         ([remap delete-char] . smart-hungry-delete-forward-char))
  :init (smart-hungry-delete-add-default-hooks))

;; https://github.com/manateelazycat/color-rg
(use-package color-rg
  :defer nil
  :commands (color-rg-search-input)
  :straight (color-rg :type git :host github :repo "manateelazycat/color-rg")
  :bind
  ("M-s M-s" . isearch-toggle-color-rg)
  )

(use-package nxml-mode
  :ensure nil
  :hook (nxml-mode . emmet-mode)
  :config
  (use-package emmet-mode
    :ensure t)
  )

(provide 'init-edit)
