(use-package auto-complete
  :disabled t
  :config
  (require 'auto-complete-config)
  (ac-config-default)
  (global-auto-complete-mode t)
  (setq ac-show-menu-immediately-on-auto-complete t)

  ;; C-n/C-p で候補を選択
  (setq ac-use-menu-map t)
  (global-set-key "\M-/" 'ac-start)

  ;; パス入力用の情報源を追加
  (defun ac-common-setup ()
    (add-to-list 'ac-sources 'ac-source-filename)
    (add-to-list 'ac-sources 'ac-source-gtags))
  )
