;; language and coding
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

(menu-bar-mode 0)
(scroll-bar-mode 0)
(line-number-mode t)
(column-number-mode t)
(blink-cursor-mode 1)
(show-paren-mode 1) ;; highlight corresponding bracket
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)

;; 行末スペースの色付け
(when (boundp 'show-trailing-whitespace)
  (setq-default show-trailing-whitespace t))

;; tab
(setq-default tab-width 2 indent-tabs-mode nil)
(setq-default basic-offset 2)
(setq-default c-basic-offset 2)

;; file
(setq mode-require-final-newline t)
(setq backup-inhibited t)
(setq delete-auto-save-files t)

;; emacs permission
;; (setq wdired-allow-to-change-permissions t)
