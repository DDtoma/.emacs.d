(eval-when-compile
  (require 'package))

(defgroup llight nil
  "Centaur Emacs customization."
  :group 'convenience
  :link '(url-link :tag "Homepage" "https://github.com/ddtoma/.emacs.d"))

(defcustom llight-icon t
  "Display icons or not."
  :group 'llight
  :type 'boolean)

(defcustom llight-org-directory (expand-file-name "~/Documents/Note")
  "Set org directory."
  :group 'llight
  :type 'string)

(defcustom llight-use-meow nil
  "set using meow package"
  :group 'llight
  :type 'boolean)

(defcustom llight-hl-active nil
  "hight light current line"
  :group 'llight
  :type 'boolean
  )

(defcustom llight-prettify-symbols-alist
  '(("lambda" . ?λ)
    ("<-"     . ?←)
    ("->"     . ?→)
    ("->>"    . ?↠)
    ("=>"     . ?⇒)
    ("/="     . ?≠)
    ("!="     . ?≠)
    ("<="     . ?≤)
    (">="     . ?≥))
  "A list of symbol prettifications.
Nil to use font supports ligatures."
  :group 'llight
  :type '(alist :key-type string :value-type (choice character sexp)))

(defcustom llight-package-archives-alist
  (let ((proto (if (gnutls-available-p) "https" "http")))
    `((melpa    . (("gnu"    . ,(format "%s://elpa.gnu.org/packages/" proto))
                   ("nongnu" . ,(format "%s://elpa.nongnu.org/nongnu/" proto))
                   ("melpa"  . ,(format "%s://melpa.org/packages/" proto))))
      (emacs-cn . (("gnu"    . ,(format "%s://1.15.88.122/gnu/" proto))
                   ("nongnu" . ,(format "%s://1.15.88.122/nongnu/" proto))
                   ("melpa"  . ,(format "%s://1.15.88.122/melpa/" proto))))
      (bfsu     . (("gnu"    . ,(format "%s://mirrors.bfsu.edu.cn/elpa/gnu/" proto))
                   ("nongnu" . ,(format "%s://mirrors.bfsu.edu.cn/elpa/nongnu/" proto))
                   ("melpa"  . ,(format "%s://mirrors.bfsu.edu.cn/elpa/melpa/" proto))))
      (netease  . (("gnu"    . ,(format "%s://mirrors.163.com/elpa/gnu/" proto))
                   ("nongnu" . ,(format "%s://mirrors.163.com/elpa/nongnu/" proto))
                   ("melpa"  . ,(format "%s://mirrors.163.com/elpa/melpa/" proto))))
      (sjtu     . (("gnu"    . ,(format "%s://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/gnu/" proto))
                   ("nongnu" . ,(format "%s://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/nongnu/" proto))
                   ("melpa"  . ,(format "%s://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/melpa/" proto))))
      (tuna     . (("gnu"    . ,(format "%s://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/" proto))
                   ("nongnu" . ,(format "%s://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/" proto))
                   ("melpa"  . ,(format "%s://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/" proto))))
      (ustc     . (("gnu"    . ,(format "%s://mirrors.ustc.edu.cn/elpa/gnu/" proto))
                   ("nongnu" . ,(format "%s://mirrors.ustc.edu.cn/elpa/nongnu/" proto))
                   ("melpa"  . ,(format "%s://mirrors.ustc.edu.cn/elpa/melpa/" proto))))))
  "A list of the package archives."
  :group 'llight
  :type '(alist :key-type (symbol :tag "Archive group name")
                :value-type (alist :key-type (string :tag "Archive name")
                                   :value-type (string :tag "URL or directory name"))))

(defcustom llight-package-archives 'melpa
  "Set package archives from which to fetch."
  :group 'llight
  :set (lambda (symbol value)
         (set symbol value)
         (setq package-archives
               (or (alist-get value llight-package-archives-alist)
                   (error "Unknown package archives: `%s'" value))))
  :type `(choice ,@(mapcar
                    (lambda (item)
                      (let ((name (car item)))
                        (list 'const
                              :tag (capitalize (symbol-name name))
                              name)))
                    llight-package-archives-alist)))

;; Load `custom-file'
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))


(provide 'init-custom)
