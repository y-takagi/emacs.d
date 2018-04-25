(use-package js2-mode
  :disabled t
  :mode (("\\.js$" . js2-mode))
  :config
  (setq js2-include-browser-externs nil)
  (setq js2-mode-show-parse-errors nil)
  (setq js2-mode-show-strict-warnings nil)
  (setq js2-highlight-external-variables nil)
  (setq js2-include-jslint-globals nil)

  (add-hook 'js2-mode-hook #'flycheck-mode)
  (flycheck-add-mode 'javascript-eslint 'js2-mode)
  )
