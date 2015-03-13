;; language and coding
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

;; windowのサイズおよび色設定
(if window-system
    (progn
      (setq initial-frame-alist '((top . 50) (left . 100) (width . 120) (height . 40)))
      (set-background-color "Black")
      (set-foreground-color "LightGray")
      (set-cursor-color "Gray")
      (set-face-background 'fringe "black")
      (set-face-foreground 'fringe "DimGray")
      )
  )
(add-to-list 'default-frame-alist '(alpha . 85))

;; 行末スペースの色付け
(when (boundp 'show-trailing-whitespace)
  (setq-default show-trailing-whitespace t))

;; (display-time-mode t)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(line-number-mode t)
(column-number-mode t)
(blink-cursor-mode 1)

(setq inhibit-startup-message t)
;; (if (fboundp 'fringe-mode) (fringe-mode '(1 . 1)))
;;(iswitchb-mode 1) ;; switch buffer with name
(global-set-key "\C-cc" 'comment-or-uncomment-region)
(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\C-z" 'undo)
(global-set-key "\C-x\C-i" 'indent-region)
(setq ring-bell-function 'ignore)
(show-paren-mode 1) ;; highlight corresponding bracket

;; tab
(setq-default tab-width 2 indent-tabs-mode nil)
(setq-default basic-offset 2)
(setq-default c-basic-offset 2)

;; file
(setq mode-require-final-newline nil)
(setq backup-inhibited t)
(setq delete-auto-save-files t)

;; copy & paste
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-w" 'clipboard-kill-region)

;; emacs permission
;; (setq wdired-allow-to-change-permissions t)