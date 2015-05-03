(when (require 'git-gutter nil t)
  (global-git-gutter-mode +1)
  (set-face-background 'git-gutter:unchanged "white")
  )
