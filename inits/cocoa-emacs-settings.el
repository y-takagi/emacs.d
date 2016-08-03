(when window-system
  ;; Load $PATH set up by the user's shell
  (exec-path-from-shell-initialize)

  (scroll-bar-mode 0)

  ;; Fonts
  (add-to-list 'default-frame-alist '(font . "ricty-18"))

  ;; フルスクリーン
  (set-frame-parameter nil 'fullscreen 'fullboth)

  ;; Modify right command to super
  (setq mac-right-command-modifier 'super)

  ;; フォントの拡大・縮小
  (global-set-key (kbd "s-=") (lambda () (interactive) (text-scale-increase 1)))
  (global-set-key (kbd "s--") (lambda () (interactive) (text-scale-decrease 1)))
  (global-set-key (kbd "s-0") (lambda () (interactive) (text-scale-increase 0)))
  )

;; Completion for Swift projects via SourceKit
(use-package company-sourcekit
  :config
  (add-to-list 'company-backends 'company-sourcekit)
  )
