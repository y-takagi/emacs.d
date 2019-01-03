(use-package elscreen
  :ensure t
  :config
  (elscreen-start)
  ;; タブの先頭に[X]を表示しない
  (setq elscreen-tab-display-kill-screen nil)
  ;; header-lineの先頭に[<->]を表示しない
  (setq elscreen-tab-display-control nil)
  (define-key global-map (kbd "C-z b") 'helm-elscreen)
  )

(use-package elscreen-separate-buffer-list
  :ensure t
  :config
  (setq esbl-separate-buffer-list-default '("*dashboard*" "*scratch*" "*Messages*"))
  (elscreen-separate-buffer-list-mode 1)
  )
