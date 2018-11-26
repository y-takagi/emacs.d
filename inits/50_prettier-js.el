(use-package prettier-js
  :config
  (setq prettier-js-args
        '("--find-config-path" "--write" "src/**/*.tsx"))
  (with-eval-after-load 'mhtml-mode
    (add-hook 'mhtml-mode-hook #'add-node-modules-path)
    (add-hook 'mhtml-mode-hook #'prettier-js-mode))
  )
