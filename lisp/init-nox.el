(use-package posframe
  :ensure t)

(use-package nox
  :load-path "~/.emacs.d/plugin/nox"
  :ensure nil
  :config
  (setq nox-python-server 'pyls)
  :hook
  ;; (emacs-lisp-mode . (lambda () (require 'nox) (nox-ensure)))
  ;; (lisp-mode . (lambda () (require 'nox) (nox-ensure)))
  (python-mode . (lambda () (require 'nox) (nox-ensure)))
  )

(provide 'init-nox)
