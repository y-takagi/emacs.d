(setq org-directory "~/Dropbox/Note/org/")
(setq org-default-notes-file (concat org-directory "default.org"))
(setq org-agenda-files (list org-directory))
(setq org-project-file (concat org-directory "project-wtvr.org"))

;; keybind
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cb" 'org-iswitchb)

;; 曜日を英語表記
(setq system-time-locale "C")

;; 画像をインライン表示
(setq org-startup-with-inline-images t)

;; コードブロックをハイライトする
(setq org-src-fontify-natively t)

;; アジェンダ表示で下線を用いる
(add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))
(setq hl-line-face 'underline)

;; diaryを
(setq org-agenda-include-diary t)

;; TODO状態
(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s)" "WAIT(w)" "|" "DONE(d)" "CANCELED(c)")))

(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "red" :weight bold))
        ("STARTED" . (:foreground "color-21" :weight bold))
        ))

;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; clock-inしたらstateをSTARTEDに変更
(setq org-clock-in-switch-to-state "STARTED")

;;; DONEの時刻を記録
(setq org-log-done 'time)

(use-package org-capture
  :bind (("C-o c" . org-capture))
  :config
  (setq org-capture-templates
        '(("d" "Daily Log" plain (file+datetree (concat org-directory "daily.org"))
           "%t\n%?"
           :immediate-finish t)
          ("n" "Note" entry (file (concat org-directory "note.org"))
           "* %?"
           :prepend t)
          ("k" "KPT" entry (file+headline org-project-file "KPT")
           "* %T %?振り返り\n\n\t| Fact | Keep | Problem | Try |\n"
           :prepend t)
          ("m" "Meeting" entry (file+headline org-project-file "Meeting")
           "* %T %?\n"
           :prepend t)
          ))
  )
