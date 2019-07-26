(global-display-line-numbers-mode)
;; (setq make-backup-files nil)
;; (setq auto-save-default nil)
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

(defun my-backup-file-name (fpath)
  "Return a new file path of a given file path.
If the new path's directories does not exist, create them."
  (let* (
        (backupRootDir "~/.emacs.d/backup/")
        (filePath (replace-regexp-in-string "[A-Za-z]:" "" fpath )) ; remove Windows driver letter in path, for example, “C:”
        (backupFilePath (replace-regexp-in-string "//" "/" (concat backupRootDir filePath "~") ))
        )
    (make-directory (file-name-directory backupFilePath) (file-name-directory backupFilePath))
    backupFilePath
  )
  )

(setq make-backup-file-name-function 'my-backup-file-name)

(global-unset-key (kbd "C-j"))

(use-package treemacs
  :bind (("C-c t" . treemacs)))

(use-package ivy
  :ensure t
  :init
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  :bind
  (("C-c c" . avy-goto-char)
   ("C-c l" . avy-goto-line))
  )

(use-package all-the-icons-ivy
  :ensure t
  :init
  (ivy-set-display-transformer 'ivy-switch-buffer 'all-the-icons-ivy--buffer-transformer))

(use-package swiper
  :bind
  (("\C-s" . swiper))
  )

(use-package counsel
  :init
  (global-unset-key (kbd "C-j"))
  :bind
  (("C-c f" . counsel-fzf)
   ("C-c C-r" . counsel-recentf)
   ("C-x C-b" . counsel-ibuffer))
  )

(use-package smartparens
  :init 
  (show-smartparens-global-mode t)
  (sp-local-pair '(emacs-lisp-mode) "'" "'" :actions nil)
  :hook
  (prog-mode . turn-on-smartparens-strict-mode)
  )



(provide 'init-base)
