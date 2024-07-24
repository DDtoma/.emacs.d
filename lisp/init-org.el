(use-package org
  :ensure nil
  :defer nil
  :straight (:type built-in)
  :hook
  ((org-mode . (lambda ()
                 "Beautify Org Checkbox Symbol"
                 ;; (push '("[ ]" . ?☐) prettify-symbols-alist)
                 ;; (push '("[X]" . ?☑) prettify-symbols-alist)
                 ;; (push '("[-]" . ?❍) prettify-symbols-alist)
                 ;; (push '("#+BEGIN_SRC" . ?✎) prettify-symbols-alist)
                 ;; (push '("#+END_SRC" . ?□) prettify-symbols-alist)
                 ;; (push '("#+BEGIN_QUOTE" . ?») prettify-symbols-alist)
                 ;; (push '("#+END_QUOTE" . ?«) prettify-symbols-alist)
                 ;; (push '("#+HEADERS" . ?☰) prettify-symbols-alist)
                 (prettify-symbols-mode 1)))
   (org-indent-mode . (lambda()
                        (diminish 'org-indent-mode)
                        ;; WORKAROUND: Prevent text moving around while using brackets
                        ;; @see https://github.com/seagle0128/.emacs.d/issues/88
                        (make-variable-buffer-local 'show-paren-mode)
                        (setq show-paren-mode nil)))
   )
  :config
  ;; 关闭转译字符下划线 _和^  Non-nil means interpret \"_\" and \"^\" for display.
  (setq-default org-use-sub-superscripts nil)

  (defhydra hydra-global-org (:color blue :hint nil)
    "
Timer^^        ^Clock^         ^Capture^
--------------------------------------------------
s_t_art        _w_ clock in    _c_apture
_s_top        _o_ clock out   _l_ast capture
_r_eset        _j_ clock goto
_p_rint
"
    ("t" org-timer-start)
    ("s" org-timer-stop)
    ;; Need to be at timer
    ("r" org-timer-set-timer)
    ;; Print timer value to buffer
    ("p" org-timer)
    ("w" (org-clock-in '(4)))
    ("o" org-clock-out)
    ;; Visit the clocked task from any buffer
    ("j" org-clock-goto)
    ("c" org-capture)
    ("l" org-capture-goto-last-stored))

  (global-set-key [f11] 'hydra-global-org/body)

  (setq org-agenda-files '("~/Documents/org-roam/")
        org-todo-keywords '((sequence "TODO(t)" "DOING(i)" "HANGUP(h)" "|" "DONE(d)" "CANCEL(c)" "DELAY(D)"))
        org-todo-keyword-faces '(("HANGUP" . warning)
                                 ("❓" . warning))
        org-log-done 'time
        org-catch-invisible-edits 'smart
        org-startup-indented t
        org-ellipsis (if (char-displayable-p ?) " " nil)
        org-pretty-entities t
        org-hide-emphasis-markers t

        ;; 优先级范围和默认任务的优先级
        org-highest-priority ?A
        org-lowest-priority  ?D
        org-default-priority ?D
        org-priority-faces '(
                             (?A . (:background "yellow" :foreground "red" :weight bold))
                             (?B . (:background "DarkOrange" :foreground "white" :weight bold))
                             (?C . (:background "yellow" :foreground "DarkGreen" :weight bold))
                             (?D . (:background "DodgerBlue" :foreground "black" :weight bold))
                             )
        )

  ;; (setq org-capture-templates
  ;;       '(("t" "Todo" entry (file+headline "~/Documents/Note/gtd.org" "Tasks")
  ;;          "* TODO %?\n %i\n %a")
  ;;         ("j" "Journal" entry (file+datetree "~/Documents/Note/journal.org")
  ;;          "* %?\nEntered on %U\n %i\n %a")
  ;;         ("i" "Checkitem" checkitem (file+headline "~/Documents/Note/gtd.org" "ItemBox")
  ;;          "[ ] %?\n - [ ] Enter Item\n\n %U\n")))
  )

(use-package org-modern
  :ensure t
  :after org
  :init
  (add-hook 'org-mode-hook #'org-modern-mode)
  (add-hook 'org-agenda-finalize-hook #'org-modern-agenda)

  (setq
   ;; Edit settings
   org-auto-align-tags nil
   org-tags-column 0
   org-catch-invisible-edits 'show-and-error
   org-special-ctrl-a/e t
   org-insert-heading-respect-content t

   ;; Org styling, hide markup etc.
   org-hide-emphasis-markers t
   org-pretty-entities t

   ;; Agenda styling
   org-agenda-tags-column 0
   org-agenda-block-separator ?─
   org-agenda-time-grid
   '((daily today require-timed)
     (300 600 900 1200 1500 1800 2100 2400)
     " ┄┄┄┄┄ "
     "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
   org-agenda-current-time-string
   "◀── now ─────────────────────────────────────────────────")
  )

(use-package org-modern-indent
  :straight (org-modern-indent :type git :host github :repo "jdtsmith/org-modern-indent")
  :init ; add late to hook
  (add-hook 'org-mode-hook #'org-modern-indent-mode 90))

(use-package org-roam
  :ensure t
  :defer nil
  ;; :custom
  ;; (setq org-roam-directory (file-truename "~/Documents/org-roam"))
  :config
  (setq org-roam-directory (file-truename "~/Documents/org-roam/"))
  (setq find-file-visit-truename t)
  (setq org-roam-database-connector 'sqlite-builtin)
  (setq org-roam-mode-sections
      (list #'org-roam-backlinks-section
            #'org-roam-reflinks-section
            #'org-roam-unlinked-references-section))
  (org-roam-db-autosync-mode)
  (require 'org-roam-protocol)

  ;; todo: 编写一个函数将当天前5天和后三天的daily文件加入agenda当中
  ;; (add-to-list 'org-agenda-files "")
  ;; (setq org-roam-daily-path (concat org-roam-directory "daily"))
  ;; (calendar-current-date)
  ;; (directory-files org-roam-daily-path t "2024-07-.*\.org")

  )

(use-package org-roam-ui
  :straight (:host github :repo "org-roam/org-roam-ui" :branch "main" :files ("*.el" "out"))
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start nil))

(use-package llight//org-keymap
  :ensure nil
  :autoload (org-agenda
             org-roam-capture
             org-roam-node-find
             org-roam-node-insert
             org-roam-dailies-capture-today
             org-roam-dailies-goto-today
             org-roam-ui-open
             )
  :bind
  ("C-c o a" . org-agenda)
  ("C-c o b" . org-switchb)
  ("C-c o c" . org-capture)
  (:map llight//global-map
        :prefix-map @org
        :prefix "o"
        ("I" .  org-insert-link)
        ("a" . org-agenda)
        ("," . org-insert-structure-template)
        ("l" . org-roam-buffer-toggle)
        ("f" . org-roam-node-find)
        ("i" . org-roam-node-insert)
        ("c" . org-roam-capture)
        ("j" . org-roam-dailies-capture-today)
        ("t" . org-roam-dailies-goto-today)
        ("o" . org-roam-ui-open)
        )
  )

(provide 'init-org)
