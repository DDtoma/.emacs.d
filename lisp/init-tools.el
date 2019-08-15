(use-package which-key
  :ensure t
  :init
  (setq which-key-idle-delay 0.3)
  :bind (:map help-map ("C-h" . which-key-C-h-dispatch))
  :hook (after-init . which-key-mode))

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

(use-package sudo-edit
  :ensure t)

(use-package helpful
  :ensure t
  :defines ivy-initial-inputs-alist
  :after ivy
  :bind
  (:map llight//global-map
	("h p" . helpful-at-point))
  :config
  (with-eval-after-load 'ivy
    (dolist (cmd '(helpful-callable
		   helpful-variable
		   helpful-function
		   helpful-macro
		   helpful-command))
      (cl-pushnew `(,cmd . "^") ivy-initial-inputs-alist))))

(provide 'init-tools)
