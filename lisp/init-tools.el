(use-package which-key
  :ensure t
  :init
  (setq which-key-idle-delay 0.3)
  :bind (:map help-map ("C-h" . which-key-C-h-dispatch))
  :hook (after-init . which-key-mode))

;; (use-package snails
;;   :if (display-graphic-p)
;;   :quelpa (snails :fetcher github :repo "manateelazycat/snails")
;;   :config
;;   (push 'snails snails-backend-imenu)
;;   (push 'snails snails-backend-rg)	;ripgrep
;;   (when (eq system-type 'darwin)
;;     (push 'snails snails-backend-mdfind))
;;   (when (eq system-type 'windows-nt)
;;     (push 'snails snails-backend-everything))
;;   :bind (:map llight//global-map
;; 	      ("S s" . snails)
;; 	      ("S p" . snails-search-point)))

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

(use-package web-search
  :ensure t
  :if (display-graphic-p)
  :bind
  (:map llight//global-map ("t s" . web-search)))

(use-package youdao-dictionary
  :ensure t
  :config
  (setq youdao-dictionary-app-key "649f058f9b9b0472"
        youdao-dictionary-secret-key "vygjnzLXI1piI4bXeCr8GOE7TsXl1vBs"
        url-automatic-caching t)
  :bind
  (:map llight//global-map
        ("d p" . youdao-dictionary-search-at-point-posframe)
        ("d v" . youdao-dictionary-play-voice-at-point)))


(use-package memory-usage
  :ensure t)

(provide 'init-tools)
