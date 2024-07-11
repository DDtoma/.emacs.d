(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

(use-package popon
  :straight (popon :type git :url "https://codeberg.org/akib/emacs-popon.git"))

(use-package lsp-bridge
  :straight (lsp-bridge
            :type git
            :host github
            :repo "manateelazycat/lsp-bridge"
            :files (:defaults "*.el" "*.py" "acm" "core" "langserver" "multiserver" "resources")
            :build (:not compile))
  ;; :init (global-lsp-bridge-mode)
  :config
  (setq acm-enable-capf t)
  (setq acm-enable-quick-access t)
  (require 'avy)
  (defun lsp-bridge-avy-peek ()
    "Peek any symbol in the file by avy jump."
    (interactive)
    (setq lsp-bridge-peek-ace-list (make-list 5 nil))
    (setf (nth 1 lsp-bridge-peek-ace-list) (point))
    (setf (nth 2 lsp-bridge-peek-ace-list) (buffer-name))
    (save-excursion
      (call-interactively 'avy-goto-word-0)
      (lsp-bridge-peek)
      (setf (nth 3 lsp-bridge-peek-ace-list) (buffer-name))
      (setf (nth 4 lsp-bridge-peek-ace-list) (point))))
  )

(use-package acm-terminal
  :if (not (display-graphic-p))
  ;; :quelpa (acm-terminal
  ;;          :fetcher github
  ;;          :repo "twlz0ne/acm-terminal")
  :straight (acm-terminal :type git :host github :repo "twlz0ne/acm-terminal")
  :init (unless (package-installed-p 'yasnippet)
          (package-install 'yasnippet))
  )

(use-package treesit-auto
  :ensure t
  :init
  (setq treesit-font-lock-level 4)
  (add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))
  :config
  (setq treesit-auto-install 'prompt)
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode)
  )

(use-package llight//lsp-keymap
  :ensure nil
  :bind
  (:map markdown-mode-map
        ("C-c C-e" . markdown-do)
        :map lsp-bridge-mode-map
        ("M-," . lsp-bridge-find-def-return)
        ("M-." . lsp-bridge-find-def)
        :map llight//global-map
        :prefix-map @lsp
        :prefix "l"
        ("p" . lsp-bridge-avy-peek)
        ("r" . lsp-bridge-find-references))
  )

(provide 'init-lsp)
