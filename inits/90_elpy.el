(use-package elpy
  :config
  (elpy-enable)
  (add-hook 'elpy-mode-hook
            '(lambda ()
               (add-hook 'before-save-hook 'elpy-yapf-fix-code)
               ))
  )