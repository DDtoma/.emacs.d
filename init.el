;; config use-package
(require 'package)
(setq package-archives '(("melpa"   . "https://melpa.org/packages/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(setq package-list '(use-package quelpa quelpa-use-package))

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


;; config quelpa
(require 'quelpa)
(require 'quelpa-use-package)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(add-to-list 'load-path "~/.emacs.d/lisp")

(eval-when-compile
  (require 'use-package))

;; Base
(require 'init-const)
(require 'init-env)
(require 'init-func)
(require 'init-base)
(require 'init-org)
(require 'init-edit)
(require 'init-ui)

;; Completion
(require 'init-completion)
(require 'init-lsp)
;; (require 'init-nox)

;; Tools
(require 'init-git)
;; (require 'init-flycheck)
(require 'init-tools)

;; Language
(require 'init-c)
(require 'init-java)
(require 'init-python)
;; (require 'init-json)
(require 'init-keymap)

(require 'init-tmp)
;; (require 'init-eaf)
