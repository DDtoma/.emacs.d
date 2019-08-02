(require 'package)
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			 ("melpa" . "http://elpa.emacs-china.org/melpa/")))
(package-initialize)

(setq package-list '(use-package))

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
(require 'init-func)
(require 'init-base)
(require 'init-edit)
(require 'init-ui)

;; Completion
(require 'init-completion)
(require 'init-lsp)

;; Tools
(require 'init-git)
(require 'init-tools)

;; Language
(require 'init-c)
(require 'init-java)

(require 'init-keymap)
