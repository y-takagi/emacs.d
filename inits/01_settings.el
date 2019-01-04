;;; language and coding
(prefer-coding-system 'utf-8-unix)
;; (set-language-environment "Japanese")
;; (setq file-name-coding-system 'utf-8)
;; (setq locale-coding-system 'utf-8)

(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(blink-cursor-mode 1)
(show-paren-mode 1) ;; highlight corresponding bracket
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(setq vc-follow-symlinks t)
(setq-default cursor-in-non-selected-windows nil)

;; line number
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'text-mode-hook #'display-line-numbers-mode)

;;; disable auto indent
(electric-indent-mode -1)

;;; exitコマンド
(defalias 'exit 'save-buffers-kill-terminal)

;;; 変更されたファイルを自動的に再読み込み
(global-auto-revert-mode 1)

;;; tab
(setq-default tab-width 4 indent-tabs-mode nil)
(setq-default basic-offset 2)
(setq-default c-basic-offset 2)

;; indent
(setq css-indent-offset 2)
(setq js-indent-level 2)
(setq python-indent-guess-indent-offset nil)

;;; file
(setq mode-require-final-newline t)
(setq backup-inhibited t)
(setq delete-auto-save-files t)

;;; 問い合せには y か n で返答
(fset 'yes-or-no-p 'y-or-n-p)

;;; emacs permission
;; (setq wdired-allow-to-change-permissions t)

;;; diredの表示オプション
(if (executable-find "gls")
    (progn
      (setq insert-directory-program "gls")
      (setq dired-listing-switches "-ahl --time-style long-iso --group-directories-first"))
  (setq dired-listing-switches "-ahl --time-style long-iso --group-directories-first"))

;;; emacs のデフォルトブラウザを eww に変更
(setq browse-url-browser-function 'eww-browse-url)

;; Theme settings
(load-theme 'solarized t)

;;; Global Key
;; copy & paste
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-w" 'clipboard-kill-region)

(global-set-key "\C-cc"    'comment-or-uncomment-region)
(global-set-key "\C-h"     'backward-delete-char)
(global-set-key "\C-x\C-i" 'indent-region)
(global-set-key [C-tab]    'indent-for-tab-command)

(global-unset-key "\C-x\C-z")
(global-unset-key "\C-o")
