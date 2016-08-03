;; load-path for elisp files
;; emacs -l init.el等で直接ロードしたときに, user-emacs-directoryが書き換わる
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp"))

;; cask setting
(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; use pallet
(pallet-mode t)

;; use-package option
(unless (require 'use-package nil t)
  (defmacro use-package (&rest args)))

;; init-loader setting
(require 'init-loader)
(setq init-loader-show-log-after-init 'error-only)
(init-loader-load (concat user-emacs-directory "inits"))

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
