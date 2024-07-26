(when (version< emacs-version "27.1")
  (error "This requires Emacs 27.1 and above!"))

;; Load path
;; Optimize: Force "lisp"" and "site-lisp" at the head to reduce the startup time.
(defun update-load-path (&rest _)
  "Update `load-path'."
  (dolist (dir '("site-lisp" "lisp"))
    (push (expand-file-name dir user-emacs-directory) load-path)))

(defun add-subdirs-to-load-path (&rest _)
  "Add subdirectories to `load-path'.

Don't put large files in `site-lisp' directory, e.g. EAF.
Otherwise the startup will be very slow."
  (let ((default-directory (expand-file-name "site-lisp" user-emacs-directory)))
    (normal-top-level-add-subdirs-to-load-path)))

(advice-add #'package-initialize :after #'update-load-path)
(advice-add #'package-initialize :after #'add-subdirs-to-load-path)

(update-load-path)

;; Base
(require 'init-const)
(require 'init-custom)
(require 'init-env)
(require 'init-func)
(require 'init-package)
(require 'init-base)

(require 'init-edit)
(require 'init-org)
(require 'init-ui)

;; project Completion
(require 'init-project)
(require 'init-completion)
(require 'init-lsp)

;; Tools
(require 'init-git)
;; (require 'init-flycheck)
(require 'init-tools)

;; Language
(require 'init-c)
(require 'init-web)
;; (require 'init-java)
(require 'init-python)
;; (require 'init-json)
(require 'init-keymap)

(require 'init-tmp)
;; (require 'init-eaf)
