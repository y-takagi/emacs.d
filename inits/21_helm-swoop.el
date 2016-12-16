(use-package helm-swoop
  :bind (("C-s" . helm-swoop))
  :config
  ;; 検索結果をcycleしない、お好みで
  (setq helm-swoop-move-to-line-cycle nil)

  ;; [2014-11-25 Tue]
  (when (featurep 'helm-anything)
    (defadvice helm-resume (around helm-swoop-resume activate)
      "helm-anything-resumeで復元できないのでその場合に限定して無効化"
      ad-do-it))
  )
