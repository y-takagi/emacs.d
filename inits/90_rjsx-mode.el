(use-package rjsx-mode
  :config
  (add-hook 'rjsx-mode-hook #'flycheck-mode)
  (flycheck-add-mode 'javascript-eslint 'rjsx-mode)
  )
