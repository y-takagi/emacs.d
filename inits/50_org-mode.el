(setq org-directory "~/Dropbox/Note/org-directory")
(setq org-agenda-files (list org-directory))

;; TODO状態
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))

;; DONEの時刻を記録
(setq org-log-done 'time)

(use-package org-capture
  :bind (("C-o c" . org-capture))
  )
