;;; language and coding
(prefer-coding-system 'utf-8-unix)
;; (set-language-environment "Japanese")
;; (setq file-name-coding-system 'utf-8)
;; (setq locale-coding-system 'utf-8)

;; (defun copy-from-osx ()
;;  (shell-command-to-string "pbpaste"))

;; (defun paste-to-osx (text &optional push)
;;  (let ((process-connection-type nil))
;;      (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
;;        (process-send-string proc text)
;;        (process-send-eof proc))))

;; (setq interprogram-cut-function 'paste-to-osx)
;; (setq interprogram-paste-function 'copy-from-osx)

(menu-bar-mode 0)
(line-number-mode t)
(column-number-mode t)
(blink-cursor-mode 1)
(show-paren-mode 1) ;; highlight corresponding bracket
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(setq vc-follow-symlinks t)
;;(setq x-select-enable-clipboard t)

;;; disable auto indent
(electric-indent-mode -1)

;;; 行末スペースの色付け
(when (boundp 'show-trailing-whitespace)
  (setq-default show-trailing-whitespace t))

;;; 行末のスペースを強調表示しないモードを列挙
(defconst ignore-show-trailing-whitespace-mode-alist
  '(eww-mode
    term-mode
    org-agenda-mode
    calendar-mode
    eshell-mode))

;;; 行末のスペースの強調表示を無効化
(--each ignore-show-trailing-whitespace-mode-alist
  (add-hook (intern (concat (symbol-name it) "-hook"))
            '(lambda ()
               (setq show-trailing-whitespace nil))))

;;; 画像ファイルを表示
(auto-image-file-mode)

;;; 変更されたファイルを自動的に再読み込み
(global-auto-revert-mode 1)

;;; tab
(setq-default tab-width 2 indent-tabs-mode nil)
(setq-default basic-offset 2)
(setq-default c-basic-offset 2)

;;; file
(setq mode-require-final-newline t)
(setq backup-inhibited t)
(setq delete-auto-save-files t)

;;; 問い合せには y か n で返答
(fset 'yes-or-no-p 'y-or-n-p)

;;; emacs permission
;; (setq wdired-allow-to-change-permissions t)
