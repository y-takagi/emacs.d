(use-package add-node-modules-path :ensure t)
(use-package all-the-icons :ensure t)
(use-package company
  :ensure t
  :diminish company-mode
  :config
  (global-company-mode +1)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)

  ;; Keybind settings
  (global-set-key (kbd "M-/") 'company-complete)

  ;; C-hを解除
  (define-key company-active-map (kbd "C-h") nil)

  ;; C-n, C-pで補完候補を次/前の候補を選択
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-search-map (kbd "C-n") 'company-select-next)
  (define-key company-search-map (kbd "C-p") 'company-select-previous)

  ;; C-sで絞り込む
  (define-key company-active-map (kbd "C-s") 'company-filter-candidates)

  ;; TABで候補を設定
  (define-key company-active-map (kbd "C-i") 'company-complete-selection)

  ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
  (define-key emacs-lisp-mode-map (kbd "M-/") 'company-complete))
(use-package company-box
  :disabled t
  :ensure t
  :hook (company-mode . company-box-mode))
(use-package company-lsp :ensure t)
(use-package company-quickhelp
  :disabled t
  :ensure t
  :config (company-quickhelp-mode))
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
  (setq exec-path-from-shell-arguments '("-l"))
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))
(use-package find-file-in-repository
  :ensure t
  :bind (("C-c f" . find-file-in-repository)))
(use-package flycheck :ensure t)
(use-package gitconfig-mode :ensure t)
(use-package git-gutter
  :ensure t
  :diminish git-gutter-mode
  :config
  (global-git-gutter-mode +1))
(use-package gitignore-mode :ensure t)
(use-package go-mode
  :ensure t
  :config
  (add-hook 'go-mode-hook
            '(lambda ()
               (add-hook 'before-save-hook 'gofmt-before-save)
               (local-set-key (kbd "M-.") 'godef-jump)
               (add-to-list 'company-backends 'company-go))))
(use-package helm
  :ensure t
  :diminish helm-mode
  :init
  (require 'helm-config)
  (helm-mode)
  :bind (("C-c m" . helm-mini)
         ("C-x C-c" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x C-r" . helm-recentf)
         ("M-y" . helm-show-kill-ring)
         ("C-c i" . helm-imenu)
         ("C-x b" . helm-buffers-list))
  :config
  (define-key helm-map (kbd "C-h") 'delete-backward-char)
  (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
  (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
  (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

  ;; Disable helm in some functions
  (add-to-list 'helm-completing-read-handlers-alist '(find-alternate-file . nil))

  ;; Emulate `kill-line' in helm minibuffer
  ;; (setq helm-delete-minibuffer-contents-from-point t)
  (defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
    "Emulate `kill-line' in helm minibuffer"
    (kill-new (buffer-substring (point) (field-end))))

  (defadvice helm-ff-kill-or-find-buffer-fname (around execute-only-if-exist activate)
    "Execute command only if CANDIDATE exists"
    (when (file-exists-p candidate)
      ad-do-it))

  (defadvice helm-ff-transform-fname-for-completion (around my-transform activate)
    "Transform the pattern to reflect my intention"
    (let* ((pattern (ad-get-arg 0))
           (input-pattern (file-name-nondirectory pattern))
           (dirname (file-name-directory pattern)))
      (setq input-pattern (replace-regexp-in-string "\\." "\\\\." input-pattern))
      (setq ad-return-value
            (concat dirname
                    (if (string-match "^\\^" input-pattern)
                        ;; '^' is a pattern for basename
                        ;; and not required because the directory name is prepended
                        (substring input-pattern 1)
                      (concat ".*" input-pattern)))))))
(use-package helm-ag
  :ensure t
  :bind (("C-c g" . helm-ag)
         ("C-c p" . helm-do-ag-project-root))
  :config
  (setq helm-ag-insert-at-point 'symbol)
  (setq helm-ag-base-command "rg --no-heading"))
(use-package helm-bundle-show :ensure t)
(use-package helm-dash
  :ensure t
  :config
  (defun ruby-doc ()
    (interactive)
    (setq-local helm-dash-docsets '("Ruby" "Ruby on Rails" "PostgreSQL")))
  (add-hook 'ruby-mode-hook 'ruby-doc))
(use-package helm-elscreen :ensure t)
(use-package helm-ghq
  :ensure t
  :bind (("C-c q" . helm-ghq)))
(use-package helm-gtags
  :ensure t
  :bind (("M-t" . helm-gtags-find-tag)
         ("M-r" . helm-gtags-find-rtag)
         ("M-s" . helm-gtags-find-symbol)
         ("M-l" . helm-gtags-select)
         ("C-t" . helm-gtags-pop-stack))
  :config
  (setq helm-gtags-auto-update t)
  (add-hook 'ruby-mode-hook 'helm-gtags-mode))
(use-package helm-swoop
  :ensure t
  :bind (("C-s" . helm-swoop))
  :config
  ;; 検索結果をcycleしない、お好みで
  (setq helm-swoop-move-to-line-cycle nil))
(use-package hgrc-mode :ensure t)
(use-package hgignore-mode :ensure t)
(use-package json-mode :ensure t)
(use-package kotlin-mode :ensure t)
(use-package less-css-mode :ensure t)
(use-package lsp-mode
  :ensure t
  :diminish lsp-mode
  :hook (prog-mode . lsp)
  :bind (:map lsp-mode-map
              ("C-c C-d" . lsp-describe-thing-at-point))
  :init
  (setq lsp-auto-guess-root t    ; Detect project root
        lsp-prefer-flymake nil)) ; Use flycheck
(use-package lsp-ui
  :ensure t
  :bind (:map lsp-ui-mode-map
              ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
              ([remap xref-find-references] . lsp-ui-peek-find-references)
              ("C-c u" . lsp-ui-imenu))
  :init (setq lsp-ui-doc-enable nil
              lsp-ui-doc-header t
              lsp-ui-doc-include-signature t
              lsp-ui-doc-position 'top
              lsp-ui-doc-use-webkit t
              lsp-ui-sideline-enable nil
              lsp-ui-sideline-ignore-duplicate t
              lsp-ui-imenu-enable nil
              lsp-ui-imenu-kind-position 'top)
  :hook (lsp-mode . lsp-ui-mode))
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))
(use-package open-junk-file
  :ensure t
  :bind (("C-x j" . open-junk-file))
  :config
  (setq open-junk-file-format "~/Dropbox/Note/junk/%Y-%m%d-%H%M%S."))
(use-package prettier-js
  :ensure t
  :config
  ;; (setq prettier-js-args
  ;;       '("--find-config-path" "--write" "src/**/*.tsx"))
  (add-hook 'mhtml-mode-hook #'add-node-modules-path)
  (add-hook 'mhtml-mode-hook #'prettier-js-mode)
  (add-hook 'scss-mode-hook #'add-node-modules-path)
  (add-hook 'scss-mode-hook #'prettier-js-mode)
  (add-hook 'json-mode-hook #'add-node-modules-path)
  (add-hook 'json-mode-hook #'prettier-js-mode))
(use-package rhtml-mode :ensure t)
(use-package rjsx-mode
  :ensure t
  :mode (("\\.js$" . rjsx-mode))
  :config
  (add-hook 'rjsx-mode-hook #'flycheck-mode)
  (flycheck-add-mode 'javascript-eslint 'rjsx-mode))
(use-package rspec-mode :ensure t)
(use-package ruby-end :ensure t)
(use-package ruby-mode
  :ensure t
  :mode (("\\.erb$" . ruby-mode)
         ("\\.rake$" . ruby-mode)
         ("\\.jbuilder$" . ruby-mode)
         ("\\.builder$" . ruby-mode)
         ("Fastfile". ruby-mode)))
(use-package s :ensure t)
(use-package slim-mode :ensure t)
(use-package smart-newline
  :ensure t
  :bind (("C-j" . smart-newline)))
(use-package smooth-scrolling
  :ensure t
  :config
  (smooth-scrolling-mode 1))
(use-package swift-mode
  :ensure t
  :config
  (setq swift-mode:basic-offset 2))
(use-package typescript-mode
  :ensure t
  :mode (("\\.ts$" . typescript-mode)
         ("\\.tsx$" . typescript-mode))
  :hook ((typescript-mode . add-node-modules-path)
         (typescript-mode . prettier-js-mode))
  :config
  (setq typescript-indent-level 2))
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
(use-package web-mode
  :ensure t
  :mode (("\\.tag$" . web-mode))
  :config
  (setq web-mode-engines-alist
        '(("riot" . "\\.tag\\'")))
  (set-face-foreground 'web-mode-html-tag-face "blue")
  (set-face-foreground 'web-mode-html-tag-bracket-face "brightyellow")
  (set-face-foreground 'web-mode-html-attr-name-face "brightyellow"))
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
