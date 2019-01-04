(use-package add-node-modules-path :ensure t)
(use-package color-theme-solarized :ensure t)
(use-package csv-mode :ensure t)
(use-package dash :ensure t)
(use-package diminish
  :ensure t
  :config
  (diminish 'eldoc-mode)
  )
(use-package dockerfile-mode :ensure t)
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))
  )
(use-package gitconfig-mode :ensure t)
(use-package gitignore-mode :ensure t)
(use-package helm-bundle-show :ensure t)
(use-package helm-elscreen :ensure t)
(use-package hgrc-mode :ensure t)
(use-package hgignore-mode :ensure t)
(use-package json-mode :ensure t)
(use-package kotlin-mode :ensure t)
(use-package less-css-mode :ensure t)
(use-package magit-popup :ensure t)
(use-package popup :ensure t)
(use-package rhtml-mode :ensure t)
(use-package rspec-mode :ensure t)
(use-package ruby-end :ensure t)
(use-package s :ensure t)
(use-package slim-mode :ensure t)
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
  (add-hook 'text-mode-hook #'whitespace-mode)
  )
(use-package yagist :ensure t)
(use-package yaml-mode :ensure t)
(use-package yasnippet :ensure t)
