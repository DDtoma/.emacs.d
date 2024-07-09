;; close voice
(setq ring-bell-function 'ignore)

;; system coding
(prefer-coding-system 'utf-8)
(setq default-file-name-coding-system 'utf-8)

;; Environment
(use-package exec-path-from-shell
  :ensure t
  :if (or sys/mac-x-p sys/linux-x-p)
  :init
  (setq exec-path-from-shell-check-startup-files nil
        exec-path-from-shell-variables '("PATH" "MANPATH" "PYTHONPATH" "GOPATH")
        exec-path-from-shell-arguments '("-l" "-i"))
  (exec-path-from-shell-initialize))

;; Buackup
;; (setq make-backup-files nil)
(setq auto-save-default nil)
(setq backup-directory-alist '(("" . "~/.emacs.d/.backup")))
(defun my-backup-file-name (fpath)
  "Return a new file path of a given file path.If the new path's directories does not exist, create them."
  (let* (
         (backupRootDir "~/.emacs.d/.backup/")
         ;; remove Windows driver letter in path, for example, “C:”
         (filePath (replace-regexp-in-string "[A-Za-z]:" "" fpath ))
         (backupFilePath (replace-regexp-in-string "//" "/" (concat backupRootDir filePath "~") ))
         )
    (make-directory (file-name-directory backupFilePath) (file-name-directory backupFilePath))
    backupFilePath))
(setq make-backup-file-name-function 'my-backup-file-name)

;; garbage collection
;; resource site http://akrl.sdf.org/
;; ---------------------------------------------------------
(defmacro k-time (&rest body)
  "Measure and return the time it takes evaluating BODY."
  `(let ((time (current-time)))
     ,@body
     (float-time (time-since time))))

;; ;;;; Set garbage collection threshold to 1GB.
(setq gc-cons-threshold #x80000000)

;; ;;;; when idle for 15sec run the GC no matter what.
(defvar k-gc-timer
  (run-with-idle-timer 15 t
                       (lambda ()
                         (k-time (garbage-collect))
                         ;; (message "Garbage Collector has run for %.06fsec"
                         ;;          (k-time (garbage-collect)))
                         )))
;; ---------------------------------------------------------

(provide 'init-env)
