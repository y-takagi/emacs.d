(use-package git-gutter
  :ensure t
  :diminish git-gutter-mode
  :config
  (global-git-gutter-mode +1)
  (set-face-background 'git-gutter:unchanged "white")
  )
