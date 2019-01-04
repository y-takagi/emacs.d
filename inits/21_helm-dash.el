(use-package helm-dash
  :ensure t
  :config
  (defun ruby-doc ()
    (interactive)
    (setq-local helm-dash-docsets '("Ruby" "Ruby on Rails" "PostgreSQL")))

  (add-hook 'ruby-mode-hook 'ruby-doc)
  )
