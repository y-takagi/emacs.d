(use-package prettier-js
  :config
  (setq prettier-js-args
        '("--find-config-path" "--write" "src/**/*.tsx"))
  )
