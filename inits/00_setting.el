;; language and coding
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

(menu-bar-mode 0)
(line-number-mode t)
(column-number-mode t)
(blink-cursor-mode 1)
(show-paren-mode 1) ;; highlight corresponding bracket
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)

;; 行末スペースの色付け
(when (boundp 'show-trailing-whitespace)
  (setq-default show-trailing-whitespace t))

;; 行末のスペースを強調表示しないモードを列挙
(defconst ignore-show-trailing-whitespace-mode-alist
  '(eww-mode
    term-mode
    eshell-mode))

;; 行末のスペースの強調表示を無効化
(--each ignore-show-trailing-whitespace-mode-alist
  (add-hook (intern (concat (symbol-name it) "-hook"))
            '(lambda ()
               (setq show-trailing-whitespace nil))))

;; 画像ファイルを表示
(auto-image-file-mode)

;; 変更されたファイルを自動的に再読み込み
(global-auto-revert-mode 1)

;; tab
(setq-default tab-width 2 indent-tabs-mode nil)
(setq-default basic-offset 2)
(setq-default c-basic-offset 2)

;; file
(setq mode-require-final-newline t)
(setq backup-inhibited t)
(setq delete-auto-save-files t)

(setq browse-url-browser-function 'eww)

;; 問い合せには y か n で返答
(fset 'yes-or-no-p 'y-or-n-p)

;; emacs permission
;; (setq wdired-allow-to-change-permissions t)
