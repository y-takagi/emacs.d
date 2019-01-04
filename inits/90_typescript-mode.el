(use-package typescript-mode
  :ensure t
  :mode (("\\.ts$" . typescript-mode)
         ("\\.tsx$" . typescript-mode))
  :config
  (setq typescript-indent-level 2)
  (with-eval-after-load 'typescript-mode
    (add-hook 'typescript-mode-hook #'add-node-modules-path)
    (add-hook 'typescript-mode-hook #'prettier-js-mode))
  )
