(use-package eaf
  :if sys/linux-x-p
  :ensure nil
  ;; :quelpa ((eaf :fetcher github :repo "emacs-eaf/emacs-application-framework") :upgrade nil)
  :straight (eaf :type git :host github :repo "emacs-eaf/emacs-application-framework")
  ;; :load-path "~/.emacs.d/plugin/emacs-application-framework" ; Set to "/usr/share/emacs/site-lisp/eaf" if installed from AUR
  :custom
  (eaf-browser-continue-where-left-off t)
  (eaf-browser-enable-adblocker t)
  (browse-url-browser-function 'eaf-open-browser)
  :config
;  (defalias 'browse-web #'eaf-open-browser) ;
  (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
  (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
  (eaf-bind-key take_photo "p" eaf-camera-keybinding)
  (eaf-bind-key nil "M-q" eaf-browser-keybinding) ;; unbind, see more in the Wiki

  (setq eaf-proxy-type "socks5")
  (setq eaf-proxy-host "127.0.0.1")
  (setq eaf-proxy-port "1090")
  )

(provide 'init-eaf)
