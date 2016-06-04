(when (require 'helm-swoop nil t)
  ;; isearchからの連携を考えるとC-r/C-sにも割り当て推奨
  (global-set-key (kbd "M-i") 'helm-swoop)
  (define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
  (define-key helm-swoop-map (kbd "C-s") 'helm-next-line)

  ;; 検索結果をcycleしない、お好みで
  (setq helm-swoop-move-to-line-cycle nil)

  ;; (cl-defun helm-swoop-nomigemo (&key $query ($multiline current-prefix-arg))
  ;;   "シンボル検索用Migemo無効版helm-swoop"
  ;;   (interactive)
  ;;   (let ((helm-swoop-pre-input-function
  ;;          (lambda () (format "\\_<%s\\_> " (thing-at-point 'symbol)))))
  ;;     (helm-swoop :$source (delete '(migemo) (copy-sequence (helm-c-source-swoop)))
  ;;                 :$query $query :$multiline $multiline)))

  ;; ;; C-M-:に割り当て
  ;; (global-set-key (kbd "C-M-:") 'helm-swoop-nomigemo)

  ;; [2014-11-25 Tue]
  (when (featurep 'helm-anything)
    (defadvice helm-resume (around helm-swoop-resume activate)
      "helm-anything-resumeで復元できないのでその場合に限定して無効化"
      ad-do-it)))

(when (require 'ace-isearch nil t)
  (global-ace-isearch-mode 1))
