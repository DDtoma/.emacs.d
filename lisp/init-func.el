(require 'cl-lib)

;; Suppress warnings
(eval-when-compile
  (require 'init-const)
  (require 'init-custom))

(defun llight//set-windows-size-unix ()
  "setup frame size"
  (setq initial-frame-alist
        '((width . 120)
          (height . 60)
          (left . 70)
          (top . 30)))
  (setq default-frame-alist
        '((width . 120)
          (height . 60)
          (left . 70)
          (left . 30)))
  )

(defun llight//set-windows-size-windows ()
  "setup frame size in windwos"
  (setq initial-frame-alist
        '((width . 120)
          (height . 40)
          (left . 70)
          (top . 30)))
  (setq default-frame-alist
        '((width . 120)
          (height . 60)
          (left . 40)
          (left . 30)))
  )

;; Configure network proxy
(setq my-proxy "http://127.0.0.1:7897")

(defun show-proxy ()
  "Show http/https proxy."
  (interactive)
  (if url-proxy-services
      (message "Current proxy is \"%s\"" my-proxy)
    (message "No proxy")))

(defun set-proxy ()
  "Set http/https proxy."
  (interactive)
  (setq url-proxy-services `(("http" . ,my-proxy)
                             ("https" . ,my-proxy)))
  (show-proxy))

(defun unset-proxy ()
  "Unset http/https proxy."
  (interactive)
  (setq url-proxy-services nil)
  (show-proxy))

(defun toggle-proxy ()
  "Toggle http/https proxy."
  (interactive)
  (if url-proxy-services
      (unset-proxy)
    (set-proxy)))

(defun icons-displayable-p ()
  "Return non-nil if icons are displayable."
  (and llight-icon
       (or (featurep 'nerd-icons)
           (require 'nerd-icons nil t))))

(defun llight-set-variable (variable value &optional no-save)
  "Set the VARIABLE to VALUE, and return VALUE.

  Save to option `custom-file' if NO-SAVE is nil."
  (customize-set-variable variable value)
  (when (and (not no-save)
             (file-writable-p custom-file))
    (with-temp-buffer
      (insert-file-contents custom-file)
      (goto-char (point-min))
      (while (re-search-forward
              (format "^[\t ]*[;]*[\t ]*(setq %s .*)" variable)
              nil t)
        (replace-match (format "(setq %s '%s)" variable value) nil nil))
      (write-region nil nil custom-file)
      (message "Saved %s (%s) to %s" variable value custom-file))))

;; Refer to https://emacs-china.org/t/elpa/11192
(defun llight-test-package-archives (&optional no-chart)
  "Test connection speed of all package archives and display on chart.

Not displaying the chart if NO-CHART is non-nil.
Return the fastest package archive."
  (interactive)

  (let* ((durations (mapcar
                     (lambda (pair)
                       (let ((url (concat (cdr (nth 2 (cdr pair)))
                                          "archive-contents"))
                             (start (current-time)))
                         (message "Fetching %s..." url)
                         (ignore-errors
                           (url-copy-file url null-device t))
                         (float-time (time-subtract (current-time) start))))
                     llight-package-archives-alist))
         (fastest (car (nth (cl-position (apply #'min durations) durations)
                            llight-package-archives-alist))))

    ;; Display on chart
    (when (and (not no-chart)
               (require 'chart nil t)
               (require 'url nil t))
      (chart-bar-quickie
       'vertical
       "Speed test for the ELPA mirrors"
       (mapcar (lambda (p) (symbol-name (car p))) llight-package-archives-alist)
       "ELPA"
       (mapcar (lambda (d) (* 1e3 d)) durations) "ms"))

    (message "`%s' is the fastest package archive" fastest)

    ;; Return the fastest
    fastest))

;; Pakcage repository (ELPA)
(defun set-package-archives (archives &optional refresh async no-save)
  "Set the package ARCHIVES (ELPA).

REFRESH is non-nil, will refresh archive contents.
ASYNC specifies whether to perform the downloads in the background.
Save to option `custom-file' if NO-SAVE is nil."
  (interactive
   (list
    (intern
     (completing-read "Select package archives: "
                      (mapcar #'car llight-package-archives-alist)))))
  ;; Set option
  (llight-set-variable 'llight-package-archives archives no-save)

  ;; Refresh if need
  (and refresh (package-refresh-contents async))

  (message "Set package archives to `%s'" archives))

(defalias 'llight-set-package-archives #'set-package-archives)





;;----------------------------------------------------
(provide 'init-func)
