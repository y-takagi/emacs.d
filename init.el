;; load-path for elisp files
;; emacs -l init.el等で直接ロードしたときに, user-emacs-directoryが書き換わる
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;;(add-to-list 'load-path (concat user-emacs-directory "site-lisp"))

(setq warning-minimum-level :error)

;; package.el settings
(require 'package)
(setq package-enable-at-startup nil)
(setq package-native-compile t)
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))
(package-refresh-contents)

;; ensure to use use-package
(when (not (package-installed-p 'use-package))
  (package-install 'use-package))
(require 'use-package)

;; Do nothing if use-package.el doesn't exist
(unless (require 'use-package nil t)
  (defmacro use-package (&rest args)))

(use-package quelpa
  :ensure t
  :custom
  (quelpa-self-upgrade-p nil)
  (quelpa-update-melpa-p nil)
  (quelpa-checkout-melpa-p nil))
(use-package quelpa-use-package :ensure t)
(use-package hydra
  :ensure t
  :bind (("C-z" . hydra-main/body))
  :config (hydra-set-property 'hydra-main :verbosity 1))
(use-package add-node-modules-path
  :ensure t
  :hook (prog-mode gfm-mode markdown-mode))
(use-package all-the-icons
  :ensure t
  :custom (all-the-icons-scale-factor 1.0))
(use-package amx :ensure t :config (amx-mode))
(use-package auto-sudoedit
  :ensure t
  :config
  (auto-sudoedit-mode 1))
(use-package centaur-tabs
  :ensure t
  :custom
  (centaur-tabs-height 28)
  (centaur-tabs-style "bar")
  (centaur-tabs-set-icons t)
  (centaur-tabs-set-bar 'over)
  (centaur-tabs-set-close-button nil)
  (centaur-tabs-set-modified-marker t)
  (centaur-tabs-modified-marker "●")
  (centaur-tabs-cycle-scope 'tabs)
  :config
  (centaur-tabs-mode t))
(use-package company
  :ensure t
  :diminish company-mode
  :config
  (global-company-mode +1)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)

  (defvar company-mode/enable-yas t
    "Enable yasnippet for all backends.")
  (defun company-mode/backend-with-yas (backend)
    (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
        backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))
  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

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
  :hook (company-mode . company-box-mode)
  :custom
  (company-box-icons-alist 'company-box-icons-all-the-icons)
  (company-box-doc-enable nil))
(use-package company-quickhelp
  :disabled t
  :ensure t
  :config (company-quickhelp-mode))
(use-package counsel
  :ensure t
  :diminish ivy-mode counsel-mode
  :bind (("C-s" . swiper)
         ("C-c C-r" . ivy-resume)
         ("C-x C-c" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-c p" . counsel-git-grep)
         ("C-c g" . counsel-rg))
  :hook ((after-init . ivy-mode)
         (ivy-mode . counsel-mode))
  :config
  (setq ivy-use-virtual-buffers t
        ivy-initial-inputs-alist nil
        ivy-virtual-abbreviate 'abbreviate
        ivy-height 14
        ivy-fixed-height-minibuffer t
        ivy-use-selectable-prompt t
        enable-recursive-minibuffers t
        ivy-extra-directories '("./"))
  (define-key ivy-minibuffer-map (kbd "C-l") 'counsel-up-directory)
  (define-key ivy-minibuffer-map (kbd "TAB") 'counsel-down-directory))
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
(use-package exec-path-from-shell
  :ensure t
  :config
  (setq exec-path-from-shell-arguments '("-l"))
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))
(use-package flycheck
  :ensure t
  :bind (("M-p" . flycheck-previous-error)
         ("M-n" . flycheck-next-error))
  :config
  (setq flycheck-checker-error-threshold nil))
(use-package format-all
  :ensure t
  :hook ((emacs-lisp-mode python-mode) . format-all-mode))
(use-package git-gutter
  :ensure t
  :diminish git-gutter-mode
  :config
  (global-git-gutter-mode +1))
(use-package highlight-indent-guides
  :disabled t
  :ensure t
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character
        highlight-indent-guides-auto-enabled t
        highlight-indent-guides-responsive t))
(use-package ivy-ghq
  :quelpa (ivy-ghq :fetcher github :repo "analyticd/ivy-ghq")
  :bind ("C-c q" . ivy-ghq-open)
  :custom (ivy-ghq-short-list t))
(use-package ivy-rich
  :ensure t
  :after (ivy)
  :config
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
  (setq ivy-rich--display-transformers-list
        '(ivy-switch-buffer
          (:columns
           ((ivy-rich-candidate (:width 40))
            (ivy-rich-switch-buffer-project (:width 30 :face success))
            (ivy-rich-switch-buffer-path (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.3))))))
           :predicate
           (lambda (cand) (get-buffer cand)))))

  (ivy-rich-mode 1))
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :bind (:map lsp-mode-map
              ("C-c C-d" . lsp-describe-thing-at-point))
  :init
  (setq gc-cons-threshold 100000000
        read-process-output-max (* 1024 1024)
        lsp-keymap-prefix "C-c l"
        lsp-idle-delay 0.500
        lsp-auto-guess-root t         ; Detect project root
        lsp-prefer-flymake nil        ; Use flycheck
        lsp-report-if-no-buffer nil
        lsp-disabled-clients '(angular-ls)
        lsp-signature-auto-activate t
        lsp-signature-doc-lines 1
        lsp-before-save-edits nil
        lsp-modeline-diagnostics-mode nil
        lsp-enable-file-watchers nil
        lsp-clients-python-library-directories '("/usr/local/" "/usr/")))
(use-package lsp-haskell
  :ensure t
  :config
  (add-hook 'haskell-mode-hook #'lsp)
  (add-hook 'haskell-literate-mode-hook #'lsp))
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :after (flycheck)
  :bind (:map lsp-ui-mode-map
              ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
              ([remap xref-find-references] . lsp-ui-peek-find-references)
              ("C-c u" . lsp-ui-imenu))
  :init (setq lsp-ui-doc-enable nil
              lsp-ui-doc-header t
              lsp-ui-doc-include-signature t
              lsp-ui-doc-position 'top
              lsp-ui-sideline-enable nil
              lsp-ui-sideline-ignore-duplicate t
              lsp-ui-imenu-enable nil
              lsp-ui-imenu-kind-position 'top)
  :config
  ;;(flycheck-add-next-checker 'lsp 'typescript-tslint)
  )
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))
(use-package omnisharp
  :disabled t
  :config
  (setq omnisharp-server-executable-path "~/.ghq/github.com/OmniSharp/omnisharp-server/OmniSharp/bin/Debug/OmniSharp.exe")
  (define-key omnisharp-mode-map (kbd "<C-tab>") 'omnisharp-auto-complete)
  (define-key omnisharp-mode-map "." 'omnisharp-add-dot-and-auto-complete))
(use-package open-junk-file
  :ensure t
  :bind (("C-x j" . open-junk-file))
  :config
  (setq open-junk-file-format "~/Documents/Note/%Y-%m%d-%H%M%S."))
(use-package org
  :ensure t
  :config
  (setq org-directory "~/Documents/Note/")
  (setq org-default-notes-file (concat org-directory "default.org"))
  (setq org-agenda-files (list org-directory))
  (setq org-project-file (concat org-directory "project-wtvr.org"))

  ;; keybind
  (global-unset-key "\C-o")
  (global-set-key "\C-oc" 'org-capture)
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

  ;; DONEの時刻を記録
  (setq org-log-done 'time)

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
          )))
(use-package prettier-js :ensure t)
(use-package ruby-end :ensure t)
(use-package s :ensure t)
(use-package smartparens
  :ensure t
  :config
  (use-package smartparens-config)
  (smartparens-global-mode t))
(use-package smooth-scrolling
  :ensure t
  :config
  (smooth-scrolling-mode 1))
(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode
  :custom
  (undo-tree-auto-save-history t)
  (undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  :config
  (global-undo-tree-mode t))
(use-package wgrep :ensure t)
(use-package whitespace
  :defer t
  :diminish whitespace-mode
  :config
  ;;; 行末スペースとtabの色付け
  (setq whitespace-style '(face trailing tabs space-mark tab-mark))
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
(use-package yasnippet
  :ensure t
  :config
  (yas-reload-all)
  (add-hook 'markdown-mode-hook #'yas-minor-mode)
  (add-hook 'prog-mode-hook #'yas-minor-mode))
(use-package yasnippet-snippets :ensure t)


;;; mode
(use-package csv-mode :ensure t)
(use-package dockerfile-mode :ensure t)
(use-package gitconfig-mode :ensure t)
(use-package gitignore-mode :ensure t)
(use-package go-mode
  :ensure t
  :config
  (add-hook 'go-mode-hook
            '(lambda ()
               (add-hook 'before-save-hook 'gofmt-before-save)
               (local-set-key (kbd "M-.") 'godef-jump)
               (add-to-list 'company-backends 'company-go))))
(use-package hgrc-mode :ensure t)
(use-package hgignore-mode :ensure t)
(use-package json-mode
  :ensure t
  :hook (json-mode . prettier-js-mode))
(use-package kotlin-mode :ensure t)
(use-package less-css-mode :ensure t)
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :hook ((markdown-mode gfm-mode) . prettier-js-mode)
  :init (setq markdown-command "multimarkdown"))
(use-package mhtml-mode
  :hook ((mhtml-mode . prettier-js-mode)
         (mhtml-mode . lsp-deferred)))
(use-package python-mode
  :hook (python-mode . lsp-deferred))
(use-package rhtml-mode :ensure t)
(use-package rjsx-mode
  :ensure t
  :hook ((rjsx-mode . prettier-js-mode)
         (rjsx-mode . flycheck-mode))
  :mode (("\\.js$" . rjsx-mode))
  :config
  (flycheck-add-mode 'javascript-eslint 'rjsx-mode))
(use-package rspec-mode :ensure t)
(use-package ruby-mode
  :ensure t
  :mode (("\\.erb$" . ruby-mode)
         ("\\.rake$" . ruby-mode)
         ("\\.jbuilder$" . ruby-mode)
         ("\\.builder$" . ruby-mode)
         ("Fastfile". ruby-mode)))
(use-package rustic
  :ensure t
  :hook ((rustic-mode . lsp-deferred))
  :config
  (setq rustic-format-on-save t))
(use-package scss-mode
  :hook ((scss-mode . prettier-js-mode)
         (scss-mode . lsp-deferred)))
(use-package slim-mode :ensure t)
(use-package swift-mode
  :ensure t
  :config
  (setq swift-mode:basic-offset 2))
(use-package typescript-mode
  :ensure t
  :mode (("\\.ts$" . typescript-mode)
         ("\\.tsx$" . typescript-mode))
  :hook ((typescript-mode . prettier-js-mode)
         (typescript-mode . lsp-deferred))
  :config
  (setq typescript-indent-level 2))
(use-package web-mode
  :ensure t
  :mode (("\\.tag$" . web-mode))
  :config
  (setq web-mode-engines-alist
        '(("riot" . "\\.tag\\'")))
  (set-face-foreground 'web-mode-html-tag-face "blue")
  (set-face-foreground 'web-mode-html-tag-bracket-face "brightyellow")
  (set-face-foreground 'web-mode-html-attr-name-face "brightyellow"))
(use-package yaml-mode :ensure t)

;;; hydra
(defhydra hydra-main (:hint nil :exit t)
  "hydra-main"
  ("x" counsel-M-x)
  ("s" save-buffer)
  ("f" counsel-find-file)
  ("b" ivy-switch-buffer)
  ("a" beginning-of-buffer)
  ("e" end-of-buffer)
  ("RET" hydra-mark/body)
  ("u" undo-tree-visualize)
  ("q" ivy-ghq-open)
  ("j" open-junk-file)
  ("y" counsel-yank-pop)

  ("o" other-window)
  ("w" split-window-below)
  ("p" delete-window)

  ("l" counsel-git)
  ("g" counsel-rg)
  ("r" ivy-resume)
  ("." lsp-ui-peek-find-definitions)
  ("/" lsp-ui-peek-find-references)
  ("," xref-pop-marker-stack)
  )


(defhydra hydra-mark (:body-pre (set-mark-command nil) :hint nil :color pink)
  "
  ^Mark^                     ^Move^
  ^^^^------------------------------------------------
  _c_: comment-or-uncomment  _a_: beginning-of-buffer
  _k_: kill-region           _e_: end-of-buffer
  _w_: copy-region
  "
  ("c" comment-or-uncomment-region :exit t)
  ("i" indent-region :exit t)
  ("k" clipboard-kill-region :exit t)
  ("w" clipboard-kill-ring-save :exit t)
  ("a" beginning-of-buffer :exit nil)
  ("e" end-of-buffer :exit nil))


;;; language and coding
(prefer-coding-system 'utf-8)
(set-language-environment "Japanese")
;; (setq file-name-coding-system 'utf-8)
;; (setq locale-coding-system 'utf-8)

(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(blink-cursor-mode 1)
(show-paren-mode 1) ;; highlight corresponding bracket
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(setq vc-follow-symlinks t)
(setq-default cursor-in-non-selected-windows nil)

;; line number
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'text-mode-hook #'display-line-numbers-mode)
(add-hook 'conf-space-mode-hook #'display-line-numbers-mode)
(add-hook 'conf-unix-mode-hook #'display-line-numbers-mode)
(add-hook 'conf-toml-mode-hook #'display-line-numbers-mode)

;;; disable auto indent
(add-hook 'after-change-major-mode-hook
          (lambda() (electric-indent-mode -1)))

;;; exitコマンド
(defalias 'exit 'save-buffers-kill-terminal)

;;; 変更されたファイルを自動的に再読み込み
(global-auto-revert-mode 1)

(setq default-directory "~/")

;;; tab
(setq-default tab-width 4 indent-tabs-mode nil)
(setq-default basic-offset 2)
(setq-default c-basic-offset 2)

;; indent
(setq css-indent-offset 2)
(setq js-indent-level 2)
(setq python-indent-guess-indent-offset nil)

;;; file
(setq mode-require-final-newline t)
(setq backup-inhibited t)
(setq make-backup-files nil)
(setq create-lockfiles nil)
(setq delete-auto-save-files t)
(setq auto-save-default nil)

;;; 問い合せには y か n で返答
(fset 'yes-or-no-p 'y-or-n-p)

;;; emacs permission
;; (setq wdired-allow-to-change-permissions t)

;;; suppress warning messsage.
(setq ad-redefinition-action 'accept)

;;; diredの表示オプション
(let ((gls (executable-find "gls")))
  (when gls
    (setq insert-directory-program gls
          dired-listing-switches "-ahl --time-style long-iso --group-directories-first")))

;;; Global Key
;; copy & paste
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-w" 'clipboard-kill-region)

(global-set-key "\C-cc"         'comment-or-uncomment-region)
(global-set-key "\C-h"          'backward-delete-char)
(global-set-key "\C-x\C-i"      'indent-region)
(global-set-key [C-tab]         'indent-for-tab-command)

;;; emacs のデフォルトブラウザを eww に変更
(setq browse-url-browser-function 'eww-browse-url)

(when (eq system-type 'darwin)
  ;; Fonts
  (add-to-list 'default-frame-alist '(font . "Ricty 16"))
  (set-fontset-font "fontset-default" 'unicode "Apple Color Emoji" nil 'prepend)

  ;; フルスクリーン (maximized, fullscreen)
  ;;(add-hook 'emacs-startup-hook #'toggle-frame-maximized)

  ;; Modify right command to super
  ;; (setq mac-right-command-modifier 'super)
  ;; (setq ns-command-modifier (quote meta))

  ;; フォントの拡大・縮小
  (global-set-key (kbd "s-=") (lambda () (interactive) (text-scale-increase 1)))
  (global-set-key (kbd "s--") (lambda () (interactive) (text-scale-decrease 1)))
  (global-set-key (kbd "s-0") (lambda () (interactive) (text-scale-increase 0)))
  )

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
