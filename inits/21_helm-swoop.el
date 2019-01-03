(use-package helm-swoop
  :ensure t
  :bind (("C-s" . helm-swoop))
  :config
  ;; 検索結果をcycleしない、お好みで
  (setq helm-swoop-move-to-line-cycle nil)
  )
