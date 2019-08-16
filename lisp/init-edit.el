(eval-when-compile
  (require 'init-const))

(use-package avy
  :ensure t
  :bind
  (:map llight//global-map
	("j j" . avy-goto-char)
	("j l" . avy-goto-line)))

(use-package awesome-pair
  :load-path "~/.emacs.d/plugin/awesome-pair"
  :ensure nil
  :hook
  (emacs-lisp-mode . awesome-pair-mode)
  (c-mode-common . awesome-pair-mode)
  (c-mode . awesome-pair-mode)
  (c++-mode . awesome-pair-mode)
  (java-mode . awesome-pair-mode)
  (haskell-mode . awesome-pair-mode)
  (emacs-lisp-mode . awesome-pair-mode)
  (lisp-interaction-mode . awesome-pair-mode)
  (lisp-mode . awesome-pair-mode)
  (maxima-mode . awesome-pair-mode)
  (ielm-mode . awesome-pair-mode)
  (sh-mode . awesome-pair-mode)
  (makefile-gmake-mode . awesome-pair-mode)
  (php-mode . awesome-pair-mode)
  (python-mode . awesome-pair-mode)
  (js-mode . awesome-pair-mode)
  (go-mode . awesome-pair-mode)
  (qml-mode . awesome-pair-mode)
  (jade-mode . awesome-pair-mode)
  (css-mode . awesome-pair-mode)
  (ruby-mode . awesome-pair-mode)
  (coffee-mode . awesome-pair-mode)
  (rust-mode . awesome-pair-mode)
  (qmake-mode . awesome-pair-mode)
  (lua-mode . awesome-pair-mode)
  (swift-mode . awesome-pair-mode)
  (minibuffer-inactive-mode . awesome-pair-mode)
  :bind
  (:map awesome-pair-mode-map
	("(" . awesome-pair-open-round)
	("[" . awesome-pair-open-bracket)
	("{" . awesome-pair-open-curly)
	(")" . awesome-pair-close-round)
	("]" . awesome-pair-close-bracket)
	("}" . awesome-pair-close-curly)
	("=" . awesome-pair-equal)
	("%" . awesome-pair-match-paren)
	("\"" . awesome-pair-double-quote)
	("SPC" . awesome-pair-space)
	("M-o" . awesome-pair-backward-delete)
	("C-d" . awesome-pair-forward-delete)
	("C-k" . awesome-pair-kill)
	("M-\"" . awesome-pair-wrap-double-quote)
	("M-[" . awesome-pair-wrap-bracket)
	("M-{" . awesome-pair-wrap-curly)
	("M-(" . awesome-pair-wrap-round)
	("M-)" . awesome-pair-unwrap)
	("M-p" . awesome-pair-jump-right)
	("M-n" . awesome-pair-jump-left)
	("M-:" . awesome-pair-jump-out-pair-and-newline)))

;; https://github.com/magnars/multiple-cursors.el
(use-package multiple-cursors
  :ensure t
  :config
  (define-key mc/keymap (kbd "<return>") nil)
  (setq mc/cmds-to-run-for-all
	'(
	  sp-kill-hybrid-sexp
	  sp-rewrap-sexp
	  easy-mark-sexp
	  sp-unwrap-sexp
	  electric-pair-delete-pair
	  hungry-delete-backward
	  hungry-delete-forward
	  ))
  :bind
  ;;("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C-<" . mc/mark-all-like-this))

;; (use-package smartparens
;;   :ensure t
;;   :bind
;;   ("C-c k" . sp-kill-hybrid-sexp)
;;   ("C-c r" . sp-rewrap-sexp)
;;   ("C-c d" . sp-unwrap-sexp)
;;   )

;; https://github.com/leoliu/easy-kill
;; https://github.com/knu/easy-kill-extras.el
(use-package easy-kill
  :ensure t
  :if (or sys/mac-x-p sys/linux-x-p))

(use-package easy-kill-extras
  :ensure t
  :if (display-graphic-p)
  :after easy-kill
  :bind (([remap kill-ring-save] . easy-kill)
	 ([remap mark-sexp] . easy-mark-sexp)
	 ([remap mark-word] . easy-mark-word)

	 ;; Integrate `zap-to-char'
	 ([remap zap-to-char] . easy-mark-to-char)
	 ([remap zap-up-to-char] . easy-mark-up-to-char)

	 ;; Integrate `expand-region'
	 :map easy-kill-base-map
	 ("o" . easy-kill-er-expand)
	 ("i" . easy-kill-er-unexpand))
  :init (setq kill-ring-max 200
	      save-interprogram-paste-before-kill t ; Save clipboard contents before replacement
	      easy-kill-alist '((?w word           " ")
				(?s sexp           "\n")
				(?l list           "\n")
				(?f filename       "\n")
				(?d defun          "\n\n")
				(?D defun-name     " ")
				(?e line           "\n")
				(?b buffer-file-name)
				(?^ backward-line-edge "")
				(?$ forward-line-edge "")
				(?h buffer "")
				(?< buffer-before-point "")
				(?> buffer-after-point "")
				(?f string-to-char-forward "")
				(?F string-up-to-char-forward "")
				(?t string-to-char-backward "")
				(?T string-up-to-char-backward ""))))

(use-package hungry-delete
  :ensure t
  :bind
  ("M-|" . hungry-delete-backward))

(provide 'init-edit)
