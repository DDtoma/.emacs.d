(require 'cc-mode)

;; (use-package lsp-java
;;   :ensure t
;;   :after lsp
;;   :config
;;   (add-hook 'java-mode-hook 'lsp)
;;   (add-hook 'lsp-mode-hook #'lsp-lens-mode)
;;   (add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)
;;   (setq lsp-java-vmargs '("-javaagent:\"~/.emacs.d/.cache/lombok.jar\"" "-noverify" "-Xmx1G" "-XX:+UseG1GC" "-XX:+UseStringDeduplication"))
;;   )

;; (use-package dap-mode
;;   :ensure t
;;   :after lsp-mode
;;   :config
;;   (dap-mode t)
;;   (dap-ui-mode t))

;; (use-package dap-java :after (dap-mode))

(require 'lsp-bridge-jdtls) ;; 根据项目自动生成自定义配置，添加必要的启动参数
(setq lsp-bridge-enable-auto-import t) ;; 开启自动导入依赖，目前没有code action。补全时可以通过这个导入相应的依赖，建议开启。
(setq lsp-bridge-jdtls-jvm-args '("-javaagent:/home/llight/.m2/repository/org/projectlombok/lombok/1.18.22/lombok-1.18.22.jar"))

(defun my-lsp-bridge-workspace (proj)
  (let* ((proj-2-workspace
          '(("/home/user/projects/workspace1/proj1" .
             "file:///home/user/projects/workspace1/")
            ("/home/user/projects/workspace2/proj2" .
             "file:///home/user/projects/workspace2/")))
         (kv (assoc proj proj-2-workspace)))
    (when kv
        (cdr kv))))

(custom-set-variables '(lsp-bridge-get-workspace-folder 'my-lsp-bridge-workspace))

(add-hook 'java-mode-hook (lambda ()
                            (setq-local lsp-bridge-get-lang-server-by-project 'lsp-bridge-get-jdtls-server-by-project)))

(provide 'init-java)
