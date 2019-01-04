(use-package prettier-js
  :ensure t
  :diminish prettier-js-mode
  :config
  (setq prettier-js-args
        '("--find-config-path" "--write" "src/**/*.tsx"))
  (with-eval-after-load 'mhtml-mode
    (add-hook 'mhtml-mode-hook #'add-node-modules-path)
    (add-hook 'mhtml-mode-hook #'prettier-js-mode))
  )
