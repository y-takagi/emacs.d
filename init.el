(use-package emacs
  :custom
  (modus-themes-mode-line '(moody borderless))
  (custom-file (expand-file-name "custom.el" user-emacs-directory))
  (inhibit-startup-message t)
  (ring-bell-function 'ignore)
  (vc-follow-symlinks t)
  (enable-recursive-minibuffers t)
  (warning-suppress-types '((lsp-mode)))
  (warning-suppress-log-types '((lsp-mode)))
  (split-width-threshold nil)
  (default-directory "~/")
  (browse-url-browser-function 'eww-browse-url "emacs のデフォルトブラウザを eww に変更")
  (cursor-in-non-selected-windows nil)
  (indent-tabs-mode nil)
  (tab-width 4)
  (basic-offset 2)
  (css-indent-offset 2)
  (js-indent-level 2)
  (python-indent-guess-indent-offset nil)
  (c-basic-offset 2)
  (mode-require-final-newline t)
  (backup-inhibited t)
  (make-backup-files nil)
  (create-lockfiles nil)
  (delete-auto-save-files t)
  (auto-save-default nil)
  (ad-redefinition-action 'accept "suppress warning messsage.")
  (mouse-wheel-scroll-amount '(1 ((shift) . 1)) "scroll one line at a time")
  (mouse-wheel-progressive-speed nil "don't accelerate scrolling")
  (mouse-wheel-follow-mouse t "scroll window under mouse")
  (scroll-conservatively 1 "keyboard scroll one line at a time")
  (tab-bar-new-tab-choice "*scratch*")
  (tab-bar-tab-hints t)
  (package-archives
   '(("melpa" . "https://melpa.org/packages/")
     ("org" . "https://orgmode.org/elpa/")
     ("gnu" . "https://elpa.gnu.org/packages/")))
  (native-comp-driver-options '("-Wl,-w"))
  (package-native-compile t "AOT compilation on package install.")
  :hook
  ;; line number
  (prog-mode . display-line-numbers-mode)
  (text-mode . display-line-numbers-mode)
  (conf-space-mode . display-line-numbers-mode)
  (conf-unix-mode-hook . display-line-numbers-mode)
  (conf-toml-mode-hook . display-line-numbers-mode)
  ;; disable auto indent
  (after-change-major-mode . (lambda() (electric-indent-mode -1)))
  :init
  ;; load-path for elisp files
  ;; emacs -l init.el等で直接ロードしたときに, user-emacs-directoryが書き換わる
  (when load-file-name
    (setq user-emacs-directory (file-name-directory load-file-name)))

  ;; exitコマンド
  (defalias 'exit 'save-buffers-kill-terminal)

  ;; diredの表示オプション
  ;; (let ((gls (executable-find "gls")))
  ;;   (when gls
  ;;     (setq insert-directory-program gls
  ;;           dired-listing-switches "-ahl --time-style long-iso --group-directories-first")))

  (when (eq system-type 'darwin)
    ;; Fonts
    (add-to-list 'default-frame-alist '(font . "Ricty 14"))
    (set-fontset-font "fontset-default" 'unicode "Apple Color Emoji" nil 'prepend)

    ;; フルスクリーン (maximized, fullscreen)
    ;;(add-hook 'emacs-startup-hook #'toggle-frame-maximized)

    ;; Modify right command to super
    ;; (setq mac-right-command-modifier 'super)
    ;; (setq ns-command-modifier (quote meta))
    )

  (when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
  (when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
  (when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
  (prefer-coding-system 'utf-8) ;; language and coding
  (set-language-environment "Japanese") ;; language and coding
  (blink-cursor-mode 1)
  (show-paren-mode 1) ;; highlight corresponding bracket
  (global-auto-revert-mode 1) ;; 変更されたファイルを自動的に再読み込み
  (fset 'yes-or-no-p 'y-or-n-p) ;; 問い合せには y か n で返答
  (tab-bar-mode +1)
  (package-refresh-contents)
  :config
  ;; modus-operandi is light.
  ;; modus-vivendi is dark.
  (load-theme 'modus-vivendi))

(use-package whitespace
  :diminish whitespace-mode
  :hook
  (conf-mode . whitespace-mode)
  (prog-mode . whitespace-mode)
  (text-mode . whitespace-mode)
  :custom
  (whitespace-style '(face trailing tabs space-mark tab-mark))
  (whitespace-display-mappings '((tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))
  :custom-face
  (whitespace-tab ((t (:foreground "#dc322f" :underline "#dc322f"))))
  (whitespace-trailing ((t (:background "#dc322f")))))

(use-package treesit :custom (treesit-font-lock-level 4))

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-langs '(bash css dockerfile go html javascript json make markdown python rust tsx typescript yaml))
  :config
  (global-treesit-auto-mode))

(use-package nerd-icons :ensure t)

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package add-node-modules-path
  :ensure t
  :custom (add-node-modules-path-command "echo \"$(npm root)/.bin\"")
  :hook ((prog-mode gfm-mode markdown-mode) . add-node-modules-path))

(use-package hydra
  :ensure t
  :bind (("C-z" . hydra-main/body))
  :config (hydra-set-property 'hydra-main :verbosity 1))

(use-package auto-sudoedit
  :ensure t
  :config
  (auto-sudoedit-mode 1))

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

(use-package vertico
  :ensure t
  :init (vertico-mode)
  :custom
  (vertico-count 14)
  (vertico-resize nil))

(use-package vertico-directory
  :after vertico
  :bind (:map vertico-map ("C-l" . vertico-directory-up)))

(use-package vertico-repeat
  :after vertico
  :config
  (add-hook 'minibuffer-setup-hook #'vertico-repeat-save))

(use-package orderless
  :ensure t
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))
(use-package savehist :init (savehist-mode))

(use-package marginalia :ensure t :init (marginalia-mode))

(use-package consult
  :ensure t
  :bind (("C-s" . consult-line))
  :custom (consult-line-start-from-top t)
  :config
  ;; Define consult-fd command
  (defvar consult--fd-command nil)
  (defun consult--fd-builder (input)
    (unless consult--fd-command
      (setq consult--fd-command
            (if (eq 0 (call-process-shell-command "fdfind"))
                "fdfind"
              "fd")))
    (pcase-let* ((`(,arg . ,opts) (consult--command-split input))
                 (`(,re . ,hl) (funcall consult--regexp-compiler
                                        arg 'extended)))
      (when re
        (list :command (append
                        (list consult--fd-command
                              "--color=never" "--full-path"
                              (consult--join-regexps re 'extended))
                        opts)
              :highlight hl))))
  (defun consult-fd (&optional dir initial)
    (interactive "P")
    (let* ((prompt-dir (consult--directory-prompt "Fd" dir))
           (default-directory (cdr prompt-dir)))
      (find-file (consult--find (car prompt-dir) #'consult--fd-builder initial))))
  (defun consult-ripgrep-at-point ()
    (interactive)
    (consult-ripgrep nil (thing-at-point 'symbol)))

  (consult-customize
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   :preview-key "M-.")

  (setq consult-project-root-function
        (lambda ()
          (when-let (project (project-current))
            (car (project-roots project))))))

(use-package consult-ghq :ensure t)

(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :ensure t
  :after (embark consult)
  :demand t ; only necessary if you have the hook below
  ;; if you want to have consult previews as you move around an
  ;; auto-updating embark collect buffer
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package openwith
  :ensure t
  :custom (openwith-associations '(("\\.pdf\\'" "open" (file))))
  :config
  (openwith-mode 1))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  (setq dashboard-items '((recents . 20))))

(use-package direnv
  :ensure t
  :if (executable-find "direnv")
  :config
  (direnv-mode))

(use-package doom-modeline
  :ensure t
  :custom
  (doom-modeline-buffer-file-name-style 'truncate-with-project)
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon nil)
  (doom-modeline-minor-modes nil)
  :init
  (doom-modeline-mode 1)
  :config
  (line-number-mode 0)
  (column-number-mode 0))

(use-package flycheck
  :ensure t
  :bind (("M-p" . flycheck-previous-error)
         ("M-n" . flycheck-next-error))
  :config
  (setq flycheck-checker-error-threshold nil))

(use-package git-gutter
  :ensure t
  :diminish git-gutter-mode
  :config
  (global-git-gutter-mode +1))

(use-package smartparens
  :ensure t
  :custom (smartparens-global-mode t))

(use-package multiple-cursors :ensure t)

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
        ;;lsp-disabled-clients '(angular-ls)
        lsp-eldoc-enable-hover nil
        lsp-before-save-edits nil
        lsp-enable-file-watchers nil
        lsp-overlay-document-color-char nil
        lsp-clients-python-library-directories '("/usr/local/" "/usr/")
        lsp-enable-suggest-server-download nil
        lsp-clients-deno-enable-code-lens-references nil
        lsp-clients-deno-enable-code-lens-implementations nil
        lsp-clients-deno-enable-code-lens-references-all-functions nil))

(use-package dap-mode
  :ensure t
  :config
  (add-hook 'dap-stopped-hook
          (lambda (arg) (call-interactively #'dap-hydra))))

(use-package lsp-dart
  :ensure t
  :custom
  (lsp-dart-flutter-widget-guides nil)
  (lsp-dart-closing-labels nil)
  (lsp-dart-main-code-lens nil)
  (lsp-dart-test-code-lens nil)
  (lsp-dart-line-length 140)
  (lsp-dart-dap-flutter-hot-reload-on-save t)
  :init
  (dap-register-debug-template "everytv/fresh-app"
                               (list :type "flutter"
                                     :flutterMode "debug"
                                     :program "lib/main.dart"
                                     :args '("--dart-define=FLAVOR=development"))))

(use-package lsp-haskell
  :ensure t
  :config
  (add-hook 'haskell-mode-hook #'lsp)
  (add-hook 'haskell-literate-mode-hook #'lsp))

(use-package lsp-tailwindcss
  :ensure t
  :custom (lsp-tailwindcss-add-on-mode t))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :after (flycheck)
  :bind (:map lsp-ui-mode-map
              ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
              ([remap xref-find-references] . lsp-ui-peek-find-references)
              ("C-c u" . lsp-ui-imenu))
  :init (setq lsp-ui-doc-show-with-cursor t
              lsp-ui-doc-header t
              lsp-ui-doc-include-signature t
              lsp-ui-doc-position 'at-point
              lsp-ui-doc-delay 0.5
              lsp-ui-sideline-enable nil
              lsp-ui-sideline-ignore-duplicate t
              lsp-ui-imenu-enable nil
              lsp-ui-imenu-kind-position 'top))

(use-package magit :ensure t)

(use-package open-junk-file
  :ensure t
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
  (add-hook 'org-agenda-mode-hook (lambda () (hl-line-mode 1)))
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

(use-package undo-tree
  :ensure t
  :custom
  (undo-tree-auto-save-history t)
  (undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  :init
  (global-undo-tree-mode))

(use-package vterm
  ;; requirements: brew install cmake libvterm libtool
  :disabled t
  :custom
  ;; enable hydra keymap
  (vterm-keymap-exceptions '("C-z" "C-c" "C-x" "C-u" "C-g" "C-l" "M-x" "M-o" "C-v" "M-v" "C-y" "M-y"))
  (vterm-toggle-fullscreen-p t))

(use-package vterm-toggle :disabled t)

(use-package wgrep :ensure t)

(use-package yagist :ensure t)

(use-package yasnippet
  :ensure t
  :config
  (yas-reload-all)
  (add-hook 'markdown-mode-hook #'yas-minor-mode)
  (add-hook 'prog-mode-hook #'yas-minor-mode))

(use-package yasnippet-snippets :ensure t)

;;; mode

(use-package css-ts-mode
  :mode (("\\.css$" . css-ts-mode)
         ("\\.scss$" . css-ts-mode))
  :hook
  (css-ts-mode . prettier-js-mode)
  (css-ts-mode . lsp-deferred))

(use-package csv-mode :ensure t)

(use-package json-ts-mode
  :hook (json-ts-mode . prettier-js-mode))

(use-package js-ts-mode
  :hook
  (js-ts-mode . prettier-js-mode)
  (js-ts-mode . lsp-deferred))

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :hook ((markdown-mode gfm-mode) . prettier-js-mode)
  :init (setq markdown-command "commonmarker"))

(use-package mhtml-mode
  :hook
  (mhtml-mode . prettier-js-mode)
  (mhtml-mode . lsp-deferred))

(use-package python-ts-mode
  :hook (python-ts-mode . lsp-deferred))

(use-package typescript-ts-mode
  :mode (("\\.ts$" . typescript-ts-mode)
         ("\\.tsx$" . typescript-ts-mode))
  :hook
  (typescript-ts-mode . prettier-js-mode)
  (typescript-ts-mode . lsp-deferred)
  :config
  ;; Place .dir-locals.el with below code where to run deno-ls
  ;; ((typescript-mode . ((lsp-enabled-clients . (deno-ls))))
  ;;  (typescript-mode (eval add-hook 'before-save-hook #'lsp-format-buffer t t)))
  (defun run-local-vars-mode-hook ()
    "Run `major-mode' hook after the local variables have been processed."
    (run-hooks (intern (concat (symbol-name major-mode) "-local-vars-hook"))))
  (add-hook 'hack-local-variables-hook 'run-local-vars-mode-hook)
  (add-hook 'typescript-mode-local-vars-hook #'lsp-deferred))

(use-package yaml-ts-mode
  :mode (("\\.yaml$" . yaml-ts-mode)
         ("\\.yml$" . yaml-ts-mode)))

;; (use-package dart-mode
;;   :ensure t
;;   :hook (dart-mode . lsp-deferred)
;;   :config
;;   (add-hook 'dart-mode-hook
;;             (lambda ()
;;               (add-hook 'before-save-hook #'lsp-format-buffer t t))))

;; (use-package go-mode
;;   :ensure t
;;   :hook (go-mode . lsp-deferred)
;;   :config
;;   (add-hook 'go-mode-hook
;;             (lambda ()
;;               (add-hook 'before-save-hook #'lsp-format-buffer t t)
;;               (add-hook 'before-save-hook #'lsp-organize-imports t t))))

;; (use-package kotlin-mode
;;   :ensure t
;;   :mode (("\\.kt" . kotlin-mode) ("\\.gradle" . kotlin-mode))
;;   :config (add-hook 'kotlin-mode-hook #'lsp))

;; (use-package prisma-mode
;;   :vc (:url "https://github.com/davidarenas/prisma-mode" :branch "master"))

;;; hydra
(defhydra hydra-main (:hint nil :exit t)
  "hydra-main"
  ("x" execute-extended-command)
  ("s" save-buffer)
  ("f" find-file)
  ("b" consult-buffer)
  ("a" beginning-of-buffer)
  ("e" end-of-buffer)
  ("q" consult-ghq-find)
  ("l" project-find-file)
  ("g" consult-ripgrep)
  ("h" consult-ripgrep-at-point)
  ("u" undo-tree-visualize)
  ("j" open-junk-file)
  ("o" other-window)
  ("w" split-window-below)
  ("p" delete-window)
  ("r" vertico-repeat)
  ("m" magit-status)
  ("." lsp-ui-peek-find-definitions)
  ("/" lsp-ui-peek-find-references)
  ("\\" lsp-execute-code-action)
  ("," xref-pop-marker-stack)
  ("RET" hydra-mark/body)
  ("z" hydra-zoom/body))

(defhydra hydra-mark (:body-pre (set-mark-command nil) :hint nil :color pink)
  "
  ^Mark^                     ^Move^
  ^^^^------------------------------------------------
  _c_: comment-or-uncomment  _a_: beginning-of-buffer
  _k_: kill-region           _e_: end-of-buffer
  _w_: copy-region
  _i_: indent-region
  "
  ("c" comment-or-uncomment-region :exit t)
  ("k" clipboard-kill-region :exit t)
  ("w" clipboard-kill-ring-save :exit t)
  ("i" indent-region :exit t)
  ("a" beginning-of-buffer :exit nil)
  ("e" end-of-buffer :exit nil))

(defhydra hydra-zoom ()
  "zoom"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("l" (text-scale-adjust 0) "adjust"))

;; (defhydra hydra-tab (:hint nil :exit t)
;;   "
;;   ^Tab^
;;   ^^^^------------
;;   _n_: new-tab
;;   _r_: rename-tab
;;   _b_: switch-tab
;;   "
;;   ("n" tab-bar-new-tab)
;;   ("r" tab-bar-rename-tab)
;;   ("b" tab-switcher)
;;   ("d" tab-bar-close-tab))

;; (defhydra hydra-window (:hint nil :exit t)
;;   "
;;         Move: _h_:left _j_:down _k_:up _l_:right
;;        Split: _w_:below _v_:right
;;   Split Move: _H_:left _J_:down _K_:up _L_:right
;;       Buffer: _p_:delete _d_:kill
;;   "
;;   ("h" windmove-left)
;;   ("j" windmove-down)
;;   ("k" windmove-up)
;;   ("l" windmove-right)
;;   ("H" hydra-move-splitter-left)
;;   ("J" hydra-move-splitter-down)
;;   ("K" hydra-move-splitter-up)
;;   ("L" hydra-move-splitter-right)
;;   ("v" split-window-right)
;;   ("w" split-window-below)
;;   ("p" delete-window)
;;   ("d" kill-this-buffer))

(server-start)
