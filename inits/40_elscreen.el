(use-package elscreen
  :config
  (elscreen-start)
  (setq elscreen-display-tab nil)
  (define-key global-map (kbd "C-z b") 'helm-elscreen)
  )

(use-package elscreen-separate-buffer-list
  :config
  (setq esbl-separate-buffer-list-default '("*dashboard*" "*scratch*" "*Messages*"))
  (elscreen-separate-buffer-list-mode 1)
  )
