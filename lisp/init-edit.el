;; https://github.com/magnars/multiple-cursors.el
(use-package multiple-cursors
  :ensure t
  :config
  (define-key mc/keymap (kbd "<return>") nil)
  (setq mc/cmds-to-run-for-all
	'(
	  sp-rewrap-sexp
	  ))
  :bind
  ;;("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C-<" . mc/mark-all-like-this))

;; (use-package smartparens
;;   :init
;;   ;; (show-smartparens-global-mode t)
;;   (sp-local-pair '(emacs-lisp-mode) "'" "'" :actions nil)
;;   ;; :hook
;;   ;; (prog-mode . turn-on-smartparens-strict-mode)
;;   :bind
;;   (:map llight//global-map
;;	("e p" . sp-rewrap-sexp))

;;   )

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

(provide 'init-edit)
