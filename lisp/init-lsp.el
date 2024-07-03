(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do)))

(use-package popon
  :quelpa (popon
           :fetcher git
           :url "https://codeberg.org/akib/emacs-popon.git"))

(use-package lsp-bridge
  :quelpa (lsp-bridge
           :fetcher github
           :repo "manateelazycat/lsp-bridge"
           :files (:defaults "*.el" "*.py" "acm" "core" "langserver" "multiserver" "resources")
           :build (:not compile))
  ;; :init
  ;; (global-lsp-bridge-mode)
  )

(use-package acm-terminal
  :if (not (display-graphic-p))
  :quelpa (acm-terminal
           :fetcher github
           :repo "twlz0ne/acm-terminal")
  :init (unless (package-installed-p 'yasnippet)
          (package-install 'yasnippet))
  )



(provide 'init-lsp)
