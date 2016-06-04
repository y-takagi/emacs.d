(when (require 'helm-swoop nil t)
  (global-set-key (kbd "C-s") 'helm-swoop)
  ;; (define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
  ;; (define-key helm-swoop-map (kbd "C-s") 'helm-next-line)

  ;; 検索結果をcycleしない、お好みで
  (setq helm-swoop-move-to-line-cycle nil)

  ;; [2014-11-25 Tue]
  (when (featurep 'helm-anything)
    (defadvice helm-resume (around helm-swoop-resume activate)
      "helm-anything-resumeで復元できないのでその場合に限定して無効化"
      ad-do-it)))
