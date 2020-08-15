(use-package org
  :ensure nil
  :bind
  (("C-c a" . org-agenda)
	 ("C-c b" . org-switchb)
	 :map org-mode-map
	 ("<" . (lambda ()
		  "Insert org template."
		  (interactive)
		  (if (or (region-active-p) (looking-back "^\s*" 1))
		      (org-hydra/body)
		    (self-insert-command 1)))))
  :hook
  ((org-mode . (lambda ()
		       "Beautify Org Checkbox Symbol"
		       (push '("[ ]" . ?☐) prettify-symbols-alist)
		       (push '("[X]" . ?☑) prettify-symbols-alist)
		       (push '("[-]" . ?❍) prettify-symbols-alist)
		       (push '("#+BEGIN_SRC" . ?✎) prettify-symbols-alist)
		       (push '("#+END_SRC" . ?□) prettify-symbols-alist)
		       (push '("#+BEGIN_QUOTE" . ?») prettify-symbols-alist)
		       (push '("#+END_QUOTE" . ?«) prettify-symbols-alist)
		       (push '("#+HEADERS" . ?☰) prettify-symbols-alist)
		       (prettify-symbols-mode 1)))
   (org-indent-mode . (lambda()
			(diminish 'org-indent-mode)
			;; WORKAROUND: Prevent text moving around while using brackets
			;; @see https://github.com/seagle0128/.emacs.d/issues/88
			(make-variable-buffer-local 'show-paren-mode)
			((save-excursion)tq show-paren-mode nil)))
   )
  :config
  (setq org-agenda-files '("/home/llight/Documents/Note")
	org-todo-keywords '((sequence "TODO(t)" "DOING(i)" "HANGUP(h)" "|" "DONE(d)" "CANCEL(c)"))
	org-todo-keyword-faces '(("HANGUP" . warning)
				 ("❓" . warning))
	org-log-done 'time
	org-catch-invisible-edits 'smart
	org-startup-indented t
	org-ellipsis (if (char-displayable-p ?) "  " nil)
	org-pretty-entities t
	org-hide-emphasis-markers t)

  (setq org-capture-templates
	 '(("t" "Todo" entry (file+headline "/home/llight/Documents/Note/gtd.org" "Tasks")
	    "* TODO %?\n %i\n %a")
	   ("j" "Journal" entry (file+datetree "/home/llight/Documents/Note/journal.org")
	    "* %?\nEntered on %U\n %i\n %a")
	   ("i" "Checkitem" checkitem (file+headline "/home/llight/Documents/Note/gtd.org" "ItemBox")
	    "[ ] %?\n - [ ] Enter Item\n\n %U\n")
	   ))
  ;; markdown backend
  ;; (add-to-list 'org-export-backends 'md)
  )


(provide 'init-org)
