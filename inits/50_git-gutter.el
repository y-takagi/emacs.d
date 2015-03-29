(when (require 'git-gutter nil t)
  (global-git-gutter-mode +1)

  (custom-set-variables
   '(git-gutter:unchanged-sign " "))

  (set-face-background 'git-gutter:unchanged "white")
  )
