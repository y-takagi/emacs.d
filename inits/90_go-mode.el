(use-package go-mode
  :ensure t
  :config
  (add-hook 'go-mode-hook
            '(lambda ()
               (add-hook 'before-save-hook 'gofmt-before-save)
               (local-set-key (kbd "M-.") 'godef-jump)
               (add-to-list 'company-backends 'company-go)))
  )
