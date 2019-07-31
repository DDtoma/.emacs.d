(defun xah-delete-backward-char-or-bracket-text ()
  (interactive)
  (if (and delete-selection-mode (region-active-p))
      (delete-region (region-beginning) (region-end))
    (cond
     ((looking-back "\\s)" 1)
      (if current-prefix-arg
	  (xah-delete-backward-bracket-pair)
	(xah-delete-backward-bracket-text)))
     ((looking-back "\\s(" 1)
      (progn
	(backward-char)
	(forward-sexp)
	(if current-prefix-arg
	    (xah-delete-backward-bracket-pair)
	  (xah-delete-backward-bracket-text))))
     ((looking-back "\\s\"" 1)
      (if (nth 3 (syntax-ppss))
	  (progn
	    (backward-char )
	    (xah-delete-forward-bracket-pairs (not current-prefix-arg)))
	(if current-prefix-arg
	    (xah-delete-backward-bracket-pair)
	  (xah-delete-backward-bracket-text))))
     (t
      (delete-char -1)))))

(defun xah-delete-backward-bracket-text ()
  (interactive)
  (progn
    (forward-sexp -1)
    (mark-sexp)
    (kill-region (region-beginning) (region-end))))

(defun xah-delete-backward-bracket-pair ()
  (interactive)
  (let (( $p0 (point)) $p1)
    (forward-sexp -1)
    (setq $p1 (point))
    (goto-char $p0)
    (delete-char -1)
    (goto-char $p1)
    (delete-char 1)
    (push-mark (point) t)
    (goto-char (- $p0 2))))

(defun xah-delete-forward-bracket-pairs ( &optional @delete-inner-text-p)
  (interactive)
  (if @delete-inner-text-p
      (progn
	(mark-sexp)
	(kill-region (region-beginning) (region-end)))
    (let (($pt (point)))
      (forward-sexp)
      (delete-char -1)
      (push-mark (point) t)
      (goto-char $pt)
      (delete-char 1))))

(defun xah-insert-bracket-pair (@left-bracket @right-bracket &optional @wrap-method)
  (if (use-region-p)
      (progn ; there's active region
	(let (
	      ($p1 (region-beginning))
	      ($p2 (region-end)))
	  (goto-char $p2)
	  (insert @right-bracket)
	  (goto-char $p1)
	  (insert @left-bracket)
	  (goto-char (+ $p2 2))))
    (progn ; no text selection
      (let ($p1 $p2)
	(cond
	 ((eq @wrap-method 'line)
	  (setq $p1 (line-beginning-position) $p2 (line-end-position))
	  (goto-char $p2)
	  (insert @right-bracket)
	  (goto-char $p1)
	  (insert @left-bracket)
	  (goto-char (+ $p2 (length @left-bracket))))
	 ((eq @wrap-method 'block)
	  (save-excursion
	    (progn
	      (if (re-search-backward "\n[ \t]*\n" nil 'move)
		  (progn (re-search-forward "\n[ \t]*\n")
			 (setq $p1 (point)))
		(setq $p1 (point)))
	      (if (re-search-forward "\n[ \t]*\n" nil 'move)
		  (progn (re-search-backward "\n[ \t]*\n")
			 (setq $p2 (point)))
		(setq $p2 (point))))
	    (goto-char $p2)
	    (insert @right-bracket)
	    (goto-char $p1)
	    (insert @left-bracket)
	    (goto-char (+ $p2 (length @left-bracket)))))
	 ( ;  do line. line must contain space
	  (and
	   (eq (point) (line-beginning-position))
	   ;; (string-match " " (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
	   (not (eq (line-beginning-position) (line-end-position))))
	  (insert @left-bracket )
	  (end-of-line)
	  (insert  @right-bracket))
	 ((and
	   (or ; cursor is at end of word or buffer. i.e. xyz▮
	    (looking-at "[^-_[:alnum:]]")
	    (eq (point) (point-max)))
	   (not (or
		 (string-equal major-mode "xah-elisp-mode")
		 (string-equal major-mode "emacs-lisp-mode")
		 (string-equal major-mode "lisp-mode")
		 (string-equal major-mode "lisp-interaction-mode")
		 (string-equal major-mode "common-lisp-mode")
		 (string-equal major-mode "clojure-mode")
		 (string-equal major-mode "xah-clojure-mode")
		 (string-equal major-mode "scheme-mode"))))
	  (progn
	    (setq $p1 (point) $p2 (point))
	    (insert @left-bracket @right-bracket)
	    (search-backward @right-bracket )))
	 (t (progn
	      (skip-chars-backward "-_[:alnum:]")
	      (setq $p1 (point))
	      (skip-chars-forward "-_[:alnum:]")
	      (setq $p2 (point))
	      (goto-char $p2)
	      (insert @right-bracket)
	      (goto-char $p1)
	      (insert @left-bracket)
	      (goto-char (+ $p2 (length @left-bracket))))))))))

(defun xah-insert-paren ()
  (interactive)
  (xah-insert-bracket-pair "(" ")") )

(defun xah-insert-bracket ()
  (interactive)
  (xah-insert-bracket-pair "[" "]") )

(defun xah-insert-brace ()
  (interactive)
  (xah-insert-bracket-pair "{" "}") )


;;----------------------------------------------------
(provide 'init-func)
