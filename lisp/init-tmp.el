;; 写入临时配置，测试使用

(use-package memory-usage
  :ensure t)

;; https://github.com/manateelazycat/color-rg
(use-package color-rg
  :defer nil
  :commands (color-rg-search-input)
  :quelpa (color-rg :fetcher github :repo "manateelazycat/color-rg")
  :bind
  (:map isearch-mode-map
        ("M-s M-s" . isearch-toggle-color-rg))
  )

(provide 'init-tmp)
