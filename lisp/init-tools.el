(use-package which-key
  :ensure t
  :init
  (setq which-key-idle-delay 0.3)
  :bind (:map help-map ("C-h" . which-key-C-h-dispatch))
  :hook (after-init . which-key-mode)
  )

(use-package avy
  :ensure t
  :bind
  (:map llight//global-map
	("j j" . avy-goto-char)
	("j l" . avy-goto-line)))



(use-package snails
  :if (display-graphic-p)
  :load-path "~/.emacs.d/plugin/snails"
  :config
  (push 'snails snails-backend-imenu)
  (push 'snails snails-backend-rg)	;ripgrep
  (when (eq system-type 'darwin)
    (push 'snails snails-backend-mdfind))
  (when (eq system-type 'windows-nt)
    (push 'snails snails-backend-everything))
  :bind (:map llight//global-map
	      ("S s" . snails)
	      ("S p" . snails-search-point)))


(use-package awesome-pair
  :load-path "~/.emacs.d/plugin/awesome-pair"
  :ensure nil
  :hook
  (emacs-lisp-mode . awesome-pair-mode)
  (c-mode-common-hook . awesome-pair-mode)
  (c-mode-hook . awesome-pair-mode)
  (c++-mode-hook . awesome-pair-mode)
  (java-mode-hook . awesome-pair-mode)
  (haskell-mode-hook . awesome-pair-mode)
  (emacs-lisp-mode-hook . awesome-pair-mode)
  (lisp-interaction-mode-hook . awesome-pair-mode)
  (lisp-mode-hook . awesome-pair-mode)
  (maxima-mode-hook . awesome-pair-mode)
  (ielm-mode-hook . awesome-pair-mode)
  (sh-mode-hook . awesome-pair-mode)
  (makefile-gmake-mode-hook . awesome-pair-mode)
  (php-mode-hook . awesome-pair-mode)
  (python-mode-hook . awesome-pair-mode)
  (js-mode-hook . awesome-pair-mode)
  (go-mode-hook . awesome-pair-mode)
  (qml-mode-hook . awesome-pair-mode)
  (jade-mode-hook . awesome-pair-mode)
  (css-mode-hook . awesome-pair-mode)
  (ruby-mode-hook . awesome-pair-mode)
  (coffee-mode-hook . awesome-pair-mode)
  (rust-mode-hook . awesome-pair-mode)
  (qmake-mode-hook . awesome-pair-mode)
  (lua-mode-hook . awesome-pair-mode)
  (swift-mode-hook . awesome-pair-mode)
  (minibuffer-inactive-mode-hook . awesome-pair-mode)
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
	("M-:" . awesome-pair-jump-out-pair-and-newline)
	)
  )

(provide 'init-tools)
