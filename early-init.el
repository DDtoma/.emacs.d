(defalias 'yes-or-no-p 'y-or-n-p)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq inhibit-startup-screen t
      initial-scratch-message nil
      sentence-end-double-space nil
      ring-bell-function 'ignore
      frame-resize-pixelwise t
      show-paren-style 'parenthesis

      user-full-name "llight"
      user-mail-address "ll66456645@163.com"

      tab-always-indent 'complete

      default-process-coding-system '(utf-8-unix . utf-8-unix)

      read-process-output-max (* 1024 1024)
      )

(set-charset-priority 'unicode)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(display-time-mode -1)
(show-paren-mode 1)
(display-line-numbers-mode 1)

(when (window-system)
    (tool-bar-mode -1)
    (toggle-scroll-bar -1))
