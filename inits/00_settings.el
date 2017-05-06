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
(tool-bar-mode 0)
(line-number-mode t)
(column-number-mode t)
(blink-cursor-mode 1)
(show-paren-mode 1) ;; highlight corresponding bracket
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(setq vc-follow-symlinks t)
(setq-default cursor-in-non-selected-windows nil)
;;(setq x-select-enable-clipboard t)

;;; disable auto indent
(electric-indent-mode -1)

;;; exitコマンド
(defalias 'exit 'save-buffers-kill-terminal)

;;; 行末スペースとtabの色付け
(setq whitespace-style '(face
                         trailing
                         tabs
                         space-mark
                         tab-mark
                         ))
(setq whitespace-display-mappings
      '((tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))
(setq whitespace-global-modes '(not
                                eww-mode
                                term-mode
                                eshell-mode
                                org-agenda-mode
                                calendar-mode))
(global-whitespace-mode 1)

;; css-mode
(setq css-indent-offset 2)

;;; 変更されたファイルを自動的に再読み込み
(global-auto-revert-mode 1)

;;; tab
(setq-default tab-width 4 indent-tabs-mode nil)
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

;;; diredの表示オプション
(if (executable-find "gls")
    (progn
      (setq insert-directory-program "gls")
      (setq dired-listing-switches "-ahl --time-style long-iso --group-directories-first"))
  (setq dired-listing-switches "-ahl --time-style long-iso --group-directories-first"))
