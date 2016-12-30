(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice '(lambda () (get-buffer "*dashboard*")))
  (setq dashboard-items '((recents . 20)))
  )
