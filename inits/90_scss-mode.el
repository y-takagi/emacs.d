(use-package scss-mode
  :mode (("\\.css$" . scss-mode))
  :config
  (add-hook 'scss-mode-hook
            '(lambda () (setq css-indent-offset 2))))
