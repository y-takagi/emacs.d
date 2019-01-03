;; load-path for elisp files
;; emacs -l init.el等で直接ロードしたときに, user-emacs-directoryが書き換わる
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;;(add-to-list 'load-path (concat user-emacs-directory "site-lisp"))

;; package.el settings
(require 'package)
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))
(package-refresh-contents)

;; ensure to use use-package
(when (not (package-installed-p 'use-package))
  (package-install 'use-package))
(require 'use-package)

;; Do nothing if use-package.el doesn't exist
(unless (require 'use-package nil t)
  (defmacro use-package (&rest args)))

;; init-loader setting
(use-package init-loader
  :ensure t
  :config
  (setq init-loader-show-log-after-init 'error-only)
  (init-loader-load (concat user-emacs-directory "inits")))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
