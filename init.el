(require 'package)
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))
(package-initialize)

(setq package-list '(
		     ;; Base
		     use-package
		     bind-key exec-path-from-shell
		     ;; Edit
		     smartparens easy-kill-extras
		     ;; Git
		     magit diff-hl
		     ;; Search
		     ag fzf counsel swiper ivy
		     ;; lsp
		     lsp-treemacs lsp-ui lsp-mode
		     ;; Company
		     company company-lsp company-prescient company-box yasnippet yasnippet-snippets
		     ;; Theme UI
		     kaolin-themes
		     ;; Language
		     modern-cpp-font-lock
		     ))

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(add-to-list 'load-path "~/.emacs.d/lisp")

(eval-when-compile
  (require 'use-package))

;; Base
(require 'init-const)
(require 'init-base)
(require 'init-kill)
(require 'init-keymap)
(require 'init-ui)

;; Completion
(require 'init-completion)
(require 'init-lsp)

;; Tools
(require 'init-git)

;; Language
(require 'init-c)
