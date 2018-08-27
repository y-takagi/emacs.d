(use-package helm-ag
  :bind (("C-c g" . helm-ag)
         ("C-c p" . helm-do-ag-project-root))
  :config
  (setq helm-ag-insert-at-point 'symbol)
  (setq helm-ag-base-command "rg --no-heading")
 )
