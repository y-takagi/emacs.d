(setq org-directory "~/Dropbox/Note/org/")
(setq org-default-notes-file (concat org-directory "projects.org"))
(setq org-agenda-files (list org-directory))

;;; keybind
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cb" 'org-iswitchb)

;;; コードブロックをハイライトする
(setq org-src-fontify-natively t)

;;; アジェンダ表示で下線を用いる
(add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))
(setq hl-line-face 'underline)

;;; TODO状態
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))

;;; DONEの時刻を記録
(setq org-log-done 'time)

(use-package org-capture
  :bind (("C-o c" . org-capture))
  :config
  (setq org-capture-templates
        '(("d" "Diary" plain (file+datetree (concat org-directory "diary.org"))
           "%U\n%?")
          ("t" "Timeline" entry (file+datetree (concat org-directory "timeline.org"))
           "* %T %?")
          ("q" "Quick Memo" entry (file+headline nil "Inbox")
           "* %U %?\n%a\n%i\n"
           :prepend t)
          ("k" "KPT" item (file+headline nil "KPT")
           "* %T %?\n"
           :prepend t)
          ("m" "Meeting" entry (file+headline nil "Meeting")
           "* %T %?\n"
           :prepend t)
          ))
  )
