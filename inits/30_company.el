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
  (define-key emacs-lisp-mode-map (kbd "M-/") 'company-complete)
  )
