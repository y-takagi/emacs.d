(use-package company-jedi
  :config
  (add-hook 'python-mode-hook
            '(lambda ()
               (setq jedi:complete-on-dot t)
               (setq jedi:use-shortcuts t)
               (add-to-list 'company-backends 'company-jedi))))
