(require 'package)
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))
(package-initialize)

(setq package-list '(use-package smartparens diff-hl magit ag fzf counsel swiper ivy lsp-treemacs lsp-ui company-lsp company lsp-mode kaolin-themes bind-key modern-cpp-font-lock exec-path-from-shell yasnippet company-prescient company-box easy-kill-extras))

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(add-to-list 'load-path "~/.emacs.d/lisp")

(eval-when-compile
  (require 'use-package))

(require 'init-const)
(require 'init-base)
(require 'init-kill)
(require 'init-keymap)
(require 'init-ui)
(require 'init-completion)
(require 'init-lsp)
(require 'init-git)

;; Language
(require 'init-c)
