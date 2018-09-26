(use-package web-mode
  :mode (("\\.tag$" . web-mode))
  :config
  (setq web-mode-engines-alist
        '(("riot" . "\\.tag\\'")))
  (set-face-foreground 'web-mode-html-tag-face "blue")
  (set-face-foreground 'web-mode-html-tag-bracket-face "brightyellow")
  (set-face-foreground 'web-mode-html-attr-name-face "brightyellow")
  )
