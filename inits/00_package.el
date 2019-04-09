(use-package add-node-modules-path :ensure t)
(use-package all-the-icons)
(use-package csv-mode :ensure t)
(use-package dash :ensure t)
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice '(lambda () (get-buffer "*dashboard*")))
  (setq dashboard-items '((recents . 20))))
(use-package diminish
  :ensure t
  :config
  (diminish 'eldoc-mode))
(use-package direnv
  :ensure t
  :config
  (direnv-mode))
(use-package dockerfile-mode :ensure t)
(use-package doom-modeline
  :ensure t
  :custom
  (doom-modeline-buffer-file-name-style 'truncate-with-project)
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon nil)
  (doom-modeline-minor-modes nil)
  :hook
  (after-init . doom-modeline-mode)
  :config
  (line-number-mode 0)
  (column-number-mode 0))
(use-package doom-themes
  :ensure t
  :custom-face
  (doom-modeline-bar ((t (:background "#6272a4"))))
  :config
  (load-theme 'doom-dracula t)
  (doom-themes-neotree-config)
  (doom-themes-org-config))
(use-package elscreen
  :ensure t
  :config
  (elscreen-start)
  ;; タブの先頭に[X]を表示しない
  (setq elscreen-tab-display-kill-screen nil)
  ;; header-lineの先頭に[<->]を表示しない
  (setq elscreen-tab-display-control nil)
  (define-key global-map (kbd "C-z b") 'helm-elscreen))
(use-package elscreen-separate-buffer-list
  :ensure t
  :config
  (setq esbl-separate-buffer-list-default '("*dashboard*" "*scratch*" "*Messages*"))
  (elscreen-separate-buffer-list-mode 1))
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))
(use-package find-file-in-repository
  :ensure t
  :bind (("C-c f" . find-file-in-repository)))
(use-package gitconfig-mode :ensure t)
(use-package git-gutter
  :ensure t
  :diminish git-gutter-mode
  :config
  (global-git-gutter-mode +1))
(use-package gitignore-mode :ensure t)
(use-package helm-bundle-show :ensure t)
(use-package helm-elscreen :ensure t)
(use-package hgrc-mode :ensure t)
(use-package hgignore-mode :ensure t)
(use-package json-mode :ensure t)
(use-package kotlin-mode :ensure t)
(use-package less-css-mode :ensure t)
(use-package magit-popup :ensure t)
(use-package open-junk-file
  :ensure t
  :bind (("C-x j" . open-junk-file))
  :config
  (setq open-junk-file-format "~/Dropbox/Note/junk/%Y-%m%d-%H%M%S."))
(use-package popup :ensure t)
(use-package rhtml-mode :ensure t)
(use-package rspec-mode :ensure t)
(use-package ruby-end :ensure t)
(use-package s :ensure t)
(use-package slim-mode :ensure t)
(use-package smart-newline
  :ensure t
  :bind (("C-j" . smart-newline)))
(use-package smooth-scrolling
  :ensure t
  :config
  (smooth-scrolling-mode 1))
(use-package undohist
  :ensure t
  :config
  (undohist-initialize)
  ;; 永続化を無視するファイル名の正規表現
  (setq undohist-ignored-files
        '("COMMIT_EDITMSG")))
(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode
  :config
  (global-undo-tree-mode t))
(use-package wgrep :ensure t)
(use-package wgrep-helm :ensure t)
(use-package whitespace
  :defer t
  :diminish whitespace-mode
  :config
  ;;; 行末スペースとtabの色付け
  (setq whitespace-style '(face
                           trailing
                           tabs
                           space-mark
                           tab-mark
                           ))
  (setq whitespace-display-mappings
        '((tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))
  (set-face-attribute 'whitespace-tab nil
                      :foreground "#dc322f"
                      :underline "#dc322f")
  (set-face-attribute 'whitespace-trailing nil
                      :background "#dc322f")
  (add-hook 'prog-mode-hook #'whitespace-mode)
  (add-hook 'text-mode-hook #'whitespace-mode))
(use-package yagist :ensure t)
(use-package yaml-mode :ensure t)
(use-package yasnippet :ensure t)
