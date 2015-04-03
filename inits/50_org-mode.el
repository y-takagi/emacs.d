(setq org-directory "~/Dropbox/Note/org-directory")
(setq org-agenda-files (list org-directory))

(use-package org-capture
  :bind (("C-o c" . org-capture))
  )
