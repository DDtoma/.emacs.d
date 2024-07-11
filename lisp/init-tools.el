(use-package which-key
  :ensure t
  :init
  (setq which-key-idle-delay 0.3)
  :hook (after-init . which-key-mode)
  )

(use-package sudo-edit
  :ensure t)

(use-package helpful
  :ensure t)

(use-package web-search
  :ensure t
  :if (display-graphic-p)
  )

(use-package youdao-dictionary
  :ensure t
  :config
  (setq youdao-dictionary-app-key "649f058f9b9b0472"
        youdao-dictionary-secret-key "vygjnzLXI1piI4bXeCr8GOE7TsXl1vBs"
        url-automatic-caching t)
  )

(use-package memory-usage
  :ensure t)

(use-package avy
  :ensure t)

(use-package llight//tools-keymap
  :ensure nil
  :after youdao-dictionary helpful avy
  :bind
  (:map llight//global-map
        :prefix-map @tools
        :prefix "t"
        ("p" . youdao-dictionary-search-at-point-posframe)
        ("v" . youdao-dictionary-play-voice-at-point)
        ("s" . web-search)
        :prefix-map @help
        :prefix "h"
        ("p" . helpful-at-point)
        ("C" . helpful-callable)
        ("v" . helpful-variable)
        ("f" . helpful-function)
        ("m" . helpful-macro)
        ("c" . helpful-command)
        ("k" . helpful-key)
        :prefix-map @jump
        :prefix "j"
        ("j" . avy-goto-char)
        ("l" . avy-goto-line)
        ))

(provide 'init-tools)
