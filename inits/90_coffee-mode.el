(use-package coffee-mode
  :disabled t
  :config
  (set (make-local-variable 'tab-width) 2)
  (setq coffee-tab-width 2)
  (add-hook 'coffee-mode-hook
            '(lambda() (coffee-custom)))
  )
