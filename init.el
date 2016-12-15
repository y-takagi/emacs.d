;; load-path for elisp files
;; emacs -l init.el等で直接ロードしたときに, user-emacs-directoryが書き換わる
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp"))

;; package.el settings
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-refresh-contents)
(package-initialize)

;; Setup quelpa
(unless (require 'quelpa nil t)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
    (eval-buffer)))

;; Setup quelpa-use-package
(quelpa
 '(quelpa-use-package
   :fetcher github
   :repo "quelpa/quelpa-use-package"))
(require 'quelpa-use-package)

;; Do nothing if use-package.el doesn't exist
(unless (require 'use-package nil t)
  (defmacro use-package (&rest args)))

;; init-loader setting
(use-package init-loader
  :quelpa
  :config
  (setq init-loader-show-log-after-init 'error-only)
  (init-loader-load (concat user-emacs-directory "inits")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(git-gutter:unchanged-sign " ")
 '(helm-boring-file-regexp-list (quote ("~$" "\\.elc$")))
 '(helm-buffer-max-length 35)
 '(helm-delete-minibuffer-contents-from-point t)
 '(helm-ff-skip-boring-files t)
 '(helm-ls-git-show-abs-or-relative (quote relative))
 '(helm-mini-default-sources
   (quote
    (helm-source-buffers-list helm-source-ls-git helm-source-recentf helm-source-buffer-not-found)))
 '(helm-truncate-lines t t)
 '(rainbow-html-colors-major-mode-list
   (quote
    (scss-mode html-mode css-mode php-mode nxml-mode xml-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit outline-1 :background "SkyBlue1" :underline t))))
 '(whitespace-tab ((t (:foreground "#dc322f" :underline "#dc322f"))))
 '(whitespace-trailing ((t (:background "#dc322f")))))
