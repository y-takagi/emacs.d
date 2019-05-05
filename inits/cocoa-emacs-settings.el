(when window-system
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

(load-file (concat (concat user-emacs-directory "inits/") "org-mode.el"))
