(use-package helm-gtags
  :bind (("M-t" . helm-gtags-find-tag)
         ("M-r" . helm-gtags-find-rtag)
         ("M-s" . helm-gtags-find-symbol)
         ("M-l" . helm-gtags-select)
         ("C-t" . helm-gtags-pop-stack))
  :config
  (setq helm-gtags-auto-update t)
  (add-hook 'ruby-mode-hook 'helm-gtags-mode)
  )
