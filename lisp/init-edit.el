;; https://github.com/magnars/multiple-cursors.el
(use-package multiple-cursors
  :ensure t
  :config
  (define-key mc/keymap (kbd "<return>") nil)
  (setq mc/cmds-to-run-for-all
	'(
	  sp-kill-hybrid-sexp
	  sp-rewrap-sexp
	  easy-mark-sexp
	  sp-unwrap-sexp
	  electric-pair-delete-pair
	  ))
  :bind
  ;;("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C-<" . mc/mark-all-like-this))

(use-package smartparens
  :ensure t
  :bind
  ("C-c k" . sp-kill-hybrid-sexp)
  ("C-c r" . sp-rewrap-sexp)
  ("C-c d" . sp-unwrap-sexp)
  )

;; https://github.com/leoliu/easy-kill
;; https://github.com/knu/easy-kill-extras.el
(use-package easy-kill-extras
  :bind (([remap kill-ring-save] . easy-kill)
	 ([remap mark-sexp] . easy-mark-sexp)
	 ([remap mark-word] . easy-mark-word)

	 ;; Integrate `zap-to-char'
	 ([remap zap-to-char] . easy-mark-to-char)
	 ([remap zap-up-to-char] . easy-mark-up-to-char)

	 ;; Integrate `expand-region'
	 :map easy-kill-base-map
	 ("o" . easy-kill-er-expand)
	 ("i" . easy-kill-er-unexpand))
  :init (setq kill-ring-max 200
	      save-interprogram-paste-before-kill t ; Save clipboard contents before replacement
	      easy-kill-alist '((?w word           " ")
				(?s sexp           "\n")
				(?l list           "\n")
				(?f filename       "\n")
				(?d defun          "\n\n")
				(?D defun-name     " ")
				(?e line           "\n")
				(?b buffer-file-name)

				(?^ backward-line-edge "")
				(?$ forward-line-edge "")
				(?h buffer "")
				(?< buffer-before-point "")
				(?> buffer-after-point "")
				(?f string-to-char-forward "")
				(?F string-up-to-char-forward "")
				(?t string-to-char-backward "")
				(?T string-up-to-char-backward ""))))

(use-package hungry-delete
  :ensure t
  :config (global-hungry-delete-mode))

(provide 'init-edit)
